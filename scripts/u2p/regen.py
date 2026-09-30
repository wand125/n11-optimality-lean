"""Regenerate the U2 case files recorded in a MANIFEST and compare their sha256.
Usage: python3 regen.py MANIFEST OUTDIR [JOBS] [CASE ...]
MANIFEST lines: `<sha256>  C<case>/<file>`; its header lines `# kmax <case> <k>` give the target
limit used for the case (default 16), `# prefix <P>` the module prefix."""
import hashlib
import multiprocessing as mp
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)


def gen(args):
    ci, kmax, prefix, outdir = args
    import gen_u2p as G
    G.KMAX = kmax
    J, steps = G.exclude(ci, log=lambda s: None)
    if steps is None:
        return ci, False
    G.emit_case(ci, J, steps, outdir, prefix)
    return ci, True


if __name__ == "__main__":
    man, outdir = sys.argv[1], sys.argv[2]
    jobs = int(sys.argv[3]) if len(sys.argv) > 3 else 1
    only = {int(c) for c in sys.argv[4:]}
    want, kmax, prefix = {}, {}, "U2P"
    for line in open(man):
        if line.startswith("# kmax "):
            _, _, c, k = line.split(); kmax[int(c)] = int(k)
        elif line.startswith("# prefix "):
            prefix = line.split()[2]
        elif line.strip() and not line.startswith("#"):
            h, f = line.split(); want[f] = h
    cases = sorted({int(f.split("/")[0][1:]) for f in want} - set() if not only else only)
    with mp.Pool(jobs) as pool:
        for ci, ok in pool.imap_unordered(gen, [(c, kmax.get(c, 16), prefix, outdir) for c in cases]):
            print(ci, "generated" if ok else "FAILED", flush=True)
    bad = 0
    for f, h in sorted(want.items()):
        if int(f.split("/")[0][1:]) not in cases:
            continue
        p = os.path.join(outdir, f)
        got = hashlib.sha256(open(p, "rb").read()).hexdigest() if os.path.exists(p) else None
        if got != h:
            bad += 1
            print("MISMATCH", f)
    print("OK" if not bad else f"{bad} mismatches")
    sys.exit(1 if bad else 0)
