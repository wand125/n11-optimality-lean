import Sqpack.S11Opt.Split.U1Labels

/-!
# U3 — the D4 bridge to case 438 (PROOF.md §6)

Owner: (unassigned).  Inputs: `phase2/geometry/cover_overlay_exact.json` (220 overlay regions:
212 polygons and 8 points), `overlay_distance_pairs.json` (1,572 strict distance bans),
`results/d4-bridge.json`, checker `finalization/global-composition/audit_d4_bridge.py`,
note `docs/D4-BRIDGE-THEOREM.md`.  Tools: `Cells` (Voronoi cells in H-representation: an overlay
region `⋂ₖ gₖ⁻¹(C_{lₖ})` is again a list of half-planes), evand's `D4.lean` (`reflX`, `swapXY`,
`sq_add_pi_div_two`), U1 (labels in every view).  The distance bans need the maximum of the
squared distance over two regions, i.e. vertices (share the vertex lemma with U1).  The CSP is
small (75/61/31 search nodes for 999/1462/1659): kernel `decide`, seconds to minutes.
Weight: moderate (≈ 500–1,000 lines, data < 1 MB).
-/

namespace SquarePacking.S11Opt.Split

/-- **U3.**  If every non-candidate case is excluded, every packing of 11 unit squares in
`cbox S` has a D4 image (in the same `cbox S`) realizing exactly the cells of case 438. -/
theorem d4_bridge (hNC : NoncandidateExcluded) {S : ℝ} (hS : S ≤ Ux) {ctr : Fin 11 → ℝ × ℝ}
    {ang : Fin 11 → ℝ} (h : PackIn (cbox S) ctr ang) : RealizesIn S J438 := by
  sorry

end SquarePacking.S11Opt.Split
