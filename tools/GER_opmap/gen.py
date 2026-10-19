"""Generate the GER operations mini-map (sprites, .gfx, .gui, scripted gui/effects/triggers, loc)."""
import os, struct
import numpy as np
from PIL import Image
from mapdata import load, MOD

# ---------------------------------------------------------------- settings
X0, Y0, X1, Y1 = 2640, 110, 3720, 860          # region in provinces.bmp pixels (Europe + European USSR)
W = 496                                          # map width in GUI pixels
S = W / (X1 - X0)
H = int(round((Y1 - Y0) * S))
MAP_X, MAP_Y = 3, 4                              # map position inside the window
MIN_PX = 3                                       # states smaller than this (in GUI px) are drawn only in the base image

GFX_DIR = "gfx/interface/GER_opmap"
IND = ((1, "sel"),)   # indicator bar frames on the operation buttons (selected)
P = "GER_opmap"

SEA = (11, 17, 28)
LAKE = (22, 36, 56)
FRAME = (150, 128, 82)
# fill, border  (frame order: 1 neutral, 2 axis, 3 allies, 4 comintern)
PAL = [
    ((92, 92, 98), (44, 44, 50)),
    ((22, 22, 24), (104, 104, 110)),
    ((62, 112, 170), (24, 46, 78)),
    ((150, 40, 44), (64, 14, 18)),
]
RED = (255, 40, 40)
SEL = (255, 236, 150)

OPS = [  # key, flag/decision, states
    ("taif", "GER_taif", [205, 243, 224, 222, 242, 223, 219, 247, 246]),
    ("blau", "GER_blau", [221, 227, 240, 220, 228, 218, 245, 238, 235, 234, 260, 217]),
    ("lenik", "GER_lenik", [191, 13, 811, 812, 813, 209, 208, 263, 244, 210, 810]),
    ("balt", "GER_balt", [188, 814, 11, 815, 190, 809, 784, 96, 95, 97, 5, 763, 810, 808, 12, 811, 13, 812, 813, 191, 189]),
    ("beni", "GER_beni", [35, 977, 51, 42, 8, 980, 34, 6, 29, 785]),
    ("balaton", "GER_balaton", [975, 109, 45, 764, 155, 974, 43, 973, 154, 664, 70, 71]),
    ("pomerania", "GER_pomerania", [64, 62, 63, 68, 65, 66, 67, 87, 86, 807, 85, 762]),
    ("ukroxa", "GER_ukroxa", [766, 78, 834, 192, 198, 199, 201, 202, 203, 197, 193, 225, 259, 221, 226, 200, 196, 227, 228, 80, 73, 89, 91, 93]),
    ("belarus", "GER_belarus", [97, 94, 95, 784, 96, 207, 206, 204, 194, 241]),
]

# ---------------------------------------------------------------- helpers
def write_dds(path, rgba):
    """Uncompressed A8R8G8B8 DDS (what HoI4 / paint.net use)."""
    h, w, _ = rgba.shape
    hdr = struct.pack("<4sIIIIIII44x", b"DDS ", 124, 0x1 | 0x2 | 0x4 | 0x1000 | 0x8, h, w, w * 4, 0, 1)
    pf = struct.pack("<IIIIIIII", 32, 0x40 | 0x1, 0, 32, 0x00FF0000, 0x0000FF00, 0x000000FF, 0xFF000000)
    caps = struct.pack("<IIII4x", 0x1000, 0, 0, 0)
    bgra = rgba[:, :, [2, 1, 0, 3]].astype(np.uint8)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "wb") as f:
        f.write(hdr + pf + caps + bgra.tobytes())


def downsample(r):
    """Nearest-neighbour label raster at GUI resolution."""
    xs = (X0 + (np.arange(W) + 0.5) / S).astype(int)
    ys = (Y0 + (np.arange(H) + 0.5) / S).astype(int)
    return r[np.ix_(ys, xs)]


def edge(mask):
    """Pixels of mask that touch a non-mask pixel (4-neighbourhood)."""
    p = np.pad(mask, 1, constant_values=False)
    inner = p[1:-1, :-2] & p[1:-1, 2:] & p[:-2, 1:-1] & p[2:, 1:-1]
    return mask & ~inner


def border_px(lab):
    """1px state borders: a pixel is border if its right/down neighbour differs, or it touches non-land."""
    b = np.zeros(lab.shape, bool)
    b[:, :-1] |= lab[:, :-1] != lab[:, 1:]
    b[:-1, :] |= lab[:-1, :] != lab[1:, :]
    b |= edge(lab > 0)
    b &= lab > 0
    return b


