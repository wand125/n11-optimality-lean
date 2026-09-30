import Sqpack.S11Opt.Split.U2Generic
import Sqpack.S11Opt.Split.U2Prior
import Sqpack.S11Opt.Split.U2Returned
import Sqpack.S11Opt.Split.U3D4
import Sqpack.S11Opt.Split.U5Case438
import Sqpack.S11Opt.Split.UField

/-!
# U6 — the composition `minSide 11 = T` (PROOF.md §10)

Owner: 9c.  No `sorry` here: the units' theorems compose.
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

lemma coord_shift (c v : ℝ × ℝ) (θ : ℝ) (p : ℝ × ℝ) :
    coord (c + v) θ (p + v) = coord c θ p := by
  simp only [coord, Prod.fst_add, Prod.snd_add]; ext <;> simp only <;> ring

lemma mem_sq_shift {c v p : ℝ × ℝ} {θ L : ℝ} : p + v ∈ sq (c + v) θ L ↔ p ∈ sq c θ L := by
  simp only [sq, Set.mem_ofPred_eq, coord_shift]

lemma mem_sqInt_shift {c v p : ℝ × ℝ} {θ L : ℝ} : p + v ∈ sqInt (c + v) θ L ↔ p ∈ sqInt c θ L := by
  simp only [sqInt, Set.mem_ofPred_eq, coord_shift]

/-- A packing in a square of side `S`, translated into the centred frame (PROOF.md §3). -/
theorem frame {S : ℝ} (h : Packs 11 S) :
    ∃ (ctr : Fin 11 → ℝ × ℝ) (ang : Fin 11 → ℝ), PackIn (cbox S) ctr ang := by
  obtain ⟨ctr, ang, hin, hd⟩ := h
  set v : ℝ × ℝ := ((Ux - S) / 2, (Ux - S) / 2)
  refine ⟨fun i => ctr i + v, ang, fun i q hq => ?_, fun i j hij => ?_⟩
  · have hq' : (q - v) + v ∈ sq (ctr i + v) (ang i) 1 := by simpa using hq
    obtain ⟨h1, h2, h3, h4⟩ := hin i (mem_sq_shift.mp hq')
    simp only [Prod.fst_sub, Prod.snd_sub, v] at h1 h2 h3 h4
    exact ⟨by linarith, by linarith, by linarith, by linarith⟩
  · rw [Set.disjoint_left]
    intro q h1 h2
    have e : q = (q - v) + v := by simp
    rw [e] at h1 h2
    exact Set.disjoint_left.mp (hd i j hij) (mem_sqInt_shift.mp h1) (mem_sqInt_shift.mp h2)

lemma T_lt_Ux : T < Ux := by simpa [Ux] using T_lt_U

/-- **No packing of 11 unit squares below `T`.** -/
theorem not_packs_below {S : ℝ} (hS : S < T) : ¬ Packs 11 S := by
  intro h
  obtain ⟨ctr, ang, hp⟩ := frame h
  exact case438 hS (d4_bridge noncandidate (le_of_lt (lt_trans hS T_lt_Ux)) hp)

/-- **`s(11) = T`.** -/
theorem minSide_eq_T : minSide 11 = T := by
  refine le_antisymm minSide_le_T (le_csInf ⟨T, packs_T⟩ fun S hS => ?_)
  by_contra hlt
  exact not_packs_below (not_le.mp hlt) hS

end SquarePacking.S11Opt.Split
