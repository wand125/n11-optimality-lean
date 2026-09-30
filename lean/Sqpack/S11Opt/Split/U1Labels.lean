import Sqpack.S11Opt.Split.Interface

/-!
# U1 — labels: every small packing realizes a canonical case (PROOF.md §4)

Owner: (unassigned).  Inputs: `center-cover-symmetric-exact.json` (sha256 df7938d9…, vertices of
the 16 cells), the author's `audit_center_cover.py`.  Already available: `InCellU`,
`exists_cell` (every point lies in a cell), `hmask`, `Realizes.hmask`, `canonicalMasks` (Cells).

To prove:
1. centres of interior-disjoint unit squares are at distance `≥ 1` (open inscribed disks);
2. two points of the same closed cell are at distance `< 1`: `(Ux − 1)² diam(C_k)² < 1`
   (needs the cell ⊆ convex hull of its listed vertices, e.g. by a fan triangulation with exact
   barycentrics, then the maximum of the squared distance over vertex pairs);
3. hence 11 centres have 11 distinct labels; sort them; the sorted list or its half-turn is in
   `canonicalMasks`, and the half-turn about the centre maps `cbox S` to itself.
Weight: data small (16 cells); Lean moderate (≈ 300–600 lines).
-/

namespace SquarePacking.S11Opt.Split

/-- **U1.**  A packing of 11 unit squares in `cbox S` (`S ≤ Ux`) realizes some canonical case. -/
theorem realizes_canonical {S : ℝ} (hS : S ≤ Ux) {ctr : Fin 11 → ℝ × ℝ} {ang : Fin 11 → ℝ}
    (h : PackIn (cbox S) ctr ang) : ∃ J ∈ canonicalMasks, RealizesIn S J := by
  sorry

end SquarePacking.S11Opt.Split