def dilate(mask, n=1):
    m = mask.copy()
    for _ in range(n):
        p = np.pad(m, 1, constant_values=False)
        m = m | p[1:-1, :-2] | p[1:-1, 2:] | p[:-2, 1:-1] | p[2:, 1:-1]
    return m


def shade(lab, fill_of):
    """RGB image with per-state fill and 1px borders."""
    img = np.zeros(lab.shape + (3,), np.uint8)
    img[:] = SEA
    img[lab == -1] = LAKE
    bd = border_px(lab)
    for sid in np.unique(lab[lab > 0]):
        m = lab == sid
        fill, brd = fill_of(sid)
        img[m] = fill
        img[m & bd] = brd
    return img


def outline_layer(mask, color, width, tint_alpha):
    """RGBA overlay: soft tint inside mask + outline of the union area with a dark halo."""
    out = np.zeros(mask.shape + (4,), np.uint8)
    out[mask] = (*color, tint_alpha)
    inner_edge = mask & dilate(~mask, width)
    halo = dilate(mask, 1) & ~mask
    out[halo] = (0, 0, 0, 200)
    out[inner_edge] = (*color, 255)
    return out


# ---------------------------------------------------------------- 1942 reference (only for the preview png)
AXIS_TAGS = {"GER", "ITA", "HUN", "ROM", "BUL", "FIN", "FRA", "BEL", "HOL", "LUX", "DEN", "NOR", "POL",
              "CZE", "AUS", "YUG", "GRE", "ALB", "LIT", "LAT", "EST"}
ALLY_TAGS = {"ENG", "IRQ", "EGY", "USA", "CAN"}
SOV_AXIS_1942 = {199, 204, 201, 198, 206, 209, 194, 207, 208, 834, 210, 202, 192, 241, 203, 263, 193, 197, 243,
                 242, 224, 196, 259, 225, 137, 226, 200, 220, 222, 221, 240, 227, 228, 218, 234, 245, 238, 235,
                 237, 827, 217, 246, 260, 216, 215}


def alliance_1942(s, cx, cy):
    o = s["owner"]
    if o == "SOV":
        return 1 if s["id"] in SOV_AXIS_1942 else 3
    if o == "PER":
        return 3 if cy < 760 else 2          # Anglo-Soviet occupation of Iran
    if o == "FRA" and cy > 790:
        return 2 if (cx > 3150 or cx < 2930) else 1   # Levant/Algeria/Morocco: Allies, Tunisia: Axis
    if o in AXIS_TAGS:
        return 1
    if o in ALLY_TAGS:
        return 2
    return 0


