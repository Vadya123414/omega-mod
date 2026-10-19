"""One-time conversion: GER operation decisions -> scripted triggers/effects + end events, used by the opmap GUI."""
import os, re, shutil

MOD = r"C:\Users\User\Documents\Paradox Interactive\Hearts of Iron IV\mod\Vanila Upgrade 2.0"
SRC = os.path.join(MOD, "common", "decisions", "operations_ger.txt")
HERE = os.path.dirname(__file__)
BACKUP = os.path.join(HERE, "operations_ger.orig.txt")
KEYS = ["taif", "blau", "lenik", "balt", "beni", "balaton", "pomerania", "ukroxa", "belarus"]
P = "GER_opmap"

if not os.path.exists(BACKUP):
    shutil.copy(SRC, BACKUP)
text = open(BACKUP, encoding="utf-8-sig").read()


def block(t, start):
    """Return (inner, end) for the brace block whose '{' is at/after start."""
    i = t.index("{", start)
    depth = 0
    for j in range(i, len(t)):
        if t[j] == "{":
            depth += 1
        elif t[j] == "}":
            depth -= 1
            if depth == 0:
                return t[i + 1:j], j + 1
    raise ValueError("unbalanced")


def sub(inner, name):
    m = re.search(r"(?m)^\s*" + name + r"\s*=\s*\{", inner)
    if not m:
        return None
    return block(inner, m.start())[0]


def dedent(s, tabs):
    lines = [l.rstrip() for l in s.strip("\n").split("\n")]
    lines = [l for l in lines if l.strip()]
    out = []
    for l in lines:
        l = l.replace("    ", "\t")
        out.append("\t" * tabs + l.lstrip("\t ") if False else "\t" * tabs + l.strip())
    return out


ops = {}
spans = {}
for key in KEYS:
    m = re.search(r"(?m)^\tGER_" + key + r"\s*=\s*\{", text)
    inner, end = block(text, m.start())
    spans[key] = (m.start(), end)
    days = int(re.search(r"days_remove\s*=\s*(\d+)", inner).group(1))
    ops[key] = dict(available=sub(inner, "available"), visible=sub(inner, "visible"),
                    complete=sub(inner, "complete_effect"), remove=sub(inner, "remove_effect"), days=days)


def indent_block(s, base):
    """Re-indent a block body keeping relative nesting by brace depth."""
    s = re.sub(r"#[^\n]*", "", s)
    out, depth = [], 0
    for raw in s.split("\n"):
        l = raw.strip()
        if not l:
            continue
        d = depth - (1 if l.startswith("}") else 0)
        out.append("\t" * (base + max(d, 0)) + l)
        depth += l.count("{") - l.count("}")
    return out


hdr = ("# GER operations (former decisions from common/decisions/operations_ger.txt).\n"
       "# Started from the operations map GUI (GER_opmap_ui); conditions and effects are the original ones.\n")
T = [hdr]
for k, o in ops.items():
    T += [f"{P}_{k}_visible = {{"] + indent_block(o["visible"], 1) + ["}"]
    T += [f"{P}_{k}_available = {{"] + indent_block(o["available"], 1) + ["}"]
    T += [f"{P}_{k}_startable = {{", f"\t{P}_{k}_visible = yes", f"\t{P}_{k}_available = yes",
          f"\tNOT = {{ has_country_flag = {P}_done_{k} }}", f"\tNOT = {{ has_country_flag = GER_{k} }}", "}", ""]
T += [f"{P}_any_active = {{", "\tOR = {"] + [f"\t\thas_country_flag = GER_{k}" for k in ops] + ["\t}", "}", ""]
T += [f"{P}_any_visible = {{", "\tOR = {"] + [f"\t\t{P}_{k}_visible = yes" for k in ops] + ["\t}", "}", ""]
open(os.path.join(MOD, "common", "scripted_triggers", f"{P}_operations.txt"), "w", encoding="utf-8", newline="\n").write("\n".join(T))

E = [hdr]
for n, (k, o) in enumerate(ops.items(), 1):
    E += [f"{P}_{k}_start = {{"] + indent_block(o["complete"], 1) + [
        f"\tset_country_flag = {P}_done_{k}",
        f"\tset_variable = {{ {P}_days_{k} = {o['days']} }}   # days left, counted down in GER_opmap_on_actions",
        f"\thidden_effect = {{ country_event = {{ id = {P}.{n} days = {o['days']} }} }}", "}"]
    E += [f"{P}_{k}_end = {{"] + indent_block(o["remove"], 1) + [f"\tclear_variable = {P}_days_{k}", "}", ""]
open(os.path.join(MOD, "common", "scripted_effects", f"{P}_operations.txt"), "w", encoding="utf-8", newline="\n").write("\n".join(E))

V = [hdr, f"add_namespace = {P}", ""]
for n, k in enumerate(ops, 1):
    V += ["country_event = {", f"\tid = {P}.{n}", "\thidden = yes", "\tis_triggered_only = yes",
          f"\timmediate = {{ {P}_{k}_end = yes }}", "}", ""]
open(os.path.join(MOD, "events", f"{P}_events.txt"), "w", encoding="utf-8", newline="\n").write("\n".join(V))

# remove the 9 decisions, keep everything else (GER_case_anton)
out, last = [], 0
for k in KEYS:
    s, e = spans[k]
    out.append(text[last:s])
    last = e
out.append(text[last:])
new = "".join(out)
new = re.sub(r"\n[ \t]*\n(?:[ \t]*\n)+", "\n\n", new)
open(SRC, "w", encoding="utf-8", newline="\n").write(new)
print({k: o["days"] for k, o in ops.items()})
