(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: January, 2013
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/list.dats"
staload
_(*anon*) = "prelude/DATS/list_vt.dats"
staload
_(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload compare with $LAB.compare_label_label

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload P2TC = "./pats_patcst2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

(*
datatype
p2atcst =
  | P2TCany of ()
  | P2TCcon of (d2con, p2atcstlst)
  | P2TCempty of ()
  | P2TCint of intinf
  | P2TCbool of bool
  | P2TCchar of char
  | P2TCstring of string
  | P2TCfloat of string(*rep*)
  | P2TCrec of (int(*reckind*), labp2atcstlst)
  | P2TCintc of intinfset
// end of [p2atcst]
*)

(* ****** ****** *)

datatype
tmprimval =
  | TPMVnone of (primval)
  | TPMVsome of (tmpvar, primval)
// end of [tmprimval]

(* ****** ****** *)

(*
extern
fun tmprimval_make_none (pmv: primval): tmprimval
extern
fun tmprimval_make_some (pmv: primval): tmprimval
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

extern
fun tmprimval_get_pmv (tpmv: tmprimval): primval

(* ****** ****** *)

implement
tmprimval_get_pmv
  (tpmv) = let
in
//
case+ tpmv of
| TPMVnone (pmv) => pmv
| TPMVsome (tmp, _) => let
    val loc = tmpvar_get_loc (tmp) in primval_make_tmp (loc, tmp)
  end // end of [TPMVsome]
//
end // end of [tmprimval_get_pmv]

(* ****** ****** *)

extern
fun fprint_tmprimval (out: FILEref, x: tmprimval): void

(* ****** ****** *)

implement
fprint_tmprimval
  (out, x) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))
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

typedef
tmpmov =
@(
  tmpvar(*src*), tmpvar(*dst*)
) // end of [tmpmov]

typedef tmpmovlst = List (tmpmov)
vtypedef tmpmovlst_vt = List_vt (tmpmov)

(* ****** ****** *)

extern
fun fprint_tmpmovlst (out: FILEref, xs: tmpmovlst): void

(* ****** ****** *)

implement
fprint_tmpmovlst (out, xs) = let
//
fun fpr
(
  out: FILEref, x: tmpmov
) : void =
{
  val () = fprint_tmpvar (out, x.0)
  val () = fprint_string (out, "->")
  val () = fprint_tmpvar (out, x.1)
}
//
in
  $UT.fprintlst (out, xs, " | ", fpr)
end // end of [fprint_tmpmovlst]

(* ****** ****** *)

extern
fun tmpmovlst_add
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
val out = stdout_ref
val () = fprintln! (out, "tmpmovlst_add: tpmv1 = ", tpmv1)
val () = fprintln! (out, "tmpmovlst_add: tpmv2 = ", tpmv2)
*)
//
in
//
case+ tpmv1 of
| TPMVnone _ => ()
| TPMVsome (tmp1, _) =>
  (
    case+ tpmv2 of
    | TPMVnone _ => ()
    | TPMVsome (tmp2, _) =>
        tmvlst := list_vt_cons ((tmp1, tmp2), tmvlst)
      // end of [TPMVsome]
  )
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
fun fprint_matoken (out: FILEref, x: matoken): void
extern
fun fprint_matokenlst (out: FILEref, xs: matokenlst): void
*)

(* ****** ****** *)

datatype
patjump =
  | PTJMPnone of ()
  | PTJMPsome of (patckont)
  | PTJMPsome2 of (tmplab, tmpmovlst)
typedef patjumpref = ref (patjump)

(* ****** ****** *)

extern
fun fprint_patjump (out: FILEref, x: patjump): void
overload fprint with fprint_patjump

(* ****** ****** *)

implement
fprint_patjump
  (out, x) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
| PTJMPsome (kont) =>
  {
    val () = prstr "PTJMPsome("
    val () = fprint_patckont (out, kont)
    val () = prstr ")"
  }
| PTJMPsome2 (tlab, tmvlst) =>
  {
    val () = prstr "PTJMPsome2("
    val () = fprint_tmplab (out, tlab)
    val () = prstr "; "
    val () = fprint_tmpmovlst (out, tmvlst)
    val () = prstr ")"
  }
| PTJMPnone () => prstr "PTJMPnone()"
//
end // end of [fprint_patjump]

(* ****** ****** *)

