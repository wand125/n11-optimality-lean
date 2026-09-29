# Lean formalization toward s(11) = T (eleven unit squares)

Work in progress on a Lean 4 formalization of the computer-assisted proof, by
**Queuing Theory #1 Fan**, that Walter Trump's 1979 packing of 11 unit squares
is optimal:

> s(11) = T ≈ 3.8770835900, where T = (6u + 4)/(1 + 2u − u²) and u is the root in
> (9/25, 37/100) of 5u⁸ − 10u⁷ − 2u⁶ + 14u⁵ + 12u⁴ − 6u³ + 2u² + 2u − 1.

The proof being formalized is
[Queuingtheorydotcom/11SquaresOptimal](https://github.com/Queuingtheorydotcom/11SquaresOptimal),
commit `f9e0de713a0949d1bc6a0fa6b59d96edf6c3d65c`. The definitions of packings
(`Packs`, `minSide`, `sq`, `sqInt`, `box`), the admissibility lemma and the
kernel-checked containment test `ptOk` come from Evan Daniel's Lean project
[evand/square-packing](https://github.com/evand/square-packing) (`s12/lean`,
commit `6e1223c`, MIT), which is fetched by the build script and not copied.

## What is kernel-checked

All four theorems below depend only on the standard axioms `propext`,
`Classical.choice` and `Quot.sound`. No `sorry`, no `native_decide`, no new
`axiom`.

**1. The upper bound (Trump's packing).**

```lean
theorem SquarePacking.S11Opt.minSide_le_T : minSide 11 ≤ T
theorem SquarePacking.S11Opt.minSide_lt_U : minSide 11 < 387708359002281417731 / 10 ^ 20
```

`u₀` is defined as the unique root of the polynomial in (9/25, 37/100)
(intermediate value theorem, and P' > 0 there). Every coordinate of the packing
is written as a polynomial of degree ≤ 7 in u₀ with rational coefficients. The
44 wall inequalities (11 tight) and the 55 pairwise separations (14 contacts)
are each proved as an exact polynomial identity modulo P plus the sign of the
remainder on an isolating interval of width 10⁻⁴⁰. The sign is checked by the
kernel with an interval Horner evaluator whose soundness is proved once.
Separation uses the sufficient direction of the separating-axis theorem along
an edge normal (`disjoint_of_dir`).

**2. The first baseline field certificate, `field-00`, re-proved.**

```lean
theorem SquarePacking.S11Opt.F00.field00 {n : ℕ} (ctr : Fin n → ℝ × ℝ) (ang : Fin n → ℝ)
    (hin : ∀ i, sq (ctr i) (ang i) 1 ⊆ box Ux)
    (hdisj : ∀ i j, i ≠ j → Disjoint (sqInt (ctr i) (ang i) 1) (sqInt (ctr j) (ang j) 1))
    (σ : ℕ → Fin n) (hσ : ∀ a ∈ supp, ∀ b ∈ supp, σ a = σ b → a = b)
    (hcell : ∀ a ∈ supp, InCellU a (ctr (σ a))) : False
```

No family of unit squares in [0, U]² (U = 3.87708359002281417731) with
pairwise disjoint interiors has distinct squares whose centres lie in the
closed Voronoi cells 1, 2, 4, 5, 8, 9 and 13 of the author's 16-site centre
cover (`supp`).

**3. The transfer: field-00 excludes 126 of the 2184 canonical cases.**

```lean
def SquarePacking.S11Opt.CaseExcluded (J : List ℕ) : Prop := ¬ Realizes J
theorem SquarePacking.S11Opt.F00.excluded00_all : ∀ J ∈ excluded00, CaseExcluded J
lemma  SquarePacking.S11Opt.F00.excluded00_length : excluded00.length = 126
```

`canonicalMasks` (2184 sets of 11 cells, `J ≤ halfturn J`) and the 126 sets are
the same as the author's `canonical_eleven_cell_subsets` and
`transferred_canonical_mask_indices` for field-00.

### How field-00 is re-proved

Our argument follows the author's field certificate, but it is organized so that
none of the author's numerical values need to be trusted.

- **Capacity one of majority features** (`Majority.lean`, `FieldBridge.lean`).
  Take a feature with 2k − 1 sites. Call a set TRUE for it if the set meets the
  convex hull of every k-subset of the sites. Two disjoint open convex sets
  cannot both be TRUE. Proof: separate them by a line (Hahn–Banach); one closed
  side contains k sites, and the hull of those k sites misses the set on the
  other side. This is the capacity rule of the author's `majority_hull`
  features. PROOF.md does not state it.
- **A box-tree checker** (`FieldTree.lean`). Over pose space (centre, u = tan(θ/2)
  ∈ [0, 1]), a leaf certifies one of three things for every admissible pose in
  its box:
  - the wall-clipped box is empty;
  - a Voronoi bisector excludes the box;
  - one "option" holds: for each group of the option, one candidate point lies
    in the square. This uses evand's `ptOk`.

  Soundness is proved once (`soundF`). The trees are shipped as digit streams and
  decoded in the kernel.
- **Strictness without a boundary argument** (`FieldBridge.lean`). Everything is
  checked in the world scaled by 1/s, s = 1 − 2⁻²⁰. A point in the *closed* unit
  square about c/s is, after scaling back, in the *open* unit square about c.
- **The certificate** (generated in `F00/`):
  - For each of cells 1, 5 and 9, every admissible square with centre in the
    cell does one of two things. Either it contains a witness point of every
    majority hull of one of the two features (barycentric witnesses, checked in
    the kernel), or it contains a point owned by another square.
  - For each of the 37 owned points, the point lies inside its owner's square in
    every admissible pose with centre in the owner's cell.
  - The three squares in cells 1, 5 and 9 would therefore need three TRUE
    features among two. Each feature has capacity one, so this is impossible.
- **Size.** The cover trees have 104k leaves and the ownership trees 196k. The
  kernel time is about 740 CPU seconds in total (about 2.5 ms per leaf).

**What we use from the author's data.** We use only the structure of field-00:
which sites form each feature and its threshold, which cells have positive
thresholds, and which cells are owners. We also use the 16 Voronoi sites of the
centre cover (`center-cover-symmetric-exact.json`). The sites, witness points
and owned points in our certificate are our own grid points, rounded from the
author's values. The capacity argument holds for any points, so these values
need not be trusted. Floating point is used only to choose grid points; every
claim is checked exactly by the kernel. The author's two files are downloaded by
`build.sh` from the pinned commit and checked by SHA256; they are not
redistributed here.

## Not yet formalized

The following parts of the author's proof are not formalized yet. Section
numbers refer to PROOF.md; stage numbers S0–S7 are from our plan.

- The other 58 baseline field certificates (1,904 cases in all). They also use
  `threshold` and `floor` features.
- The 34 generic certificates and the "owned-hull induction" (R1–R7) used for
  the remaining 32 + 76 + 173 cases and for case 438.
- The injectivity half of the centre cover (at most one centre per cell). The
  covering half is `exists_cell`.
- The D4 bridge.
- The local isolation of Trump's configuration (the focused rectangle; this
  needs the necessary direction of the separating-axis theorem and a Taylor
  bound).
- The final composition giving `minSide 11 = T`.

## Reproduce

Requires `git`, `curl`, Python ≥ 3.8 (standard library only), and
[elan](https://github.com/leanprover/elan). The toolchain
`leanprover/lean4:v4.33.1` is selected by the upstream project.

```sh
N11_JOBS=2 sh build.sh /tmp/n11-lean-build
```

The work directory must not exist. The script does the following:

1. Clones and pins the upstream commit, and overlays `lean/Sqpack/S11Opt`.
2. Downloads the author's two input files and checks their hashes.
3. Regenerates all data and compares it with `MANIFEST.sha256`; the generation
   is deterministic.
4. Rejects `sorry`, `native_decide` and `axiom`.
5. Downloads the Mathlib cache and builds the upper bound, the field-00 trees
   (`N11_JOBS` at a time) and the final assembly.
6. Requires all four axiom reports to be the standard three, and prints
   `N11_LEAN_BUILD_VERIFIED`.

Measured on an Apple M4 Mac mini with `N11_JOBS=2`: 47 minutes wall, about
20 CPU-minutes of user time (the Mathlib cache download and the build of the
upstream dependencies are included). Peak memory is about 2 GB per process.

## Files

- `lean/Sqpack/S11Opt/` contains the hand-written files:
  - `Basic` — interval Horner check, separation lemma, and the root and T;
  - `Upper` — Trump's packing and `minSide_le_T`;
  - `Majority` — capacity one;
  - `FieldTree` — the box-tree checker;
  - `FieldBridge` — scaling, angles, barycentric checks;
  - `Cells` — Voronoi cells, `Realizes`/`CaseExcluded`, the half-turn, canonical cases;
  - `Axioms`.
- `scripts/` contains the generators:
  - `gen.py` writes `Data.lean` for the upper bound, using `field.py` for exact
    arithmetic in Q(u) and `construct.py` for Trump's packing (closed forms after
    the author's pinned `trump11/packing.py`, from jlevy/squares `c55726e`);
  - `field_tree.py` writes the field-00 trees;
  - `gen_final.py` writes the field-00 assembly.
- `MANIFEST.sha256` lists the SHA256 of every generated file.
- `REPLAY.md` summarizes our independent re-run of the author's verifier.

## Attribution and license

The mathematical proof, the certificates and the field-00 structure are by
Queuing Theory #1 Fan. The packing is Walter Trump's (1979); the exact closed
forms follow jlevy/squares. The Lean definitions of packings and the containment
checker `ptOk` are Evan Daniel's (MIT; see `UPSTREAM-LICENSE.txt`). The
formalization in this repository is released under the MIT license (`LICENSE`).
