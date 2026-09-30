import Sqpack.S11Opt.Split.Interface

/-!
# U4 — local isolation of Trump's packing (PROOF.md §7)

Owner: (unassigned).  Inputs: `global-math/FOCUSED-LOCAL-RECTANGLE.md` (the analytic argument),
`global-math/audit_focused_local_box.py` and its receipt `focused1024-local-box-independent.json`
(radii `r₀ … r₃₂`, curvature bounds `K`), `candidate-capture/focused1024-local-certificate.json`
(24 MB), `classical/trump-local-weighted-coordinate-radius.json` (11 MB: 8,448 non-negative
integer dual vectors, 128 derivative branches × 42 rows × 33 columns, entries in `Q(u)`), jlevy's
`isolation_radius.py` and `tangent_cones.py`.
Tools: `S11Opt.ctr`, `S11Opt.ang` (the packing, degree-≤7 polynomials in `u₀`), `P_u₀`, the
interval Horner check `hIv` (Basic), `disjoint_of_dir` (sufficient direction only).
New mathematics: (i) the **necessary** direction of the separating-axis theorem for two squares
(weak separation along an edge normal of one of them); (ii) second-derivative bounds `K` and
Taylor's theorem with remainder for the corner gaps; (iii) the dual argument with `τ`.
Weight: the most mathematical unit (≈ 3,000–6,000 lines); data 1–3 CPU hours of kernel checking.
-/

namespace SquarePacking.S11Opt.Split

/-- The radii `r₀ … r₃₂` of the focused rectangle (centre coordinates in unit lengths, angles in
radians; square `i` uses `r (3i)`, `r (3i+1)`, `r (3i+2)`).  To be filled from the receipt. -/
noncomputable def focusedR : Fin 33 → ℝ := sorry

/-- The poses within the focused rectangle around Trump's packing (labels as in `S11Opt.ctr`). -/
def InFocused (c : Fin 11 → ℝ × ℝ) (θ : Fin 11 → ℝ) : Prop :=
  ∀ i : Fin 11, |(c i).1 - (S11Opt.ctr i).1| ≤ focusedR ⟨3 * i, by omega⟩ ∧
    |(c i).2 - (S11Opt.ctr i).2| ≤ focusedR ⟨3 * i + 1, by omega⟩ ∧
    |θ i - S11Opt.ang i| ≤ focusedR ⟨3 * i + 2, by omega⟩

/-- **U4.**  In `[0, T]²`, the only packing in the focused rectangle is Trump's. -/
theorem local_isolation {c : Fin 11 → ℝ × ℝ} {θ : Fin 11 → ℝ} (h : PackIn (box T) c θ)
    (hf : InFocused c θ) : c = S11Opt.ctr ∧ θ = S11Opt.ang := by
  sorry

end SquarePacking.S11Opt.Split
