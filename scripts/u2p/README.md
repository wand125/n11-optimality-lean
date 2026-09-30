# Generator for U2 (prior; also usable for generic and returned)

Excludes a canonical case by the owned-hull induction with box trees (`U2P/Rules.lean`:
`owned_all_of_tris`, `excluded_of_tris`).  Pure Python (standard library only); the sites are read
from `lean/Sqpack/S11Opt/Cells.lean`, no file of the author is needed.

```sh
python3 gen_u2p.py CASE OUTDIR [PREFIX]           # one case; CASE is the index of `maskAt`
U2P_PREFIX=U2P python3 batch.py JOBS OUTDIR CASES  # many cases in parallel, OUTDIR/summary.jsonl
```

Output `OUTDIR/C<case>/`: `Data.lean` (cells, owned hulls, triangle options), `S<k>.lean` (the box
tree of step `k`, chunks of at most 1,500 leaves), `Main.lean` (the chain of promotions and the
terminal step; `theorem excluded : CaseExcluded (maskAt CASE)`).  Modules are
`Sqpack.S11Opt.Split.<PREFIX>.C<case>.*`.

* Owner step: angle rows by U-splits (32), then X/Y splits; leaves wall / cell / dead (a lattice
  point of a fan triangle of another owner's hull, weights over `bm = 65536`, lies in every square
  of the box) / alive.  The new owned hull is the intersection of the ptOk regions (12 half-planes
  per leaf) of the alive leaves; the alive leaves that bind it are refined one level at a time.
* Round-robin over the owners until one owner has no alive leaf (terminal); only the steps the
  terminal step depends on are emitted.
* `check_case.sh`, `watch_check.sh`: the Lean check of generated cases on a build machine.
