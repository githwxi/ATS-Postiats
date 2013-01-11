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

staload STMP = "./pats_stamp.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
typedef label = $LAB.label
overload = with $LAB.eq_label_label
overload != with $LAB.neq_label_label

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

datatype hitype =
  | HITYPEname of (string)
  | HITYPEtyrec of (labhitypelst)
  | HITYPEtysum of (hitypelst)
  | HITYPEundef of (int)
// end of [hitype]

and labhitype =
  | HTLABELED of (label, Option(string), hitype)
// end of [labhitype]

where
hitypelst = List (hitype)
and
labhitypelst = List (labhitype)

(* ****** ****** *)

extern
fun eq_hitype_hitype (x1: hitype, x2: hitype): bool

implement
eq_hitype_hitype
  (x1, x2) = let
//
exception EQUALexn of ()
macdef abort () = $raise (EQUALexn)
//
fun aux
  (x1: hitype, x2: hitype): void = let
in
//
case+ x1 of
//
| HITYPEname (str1) => (
  case+ x2 of
  | HITYPEname
      (str2) => if (str1 != str2) then abort ()
  | _ => abort ()
  ) // end of [HITYPEname]
//
| HITYPEtyrec (lxs1) => (
  case+ x2 of
  | HITYPEtyrec (lxs2) => auxlablst (lxs1, lxs2)
  | _ => abort ()
  ) // end of [HITYPEtyrec]
//
| HITYPEtysum (xs1) => (
  case+ x2 of
  | HITYPEtysum (xs2) => auxlst (xs1, xs2)
 | _ => abort ()
  ) // end of [HITYPEtysum]
| HITYPEundef (n1) => (
  case+ x2 of
  | HITYPEundef (n2) => if (n1 != n2) then abort ()
  | _ => abort ()
  ) // end of [HITYPEundef]
//
end // end of [aux]

and auxlst (
  xs1: hitypelst, xs2: hitypelst
) : void = let
in
//
case+ (xs1, xs2) of
| (list_cons (x1, xs1),
   list_cons (x2, xs2)) => let
    val () = aux (x1, x2) in auxlst (xs1, xs2)
  end // end of [list_cons, list_cons]
| (list_nil (), list_nil ()) => ()
| (_, _) => abort ()
//
end // end of [auxlst]

and auxlablst (
  lxs1: labhitypelst, lxs2: labhitypelst
) : void = let
in
//
case+ (lxs1, lxs2) of
| (list_cons (lx1, lxs1),
   list_cons (lx2, lxs2)) => let
    val HTLABELED (l1, opt1, x1) = lx1
    val HTLABELED (l2, opt2, x2) = lx2
    val () =
      if (l1 != l2) then abort ()
    // end of [val]
    val () = (
      case+ (opt1, opt2) of
      | (None (),
         None ()) => ()
      | (Some (name1),
         Some (name2)) => if name1 != name2 then abort ()
      | (_, _) => abort ()
    ) : void // end of [val]
    val () = aux (x1, x2)
  in
    auxlablst (lxs1, lxs2)
  end // end of [list_cons, list_cons]
| (list_nil (), list_nil ()) => ()
| (_, _) => abort ()
//
end // end of [auxlablst]
//
in
//
try let
  val () = aux (x1, x2)
in
  true
end with
  | ~EQUALexn () => false
// end of [try]
//
end // end of [eq_hitype_hitype]

(* ****** ****** *)

extern
fun hitype_undef (): hitype
implement
hitype_undef () = HITYPEundef (0)

(* ****** ****** *)

extern
fun emit_hitype (out: FILEref, hit: hitype): void
implement
emit_hitype
  (out, hit) = let
in
//
case+ hit of
| HITYPEname
    (name) => emit_text (out, name)
| HITYPEtyrec _ => emit_text (out, "postiats_tyrec")
| HITYPEtysum _ => emit_text (out, "postiats_tysum")
| HITYPEundef (n) => fprintf (out, "postiats_undef(%i)", @(n))
end // end of [emit_hitype]

(* ****** ****** *)

extern
fun hisexp_get_hitype (hse: hisexp): hitype
implement
hisexp_get_hitype (hse0) = let
//
val HITNAM (knd, fin, name) = hse0.hisexp_name
//
in
//
case+ hse0.hisexp_node of
| _ when (
    fin > 0
  ) => HITYPEname (name)
| HSEtyabs (sym) => let
    val name =
      $SYM.symbol_get_name (sym) in HITYPEname (name)
    // end of [val]
  end // end of [HSEtyabs]
(*
| HSEtyrec
    (knd, lhses) => let
    val lhits =
      labhisexplst_get_labhitypelst (lhses)
    val hit0 = HITYPEtyrec (lhits)
    val opt = hitype_find (hit0)
  in
    case+ opt of
    | ~None_vt () => let
        val hit1 = hitype_gen_tyrec ()
        val () = hitype_insert (hit0, hit1)
      in
        hit1
      end // end of [None_vt]
    | ~Some_vt (hit0) => hit0
  end // end of [HSEtyrec]
*)
| _ => hitype_undef ()
//
end // end of [hisexp_get_hitype]

(* ****** ****** *)

implement
emit2_hisexp
  (out, hse) = let
  val hit = hisexp_get_hitype (hse)
in
  emit_hitype (out, hit)
end // end of [emit2_hisexp]

(* ****** ****** *)

implement
emit2_hisexplst_sep
  (out, hses, sep) = let
//
fun loop (
  out: FILEref
, hses: hisexplst, sep: string, i: int
) : void = let
in
  case+ hses of
  | list_cons
      (hse, hses) => let
      val () =
        if i > 0 then emit_text (out, sep)
      // end of [val]
      val () = emit2_hisexp (out, hse)
    in
      loop (out, hses, sep, i+1)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [loop]
//
in
  loop (out, hses, sep, 0)
end // end of [emit2_hisexplst_sep]

(* ****** ****** *)

(* end of [pats_ccomp_hitype.dats] *)