datatype
patcomp =
//
  | PTCMPany of ()
  | PTCMPvar of (d2var, tmprimval)
  | PTCMPasvar of (d2var, tmprimval)
//
  | PTCMPlablparen of (label)
//
  | PTCMPpatlparen of
      (patck, tmprimval, tmplab, patjumpref)
//
  | PTCMPreclparen of (tmplab) // HX: failure-less
//
  | PTCMPrparen of ()
//
  | PTCMPpatneg of (patck, tmprimval)
//
  | PTCMPtmplab of (tmplab)
// end of [patcomp]

typedef patcomplst = List (patcomp)
typedef patcomplstlst = List (patcomplst)
vtypedef patcomplst_vt = List_vt (patcomp)

(* ****** ****** *)

extern
fun fprint_patcomp (out: FILEref, x: patcomp): void
overload fprint with fprint_patcomp

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
| PTCMPany () =>
  {
    val () = prstr "PTCMPany()"
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
    (ptck, tpmv, tlab, pjr) =>
  {
    val () = prstr "PTCMPpatlparen("
    val () = fprint_patck (out, ptck)
    val () = prstr ", "
    val () = fprint_tmprimval (out, tpmv)
    val () = prstr ", "
    val () = fprint_tmplab (out, tlab)
    val () = prstr ", "
    val () = fprint_patjump (out, !pjr)
    val () = prstr ")"
  }
//
| PTCMPreclparen (tlab) =>
  {
    val () = prstr "PTCMPreclparen("
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
| PTCMPtmplab (tlab) =>
  {
    val () = prstr "PTCMPtmplab("
    val () = fprint_tmplab (out, tlab)
    val () = prstr ")"
  }
//
end // end of [fprint_patcomp]

(* ****** ****** *)

extern
fun fprint_patcomplst (out: FILEref, xs: patcomplst): void
overload fprint with fprint_patcomplst
extern
fun fprint_patcomplstlst (out: FILEref, xs: patcomplstlst): void
overload fprint with fprint_patcomplstlst

(* ****** ****** *)

implement
fprint_patcomplst
  (out, xs) = $UT.fprintlst (out, xs, "; ", fprint_patcomp)
// end of [fprint_patcomplst]

implement
fprint_patcomplstlst
  (out, xss) = $UT.fprintlst (out, xss, "\n", fprint_patcomplst)
// end of [fprint_patcomplstlst]

(* ****** ****** *)

extern
fun patcomplst_find_tmplab
  (xs: patcomplst): Option_vt (tmplab)

(* ****** ****** *)

implement
patcomplst_find_tmplab
  (xs) = let
(*
val (
) = fprintln! (
  stdout_ref, "patcomplst_find_tmplab: xs = ", xs
) (* end of [val] *)
*)
in
//
case+ xs of
//
| list_cons
    (x, xs) => let
  in
    case x of
    | PTCMPpatlparen
        (_, _, tl, _) => Some_vt (tl)
    | PTCMPreclparen (tl) => Some_vt (tl)
    | PTCMPtmplab (tl) => Some_vt (tl)
    | _ => patcomplst_find_tmplab (xs)
  end // end of [list_cons]
//
| list_nil ((*void*)) => None_vt ()
//
end // end of [patcomplst_find_tmplab]

(* ****** ****** *)
//
extern
fun patcomplst_unskip
 (xs: patcomplst, na: &int >> int): patcomplst
extern
fun patcomplst_unrparen
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
| list_cons
    (x, xs) =>
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
    | _ => xs
//
  ) // end of [list_cons]
| list_nil () => list_nil ()
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
| list_cons
    (x, xs) =>
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
    | _ => auxlst2 (plvl, xs, na)
//
  )
| list_nil () => list_nil ()
  // end of [list_nil]
//
end // end of [auxlst2]
//
in
  auxlst (xs, na)
end // end of [patcomplst_unskip]

(* ****** ****** *)

implement
patcomplst_unrparen (xs0, na) = let
in
//
case+ xs0 of
| list_cons (x, xs1) =>
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
  )
| list_nil () => list_nil ()
//
end // end of [patcomplst_unrparen]

(* ****** ****** *)

extern
fun patcomplst_subtest
  (xs1: patcomplst, xs2: patcomplst): patjump
// end of [patcomplst_subtest]
extern
fun patcomplst_subtests
  (xs1: patcomplst, xss2: patcomplstlst): patjump
// end of [patcomplst_subtests]

(* ****** ****** *)

