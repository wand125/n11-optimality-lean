import Sqpack.S11Opt.Split.Interface

/-!
# UField — the 59 baseline field certificates (1,904 cases)

Owner: 9c (in progress: `S11Opt.F00`, `S11Opt.F01` … `F58`, `S11Opt.FieldAll`).  This unit also
does the index bookkeeping (the index lemmas `maskAt_438` etc. are in `Interface`): every non-candidate case outside the generic, prior and returned
lists is excluded by some field certificate (directly or through the half-turn).
-/

namespace SquarePacking.S11Opt.Split

/-- **UField.** -/
theorem field_excluded : ∀ i < 2184, i ∉ candIdx → i ∉ genericIdx → i ∉ priorIdx →
    i ∉ returnedIdx → CaseExcluded (maskAt i) := by
  sorry

end SquarePacking.S11Opt.Split
