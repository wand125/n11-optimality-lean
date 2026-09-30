import Sqpack.S11Opt.Split.U2Rules

/-!
# U2 — generic cases (27; PROOF.md §5)

Owner: (unassigned).  Inputs: results/baseline-portable/generic-*.json and research/phase3/work/phase3/generic/*.json (34 certificates, 30–57 MB each; the generic mode of v9).  Checker: `audit_capture_v9.py` and its dependencies.
Tools: `U2Rules`, `FieldTree`/`FieldBridge` (box trees, ownership), `FieldGen`.
Weight: among the heaviest units (see `SPLIT.md`).
-/

namespace SquarePacking.S11Opt.Split

/-- **U2 (generic).** -/
theorem generic_excluded : ∀ i ∈ genericIdx, CaseExcluded (maskAt i) := by
  sorry

end SquarePacking.S11Opt.Split