extern
fun patck_isbin (ptck: patck): bool
extern
fun patck_ismat
 (ptck1: patck, ptck2: patck): bool

(* ****** ****** *)

implement
patck_isbin (ptck) = let
in
//
case+ ptck of
| PATCKbool _ => true
| PATCKcon (d2c) => d2con_is_binarian (d2c)
| _ => false
end // end of [patck_ismat]

(* ****** ****** *)

implement
patck_ismat (ptck1, ptck2) = let
in
//
case+ ptck1 of
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
| PATCKcon (d2c1) =>
  (case+ ptck2 of PATCKcon (d2c2) => d2c1 = d2c2 | _ => false)
| PATCKexn (d2c1) =>
  (case+ ptck2 of PATCKexn (d2c2) => d2c1 = d2c2 | _ => false)
//
| _ => false
end // end of [patck_ismat]

(* ****** ****** *)

local

typedef patcomplst1 = List1 (patcomp)

fun auxlst
(
  xs10: patcomplst
, xs20: patcomplst
, tmvlst: &tmpmovlst_vt
) : Option_vt (patcomplst) = let
in
//
case xs10 of
| list_cons _ =>
  (
    case+ xs20 of
    | list_cons _ => auxlst2 (xs10, xs20, tmvlst) | list_nil _ => None_vt ()
  )
| list_nil () => Some_vt (xs20)
//
end // end of [auxlst]

and auxlst2
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
val () = fprintln! (out, "auxlst2: x1 = ", x1)
val () = fprintln! (out, "auxlst2: x2 = ", x2)
//
in
//
case+ x2 of
| PTCMPany _ => let
    var na: int = 0
    val xs1 = patcomplst_unskip (xs10, na)
  in
    auxlst (xs1, xs2, tmvlst)
  end
| PTCMPvar _ => let
    var na: int = 0
    val xs1 = patcomplst_unskip (xs10, na)
  in
    auxlst (xs1, xs2, tmvlst)
  end
| PTCMPasvar _ => auxlst (xs10, xs2, tmvlst)
| PTCMPrparen _ => let
    var na: int = 0
    val xs1 = patcomplst_unrparen (xs10, na)
  in
    auxlst (xs1, xs2, tmvlst)
  end
(*
| _ when x1 as PTCMPany _ =>
| _ when x1 as PTCMPvar _ =>
*)
| _ when x1 as PTCMPasvar _ => auxlst (xs1, xs20, tmvlst)
(*
| _ when x1 as PTCMPrparen () =>
*)
//
| PTCMPlablparen (lab2) =>
  (
    case+ x1 of
    | PTCMPlablparen
        (lab1) => let
        val sgn = compare (lab1, lab2)
      in
        if sgn = 0
          then auxlst (xs1, xs2, tmvlst) else None_vt ()
        // end of [if]
      end // end of [PTCMPlablparen]
    | _ => None_vt ()
  )
//
| PTCMPpatlparen (ptck2, tpmv2, _, _) =>
  (
    case+ x1 of
    | PTCMPpatneg
        (ptck1, tpmv1) => let
        val ismat = patck_ismat (ptck1, ptck2)
        val ((*void*)) =
          tmpmovlst_add (tmvlst, tpmv1, tpmv2)
      in
        if ismat
          then None_vt () else let
          val isbin = patck_isbin (ptck1)
        in
          if isbin then Some_vt (xs2) else Some_vt (xs20)
        end // end of [else] // end of [if]
      end // end of [PTCMPnegcon]
    | PTCMPpatlparen
        (ptck1, tpmv1, _, _) => let
        val ismat = patck_ismat (ptck1, ptck2)
        val ((*void*)) =
          tmpmovlst_add (tmvlst, tpmv1, tpmv2)
      in
        if ismat
          then auxlst (xs1, xs2, tmvlst) else None_vt ()
        // end of [if]
      end // end of [PTCMPpatlparen]
    | _ => None_vt ()
  )
| _ => None_vt ()
//
end // end of [auxlst2]

in (* in of [local] *)

implement
patcomplst_subtest
  (xs10, xs20) = let
//
var tmvlst
  : tmpmovlst_vt = list_vt_nil ()
val opt = auxlst (xs10, xs20, tmvlst)
//
in
//
case+
:(
  tmvlst: tmpmovlst_vt?
) => opt of
| ~Some_vt (xs) => let
    val tmvlst = list_vt_reverse (tmvlst)
    val tmvlst = list_of_list_vt (tmvlst)
    val-~Some_vt(tlab) = patcomplst_find_tmplab (xs)
  in
    PTJMPsome2 (tlab, tmvlst)
  end
