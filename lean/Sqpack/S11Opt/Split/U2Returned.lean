import Sqpack.S11Opt.Split.U2Rules

/-!
# U2 — returned cases (173; PROOF.md §5)

Owner: (unassigned).  Inputs: inputs/returned/*.zip (6.37 GB, 615 members), inputs/CASE_ASSIGNMENTS.json (12 jobs), results/returned/.  Checker: `audit_capture_v9.py` and its dependencies.
Tools: `U2Rules`, `FieldTree`/`FieldBridge` (box trees, ownership), `FieldGen`.
Weight: among the heaviest units (see `SPLIT.md`).
-/

namespace SquarePacking.S11Opt.Split

/-- **U2 (returned).** -/
theorem returned_excluded : ∀ i ∈ returnedIdx, CaseExcluded (maskAt i) := by
  sorry

end SquarePacking.S11Opt.Split
