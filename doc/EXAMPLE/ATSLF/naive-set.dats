(*
**
** some native set-theoretic stuff
**
** Author: Hongwei Xi
** Ahthoremail: hwxiATcsDOTbuDOTedu
** TIme: December 21, 2009
**
*)

(* ****** ****** *)
//
// HX-2012-06-12:
// This code is ported to ATS2 without any changes
// HX-2014-01-06: Tidying-up a bit
//
(* ****** ****** *)

propdef PROPEQ
  (P1: prop, P2: prop) = (P1 -> P2, P2 -> P1)
stadef == = PROPEQ

(* ****** ****** *)
//
datasort elt = // abstract
datasort set = // abstract
//
absprop IN (elt, set)
//
(* ****** ****** *)

dataprop SETEQ
  (set, set) = {x:set} SETEQ (x, x)
// end of [SETEQ]

(* ****** ****** *)
//
extern praxi
extensionality {X1,X2:set}
  (pf: {x:elt} IN (x, X1) == IN (x, X2)): SETEQ (X1, X2)
//
(* ****** ****** *)

sta union_set_set: (set, set) -> set
stadef + = union_set_set
sta inter_set_set: (set, set) -> set
stadef * = inter_set_set

(* ****** ****** *)

dataprop
por (A: prop, B: prop) =
  inl (A, B) of A | inr (A, B) of B

(* ****** ****** *)

extern
praxi union_intr1{X,Y:set}
  {x:elt} (pf: IN (x, X)): IN (x, X+Y)

extern
praxi union_intr2{X,Y:set}
  {x:elt} (pf: IN (x, Y)): IN (x, X+Y)

extern
praxi union_elim{X,Y:set}
  {x:elt} (pf: IN (x, X+Y)): por (IN (x, X), IN (x, Y))

(* ****** ****** *)

extern
praxi inter_intr{X,Y:set}
  {x:elt} (pf1: IN (x, X), pf2: IN (x, Y)): IN (x, X*Y)

extern
praxi inter_elim1{X,Y:set}{x:elt} (pf: IN (x, X*Y)): IN (x, X)

extern
praxi inter_elim2{X,Y:set}{x:elt} (pf: IN (x, X*Y)): IN (x, Y)

(* ****** ****** *)

prfn union_assoc
  {X,Y,Z:set} ()
: SETEQ ((X+Y)+Z, X+(Y+Z)) = let
  stadef XY_Z = (X+Y)+Z and X_YZ = X+(Y+Z)
  prfn f{x:elt}
    (pf: IN (x, XY_Z)): IN (x, X_YZ) =
  (
    case+ union_elim {X+Y,Z} (pf) of
    | inl pfXY => (
      case+ union_elim {X,Y} (pfXY) of
      | inl pfX => union_intr1{X,Y+Z}(pfX)
      | inr pfY => union_intr2{X,Y+Z}(union_intr1 {Y,Z} (pfY))
      ) (* end of [inl] *)
    | inr pfZ => union_intr2{X,Y+Z}(union_intr2 {Y,Z} (pfZ))
  ) (* end of [f] *)
  prfn g {x:elt}
    (pf: IN (x, X_YZ)): IN (x, XY_Z) =
  (
    case+ union_elim {X,Y+Z} (pf) of
    | inl pfX =>
      union_intr1 {X+Y,Z} (union_intr1 {X,Y} (pfX))
    | inr pfYZ => (
      case+ union_elim {Y,Z} (pfYZ) of
      | inl pfY => union_intr1 {X+Y,Z} (union_intr2 {X,Y} (pfY))
      | inr pfZ => union_intr2 {X+Y,Z} (pfZ)
      ) (* end of [inr] *)
  ) (* end of [g] *)
in
  extensionality {XY_Z, X_YZ} (lam {x:elt} => (f{x}, g{x}))
end // end of [union_assoc]

(* ****** ****** *)

prfn inter_assoc
  {X,Y,Z:set} ()