| ~None_vt () => let
    val () = list_vt_free<tmpmov> (tmvlst) in PTJMPnone ()
  end // end of [None_vt]
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
| list_cons
    (xs2, xss2) => let
    val ptjmp = patcomplst_subtest (xs1, xs2)
  in
    case+ ptjmp of
    | PTJMPnone () => patcomplst_subtests (xs1, xss2) | _ => ptjmp
  end // end of [list_cons]
| list_nil () => PTJMPnone ()
//
end // end of [patcomplst_subtests]

(* ****** ****** *)
//
extern
fun patcomplst_jumpfill_rest
  (xs1: patcomplst, xss2: patcomplstlst): void
//
(* ****** ****** *)

implement
patcomplst_jumpfill_rest
  (xs1, xss2) = let
//
val out = stdout_ref
val (
) = fprintln! (out, "patcomplst_jumpfill_rest: xs1 = ", xs1)
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
| list_cons
    (x1, xs1) => let
    val () = (
      case+ x1 of
      | PTCMPpatlparen
          (ptck, tpmv, tlab, pjr) => let
          val rxs1 = list_vt_copy (rxs)
          val rxs1 = list_vt_cons (PTCMPpatneg (ptck, tpmv), rxs1)
          val pxs1 = list_vt_reverse (rxs1)
          val ptjmp = patcomplst_subtests ($UN.linlst2lst(pxs1), xss2)
          val () = list_vt_free (pxs1)
        in
          !pjr := ptjmp
        end (* end of [PTCMPpatlparen] *)
      | _ => ()
    ) : void // end of [val]
  in
    auxlst (xs1, xss2, list_vt_cons(x1, rxs))
  end // end of [list_cons]
| list_nil () => let
    val () = list_vt_free (rxs) in (*nothing*)
  end // end of [list_nil]
//
end // end of [auxlst]
//
in
  auxlst (xs1, xss2, list_vt_nil())
end // end of [patcomplst_jumpfill_rest]

(* ****** ****** *)
//
extern
fun patcomplst_jumpfill_fail
  (xs: patcomplst, fail: patckont): void
//
(* ****** ****** *)

implement
patcomplst_jumpfill_fail
  (xs, fail) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = (
      case+ x of
      | PTCMPpatlparen (_, _, _, pjr) =>
        (case !pjr of PTJMPnone () => !pjr := PTJMPsome (fail) | _ => ())
      | _ => ()
    ) : void // end of [val]
  in
    patcomplst_jumpfill_fail (xs, fail)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [patcomplst_jumpfill_fail]

(* ****** ****** *)
//
extern
fun patcomplstlst_jumpfill
  (xss: patcomplstlst, fail: patckont): void
//
(* ****** ****** *)

implement
patcomplstlst_jumpfill
  (xss, fail) = let
in
//
case+ xss of
| list_cons
    (xs, xss) => let
    val () = patcomplst_jumpfill_rest (xs, xss)
    val () = patcomplst_jumpfill_fail (xs, fail)
  in
    patcomplstlst_jumpfill (xss, fail)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [patcomplstlst_jumpfill]

(* ****** ****** *)
//
extern
fun himatchlst_patcomp
(
  lvl0: int, pmvs: primvalist, hips: hipatlst
) : patcomplst // end of [himatchlst_patcomp]
//
(* ****** ****** *)

local

(* ****** ****** *)

fun auxtpmv_make
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

fun auxadd_rparen
(
  mtks: matokenlst
) : matokenlst = list_cons (MTKrparen (), mtks)

(* ****** ****** *)

fun auxadd_selcon
(
  tpmv: tmprimval
, hse_sum: hisexp
, lxs: labhipatlst
, mtks: matokenlst
) : matokenlst = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val+LABHIPAT (l, hip) = lx
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
    val pmv = tmprimval_get_pmv (tpmv)
    val pmv_l = primval_selcon (loc, hse, pmv, hse_sum, l)
    val tpmv_l = auxtpmv_make (hip, pmv_l)
    val mtk0 = MTKlabpat (l, hip, tpmv_l)
    val mtks = auxadd_selcon (tpmv, hse_sum, lxs, mtks)
  in
    list_cons (mtk0, mtks)
  end // end of [list_cons]
