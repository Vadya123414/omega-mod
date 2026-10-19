"""Load HoI4 map data (provinces.bmp, definition.csv, history/states) into a state-id raster."""
import os, re, glob, pickle
import numpy as np
from PIL import Image

MOD = r"C:\Users\User\Documents\Paradox Interactive\Hearts of Iron IV\mod\Vanila Upgrade 2.0"
GAME = r"G:\SteamLibrary\steamapps\common\Hearts of Iron IV"
CACHE = os.path.join(os.path.dirname(__file__), "cache.pkl")


def strip_comments(t):
    return re.sub(r"#[^\n]*", "", t)


def parse_states():
    states = {}
    for fn in glob.glob(os.path.join(MOD, "history", "states", "*.txt")):
        t = strip_comments(open(fn, encoding="utf-8-sig", errors="replace").read())
        m = re.search(r"\bid\s*=\s*(\d+)", t)
        if not m:
            continue
        sid = int(m.group(1))
        pm = re.search(r"provinces\s*=\s*\{([^}]*)\}", t)
        provs = [int(x) for x in pm.group(1).split()] if pm else []
        om = re.search(r"\bowner\s*=\s*(\w+)", t)
        cores = re.findall(r"add_core_of\s*=\s*(\w+)", t)
        cat = re.search(r"state_category\s*=\s*(\w+)", t)
        states[sid] = dict(id=sid, provs=provs, owner=om.group(1) if om else None,
                           cores=cores, impassable="impassable = yes" in t or "impassable=yes" in t,
                           category=cat.group(1) if cat else None)
    return states


def state_names():
    names = {}
    for root in (os.path.join(GAME, "localisation", "russian"), os.path.join(MOD, "localisation", "russian")):
        for fn in glob.glob(os.path.join(root, "**", "*.yml"), recursive=True):
            for line in open(fn, encoding="utf-8-sig", errors="replace"):
                m = re.match(r'\s*STATE_(\d+):\d*\s*"(.*)"', line)
                if m:
                    names[int(m.group(1))] = m.group(2)
    return names


def load():
    if os.path.exists(CACHE):
        return pickle.load(open(CACHE, "rb"))
    img = np.asarray(Image.open(os.path.join(MOD, "map", "provinces.bmp")).convert("RGB"))
    h, w, _ = img.shape
    key = (img[:, :, 0].astype(np.int32) << 16) | (img[:, :, 1].astype(np.int32) << 8) | img[:, :, 2]
    prov_type = {}
    color2prov = {}
    for line in open(os.path.join(MOD, "map", "definition.csv"), encoding="utf-8-sig", errors="replace"):
        p = line.strip().split(";")
        if len(p) < 5 or not p[0].isdigit():
            continue
        pid, r, g, b = map(int, p[:4])
        color2prov[(r << 16) | (g << 8) | b] = pid
        prov_type[pid] = p[4]
    states = parse_states()
    prov2state = {}
    for s in states.values():
        for pid in s["provs"]:
            prov2state[pid] = s["id"]
    # color key -> state id (0 = sea/unassigned, -1 = lake)
    uniq, inv = np.unique(key, return_inverse=True)
    lut = np.zeros(len(uniq), dtype=np.int32)
    for i, k in enumerate(uniq):
        pid = color2prov.get(int(k))
        if pid is None:
            continue
        t = prov_type.get(pid)
        if t == "lake":
            lut[i] = -1
        elif t == "land":
            lut[i] = prov2state.get(pid, 0)
    raster = lut[inv.reshape(-1)].reshape(h, w)
    data = dict(raster=raster, states=states, names=state_names())
    pickle.dump(data, open(CACHE, "wb"), protocol=4)
    return data


if __name__ == "__main__":
    d = load()
    r = d["raster"]
    print(r.shape, len(d["states"]))
    ys, xs = np.nonzero(r > 0)
    # centroids for a few reference states
    for sid in (64, 16, 219, 217, 195, 13, 230, 47, 1, 110, 149, 342, 447):
        m = r == sid
        yy, xx = np.nonzero(m)
        if len(xx):
            print(sid, d["names"].get(sid), d["states"][sid]["owner"], int(xx.mean()), int(yy.mean()), len(xx))