: SETEQ ((X*Y)*Z, X*(Y*Z)) = let
  stadef XY_Z = (X*Y)*Z and X_YZ = X*(Y*Z)
  prfn f{x:elt}
    (pf: IN (x, XY_Z)): IN (x, X_YZ) = let
    prval pfXY = inter_elim1 {X*Y,Z} (pf)
    prval pfX = inter_elim1 {X,Y} (pfXY)
    prval pfY = inter_elim2 {X,Y} (pfXY)
    prval pfZ = inter_elim2 {X*Y,Z} (pf)
    prval pfYZ = inter_intr {Y,Z} (pfY, pfZ)
  in
    inter_intr (pfX, pfYZ)
  end // end of [f]
  prfn g{x:elt}
    (pf: IN (x, X_YZ)): IN (x, XY_Z) = let
    prval pfX = inter_elim1 {X,Y*Z} (pf)
    prval pfYZ = inter_elim2 {X,Y*Z} (pf)
    prval pfY = inter_elim1 {Y,Z} (pfYZ)
    prval pfZ = inter_elim2 {Y,Z} (pfYZ)
    prval pfXY = inter_intr {X,Y} (pfX, pfY)
  in
    inter_intr (pfXY, pfZ)
  end // end of [g]
in
  extensionality {XY_Z, X_YZ} (lam {x:elt} => (f{x}, g{x}))
end // end of [inter_assoc]

(* ****** ****** *)

prfn
inter_union_distribute
  {X,Y,Z:set} ()
: SETEQ (X*(Y+Z), X*Y+X*Z) = let
  prfn f{x:elt}
    (pf: IN (x, X*(Y+Z))): IN (x, X*Y+X*Z) = let
    prval pfX = inter_elim1 {X,Y+Z} (pf)
    prval pfU_YZ = inter_elim2 {X,Y+Z} (pf)
  in
    case+ union_elim (pfU_YZ) of
    | inl pfY => union_intr1{X*Y,X*Z}(inter_intr {X,Y} (pfX, pfY))
    | inr pfZ => union_intr2{X*Y,X*Z}(inter_intr {X,Z} (pfX, pfZ))
  end // end of [f]
  prfn g{x:elt}
    (pf: IN (x, X*Y+X*Z)): IN (x, X*(Y+Z)) =
  (
    case+ union_elim {X*Y,X*Z} (pf) of
    | inl pfI_XY => inter_intr {X,Y+Z}
        (inter_elim1{X,Y}(pfI_XY), union_intr1{Y,Z}(inter_elim2 {X,Y} pfI_XY))
    | inr pfI_XZ => inter_intr {X,Y+Z}
        (inter_elim1{X,Z}(pfI_XZ), union_intr2{Y,Z}(inter_elim2 {X,Z} pfI_XZ))
    // end of [case]
  ) (* end of [g] *)
in
  extensionality {X*(Y+Z),X*Y+X*Z} (lam {x:elt} => (f{x}, g{x}))
end // end of [inter_union_distribute]

(* ****** ****** *)

prfn
union_inter_distribute
  {X,Y,Z:set} ()
: SETEQ (X+(Y*Z), (X+Y)*(X+Z)) = let
  prfn f{x:elt}
    (pf: IN (x, X+(Y*Z))): IN (x, (X+Y)*(X+Z)) =
  (
    case+ union_elim (pf) of
    | inl pfX =>
      inter_intr {X+Y,X+Z}
        (union_intr1{X,Y}(pfX), union_intr1{X,Z}(pfX))
      // end of [inl]
    | inr pfI_YZ => let
        prval pfY = inter_elim1{Y,Z}(pfI_YZ)
        prval pfZ = inter_elim2{Y,Z}(pfI_YZ)
      in
        inter_intr {X+Y,X+Z} (union_intr2{X,Y}(pfY), union_intr2{X,Z}(pfZ))
      end // end of [inr]
  ) // end of [f]
  prfn g{x:elt}
    (pf: IN (x, (X+Y)*(X+Z))): IN (x, X+(Y*Z)) = let
    prval pfU_XY = inter_elim1 {X+Y,X+Z} (pf)
    prval pfU_XZ = inter_elim2 {X+Y,X+Z} (pf)
  in
    case+ union_elim (pfU_XY) of
    | inl pfX => union_intr1 {X,Y*Z} (pfX)
    | inr pfY => (
      case+ union_elim (pfU_XZ) of
      | inl pfX => union_intr1 {X,Y*Z} (pfX)
      | inr pfZ => union_intr2 {X,Y*Z} (inter_intr{Y,Z} (pfY, pfZ))
      ) (* end of [inr] *)
  end // end of [g]
in
  extensionality {X+(Y*Z), (X+Y)*(X+Z)} (lam {x:elt} => (f{x}, g{x}))
end // end of [union_inter_distribute]

(* ****** ****** *)

(* end of [naive-set.dats] *)