| list_nil () => mtks
//
end // end of [auxadd_selcon]

fun auxadd_select
(
  tpmv: tmprimval
, hse_rec: hisexp
, lxs: labhipatlst
, mtks: matokenlst
) : matokenlst = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val+LABHIPAT (l, hip) = lx 
    val loc = hip.hipat_loc
    val hse = hip.hipat_type
    val pl = primlab_lab (loc, l)
    val pmv = tmprimval_get_pmv (tpmv)
    val pl = primlab_lab (loc, l)
    val pmv_l = primval_select (loc, hse, pmv, hse_rec, pl)
    val tpmv_l = auxtpmv_make (hip, pmv_l)
    val mtk0 = MTKlabpat (l, hip, tpmv_l)
    val mtks = auxadd_select (tpmv, hse_rec, lxs, mtks)
  in
    list_cons (mtk0, mtks)
  end // end of [list_cons]
| list_nil () => mtks
//
end // end of [auxadd_select]

(* ****** ****** *)

fun auxcomplst
(
  lvl0: int, mtks: matokenlst
) : patcomplst = let
in
//
case+ mtks of
| list_cons
    (mtk, mtks) => auxcomplst_mtk (lvl0, mtk, mtks)
| list_nil () => let
    val tl = tmplab_make () in list_sing (PTCMPtmplab(tl))
  end // end of [list_nil]
//
end // end of [auxcomplst]

and auxcomplst_mtk
(
  lvl0: int
, mtk0: matoken, mtks: matokenlst
) : patcomplst = let
in
//
case+ mtk0 of
| MTKpat (hip, tpmv) =>
    auxcomplst_pat (lvl0, tpmv, hip, mtks)
| MTKlabpat (lab, hip, tpmv) =>
    auxcomplst_labpat (lvl0, tpmv, lab, hip, mtks)
| MTKrparen () =>
  (
    list_cons (PTCMPrparen (), auxcomplst (lvl0, mtks))
  ) // end of [MTKrparen]
//
end // end of [auxcomplst_mtk]

and auxcomplst_pat
(
  lvl0: int
, tpmv: tmprimval
, hip0: hipat
, mtks: matokenlst
) : patcomplst = let
in
//
case+
  hip0.hipat_node of
//
| HIPany () => let
    val ptcmp0 = PTCMPany()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, ptcmps)
  end
| HIPvar d2v => let
    val (
    ) = d2var_set_level (d2v, lvl0)
    val ptcmp0 = PTCMPvar(d2v, tpmv)
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, ptcmps)
  end // end of [HIPvar]
//
| HIPint (i) => let
    val tl = tmplab_make ()
    val pjr = ref<patjump> (PTJMPnone)
    val ptcmp0 = PTCMPpatlparen (PATCKint(i), tpmv, tl, pjr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, list_cons (ptcmp1, ptcmps))
  end // end of [HIPint]
//
| HIPi0nt (tok) => let
    val tl = tmplab_make ()
    val pjr = ref<patjump> (PTJMPnone)
    val i0 = $P2TC.intinf_of_i0nt (tok)
    val i0 = $INTINF.intinf_get_int (i0)
    val ptcmp0 = PTCMPpatlparen (PATCKint(i0), tpmv, tl, pjr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, list_cons (ptcmp1, ptcmps))
  end // end of [HIPi0nt]
//
| HIPempty () => auxcomplst (lvl0, mtks)
//
| HIPcon
  (
    knd, d2c, hse_sum, lxs
  ) => let
    val tl = tmplab_make ()
    val pjr = ref<patjump> (PTJMPnone)
    val mtks = auxadd_rparen (mtks)
    val mtks = auxadd_selcon (tpmv, hse_sum, lxs, mtks)
    val ptcmp0 = PTCMPpatlparen (PATCKcon(d2c), tpmv, tl, pjr)
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, ptcmps)
  end // end of [HIPcon]
//
| HIPcon_any
    (knd, d2c) => let
    val tl = tmplab_make ()
    val pjr = ref<patjump> (PTJMPnone)
    val ptcmp0 = PTCMPpatlparen (PATCKcon(d2c), tpmv, tl, pjr)
    val ptcmp1 = PTCMPrparen ()
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, list_cons (ptcmp1, ptcmps))
  end // end of [HIPcon_any]