# ---------------------------------------------------------------- main
def main():
    d = load()
    states, names = d["states"], d["names"]
    lab = downsample(d["raster"])
    out = os.path.join(MOD, GFX_DIR)
    os.makedirs(out, exist_ok=True)
    for f in os.listdir(out):
        if f.endswith(".dds"):
            os.remove(os.path.join(out, f))

    ids, counts = np.unique(lab[lab > 0], return_counts=True)
    ys, xs = np.nonzero(lab > 0)
    l = lab[ys, xs]
    n = np.bincount(l, minlength=lab.max() + 1)
    cx = np.bincount(l, weights=xs, minlength=lab.max() + 1) / np.maximum(n, 1) / S + X0
    cy = np.bincount(l, weights=ys, minlength=lab.max() + 1) / np.maximum(n, 1) / S + Y0
    drawn = [int(i) for i, c in zip(ids, counts) if c >= MIN_PX]
    drawn.sort()

    # base: sea, lakes, every land state in neutral grey, gold frame
    base = shade(lab, lambda sid: PAL[0])
    base = np.dstack([base, np.full(lab.shape, 255, np.uint8)])
    base[0, :, :3] = base[-1, :, :3] = FRAME
    base[:, 0, :3] = base[:, -1, :3] = FRAME
    write_dds(os.path.join(out, "base.dds"), base)

    bd = border_px(lab)
    sprites = []  # (sid, x, y)
    for sid in drawn:
        m = lab == sid
        yy, xx = np.nonzero(m)
        y0, y1, x0, x1 = yy.min(), yy.max() + 1, xx.min(), xx.max() + 1
        mm = m[y0:y1, x0:x1]
        bb = bd[y0:y1, x0:x1] & mm
        w, h = x1 - x0, y1 - y0
        img = np.zeros((h, w * 4, 4), np.uint8)
        for k, (fill, brd) in enumerate(PAL):
            fr = img[:, k * w:(k + 1) * w]
            fr[mm] = (*fill, 255)
            fr[bb] = (*brd, 255)
        write_dds(os.path.join(out, f"st_{sid}.dds"), img)
        sprites.append((sid, int(x0), int(y0)))

    # operation overlays: frame 1 = selected (light), frame 2 = active (red)
    ops_geo = []
    for key, flag, sts in OPS:
        missing = [s for s in sts if s not in states]
        offmap = [s for s in sts if s in states and not (lab == s).any()]
        if missing or offmap:
            print(f"WARN {key}: missing={missing} offmap={offmap}")
        m = np.isin(lab, sts)
        yy, xx = np.nonzero(dilate(m, 2))
        y0, y1, x0, x1 = yy.min(), yy.max() + 1, xx.min(), xx.max() + 1
        sub = m[y0:y1, x0:x1]
        a = outline_layer(sub, SEL, 1, 60)
        b = outline_layer(sub, RED, 2, 70)
        write_dds(os.path.join(out, f"op_{key}.dds"), np.concatenate([a, b], axis=1))
        ops_geo.append((key, flag, sts, int(x0), int(y0)))

    # legend squares: 1 axis, 2 allies, 3 comintern, 4 neutral, 5 active op, 6 selected op
    sq = 12
    leg = np.zeros((sq, sq * 6, 4), np.uint8)
    for k, (fill, brd) in enumerate([PAL[1], PAL[2], PAL[3], PAL[0]]):
        leg[:, k * sq:(k + 1) * sq] = (*brd, 255)
        leg[1:-1, k * sq + 1:(k + 1) * sq - 1] = (*fill, 255)
    for k, col in ((4, RED), (5, SEL)):
        leg[:, k * sq:(k + 1) * sq] = (*col, 255)
        leg[2:-2, k * sq + 2:(k + 1) * sq - 2] = (*PAL[0][0], 255)
    write_dds(os.path.join(out, "legend.dds"), leg)

    # op button: 3 frames (normal / hover / pressed)
    bw, bh = 244, 22
    btn = np.zeros((bh, bw * 3, 4), np.uint8)
    for k, (bg, ln) in enumerate((((38, 40, 44), (86, 88, 92)), ((58, 62, 66), (150, 128, 82)), ((28, 30, 32), (150, 128, 82)))):
        fr = btn[:, k * bw:(k + 1) * bw]
        fr[:] = (*ln, 255)
        fr[1:-1, 1:-1] = (*bg, 235)
    write_dds(os.path.join(out, "button.dds"), btn)
    # state indicator: 1 selected (light), 2 active (red), 3 can start (green), 4 already done (grey)
    ind = np.zeros((bh - 6, 12, 4), np.uint8)
    for k, col in enumerate((SEL, RED, (70, 200, 80), (110, 110, 114))):
        ind[:, k * 3:(k + 1) * 3] = (*col, 255)
    write_dds(os.path.join(out, "indicator.dds"), ind)
    # start button: 3 frames (normal / hover / pressed)
    sw, sh = 496, 26
    sb = np.zeros((sh, sw * 3, 4), np.uint8)
    for k, (bg, ln) in enumerate((((52, 48, 30), (150, 128, 82)), ((78, 70, 40), (220, 190, 110)), ((36, 34, 22), (220, 190, 110)))):
        fr = sb[:, k * sw:(k + 1) * sw]
        fr[:] = (*ln, 255)
        fr[2:-2, 2:-2] = (*bg, 245)
    write_dds(os.path.join(out, "start.dds"), sb)

    # 1942 reference png for the user
    def f42(sid):
        return PAL[alliance_1942(states[sid], cx[sid], cy[sid])]
    ref = shade(lab, f42).astype(np.uint8)
    ref = np.dstack([ref, np.full(lab.shape, 255, np.uint8)])
    for key, flag, sts, x0, y0 in ops_geo:
        if key in ("taif", "blau"):
            m = np.isin(lab, sts)
            ol = outline_layer(m, RED, 2, 70)
            a_ = ol[:, :, 3:4] / 255.0
            ref[:, :, :3] = (ref[:, :, :3] * (1 - a_) + ol[:, :, :3] * a_).astype(np.uint8)
    here = os.path.dirname(__file__)
    Image.fromarray(ref).resize((W * 2, H * 2), Image.NEAREST).save(os.path.join(here, "preview_1942.png"))

    write_script(sprites, ops_geo, names)
    print(f"map {W}x{H}, state sprites {len(sprites)}, skipped tiny {len(ids) - len(drawn)}")


