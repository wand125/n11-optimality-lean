import Sqpack.S11Opt.Split.U2Rules

/-!
# U2 — prior cases (76; PROOF.md §5)

Owner: (unassigned).  Inputs: research/frontier/ (2.33 GB), research/endpoint-audit/ (0.80 GB), global-math/all-overlay-support-253/ (D4 support half-planes, a necessary premise of some of these cases; replay_prior.py, audit_all_overlay_support.py, overlay_field_halfplanes_v2.py).  Checker: `audit_capture_v9.py` and its dependencies.
Tools: `U2Rules`, `FieldTree`/`FieldBridge` (box trees, ownership), `FieldGen`.
Weight: among the heaviest units (see `SPLIT.md`).
-/

namespace SquarePacking.S11Opt.Split

/-- **U2 (prior).** -/
theorem prior_excluded : ∀ i ∈ priorIdx, CaseExcluded (maskAt i) := by
  sorry

end SquarePacking.S11Opt.Split
