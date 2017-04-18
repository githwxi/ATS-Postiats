(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: January, 2013
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<>
  ((*void*)) = prerr "pats_ccomp_claulst"
//
(* ****** ****** *)
//
staload
LAB = "./pats_label.sats"
staload
LOC = "./pats_location.sats"
//
staload SYN = "./pats_syntax.sats"
//
overload compare with $LAB.compare_label_label
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload
P2TC = "./pats_patcst2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

(*
extern
fun
tmprimval_make_none
  (pmv: primval): tmprimval
extern
fun
tmprimval_make_some
  (pmv: primval): tmprimval
//
implement
tmprimval_make_none
  (pmv) = TPMVnone (pmv)
implement
tmprimval_make_some
  (pmv) = let
  val loc = pmv.primval_loc
  val hse = pmv.primval_type
  val tmp = tmpvar_make (loc, hse)
in
  TPMVsome (tmp, pmv)
end // end of [tmprimval_make_some]
*)

(* ****** ****** *)
//
extern
fun
tmprimval2pmv
  (tpmv: tmprimval): primval
extern
fun
tmprimval2pmv2
  (tpmv: tmprimval, d2v: d2var): primval
//
(* ****** ****** *)

implement
tmprimval2pmv
  (tpmv) = let
(*
val () = println! ("tmprimval2pmv")
*)
in
//
case+ tpmv of
| TPMVnone (pmv) => pmv
| TPMVsome (tmp, _) => let
    val loc = tmpvar_get_loc (tmp) in primval_make_tmp (loc, tmp)
  end // end of [TPMVsome]
//
end // end of [tmprimval2pmv]

(* ****** ****** *)

implement
tmprimval2pmv2
  (tpmv, d2v) = let
//
fun ptrof (pmv: primval): primval =
  primval_ptrof (pmv.primval_loc, hisexp_typtr, pmv)
//
val ismut = d2var_is_mutabl (d2v)
//
in
//
case+ tpmv of
| TPMVnone (pmv) =>
    if ismut then ptrof (pmv) else pmv
| TPMVsome (tmp, pmv) =>
  (
    if ismut then ptrof (pmv) else let
      val loc =
        tmpvar_get_loc (tmp) in primval_make_tmp (loc, tmp)
      // end of [val]
    end // end of [if]
  ) // end of [TPMVsome]
//
end // end of [tmprimval2pmv2]

(* ****** ****** *)

implement
fprint_tmprimval
  (out, x) = let
//
macdef
prstr(str) =
fprint_string (out, ,(str))
//
in
//
case+ x of
| TPMVnone (pmv) =>
  {
    val () = prstr "TPMVnone("
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
| TPMVsome (tmp, pmv) =>
  {
    val () = prstr "TPMVsome("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr "<-"
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
end // end of [fprint_tmprimval]

(* ****** ****** *)

extern
fun
tmpmovlst_add
(
  tmvlst: &tmpmovlst_vt
, tpmv1: tmprimval, tpmv2: tmprimval
) : void // end of [tmpmovlst_add]

(* ****** ****** *)

implement
tmpmovlst_add
  (tmvlst, tpmv1, tpmv2) = let
//
(*
val
out = stdout_ref
//
val () =
fprintln! (out, "tmpmovlst_add: tpmv1 = ", tpmv1)
val () =
fprintln! (out, "tmpmovlst_add: tpmv2 = ", tpmv2)
*)
//
in
//
case+ tpmv2 of
| TPMVnone _ => ()
| TPMVsome (tmp2, _) =>
  (
    tmvlst := list_vt_cons ((tpmv1, tmp2), tmvlst)
  ) (* end of [TPMVsome] *)
end // end of [tmpmovlst_add]

(* ****** ****** *)

datatype
matoken =
  | MTKpat of (hipat, tmprimval)
  | MTKlabpat of (label, hipat, tmprimval)
  | MTKrparen of ()
// end of [matoken]

typedef matokenlst = List (matoken)

(* ****** ****** *)

(*
extern
fun
fprint_matoken (out: FILEref, x: matoken): void
extern
fun
fprint_matokenlst (out: FILEref, xs: matokenlst): void
*)

(* ****** ****** *)

typedef
patckontref = ref(patckont)

(* ****** ****** *)
//
extern
fun
patckontref_make
  ((*void*)): patckontref
implement
patckontref_make
  ((*void*)) = ref_make_elt<patckont>(PTCKNTnone)
//
extern
fun
patckontref_make_loc
  (loc: location): patckontref
implement
patckontref_make_loc
  (loc) = ref_make_elt<patckont>(PTCKNTcaseof_fail(loc))
//
(* ****** ****** *)

datatype
patcomp =
//
  | PTCMPany of (d2var)
  | PTCMPvar of (d2var, tmprimval)
  | PTCMPasvar of (d2var, tmprimval)
//
  | PTCMPlablparen of (label)
//
  | PTCMPpatlparen of
    (
      patck, tmprimval, tmplab, pckindopt, patckontref
    ) (* end of [PTCMPpatlparen] *)
  | PTCMPreclparen of (tmprimval, tmplab)
//
  | PTCMPrparen of ()
//
  | PTCMPpatneg of (patck, tmprimval)
//
  | PTCMPtmplabend of (tmplab)
  | PTCMPtmplabgua of (tmplab, patckontref)
// end of [patcomp]

typedef patcomplst = List (patcomp)
typedef patcomplstlst = List (patcomplst)
vtypedef patcomplst_vt = List_vt (patcomp)

(* ****** ****** *)
//
extern
fun
fprint_patcomp
  (out: FILEref, x: patcomp): void
//
overload fprint with fprint_patcomp
//
(* ****** ****** *)

implement
fprint_patcomp
  (out, x0) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x0 of
//
| PTCMPany (d2v) =>
  {
    val () = prstr "PTCMPany("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| PTCMPvar (d2v, tpmv) =>
  {
    val () = prstr "PTCMPvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ", "
    val () = fprint_tmprimval (out, tpmv)
    val () = prstr ")"
  }
//
| PTCMPasvar (d2v, tpmv) =>
  {
    val () = prstr "PTCMPasvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ", "
    val () = fprint_tmprimval (out, tpmv)
    val () = prstr ")"
  }
//
| PTCMPlablparen (lab) =>
  {
    val () = prstr "PTCMPlablparen("
    val () = $LAB.fprint_label (out, lab)
    val () = prstr ")"
  }
//
| PTCMPpatlparen
    (ptck, tpmv, tlab, opt, kntr) =>
  {
    val () = prstr "PTCMPpatlparen("
    val () = fprint_patck (out, ptck)
    val () = prstr ", "
    val () = fprint_pckindopt (out, opt)
    val () = prstr ", "
    val () = fprint_tmprimval (out, tpmv)
    val () = prstr ", "
    val () = fprint_tmplab (out, tlab)
    val () = prstr ", "
    val () = fprint_patckont (out, !kntr)
    val () = prstr ")"
  }
//
| PTCMPreclparen
    (tpmv, tlab) =>
  {
    val () = prstr "PTCMPreclparen("
    val () = fprint_tmprimval (out, tpmv)
    val () = prstr ", "
    val () = fprint_tmplab (out, tlab)
    val () = prstr ")"
  }
//
| PTCMPrparen () =>
  {
    val () = prstr "PTCMPrparen()"
  }
//
| PTCMPpatneg (ptck, tpmv) =>
  {
    val () = prstr "PTCMPpatckneg("
    val () = fprint_patck (out, ptck)
    val () = prstr ", "
    val () = fprint_tmprimval (out, tpmv)
    val () = prstr ")"
  }
//
| PTCMPtmplabend (tlab) =>
  {
    val () = prstr "PTCMPtmplabend("
    val () = fprint_tmplab (out, tlab)
    val () = prstr ")"
  }
| PTCMPtmplabgua (tlab, kntr) =>
  {
    val () = prstr "PTCMPtmplabgua("
    val () = fprint_tmplab (out, tlab)
    val () = prstr ", "
    val () = fprint_patckont (out, !kntr)
    val () = prstr ")"
  }
//
end // end of [fprint_patcomp]

(* ****** ****** *)
//
extern
fun
fprint_patcomplst
  (out: FILEref, xs: patcomplst): void
extern
fun
fprint_patcomplstlst
  (out: FILEref, xs: patcomplstlst): void
//
overload fprint with fprint_patcomplst
overload fprint with fprint_patcomplstlst
//
(* ****** ****** *)

implement
fprint_patcomplst
  (out, xs) =
  $UT.fprintlst (out, xs, "; ", fprint_patcomp)
// end of [fprint_patcomplst]

implement
fprint_patcomplstlst
  (out, xss) =
  $UT.fprintlst (out, xss, "\n", fprint_patcomplst)
// end of [fprint_patcomplstlst]

(* ****** ****** *)

extern
fun
patcomplst_find_tmplab
  (xs: patcomplst): Option_vt (tmplab)
// end of [patcomplst_find_tmplab]

(* ****** ****** *)

implement
patcomplst_find_tmplab
  (xs) = let
(*
val () =
fprintln!
(
  stdout_ref
, "patcomplst_find_tmplab: xs = ", xs
) (* end of [val] *)
*)
in
//
case+ xs of
//
| list_nil() => None_vt()
//
| list_cons(x, xs) => let
  in
    case x of
    | PTCMPpatlparen
        (_, _, tl, _, _) => Some_vt (tl)
      // end of [PTCMPpatlparen]
    | PTCMPreclparen (_, tl) => Some_vt (tl)
    | PTCMPtmplabend (tl) => Some_vt (tl)
    | PTCMPtmplabgua (tl, _) => Some_vt (tl)
    | _ (*rest-patscomp*) => patcomplst_find_tmplab (xs)
  end // end of [list_cons]
//
end // end of [patcomplst_find_tmplab]

(* ****** ****** *)
//
extern
fun
patcomplst_find_guafail
  (xs: patcomplst): patckont
//
implement
patcomplst_find_guafail
  (xs) = let
//
(*
val
out = stdout_ref
val () =
fprintln!
( out,
  "patcomplst_find_guafail: xs = ", xs
) (* end of [val] *)
*)
//
in
//
case+ xs of
//
| list_cons(x, xs) => let
(*
    val () = fprintln!(out, "x = ", x)
*)
  in
    case+ x of
    | PTCMPtmplabgua(_, kntr) => !kntr
    | _ (*non-PTCMPtmplabgua*) => patcomplst_find_guafail(xs)
  end (* end of [list_cons] *)
//
| list_nil((*void*)) => PTCKNTnone(*void*)
//
end // end of [patcomplst_find_guafail]
//
(* ****** ****** *)
//
extern
fun
patcomplst_unskip
  (xs: patcomplst, na: &int >> int): patcomplst
extern
fun
patcomplst_unrparen
  (xs: patcomplst, na: &int >> int): patcomplst
//
(* ****** ****** *)

implement
patcomplst_unskip (xs, na) = let
//
fun auxlst
(
  xs: patcomplst, na: &int >> int
) : patcomplst = let
in
//
case+ xs of
| list_nil() =>
    list_nil((*void*))
  // end of [list_nil]
| list_cons(x, xs) =>
  (
    case+ x of
//
    | PTCMPany _ => xs
    | PTCMPvar _ => xs
    | PTCMPasvar _ => auxlst (xs, na)
//
    | PTCMPlablparen _ => auxlst2 (1(*plvl*), xs, na)
//
    | PTCMPpatlparen _ => let
        val () = na := na + 1 in auxlst2 (1(*plvl*), xs, na)
      end // end of [PTCMPconlparen]
//
    | PTCMPreclparen _ => let
        val () = na := na + 1 in auxlst2 (1(*plvl*), xs, na)
      end // end of [reclparen]
//
    | PTCMPrparen _ => let val () = assertloc (false) in xs end
//
    | _ (*rest-of-patcomp*) => xs
//
  ) (* end of [list_cons] *)
//
end // end of [auxlst]
//
and auxlst2
(
  plvl: int
, xs: patcomplst, na: &int >> int
) : patcomplst = let
in
//
case+ xs of
| list_nil() =>
    list_nil((*void*))
  // end of [list_nil]
| list_cons(x, xs) =>
  (
    case+ x of
//
    | PTCMPany _ => auxlst2 (plvl, xs, na)
    | PTCMPvar _ => auxlst2 (plvl, xs, na)
    | PTCMPasvar _ => auxlst2 (plvl, xs, na)
//
    | PTCMPlablparen _ => auxlst2 (plvl+1, xs, na)
//
    | PTCMPpatlparen _ => let
        val () = na := na + 1 in auxlst2 (plvl+1, xs, na)
      end // end of [PTCMPconlparen]
    | PTCMPreclparen _ => let
        val () = na := na + 1 in auxlst2 (plvl+1, xs, na)
      end // end of [PTCMPreclparen]
//
    | PTCMPrparen () =>
      (
        if plvl = 0 then xs else auxlst2 (plvl, xs, na)
      ) // end of [PTCMPrparen]
//
    | _ (* rest-of-PTCMP *) => auxlst2 (plvl, xs, na)
//
  ) (* end of [list_cons] *)
//
end // end of [auxlst2]
//
in
  auxlst (xs, na)
end // end of [patcomplst_unskip]

(* ****** ****** *)

implement
patcomplst_unrparen
  (xs0, na) = let
in
//
case+ xs0 of
| list_nil() =>
    list_nil((*void*))
  // end of [list_nil]
| list_cons(x, xs1) =>
  (
    case+ x of
    | PTCMPrparen _ => xs1
    | _ => let
        val xs0 =
          patcomplst_unskip (xs0, na)
        // end of [val]
      in
        patcomplst_unrparen (xs0, na)
      end // end of [_]
  ) (* end of [list_cons] *)
//
end // end of [patcomplst_unrparen]

(* ****** ****** *)

extern
fun
patcomplst_subtest
  (xs1: patcomplst, xs2: patcomplst): patckont
// end of [patcomplst_subtest]
extern
fun
patcomplst_subtests
  (xs1: patcomplst, xss2: patcomplstlst): patckont
// end of [patcomplst_subtests]

(* ****** ****** *)
//
extern
fun
patck_isbin (ptck: patck): bool
extern
fun
patck_ismat (ptck1: patck, ptck2: patck): bool
//
(* ****** ****** *)

implement
patck_isbin (ptck) = let
in
//
case+ ptck of
| PATCKbool _ => true
| PATCKcon (d2c) =>
    if d2con_is_con (d2c) then d2con_is_binarian (d2c) else false
  // end of [PATCKcon]
| _ => false
end // end of [patck_isbin]

(* ****** ****** *)

implement
patck_ismat
  (ptck1, ptck2) = let
in
//
case+ ptck1 of
//
| PATCKcon (d2c1) =>
  (
  case+ ptck2 of
  | PATCKcon (d2c2) => d2c1 = d2c2 | _ => false
  )
//
| PATCKint (i1) =>
  (case+ ptck2 of PATCKint (i2) => i1 = i2 | _ => false)
| PATCKbool (b1) =>
  (case+ ptck2 of PATCKbool (b2) => b1 = b2 | _ => false)
| PATCKchar (c1) =>
  (case+ ptck2 of PATCKchar (c2) => c1 = c2 | _ => false)
| PATCKstring (str1) =>
  (case+ ptck2 of PATCKstring (str2) => str1 = str2 | _ => false)
//
(*
| PATCKi0nt of (i0nt)
| PATCKf0loat of (f0loat)
*)
//
| _ (*rest-of-PATCK*) => false
end // end of [patck_ismat]

(* ****** ****** *)

local

typedef
patcomplst1 = List1(patcomp)

fun
auxlst
(
  xs10: patcomplst
, xs20: patcomplst
, tmvlst: &tmpmovlst_vt
) : Option_vt (patcomplst) = let
in
//
case xs10 of
//
| list_nil() => Some_vt(xs20)
//
| list_cons _ =>
  (
    case+ xs20 of
    | list_nil _ => None_vt ()
    | list_cons _ => auxlst2 (xs10, xs20, tmvlst)
  )
//
end // end of [auxlst]

and
auxlst2
(
  xs10: patcomplst1
, xs20: patcomplst1
, tmvlst: &tmpmovlst_vt
) : Option_vt (patcomplst) = let
//
val+list_cons (x1, xs1) = xs10
val+list_cons (x2, xs2) = xs20
//
val out = stdout_ref
//
(*
val () = fprintln! (out, "auxlst2: x1 = ", x1)
val () = fprintln! (out, "auxlst2: xs1 = ", xs1)
val () = fprintln! (out, "auxlst2: x2 = ", x2)
val () = fprintln! (out, "auxlst2: xs2 = ", xs2)
*)
//
in
//
case+ x2 of
//
| PTCMPany _ => let
    var na: int = 0
    val xs1 = patcomplst_unskip (xs10, na)
  in
    auxlst (xs1, xs2, tmvlst)
  end
//
| PTCMPvar _ => let
    var na: int = 0
    val xs1 = patcomplst_unskip (xs10, na)
  in
    auxlst (xs1, xs2, tmvlst)
  end
//
| PTCMPasvar _ => auxlst (xs10, xs2, tmvlst)
//
| PTCMPrparen _ => let
    var na: int = 0
    val xs1 = patcomplst_unrparen (xs10, na)
  in
    auxlst (xs1, xs2, tmvlst)
  end
//
| _ when x1 as PTCMPany _ => Some_vt (xs20)
| _ when x1 as PTCMPvar _ => Some_vt (xs20)
//
| _ when x1 as PTCMPasvar _ => auxlst (xs1, xs20, tmvlst)
//
| _ when x1 as PTCMPrparen () => Some_vt (xs20)
//
| PTCMPlablparen (lab2) =>
  (
    case+ x1 of
    | PTCMPlablparen
        (lab1) => let
        val sgn = compare (lab1, lab2)
      in
        if sgn = 0 then auxlst (xs1, xs2, tmvlst) else None_vt ()
      end // end of [PTCMPlablparen]
    | _ => None_vt ()
  )
//
| PTCMPpatlparen
    (ptck2, tpmv2, _, _, _) =>
  (
    case+ x1 of
    | PTCMPpatneg
        (ptck1, tpmv1) => let
        val ismat = patck_ismat (ptck1, ptck2)
        val ((*void*)) =
          tmpmovlst_add (tmvlst, tpmv1, tpmv2)
        // end of [val]
      in
        if ismat
          then None_vt () else let
          val isbin = patck_isbin (ptck1)
        in
          if isbin then Some_vt (xs2) else Some_vt (xs20)
        end // end of [else] // end of [if]
      end // end of [PTCMPpatneg]
    | PTCMPpatlparen
        (ptck1, tpmv1, _, _, _) => let
        val ismat = patck_ismat (ptck1, ptck2)
        val ((*void*)) =
          tmpmovlst_add (tmvlst, tpmv1, tpmv2)
        // end of [val]
      in
        if ismat
          then auxlst (xs1, xs2, tmvlst) else None_vt(*void*)
        // end of [if]
      end // end of [PTCMPpatlparen]
    | _ (*non-PTCMPpatlparen*) => None_vt((*void*))
  )
//
// HX-2015-04-21:
// bug-2015-04-21 due to
// the following clause being missing
//
| PTCMPreclparen (tpmv2, _) =>
  (
    case+ x1 of
    | PTCMPreclparen (tpmv1, _) => let
        val ((*void*)) =
          tmpmovlst_add (tmvlst, tpmv1, tpmv2)
        // end of [val]
      in
        auxlst (xs1, xs2, tmvlst)
      end // end of [PTCMPreclparen]
    | _ (*non-PTCMPreclparen*) => None_vt((*void*))
  ) (* end of [PTCMPreclparen] *)
//
| _ (* rest-of-PTCMP *) => None_vt((*void*))
//
end // end of [auxlst2]

fun
auxmovfin
(
  xs2: patcomplst, tmvlst: &tmpmovlst_vt
) : void = let
//
(*
//
val
out = stdout_ref
val () =
  fprintln! (out, "auxmovfin: xs2 = ", xs2)
//
*)
//
fun ftpmv
(
  tpmv2: tmprimval
, tmvlst: &tmpmovlst_vt
) : void = 
(
  case+ tpmv2 of
  | TPMVnone
      (pmv) => ((*void*))
  | TPMVsome
      (tmp, pmv) => let
      val tpmv1 = TPMVnone (pmv)
    in
      tmpmovlst_add (tmvlst, tpmv1, tpmv2)
    end // end of [TPMVsome]
) (* end of [ftpmv] *)
//
in
//
case+ xs2 of
| list_nil() => ()
| list_cons(x2, xs2) => (
    case+ x2 of
    | PTCMPpatlparen
        (ptck2, tpmv2, _, _, _) => ftpmv (tpmv2, tmvlst)
      // end of [PTCMPpatlparen]
    | PTCMPreclparen (tpmv2, _) => ftpmv (tpmv2, tmvlst) // HX: bug-2013-12-04
    | _ (*rest-of-PTCMP...lparen*) => auxmovfin (xs2, tmvlst)
  ) (* end of [list_cons] *)
//
end // end of [auxmovfin]

in (* in of [local] *)

implement
patcomplst_subtest
  (xs10, xs20) = let
//
var tmvlst
  : tmpmovlst_vt = list_vt_nil()
//
val opt = auxlst(xs10, xs20, tmvlst)
//
in
//
case+
:(
  tmvlst: tmpmovlst_vt?
) => opt of
| ~None_vt() => let
    val () = list_vt_free<tmpmov>(tmvlst)
  in
    PTCKNTnone((*void*))
  end // end of [None_vt]
| ~Some_vt(xs2) => let
    val () = auxmovfin(xs2, tmvlst)
    val tmvlst = list_vt_reverse(tmvlst)
    val tmvlst = list_of_list_vt(tmvlst)
    val-~Some_vt(tlab) = patcomplst_find_tmplab(xs2)
  in
    PTCKNTtmplabmov(tlab, tmvlst)
  end // end of [some_vt]
//
end // end of [patcomplst_subtest]

end // end of [local]

(* ****** ****** *)

implement
patcomplst_subtests
  (xs1, xss2) = let
in
//
case+ xss2 of
| list_nil
    () => PTCKNTnone()
  // end of [list_nil]
| list_cons
    (xs2, xss2) => let
    val ptjmp = patcomplst_subtest(xs1, xs2)
  in
    case+ ptjmp of
    | PTCKNTnone() => patcomplst_subtests(xs1, xss2) | _ => ptjmp
  end // end of [list_cons]
//
end // end of [patcomplst_subtests]

(* ****** ****** *)
//
extern
fun
patcomplst_jumpfill_rest
  (xs1: patcomplst, xss2: patcomplstlst): void
//
(* ****** ****** *)

implement
patcomplst_jumpfill_rest
  (xs1, xss2) = let
//
(*
val out = stdout_ref
val ((*void*)) =
fprintln! (out, "patcomplst_jumpfill_rest: xs1 = ", xs1)
*)
//
fun auxlst
(
  xs1: patcomplst
, xss2: patcomplstlst
, rxs: patcomplst_vt
) : void = let
in
//
case+ xs1 of
| list_nil() =>
    list_vt_free (rxs)
  // end of [list_nil]
| list_cons
    (x1, xs1) => let
    val () = (
      case+ x1 of
      | PTCMPpatlparen
        (
          ptck, tpmv, tlab, opt, kntr
        ) => let
          val rxs1 = list_vt_copy(rxs)
          val rxs1 = list_vt_cons(PTCMPpatneg(ptck, tpmv), rxs1)
          val pxs1 = list_vt_reverse(rxs1)
          val ptjmp = patcomplst_subtests($UN.linlst2lst(pxs1), xss2)
          val ((*freed*)) = list_vt_free(pxs1)
        in
          !kntr := ptjmp
        end (* end of [PTCMPpatlparen] *)
      | PTCMPtmplabgua(tlab, kntr) => let
          val rxs1 = list_vt_copy(rxs)
          val pxs1 = list_vt_reverse(rxs1)      
          val ptjmp = patcomplst_subtests($UN.linlst2lst(pxs1), xss2)
          val ((*freed*)) = list_vt_free(pxs1)
        in
          case+ ptjmp of // HX-2016-10-11: fixing bug-2016-10-08
          | PTCKNTnone() => () | _(*non-PTCKNTnone*) => !kntr := ptjmp
        end (* end of [PTCMPtmplabgua] *)
      | _ (* rest-of-PTCMP *) => ((*void*))
    ) : void // end of [val]
  in
    auxlst (xs1, xss2, list_vt_cons(x1, rxs))
  end // end of [list_cons]
//
end // end of [auxlst]
//
in
  auxlst (xs1, xss2, list_vt_nil())
end // end of [patcomplst_jumpfill_rest]

(* ****** ****** *)
//
extern
fun
patcomplst_jumpfill_fail
  (xs: patcomplst, fail: patckont): void
//
(* ****** ****** *)

implement
patcomplst_jumpfill_fail
  (xs, fail) = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () = (
      case+ x of
      | PTCMPpatlparen
          (_, _, _, _, kntr) =>
        (
          case !kntr of PTCKNTnone () => !kntr := fail | _ => ()
        ) (* end of [PTCMPpatlparen] *)
      | _ (* non-PTCMPpatlparen *) => ()
    ) : void // end of [val]
  in
    patcomplst_jumpfill_fail (xs, fail)
  end // end of [list_cons]
//
end // end of [patcomplst_jumpfill_fail]

(* ****** ****** *)
//
extern
fun
patcomplstlst_jumpfill
  (xss: patcomplstlst, fail: patckont): void
//
(* ****** ****** *)

implement
patcomplstlst_jumpfill
  (xss, fail) = let
in
//
case+ xss of
| list_nil() => ()
| list_cons(xs, xss) => let
    val () = patcomplst_jumpfill_rest (xs, xss)
    val () = patcomplst_jumpfill_fail (xs, fail)
  in
    patcomplstlst_jumpfill (xss, fail)
  end // end of [list_cons]
//
end // end of [patcomplstlst_jumpfill]

(* ****** ****** *)
//
extern
fun
himatchlst_patcomp
(
  lvl0: int
, hicl: hiclau, pmvs: primvalist, hips: hipatlst
) : patcomplst // end of [himatchlst_patcomp]
//
(* ****** ****** *)

local

(* ****** ****** *)

fun
auxtpmv_make
(
  hip: hipat, pmv0: primval
) : tmprimval = let
  val loc = hip.hipat_loc
  val hse = hip.hipat_type
  val tmp = tmpvar_make (loc, hse)
in
  TPMVsome (tmp, pmv0)
end // end of [auxtpmv_make]

(* ****** ****** *)

fun
addrparen
(
  mtks: matokenlst
) : matokenlst = list_cons (MTKrparen (), mtks)

(* ****** ****** *)

fun
addselcon
(
  tpmv: tmprimval
, hse_sum: hisexp
, lxs: labhipatlst
, mtks: matokenlst
) : matokenlst = let
in
//
case+ lxs of
| list_nil() => mtks
| list_cons(lx, lxs) => let
    val+LABHIPAT (lab, hip) = lx
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
    val pmv = tmprimval2pmv (tpmv)
    val pmvsel = primval_selcon (loc, hse, pmv, hse_sum, lab)
    val tpmvsel = auxtpmv_make (hip, pmvsel)
    val mtk0 = MTKlabpat (lab, hip, tpmvsel)
    val mtks = addselcon (tpmv, hse_sum, lxs, mtks)
  in
    list_cons (mtk0, mtks)
  end // end of [list_cons]
//
end // end of [addselcon]

fun
addselect
(
  tpmv: tmprimval
, hse_rec: hisexp
, lxs: labhipatlst
, mtks: matokenlst
) : matokenlst = let
in
//
case+ lxs of
| list_nil() => mtks
| list_cons(lx, lxs) => let
    val+LABHIPAT (lab, hip) = lx 
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
    val pml = primlab_lab (loc, lab)
    val pmv = tmprimval2pmv (tpmv)
    val pmvsel = primval_select (loc, hse, pmv, hse_rec, pml)
    val tpmvsel = auxtpmv_make (hip, pmvsel)
    val mtk0 = MTKlabpat (lab, hip, tpmvsel)
    val mtks = addselect (tpmv, hse_rec, lxs, mtks)
  in
    list_cons (mtk0, mtks)
  end // end of [list_cons]
//
end // end of [addselect]

(* ****** ****** *)

fun
auxcomplst
(
  lvl0: int, mtks: matokenlst
) : patcomplst_vt = let
in
//
case+ mtks of
| list_nil() => list_vt_nil()
| list_cons
    (mtk, mtks) => auxcomplst_mtk (lvl0, mtk, mtks)
  // end of [list_cons]
//
end // end of [auxcomplst]

and
auxcomplst_mtk
(
  lvl0: int
, mtk0: matoken, mtks: matokenlst
) : patcomplst_vt = let
in
//
case+ mtk0 of
//
| MTKpat(hip, tpmv) =>
    auxcomplst_pat (lvl0, tpmv, hip, mtks)
//
| MTKlabpat
    (lab, hip, tpmv) =>
  (
    auxcomplst_labpat (lvl0, tpmv, lab, hip, mtks)
  ) (* end of [MTKlabpat] *)
//
| MTKrparen((*void*)) =>
  (
    list_vt_cons (PTCMPrparen (), auxcomplst (lvl0, mtks))
  ) (* end of [MTKrparen] *)
//
end // end of [auxcomplst_mtk]

and
auxcomplst_pat
(
  lvl0: int
, tpmv: tmprimval
, hip0: hipat
, mtks: matokenlst
) : patcomplst_vt = let
//
val loc0 = hip0.hipat_loc
//
in
//
case+
  hip0.hipat_node of
//
| HIPany d2v => let
    val ptcmp0 = PTCMPany(d2v)
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, ptcmps)
  end
| HIPvar d2v => let
    val (
    ) = d2var_set_level (d2v, lvl0)
    val nused = d2var_get_utimes (d2v)
    val ptcmp0 =
    (
      if nused > 0
        then PTCMPvar(d2v, tpmv) else PTCMPany(d2v)
      // end of [if]
    ) : patcomp // end of [val]
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, ptcmps)
  end // end of [HIPvar]
//
| HIPint (i) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val ptcmp0 =
      PTCMPpatlparen (PATCKint(i), tpmv, tl, None(*knd*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPint]
| HIPintrep (rep) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val i0 = $UT.llint_make_string (rep)
    val i0 = int_of_llint (i0)
    val ptcmp0 =
      PTCMPpatlparen (PATCKint(i0), tpmv, tl, None(*void*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPintrep]
//
| HIPbool (b) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val ptcmp0 =
      PTCMPpatlparen (PATCKbool(b), tpmv, tl, None(*knd*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPint]
//
| HIPchar (c) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val ptcmp0 =
      PTCMPpatlparen (PATCKchar(c), tpmv, tl, None(*knd*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPint]
//
| HIPstring (str) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val ptcmp0 =
      PTCMPpatlparen (PATCKstring(str), tpmv, tl, None(*knd*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPint]
//
| HIPfloat (rep) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val f = $UT.double_make_string (rep)
    val ptcmp0 =
      PTCMPpatlparen (PATCKfloat(f), tpmv, tl, None(*knd*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPint]
//
| HIPi0nt (tok) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val i0 = $P2TC.i0nt2intinf (tok)
    val i0 = $INTINF.intinf_get_int (i0)
    val ptcmp0 =
      PTCMPpatlparen (PATCKint(i0), tpmv, tl, None(*void*), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPi0nt]
//
| HIPempty () => auxcomplst (lvl0, mtks)
//
| HIPcon
  (
    knd, d2c, hse_sum, lxs
  ) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val mtks = addrparen (mtks)
    val mtks = addselcon (tpmv, hse_sum, lxs, mtks)
    val ptcmp0 =
      PTCMPpatlparen (PATCKcon(d2c), tpmv, tl, Some(knd), kntr)
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, ptcmps)
  end // end of [HIPcon]
//
| HIPcon_any
    (knd, d2c) => let
    val tl = tmplab_make (loc0)
    val kntr = patckontref_make ()
    val ptcmp0 =
      PTCMPpatlparen (PATCKcon(d2c), tpmv, tl, Some(knd), kntr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
  end // end of [HIPcon_any]
//
| HIPrec
  (
    knd, pck, lxs, hse_rec
  ) => let
    val tl = tmplab_make(loc0)
    val mtks = addrparen(mtks)
    val mtks = addselect(tpmv, hse_rec, lxs, mtks)
    val ptcmp0 = PTCMPreclparen(tpmv, tl)
    val ptcmps = auxcomplst(lvl0, mtks)
  in
    list_vt_cons (ptcmp0, ptcmps)
  end // end of [HIPrec]
//
| HIPrefas(d2v, hip) => let
    val (
    ) = d2var_set_level (d2v, lvl0)
    val ptcmp0 = PTCMPasvar (d2v, tpmv)
    val ptcmps = auxcomplst_pat (lvl0, tpmv, hip, mtks)
  in
    list_vt_cons (ptcmp0, ptcmps)
  end // end of [HIPrefas]
//
| HIPann(hip, _(*ann*)) =>
    auxcomplst_pat (lvl0, tpmv, hip, mtks)
  // end of [HIPann]
//
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = prerrln! (": himatchlst_patcomp: auxcomplst_pat: hip0 = ", hip0)
    val () = assertloc (false) in list_vt_nil(*void*)
  end // end of [_]
//
end // end of [auxcomplst_pat]

and
auxcomplst_labpat
(
  lvl0: int
, tpmv: tmprimval
, lab0: label, hip0: hipat
, mtks: matokenlst
) : patcomplst_vt = let
  val ptcmp0 = PTCMPlablparen (lab0)
  val ptcmp1 = PTCMPrparen ()
  val ptcmps = auxcomplst_pat (lvl0, tpmv, hip0, mtks)
in
  list_vt_cons (ptcmp0, list_vt_cons (ptcmp1, ptcmps))
end // end of [auxcomplst_labpat]

in (* in of [local] *)

implement
himatchlst_patcomp
  (lvl0, hicl, pmvs, hips) = let
//
fun auxloc
(
  hip: hipat, hips: hipatlst
) : location = let
in
//
case+ hips of
| list_cons
    (hip, hips) => auxloc (hip, hips)
  // end of [list_cons]
| list_nil() =>
    $LOC.location_rightmost (hip.hipat_loc)
  // end of [list_nil]
//
end // end of [auxloc]
//
fun auxlst
(
  pmvs: primvalist, hips: hipatlst
) : matokenlst = let
in
//
case+ pmvs of
| list_nil
    ((*void*)) => list_nil()
  // end of [list_nil]
| list_cons
    (pmv, pmvs) => let
    val tpmv = TPMVnone (pmv)
    val-list_cons (hip, hips) = hips
    val mtk0 = MTKpat (hip, tpmv)
    val mtks = auxlst (pmvs, hips)
  in
    list_cons (mtk0, mtks)
  end // end of [list_cons]
//
end // end of [auxlst]
//
in
//
case+ pmvs of
//
| list_nil
    ((*void*)) => list_nil()
  // end of [list_nil]
//
| list_cons
    (pmv, pmvs) => let
    val tpmv = TPMVnone (pmv)
    val-list_cons (hip, hips) = hips
    val lend = auxloc (hip, hips)
    val mtks = auxlst (pmvs, hips)
    val ptcmps = auxcomplst_pat (lvl0, tpmv, hip, mtks)
    val tlab = tmplab_make (lend)
    val isnot = list_is_nil (hicl.hiclau_gua)
    val ptcmpz =
    (
      if isnot
        then PTCMPtmplabend (tlab)
        else let
          val loc = hicl.hiclau_loc
          val kntr = patckontref_make_loc(loc) in PTCMPtmplabgua(tlab, kntr)
        end // end of [else]
      // end of [if]
    ) : patcomp // end of [val]
    val ptcmps = list_vt_extend (ptcmps, ptcmpz)
  in
    list_of_list_vt (ptcmps)
  end // end of [list_cons]
//
end // end of [himatchlst_patcomp]

end // end of [local]

(* ****** ****** *)
//
extern
fun
hiclau_patcomp
(
  lvl0: int
, hicl: hiclau, pmvs: primvalist
) : patcomplst // endfun
//
implement
hiclau_patcomp
  (lvl0, hicl, pmvs) = let
//
val hips = hicl.hiclau_pat
val ptcmps = himatchlst_patcomp (lvl0, hicl, pmvs, hips)
(*
val out = stdout_ref
val () = fprintln! (out, "hiclau_patcomp: hips =\n", hips)
val () = fprintln! (out, "hiclau_patcomp: ptcmps =\n", ptcmps)
*)
//
in
  ptcmps
end // end of [hiclau_patcomp]
//
(* ****** ****** *)

extern
fun
hiclaulst_patcomp
(
  lvl0: int
, hicls: hiclaulst, pmvs: primvalist
) : patcomplstlst // endfun
implement
hiclaulst_patcomp
  (lvl0, hicls, pmvs) = let
in
//
case+ hicls of
| list_nil
    ((*void*)) => list_nil()
  // end of [list_nil]
| list_cons
    (hicl, hicls) => let
    val xs = hiclau_patcomp (lvl0, hicl, pmvs)
    val xss = hiclaulst_patcomp (lvl0, hicls, pmvs)
  in
    list_cons (xs, xss)
  end // end of [list_cons]
//
end // end of [hiclaulst_patcomp]

(* ****** ****** *)

extern
fun
patcomplst_ccomp
  (env: !ccompenv, xs: patcomplst): instrlst_vt
// end of [patcomplst_ccomp]

(* ****** ****** *)

local

fun
addtpmv
(
  res: instrlst_vt, tpmv: tmprimval
) : instrlst_vt = let
in
//
case+ tpmv of
| TPMVnone _ => res
| TPMVsome
    (tmp, pmv) => let
    val loc = tmpvar_get_loc (tmp)
    val ins = instr_move_val (loc, tmp, pmv)
  in
    list_vt_cons (ins, res)
  end // end of [TPMVsome]
//
end (* end of [addtpmv] *)

fun
addtlab
(
  res: instrlst_vt, tlab: tmplab
) : instrlst_vt = let
  val loc = tmplab_get_loc (tlab)
  val ins = instr_tmplab (loc, tlab) in list_vt_cons (ins, res)
end // end of [addtlab]

(* ****** ****** *)

fun
addfreecon
(
  env: !ccompenv
, pmv: primval, opt: pckindopt, ptck: patck
) : void = let
in
//
case+ opt of
| Some (knd) => (
  case+ ptck of
  | PATCKcon(d2c) =>
      ccompenv_add_freeconenv_if(env, pmv, knd, d2c)
  | _(*non-PATCKcon*) => ((*nothing*))
  ) (* end of [Some] *)
| None ((*void*)) => ()
//
end // end of [addfreecon]

(* ****** ****** *)

fun
fptcmplst
(
  env: !ccompenv
, xs0: patcomplst
, res1: instrlst_vt
, res2: instrlst_vt
) : instrlst_vt = let
(*
val () = println! ("fptcmplst")
*)
in
//
case+ xs0 of
| list_nil() => let
    val
    res2 = list_vt_reverse(res2)
  in
    list_vt_reverse_append(res1, res2)
  end // end of [list_nil]
| list_cons(x0, xs1) =>
  (
    fptcmplst2(env, x0, xs1, res1, res2)
  ) (* end of [list_cons] *)
//
end (* end of [fptcmplst] *)

and
fptcmplst2
(
  env: !ccompenv
, x0: patcomp, xs1: patcomplst
, res1: instrlst_vt
, res2: instrlst_vt
) : instrlst_vt = let
(*
val () = println! ("fptcmplst2")
*)
in
//
case+ x0 of
| PTCMPany(d2v) =>
    fptcmplst(env, xs1, res1, res2)
  // end of [PTCMPany]
| PTCMPvar(d2v, tpmv) => let
    val pmv = tmprimval2pmv2(tpmv, d2v)
    val ((*void*)) =
      ccompenv_add_vbindmapenvall(env, d2v, pmv)
    val res2 = let
      val ismut = d2var_is_mutabl(d2v)
    in
      if ismut then res2 else addtpmv(res2, tpmv)
    end : instrlst_vt // end of [val]
  in
    fptcmplst (env, xs1, res1, res2)
  end // end of [PTCMPvar]
| PTCMPasvar(d2v, tpmv) => let
    val pmv = tmprimval2pmv2(tpmv, d2v)
    val ((*void*)) =
      ccompenv_add_vbindmapenvall(env, d2v, pmv)
  in
    fptcmplst (env, xs1, res1, res2)
  end // end of [PTCMPasvar]
//
| PTCMPpatlparen
  (
    ptck, tpmv, tlab, opt, kntr
  ) => let
    val res1 = addtpmv(res1, tpmv)
    val res1 = addtlab(res1, tlab)
//
    val pmv = tmprimval2pmv(tpmv)
    val ((*void*)) = addfreecon(env, pmv, opt, ptck)
    val ins = instr_patck(pmv.primval_loc, pmv, ptck, !kntr)
//
    val res1 = list_vt_cons(ins, res1)
//
  in
    fptcmplst (env, xs1, res1, res2)
  end // end of [PTCMPreclparen]
//
| PTCMPreclparen
    (tpmv, tlab) => let
    val res1 = addtpmv(res1, tpmv)
    val res1 = addtlab(res1, tlab)
  in
    fptcmplst (env, xs1, res1, res2)
  end // end of [PTCMPreclparen]
//
| PTCMPtmplabend
    (tlab) => let
    val res1 = addtlab(res1, tlab)
  in
    fptcmplst (env, xs1, res1, res2)
  end // end of [PTCMPtmplabend]
| PTCMPtmplabgua
    (tlab, _) => let
    val res1 = addtlab(res1, tlab)
  in
    fptcmplst (env, xs1, res1, res2)
  end // end of [PTCMPtmplabgua]
//
| _ (*non-PTCMP*) => fptcmplst(env, xs1, res1, res2)
//
end (* end of [fptcmplst2] *)

in (* in of [local] *)

implement
patcomplst_ccomp
  (env, xs) = let
//
(*
val () =
println! ("patcomplst_ccomp")
*)
//
in
  fptcmplst (env, xs, list_vt_nil(), list_vt_nil())
end // end of [patcomplst_ccomp]

end // end of [local]

(* ****** ****** *)
//
extern
fun
higmat_ccomp
(
  env: !ccompenv, res: !instrseq
, lvl0: int, hig: higmat, fail: patckont
) : void // end of [higmat_ccomp]
//
extern
fun
higmatlst_ccomp
(
  env: !ccompenv, res: !instrseq
, lvl0: int, higs: higmatlst, fail: patckont
) : void // end of [higmatlst_ccomp]
//
(* ****** ****** *)

implement
higmat_ccomp
(
  env, res, lvl0, hig, fail
) = let
//
val hde = hig.higmat_exp
//
val hip = (
//
case+
hig.higmat_pat of
| Some (hip) => hip
| None ((*void*)) => let
    val hse = hisexp_bool_t0ype ()
  in
    hipat_bool (hde.hidexp_loc, hse, true)
  end // end of [None]
//
) : hipat // end of [val]
//
val
pmv = hidexp_ccomp(env, res, hde)
//
val () = hipatck_ccomp(env, res, fail, hip, pmv)
val () = himatch_ccomp(env, res, lvl0, hip, pmv)
//
in
  // nothing
end // end of [higmat_ccomp]

implement
higmatlst_ccomp
  (env, res, lvl0, higs, fail) = let
//
(*
val () = println! ("higmatlst_ccomp")
*)
//
in
//
case+ higs of
| list_nil() => ()
| list_cons(hig, higs) => let
    val () =
      higmat_ccomp (env, res, lvl0, hig, fail)
    // end of [val]
  in
    higmatlst_ccomp (env, res, lvl0, higs, fail)
  end (* end of [list_cons] *)
//
end // end of [higmatlst_ccomp]

(* ****** ****** *)

local

fun auxcl
(
  env: !ccompenv
, lvl0: int
, hicl: hiclau
, ptcmps: patcomplst
, tmpret: tmpvar
) : ibranch = let
//
val res = instrseq_make_nil ()
//
val (pf0 | ()) = ccompenv_push (env)
val ((*void*)) = ccompenv_inc_freeconenv (env)
//
val inss = patcomplst_ccomp (env, ptcmps)
val ((*void*)) = instrseq_addlst_vt (res, inss)
//
val higs = hicl.hiclau_gua (* guard-list *)
//
val () = (
//
case+ higs of
| list_nil() => ()
| list_cons _ => let
    val () =
    instrseq_add_comment(res, "ibranch-guard:")
    val fail = patcomplst_find_guafail (ptcmps)
  in
    higmatlst_ccomp(env, res, lvl0, higs, fail)
  end // end of [list_cons]
//
) : void // end of [val]
//
val loc = hicl.hiclau_loc
//
val
pmvs_freecon =
  ccompenv_getdec_freeconenv(env)
//
val () =
  instrseq_add_freeconlst(res, loc, pmvs_freecon)
//
val () = instrseq_add_comment(res, "ibranch-mbody:")
//
val () =
hidexp_ccomp_ret(env, res, tmpret, hicl.hiclau_body)
//
val () = ccompenv_pop(pf0 | env)
//
val inss = instrseq_get_free(res)
//
(*
val () =
fprintln!
  (stdout_ref, "hiclaulst_ccomp: auxcl: inss =\n", inss)
// end of [val]
*)
//
in
  ibranch_make(hicl.hiclau_loc, inss)
end (* end of [auxcl] *)

fun
auxclist
(
  env: !ccompenv
, lvl0: int
, hicls: hiclaulst
, ptcmpss: patcomplstlst
, tmpret: tmpvar
) : ibranchlst = let
in
//
case+ hicls of
| list_nil
    ((*void*)) => list_nil()
  // end of [list_nil]
| list_cons(_, _) => let
//
    val+list_cons(hicl, hicls) = hicls
    val-list_cons(ptcmps, ptcmpss) = ptcmpss
//
    val ibranch =
      auxcl(env, lvl0, hicl, ptcmps, tmpret)
    val ibranchs =
      auxclist(env, lvl0, hicls, ptcmpss, tmpret)
//
  in
    list_cons(ibranch, ibranchs)
  end // end of [list_cons]
//
end (* end of [auxclist] *)

in (* in of [local] *)

implement
hiclaulst_ccomp
(
  env, lvl0, pmvs, hicls, tmpret, fail
) = let
//
val ptcmpss =
  hiclaulst_patcomp(lvl0, hicls, pmvs)
val ((*void*)) =
  patcomplstlst_jumpfill(ptcmpss, fail)
//
(*
val () = fprintln! (stdout_ref, "ptcmpss =\n", ptcmpss)
*)
//
in
  auxclist(env, lvl0, hicls, ptcmpss, tmpret)
end // end of [hiclaulst_ccomp]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_claulst.dats] *)