//
| HIPrec
    (knd, lxs, hse_rec) => let
    val tl = tmplab_make ()
    val mtks = auxadd_rparen (mtks)
    val mtks = auxadd_select (tpmv, hse_rec, lxs, mtks)
    val ptcmp0 = PTCMPreclparen (tl)
    val ptcmps = auxcomplst (lvl0, mtks)
  in
    list_cons (ptcmp0, ptcmps)
  end // end of [HIPrec]
//
| HIPrefas (d2v, hip) => let
    val (
    ) = d2var_set_level (d2v, lvl0)
    val ptcmp0 = PTCMPasvar (d2v, tpmv)
    val ptcmps = auxcomplst_pat (lvl0, tpmv, hip, mtks)
  in
    list_cons (ptcmp0, ptcmps)
  end // end of [HIPrefas]
//
| HIPann (hip, _(*ann*)) =>
    auxcomplst_pat (lvl0, tpmv, hip, mtks)
//
| _ => let
    val () = assertloc (false) in list_nil ()
  end // end of [_]
//
end // end of [auxcomplst_pat]

and auxcomplst_labpat
(
  lvl0: int
, tpmv: tmprimval
, lab0: label, hip0: hipat
, mtks: matokenlst
) : patcomplst = let
  val ptcmp0 = PTCMPlablparen (lab0)
  val ptcmp1 = PTCMPrparen ()
  val ptcmps = auxcomplst_pat (lvl0, tpmv, hip0, mtks)
in
  list_cons (ptcmp0, list_cons (ptcmp1, ptcmps))
end // end of [auxcomplst_labpat]

in (* in of [local] *)

implement
himatchlst_patcomp
  (lvl0, pmvs, hips) = let
//
fun auxlst
(
  pmvs: primvalist, hips: hipatlst
) : matokenlst = let
in
//
case+ pmvs of
| list_cons
    (pmv, pmvs) => let
    val tpmv = TPMVnone (pmv)
    val-list_cons (hip, hips) = hips
    val mtk0 = MTKpat (hip, tpmv)
    val mtks = auxlst (pmvs, hips)
  in
    list_cons (mtk0, mtks)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]
//
in
//
case+ pmvs of
//
| list_cons
    (pmv, pmvs) => let
    val tpmv = TPMVnone (pmv)
    val-list_cons (hip, hips) = hips
    val mtks = auxlst (pmvs, hips)
  in
     auxcomplst_pat (lvl0, tpmv, hip, mtks)
  end // end of [list_cons]
//
| list_nil () => list_nil ()
//
end // end of [hipatcomp_patlst]

end // end of [local]

(* ****** ****** *)

extern
fun hiclau_patcomp
(
  lvl0: int, pmvs: primvalist, hicl: hiclau
) : patcomplst // end of [hiclau_patcomp]
implement
hiclau_patcomp
  (lvl0, pmvs, hicl) = let
//
val out = stdout_ref
//
val hips = hicl.hiclau_pat
val () = fprintln! (out, "hipatcomp_clau: hips =\n", hips)
val ptcmps = himatchlst_patcomp (lvl0, pmvs, hips)
val () = fprintln! (out, "hipatcomp_clau: ptcmps =\n", ptcmps)
//
in
  ptcmps
end // end of [hiclau_patcomp]

(* ****** ****** *)

extern
fun hiclaulst_patcomp
(
  lvl0: int, pmvs: primvalist, hicls: hiclaulst
) : patcomplstlst // end of [hiclaulst_patcomp]
implement
hiclaulst_patcomp
  (lvl0, pmvs, hicls) = let
in
//
case+ hicls of
| list_cons
    (hicl, hicls) => let
    val xs = hiclau_patcomp (lvl0, pmvs, hicl)
    val xss = hiclaulst_patcomp (lvl0, pmvs, hicls)
  in
    list_cons (xs, xss)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [hiclaulst_patcomp]

(* ****** ****** *)

implement
hiclaulst_ccomp
(
  env, lvl0, pmvs, hicls, tmpret, fail
) = let
//
val ptcmpss = hiclaulst_patcomp (lvl0, pmvs, hicls)
val ((*void*)) = patcomplstlst_jumpfill (ptcmpss, fail)
//
val () = fprintln! (stdout_ref, "ptcmpss =\n", ptcmpss)
//
in
  list_nil ()
end // end of [hiclaulst_ccomp]

(* ****** ****** *)

(* end of [pats_ccomp_claulst.dats] *)
