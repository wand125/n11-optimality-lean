import Sqpack.S11Opt.Split.U2Generic
import Sqpack.S11Opt.Split.U2Prior
import Sqpack.S11Opt.Split.U2Returned
import Sqpack.S11Opt.Split.U3D4
import Sqpack.S11Opt.Split.U5Case438
import Sqpack.S11Opt.Split.UField

/-!
# U6 — the composition `minSide 11 = T` (PROOF.md §10)

Owner: 9c.  No `sorry` here beyond `frame` (a translation, 9c): the units' theorems compose.
-/

namespace SquarePacking.S11Opt.Split

/-- **The finite exclusion lemma**, from the units. -/
theorem noncandidate : NoncandidateExcluded := by
  intro i hi hc
  by_cases hg : i ∈ genericIdx
  · exact generic_excluded i hg
  by_cases hp : i ∈ priorIdx
  · exact prior_excluded i hp
  by_cases hr : i ∈ returnedIdx
  · exact returned_excluded i hr
  exact field_excluded i hi hc hg hp hr

/-- A packing in a square of side `S ≤ Ux`, translated into the centred frame (PROOF.md §3). -/
theorem frame {S : ℝ} (hSU : S ≤ Ux) (h : Packs 11 S) :
    ∃ (ctr : Fin 11 → ℝ × ℝ) (ang : Fin 11 → ℝ), PackIn (cbox S) ctr ang := by
  sorry

lemma T_lt_Ux : T < Ux := by simpa [Ux] using T_lt_U

/-- **No packing of 11 unit squares below `T`.** -/
theorem not_packs_below {S : ℝ} (hS : S < T) : ¬ Packs 11 S := by
  intro h
  obtain ⟨ctr, ang, hp⟩ := frame (le_of_lt (lt_trans hS T_lt_Ux)) h
  exact case438 hS (d4_bridge noncandidate (le_of_lt (lt_trans hS T_lt_Ux)) hp)

/-- **`s(11) = T`.** -/
theorem minSide_eq_T : minSide 11 = T := by
  refine le_antisymm minSide_le_T (le_csInf ⟨T, packs_T⟩ fun S hS => ?_)
  by_contra hlt
  exact not_packs_below (not_le.mp hlt) hS

end SquarePacking.S11Opt.Split
