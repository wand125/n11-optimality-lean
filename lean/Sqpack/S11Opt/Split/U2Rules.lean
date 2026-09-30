import Sqpack.S11Opt.Split.Interface

/-!
# U2 — the owned-hull induction (PROOF.md §5): shared rules

Owner: (unassigned; 9c proposes to take it together with U2a–c).  Used by U2a–c and U5.

The author's generic, prior and returned exclusions and the case-438 capture are inductions on
*outer pose domains* (every possible pose of a square) and *owned points* (points inside that
square in every surviving pose); checker `audit_capture_v9.py` (rules R1–R7 in
`docs/flow/2026-09/2026-09-29-50-n11-optimal-lean-plan.md` §1).  This file fixes the semantic
notions so that the family files can be proved independently.  Suggested route (as for the field
certificates): re-prove each case with box trees over poses (`FieldTree`), round by round, rather
than transcribing the author's rational polygon arrangements.
-/

namespace SquarePacking.S11Opt.Split

/-- A realization of case `J` in `cbox S` with its labelling. -/
structure Real (S : ℝ) (J : List ℕ) where
  n : ℕ
  ctr : Fin n → ℝ × ℝ
  ang : Fin n → ℝ
  pack : PackIn (cbox S) ctr ang
  σ : ℕ → Fin n
  inj : ∀ a ∈ J, ∀ b ∈ J, σ a = σ b → a = b
  cell : ∀ a ∈ J, InCellU a (ctr (σ a))

/-- `D` contains every possible pose of the square of cell `o` (centre, angle), in every
realization of `J` in `cbox S`. -/
def PoseDomain (S : ℝ) (J : List ℕ) (o : ℕ) (D : ℝ × ℝ → ℝ → Prop) : Prop :=
  ∀ r : Real S J, D (r.ctr (r.σ o)) (r.ang (r.σ o))

/-- `p` lies in the open square of cell `o` in every realization of `J` in `cbox S`. -/
def Owned (S : ℝ) (J : List ℕ) (o : ℕ) (p : ℝ × ℝ) : Prop :=
  ∀ r : Real S J, p ∈ sqInt (r.ctr (r.σ o)) (r.ang (r.σ o)) 1

/-- Terminal rule R7: two different owners owning a common point, or an empty pose domain. -/
theorem excluded_of_owned_twice {S : ℝ} {J : List ℕ} {o o' : ℕ} (ho : o ∈ J) (ho' : o' ∈ J)
    (hne : o ≠ o') {p : ℝ × ℝ} (h1 : Owned S J o p) (h2 : Owned S J o' p) : ¬ RealizesIn S J := by
  sorry

theorem excluded_of_empty {S : ℝ} {J : List ℕ} {o : ℕ} (ho : o ∈ J) {D : ℝ × ℝ → ℝ → Prop}
    (hD : PoseDomain S J o D) (hempty : ∀ c θ, ¬ D c θ) : ¬ RealizesIn S J := by
  sorry

end SquarePacking.S11Opt.Split