# ---------------------------------------------------------------- script files
def write(path, text, bom=False):
    full = os.path.join(MOD, path)
    os.makedirs(os.path.dirname(full), exist_ok=True)
    with open(full, "w", encoding="utf-8-sig" if bom else "utf-8", newline="\n") as f:
        f.write(text)


def write_script(sprites, ops, names):
    T = "\t"
    hdr = "# GENERATED by the GER operations map generator - edit the generator, not this file\n"
    # ---- .gfx
    g = [hdr, "spriteTypes = {"]
    def spr(name, tex, frames=1, extra=""):
        g.append(f'\tspriteType = {{ name = "{name}" texturefile = "{GFX_DIR}/{tex}.dds"'
                 + (f" noOfFrames = {frames}" if frames > 1 else "") + extra + " }")
    spr(f"GFX_{P}_base", "base")
    spr(f"GFX_{P}_legend", "legend", 6)
    spr(f"GFX_{P}_button", "button", 3, ' effectFile = "gfx/FX/buttonstate.lua"')
    spr(f"GFX_{P}_indicator", "indicator", 4)
    spr(f"GFX_{P}_start", "start", 3, ' effectFile = "gfx/FX/buttonstate.lua"')
    for sid, x, y in sprites:
        spr(f"GFX_{P}_st_{sid}", f"st_{sid}", 4)
    for key, *_ in ops:
        spr(f"GFX_{P}_op_{key}", f"op_{key}", 2)
    g.append("}\n")
    write(f"interface/{P}.gfx", "\n".join(g))

    # ---- .gui
    leg_y = MAP_Y + H + 6
    btn_y = leg_y + 22
    rows = (len(ops) + 1 + 1) // 2
    start_y = btn_y + rows * 25 + 4
    total_h = start_y + 26 + 8
    u = [hdr, "guiTypes = {", "\tcontainerWindowType = {", f'\t\tname = "{P}_window"',
         "\t\tposition = { x = 0 y = 0 }", f"\t\tsize = {{ width = 502 height = {total_h} }}", "",
         "\t\ticonType = {", f'\t\t\tname = "{P}_bg"', f'\t\t\tspriteType = "GFX_{P}_base"',
         f"\t\t\tposition = {{ x = {MAP_X} y = {MAP_Y} }}", "\t\t}"]
    for sid, x, y in sprites:
        u += [f'\t\ticonType = {{ name = "{P}_s{sid}" spriteType = "GFX_{P}_st_{sid}" '
              f"position = {{ x = {MAP_X + x} y = {MAP_Y + y} }} }}"]
    for key, flag, sts, x, y in ops:
        for fr, kind in ((1, "sel"), (2, "act")):
            u += [f'\t\ticonType = {{ name = "{P}_op_{key}_{kind}" spriteType = "GFX_{P}_op_{key}" frame = {fr} '
                  f"position = {{ x = {MAP_X + x} y = {MAP_Y + y} }} }}"]
    # legend
    lx = MAP_X + 2
    legend = [(1, f"{P}_LEG_AXIS", 44), (2, f"{P}_LEG_ALLIES", 86), (3, f"{P}_LEG_COMINTERN", 94),
              (4, f"{P}_LEG_NEUTRAL", 88), (5, f"{P}_LEG_ACTIVE", 84), (6, f"{P}_LEG_SELECTED", 80)]
    for fr, loc, wdt in legend:
        u += [f'\t\ticonType = {{ name = "{P}_leg{fr}" spriteType = "GFX_{P}_legend" frame = {fr} '
              f"position = {{ x = {lx} y = {leg_y + 2} }} }}",
              f'\t\tinstantTextBoxType = {{ name = "{P}_leg{fr}_txt" position = {{ x = {lx + 15} y = {leg_y} }} '
              f'font = "hoi_16mbs" text = "{loc}" maxWidth = {wdt - 16} maxHeight = 16 format = left fixedsize = yes }}']
        lx += wdt
    # buttons: ops + "show all"
    entries = [(key, f"{P}_BTN_{key.upper()}") for key, flag, *_ in ops] + [("all", f"{P}_SHOW_ALL")]
    for i, (key, text) in enumerate(entries):
        bx = MAP_X + (i % 2) * 250
        by = btn_y + (i // 2) * 25
        u += [f'\t\tbuttonType = {{ name = "{P}_btn_{key}" spriteType = "GFX_{P}_button" '
              f'position = {{ x = {bx} y = {by} }} buttonText = "{text}" buttonFont = "hoi_16mbs" '
              f'pdx_tooltip = "{P}_TT_{key.upper()}" clicksound = click_default }}']
        u += [f'\t\ticonType = {{ name = "{P}_ind_{key}_{kind}" spriteType = "GFX_{P}_indicator" frame = {fr} '
              f"position = {{ x = {bx + 3} y = {by + 3} }} }}" for fr, kind in IND]
        if key != "all":   # vanilla tick / cross: all conditions met or not
            u += [f'\t\ticonType = {{ name = "{P}_ind_{key}_{kind}" spriteType = "{spr}" '
                  f"position = {{ x = {bx + 8} y = {by + 2} }} }}"
                  for kind, spr in (("ok", "GFX_trigger_yes"), ("no", "GFX_trigger_no"))]
            # running operation: the same stopwatch the decision list shows for active decisions
            u += [f'\t\ticonType = {{ name = "{P}_ind_{key}_act" spriteType = "GFX_decision_timer_icon_strip" frame = 1 '
                  f"scale = 0.75 position = {{ x = {bx + 7} y = {by + 1} }} }}"]
    u += [f'\t\tbuttonType = {{ name = "{P}_btn_start" spriteType = "GFX_{P}_start" '
          f'position = {{ x = {MAP_X} y = {start_y} }} buttonText = "{P}_START_TXT" buttonFont = "hoi_18mbs" '
          f'pdx_tooltip = "{P}_START_TT" clicksound = click_default }}']
    u += ["\t}", "}", ""]
    write(f"interface/{P}.gui", "\n".join(u))

    # ---- scripted gui
    s = [hdr, "scripted_gui = {", f"\t{P}_ui = {{", "\t\tcontext_type = decision_category",
         f'\t\twindow_name = "{P}_window"', "", "\t\teffects = {"]
    # one operation is selected at a time (GER_opmap_sel = its number, 0 = none); "start" launches it
    for n, (key, flag, *_) in enumerate(ops, 1):
        s += [f"\t\t\t{P}_btn_{key}_click = {{",
              f"\t\t\t\tif = {{ limit = {{ check_variable = {{ {P}_sel = {n} }} }} set_variable = {{ {P}_sel = 0 }} }}",
              f"\t\t\t\telse = {{ set_variable = {{ {P}_sel = {n} }} }}", "\t\t\t}"]
    s += [f"\t\t\t{P}_btn_all_click = {{",
          f"\t\t\t\tif = {{ limit = {{ has_country_flag = {P}_show_all }} clr_country_flag = {P}_show_all }}",
          f"\t\t\t\telse = {{ set_country_flag = {P}_show_all }}", "\t\t\t}",
          f"\t\t\t{P}_btn_start_click = {{"]
    for n, (key, flag, *_) in enumerate(ops, 1):
        s += [f"\t\t\t\t{'if' if n == 1 else 'else_if'} = {{",
              f"\t\t\t\t\tlimit = {{ check_variable = {{ {P}_sel = {n} }} {P}_{key}_startable = yes }}",
              f"\t\t\t\t\t{P}_{key}_start = yes", "\t\t\t\t}"]
    s += ["\t\t\t}", "\t\t}", "", "\t\ttriggers = {", f"\t\t\t{P}_btn_start_click_enabled = {{", "\t\t\t\tOR = {"]
    s += [f"\t\t\t\t\tAND = {{ check_variable = {{ {P}_sel = {n} }} {P}_{key}_startable = yes }}"
          for n, (key, *_) in enumerate(ops, 1)]
    s += ["\t\t\t\t}", "\t\t\t}"]
    for n, (key, flag, *_) in enumerate(ops, 1):
        sel = f"check_variable = {{ {P}_sel = {n} }}"
        act = f"has_country_flag = {flag}"
        s += [f"\t\t\t{P}_op_{key}_act_visible = {{ {act} }}",
              f"\t\t\t{P}_op_{key}_sel_visible = {{ NOT = {{ {act} }} OR = {{ {sel} has_country_flag = {P}_show_all }} }}",
              f"\t\t\t{P}_ind_{key}_act_visible = {{ {act} }}",
              f"\t\t\t{P}_ind_{key}_sel_visible = {{ NOT = {{ {act} }} {sel} }}",
              f"\t\t\t{P}_ind_{key}_ok_visible = {{ {P}_{key}_startable = yes }}",
              f"\t\t\t{P}_ind_{key}_no_visible = {{ NOT = {{ {act} }} NOT = {{ {P}_{key}_startable = yes }} }}"]
    s += [f"\t\t\t{P}_ind_all_sel_visible = {{ has_country_flag = {P}_show_all }}",
          f"\t\t\t{P}_ind_all_act_visible = {{ always = no }}"]
    s += ["\t\t}", "", "\t\tproperties = {"]
    for i, (sid, x, y) in enumerate(sprites):
        s.append(f"\t\t\t{P}_s{sid} = {{ frame = {P}_f^{i} }}")
    s += ["\t\t}", "\t}", "}", ""]
    write(f"common/scripted_guis/{P}.txt", "\n".join(s))

    # ---- scripted effects
    VERSION = len(sprites) * 1000 + sum(x + y for _, x, y in sprites) % 997
    e = [hdr, f"# {P}_f^i = frame of state {P}_states^i : 1 neutral, 2 axis, 3 allies, 4 comintern",
         f"{P}_init = {{", f"\tclear_array = {P}_states", f"\tclear_array = {P}_f"]
    for sid, x, y in sprites:
        e.append(f"\tadd_to_array = {{ {P}_states = {sid} }}")
    e += [f"\tresize_array = {{ array = {P}_f value = 1 size = {len(sprites)} }}",
          f"\tset_variable = {{ {P}_version = {VERSION} }}", "}", "",
          f"{P}_update = {{",
          f"\tif = {{", f"\t\tlimit = {{ NOT = {{ check_variable = {{ {P}_version = {VERSION} }} }} }}",
          f"\t\t{P}_init = yes", "\t}",
          "\tfor_each_loop = {", f"\t\tarray = {P}_states", "\t\tvalue = opmap_st", "\t\tindex = opmap_i",
          "\t\tset_temp_variable = { opmap_fr = 1 }",
          "\t\tif = {", f"\t\t\tlimit = {{ var:opmap_st = {{ CONTROLLER = {{ {P}_is_axis = yes }} }} }}",
          "\t\t\tset_temp_variable = { opmap_fr = 2 }", "\t\t}",
          "\t\telse_if = {", f"\t\t\tlimit = {{ var:opmap_st = {{ CONTROLLER = {{ {P}_is_comintern = yes }} }} }}",
          "\t\t\tset_temp_variable = { opmap_fr = 4 }", "\t\t}",
          "\t\telse_if = {", f"\t\t\tlimit = {{ var:opmap_st = {{ CONTROLLER = {{ {P}_is_allies = yes }} }} }}",
          "\t\t\tset_temp_variable = { opmap_fr = 3 }", "\t\t}",
          f"\t\tset_variable = {{ {P}_f^opmap_i = opmap_fr }}", "\t}", "}", ""]
    write(f"common/scripted_effects/{P}_effects.txt", "\n".join(e))

    # ---- scripted triggers (country scope = controller of a state)
    t = [hdr,
         f"{P}_is_axis = {{\n\tOR = {{\n\t\ttag = GER\n\t\tAND = {{ country_exists = GER is_in_faction_with = GER }}\n\t\tAND = {{ country_exists = GER is_subject_of = GER }}\n\t}}\n}}\n",
         f"{P}_is_comintern = {{\n\tOR = {{\n\t\ttag = SOV\n\t\tAND = {{ country_exists = SOV is_in_faction_with = SOV }}\n\t\tAND = {{ country_exists = SOV is_subject_of = SOV }}\n\t}}\n}}\n",
         f"{P}_is_allies = {{\n\tOR = {{\n\t\ttag = ENG\n\t\ttag = USA\n\t\tAND = {{ country_exists = ENG is_in_faction_with = ENG }}\n\t\tAND = {{ country_exists = USA is_in_faction_with = USA }}\n\t\tAND = {{ country_exists = ENG is_subject_of = ENG }}\n\t\tAND = {{ country_exists = USA is_subject_of = USA }}\n\t}}\n}}\n"]
    write(f"common/scripted_triggers/{P}_triggers.txt", "\n".join(t))

    # ---- on_actions
    oa = [hdr, "on_actions = {",
          "\ton_startup = {", "\t\teffect = {",
          f"\t\t\tevery_country = {{ limit = {{ original_tag = GER is_ai = no }} {P}_update = yes }}",
          "\t\t}", "\t}",
          "\ton_daily_GER = {", "\t\teffect = {", "\t\t\t# days left of running operations (shown in the tooltips)"]
    for key, flag, *_ in ops:
        oa += [f"\t\t\tif = {{ limit = {{ has_country_flag = {flag} check_variable = {{ {P}_days_{key} > 0 }} }} "
               f"subtract_from_variable = {{ {P}_days_{key} = 1 }} }}"]
    oa += [f"\t\t\tif = {{ limit = {{ is_ai = no }} {P}_update = yes }}",
          "\t\t\t# the AI used to take these as decisions; now it starts them itself when they become available",
          "\t\t\telse = {"]
    for key, *_ in ops:
        oa += [f"\t\t\t\tif = {{ limit = {{ {P}_{key}_startable = yes }} random = {{ chance = 10 {P}_{key}_start = yes }} }}"]
    oa += ["\t\t\t}", "\t\t}", "\t}", "}", ""]
    write(f"common/on_actions/{P}_on_actions.txt", "\n".join(oa))

    # ---- localisation
    op_names = {
        "taif": "Операция «Тайфун»", "blau": "План «Блау»", "lenik": "Наступление на Ленинград",
        "balt": "Операция «Двойная голова»", "beni": "Арденская операция",
        "balaton": "Балатонская оборонительная операция", "pomerania": "Операция «Солнцестояние»",
        "ukroxa": "Украинская операция", "belarus": "Беларусская операция",
    }
    L = ["l_russian:", f' {P}_LEG_AXIS:0 "Ось"', f' {P}_LEG_ALLIES:0 "Союзники"', f' {P}_LEG_COMINTERN:0 "Коминтерн"',
         f' {P}_LEG_NEUTRAL:0 "Нейтралы"', f' {P}_LEG_ACTIVE:0 "Активная"', f' {P}_LEG_SELECTED:0 "Выбрана"',
         f' {P}_SHOW_ALL:0 "Показать все операции"',
         f' {P}_TT_ALL:0 "Показать на карте районы всех операций.\\n§RКрасной обводкой§! всегда отмечены идущие операции."']
    # conditions shown with a live tick/cross; must mirror GER_opmap_<key>_visible/_available
    # in common/scripted_triggers/GER_opmap_operations.txt
    COND = {
        "hist": ("has_country_flag = VUP_Hist_version", "Исторический режим"),
        "barb": ("NOT = { has_idea = GER_barbarossa }", "Нет духа «Операция «Барбаросса»»"),
        "warsov": ("has_war_with = SOV", "Война с СССР"),
        "warusa": ("has_war_with = USA", "Война с США"),
        "date42": ("date > 1942.01.1", "После 1 января 1942"),
        "date42b": ("date > 1942.06.20", "После 20 июня 1942"),
        "noblau": ("NOT = { has_country_flag = GER_blau }", "Не идёт план «Блау»"),
        "notaif": ("NOT = { has_country_flag = GER_taif }", "Не идёт операция «Тайфун»"),
        "nobalt": ("NOT = { has_country_flag = GER_balt }", "Не идёт операция «Двойная голова»"),
        "nolenik": ("NOT = { has_country_flag = GER_lenik }", "Не идёт наступление на Ленинград"),
        "brand": ("64 = { is_controlled_by = GER }", "Бранденбург под контролем Германии"),
    }
    req = {
        "taif": ["hist", "barb", "warsov", "date42", "noblau"],
        "blau": ["hist", "barb", "warsov", "date42b", "notaif"],
        "lenik": ["hist", "barb", "warsov", "date42", "nobalt"],
        "balt": ["hist", "barb", "warsov", "date42", "nolenik"],
        "beni": ["hist", "barb", "warusa"],
        "balaton": ["hist", "barb", "warsov"],
        "pomerania": ["hist", "barb", "warsov", "brand"],
        "ukroxa": ["hist", "barb", "warsov"],
        "belarus": ["hist", "barb", "warsov"],
    }
    for c, (trig, txt) in COND.items():
        L += [f' {P}_C_{c.upper()}_Y:0 "£trigger_yes {txt}"', f' {P}_C_{c.upper()}_N:0 "£trigger_no {txt}"']
    L += [f' {P}_C_NOTDONE_Y:0 "£trigger_yes Операция ещё не проводилась"',
          f' {P}_C_NOTDONE_N:0 "£trigger_no Операция ещё не проводилась"']

    def cond_lines(key):
        return "\\n".join(f"[{P}_c_{c}]" for c in req[key]) + f"\\n[{P}_c_notdone_{key}]"
    days = {"taif": 202, "blau": 149, "lenik": 83, "balt": 92, "beni": 60, "balaton": 45, "pomerania": 45,
            "ukroxa": 150, "belarus": 150}
    L += [f' {P}_START_TXT:0 "Начать: [{P}_sel_name]"',
          f' {P}_START_TT:0 "[{P}_start_status]"',
          f' {P}_NONE:0 "выберите операцию"',
          f' {P}_ST_NONE:0 "Выберите операцию кнопкой выше, затем нажмите здесь, чтобы её начать."',
          f' {P}_EMPTY:0 ""',
          f' {P}_ST_DONE:0 "§gОперация уже проводилась — повторно её начать нельзя.§!"']
    btn_names = dict(op_names, balaton="Балатонская операция")   # short labels leave room for the tick/cross
    for key, flag, sts, *_ in ops:
        K = key.upper()
        L += [f' {P}_BTN_{K}:0 "{btn_names[key]}"',
              f' {P}_RUN_{K}:0 "\\n§YОперация идёт: осталось [?{P}_days_{key}|0] д.§!"',
              f' {P}_ST_ACT_{K}:0 "§RОперация уже идёт§! — осталось §Y[?{P}_days_{key}|0]§! д."']
        L += [f' {P}_TT_{K}:0 "§Y{op_names[key]}§![{P}_run_{key}]\\n'
              f'Областей в районе операции: §Y{len(sts)}§!, длительность: §Y{days[key]}§! д.\\n\\n'
              f'§YУсловия:§!\\n{cond_lines(key)}\\n\\n§gНажмите, чтобы выбрать операцию, затем «Начать» внизу.§!"',
              f' {P}_ST_OK_{K}:0 "§GМожно начать.§!\\n${flag}_tt$\\n\\n{cond_lines(key)}"',
              f' {P}_ST_NO_{K}:0 "§RУсловия не выполнены:§!\\n{cond_lines(key)}"']
    write(f"localisation/russian/{P}_l_russian.yml", "\n".join(L) + "\n", bom=True)

    # ---- scripted localisation: name of the selected op and why it can / cannot start
    d = [hdr, f"defined_text = {{", f"\tname = {P}_sel_name"]
    for n, (key, flag, *_) in enumerate(ops, 1):
        d += [f"\ttext = {{ trigger = {{ check_variable = {{ {P}_sel = {n} }} }} localization_key = {flag} }}"]
    d += [f"\ttext = {{ localization_key = {P}_NONE }}", "}", "", "defined_text = {", f"\tname = {P}_start_status"]
    for n, (key, flag, *_) in enumerate(ops, 1):
        sel = f"check_variable = {{ {P}_sel = {n} }}"
        d += [f"\ttext = {{ trigger = {{ {sel} has_country_flag = {flag} }} localization_key = {P}_ST_ACT_{key.upper()} }}",
              f"\ttext = {{ trigger = {{ {sel} has_country_flag = {P}_done_{key} }} localization_key = {P}_ST_DONE }}",
              f"\ttext = {{ trigger = {{ {sel} {P}_{key}_startable = yes }} localization_key = {P}_ST_OK_{key.upper()} }}",
              f"\ttext = {{ trigger = {{ {sel} }} localization_key = {P}_ST_NO_{key.upper()} }}"]
    d += [f"\ttext = {{ localization_key = {P}_ST_NONE }}", "}", ""]
    # "running, N days left" line in the operation button tooltip
    for key, flag, *_ in ops:
        d += ["defined_text = {", f"\tname = {P}_run_{key}",
              f"\ttext = {{ trigger = {{ has_country_flag = {flag} }} localization_key = {P}_RUN_{key.upper()} }}",
              f"\ttext = {{ localization_key = {P}_EMPTY }}", "}", ""]
    # one tick/cross per condition, evaluated live in the tooltip
    for c, (trig, txt) in COND.items():
        d += ["defined_text = {", f"\tname = {P}_c_{c}",
              f"\ttext = {{ trigger = {{ {trig} }} localization_key = {P}_C_{c.upper()}_Y }}",
              f"\ttext = {{ localization_key = {P}_C_{c.upper()}_N }}", "}", ""]
    for key, flag, *_ in ops:
        d += ["defined_text = {", f"\tname = {P}_c_notdone_{key}",
              f"\ttext = {{ trigger = {{ NOT = {{ has_country_flag = {P}_done_{key} }} }} localization_key = {P}_C_NOTDONE_Y }}",
              f"\ttext = {{ localization_key = {P}_C_NOTDONE_N }}", "}", ""]
    write(f"common/scripted_localisation/{P}_loc.txt", "\n".join(d))


if __name__ == "__main__":
    main()
