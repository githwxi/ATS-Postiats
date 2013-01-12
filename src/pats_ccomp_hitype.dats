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

staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
overload = with $STMP.eq_stamp_stamp
overload != with $STMP.neq_stamp_stamp

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
typedef label = $LAB.label
overload = with $LAB.eq_label_label
overload != with $LAB.neq_label_label

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

datatype hitype =
  | HITnmd of (string)
  | HITapp of (hitype, hitypelst)
  | HITtyrec of (tyreckind, labhitypelst)
  | HITtysum of (labhitypelst)
  | HITundef of (stamp)
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
fun hitype_undef (): hitype

extern
fun hitype_get_boxknd (hit: hitype): int
and hitype_get_extknd (hit: hitype): int

extern
fun eq_hitype_hitype (x1: hitype, x2: hitype): bool

(* ****** ****** *)

extern
fun hisexp_typize (hse: hisexp): hitype
extern
fun hisexplst_typize (hses: hisexplst): hitypelst
extern
fun labhisexplst_typize (lhses: labhisexplst): labhitypelst
extern
fun s2exp_typize (s2e: s2exp): hitype

(* ****** ****** *)
//
extern
fun emit_hitype (out: FILEref, hit: hitype): void
extern
fun emit_hitypelst_sep
  (out: FILEref, hits: hitypelst, sep: string): void
//
(* ****** ****** *)

implement
hitype_get_boxknd
  (hit) = let
in
//
case+ hit of
| HITtyrec (knd, _) =>
    if tyreckind_is_box (knd) then 1 else 0
| _ => ~1 // HX: meaningless
//
end // end of [hitype_get_boxknd]

implement
hitype_get_extknd
  (hit) = let
in
//
case+ hit of
| HITtyrec (knd, _) =>
    if tyreckind_is_ext (knd) then 1 else 0
| _ => ~1 // HX: meaningless
//
end // end of [hitype_get_extknd]

(* ****** ****** *)

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
| HITnmd (name1) => (
  case+ x2 of
  | HITnmd
      (name2) => if (name1 != name2) then abort ()
  | _ => abort ()
  ) // end of [HITnmd]
//
| HITapp (_fun1, _arg1) => (
  case+ x2 of
  | HITapp
      (_fun2, _arg2) => let
      val () = aux (_fun1, _fun2) in auxlst (_arg1, _arg2)
    end // end of [HITapp]
       
  | _ => abort ()
  ) // end of [HITapp]
//
| HITtyrec (knd1, lxs1) => (
  case+ x2 of
  | HITtyrec (knd2, lxs2) =>
      if knd1 = knd2 then auxlablst (lxs1, lxs2) else abort ()
  | _ => abort ()
  ) // end of [HITtyrec]
//
| HITtysum (lxs1) => (
  case+ x2 of
  | HITtysum (lxs2) => auxlablst (lxs1, lxs2)
 | _ => abort ()
  ) // end of [HITtysum]
| HITundef (n1) => (
  case+ x2 of
  | HITundef (n2) => if (n1 != n2) then abort ()
  | _ => abort ()
  ) // end of [HITundef]
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
  val () =
    aux (x1, x2) in true
  // endval
end with
  | ~EQUALexn () => false
// end of [try]
//
end // end of [eq_hitype_hitype]

(* ****** ****** *)

extern
fun the_hitypemaplst_get (): List_vt @(hitype, hitype)

extern
fun the_hitypemap_search (hit: hitype): Option_vt (hitype)
extern
fun the_hitypemap_insert (hit: hitype, hit2: hitype): void

(* ****** ****** *)

local

vtypedef
keyitmlst = List_vt @(hitype, hitype)
val the_hitypemaplst = ref<keyitmlst> (list_vt_nil)

in // in of [local]

implement
the_hitypemaplst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_hitypemaplst)
val res = !p
val (
) = !p := list_vt_nil ()
//
in
  res
end // end of [the_hitypemaplst_get]

(* ****** ****** *)

implement
the_hitypemap_search (hit) = None_vt ()

(* ****** ****** *)

implement
the_hitypemap_insert
  (hit, hit2) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_hitypemaplst)
val (
) = !p := list_vt_cons ( @(hit, hit2), !p )
//
in
  // nothing
end // end of [the_hitypemap_insert]

end // end of [local]

(* ****** ****** *)

implement
hitype_undef () = let
  val stamp = $STMP.hitype_stamp_make () in HITundef (stamp)
end // end of [hitype_undef]

(* ****** ****** *)

implement
emit_hitype
  (out, hit) = let
in
//
case+ hit of
| HITnmd
    (name) => emit_text (out, name)
| HITapp
    (_fun, _arg) => let
    val () = emit_hitype (out, _fun)
    val () = emit_text (out, "(")
    val () = emit_hitypelst_sep (out, _arg, ", ")
    val () = emit_text (out, ")")
  in
    // nothing
  end // end of [HITapp]
| HITtyrec _ =>
    emit_text (out, "postiats_tyrec")
| HITtysum _ =>
    emit_text (out, "postiats_tysum")
| HITundef (stamp) => let
    val () =
      emit_text (
        out, "postiats_undef("
      ) // endfuncall
    val () = $STMP.fprint_stamp (out, stamp)
    val () = emit_text (out, ")")
  in
    // nothing
  end // end of [HITundef]
end // end of [emit_hitype]

implement
emit_hitypelst_sep
  (out, hits, sep) = let
//
fun auxlst (
  out: FILEref
, xs: hitypelst, sep: string, i: int
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () =
      if i > 0 then emit_text (out, sep)
    val () = emit_hitype (out, x)
  in
    auxlst (out, xs, sep, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]
//
in
  auxlst (out, hits, sep, 0)
end // end of [emit_hitypelst_sep]

(* ****** ****** *)

implement
emit_hisexp
  (out, hse) = let
//
val hit = hisexp_typize (hse)
//
in
//
case+ hit of
| HITundef _ => {
    val () =
      emit_text (out, "HITundef(")
    val () = fprint_hisexp (out, hse)
    val () = emit_text (out, ")")
  } // end of [HITundef]
| _ => emit_hitype (out, hit)
//
end // end of [emit_hisexp]

implement
emit_hisexplst_sep
  (out, hses, sep) = let
//
fun loop (
  out: FILEref
, hses: hisexplst, sep: string, i: int
) : void = let
in
  case+ hses of
  | list_cons (
      hse, hses
    ) => let
      val () =
        if i > 0 then emit_text (out, sep)
      // end of [val]
      val () = emit_hisexp (out, hse)
    in
      loop (out, hses, sep, i+1)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [loop]
//
in
  loop (out, hses, sep, 0)
end // end of [emit_hisexplst_sep]

(* ****** ****** *)

extern
fun hitype_gen_tyrec (): hitype
implement
hitype_gen_tyrec () = let
  val n = $STMP.hitype_stamp_make ()
  val name = $STMP.tostring_prefix_stamp ("postiats_tyrec_", n)
in
  HITnmd (name)
end // end of [hitype_gen_tyrec]

(* ****** ****** *)

implement
hisexp_typize (hse0) = let
//
val HITNAM (knd, fin, name) = hse0.hisexp_name
//
in
//
case+ hse0.hisexp_node of
| _ when (
    fin > 0
  ) => HITnmd (name)
//
| HSEapp (_fun, _arg) => let
    val _fun = hisexp_typize (_fun)
    val _arg = hisexplst_typize (_arg)
  in
    HITapp (_fun, _arg)
  end // end of [HSEapp]
//
| HSEtyabs (sym) => let
    val name =
      $SYM.symbol_get_name (sym) in HITnmd (name)
    // end of [val]
  end // end of [HSEtyabs]
| HSEtyrec
    (knd, lhses) => let
    val lhits =
      labhisexplst_typize (lhses)
    val hit0 = HITtyrec (knd, lhits)
    val opt = the_hitypemap_search (hit0)
  in
    case+ opt of
    | ~None_vt () => let
        val hit1 = hitype_gen_tyrec ()
        val () = the_hitypemap_insert (hit0, hit1)
      in
        hit1
      end // end of [None_vt]
    | ~Some_vt (hit0) => hit0
  end // end of [HSEtyrec]
//
| HSEs2exp (s2e) => s2exp_typize (s2e)
//
| _ => hitype_undef ()
//
end // end of [hisexp_typize]

(* ****** ****** *)

implement
hisexplst_typize (xs) =
  list_of_list_vt (list_map_fun (xs, hisexp_typize))
// end of [hisexplst_typize]

(* ****** ****** *)

implement
labhisexplst_typize
  (lxs) = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val HSLABELED (l, opt, x) = lx
    val y = hisexp_typize (x)
    val ly = HTLABELED (l, opt, y)
    val lys = labhisexplst_typize (lxs)
  in
    list_cons (ly, lys)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [labhisexplst_typize]

(* ****** ****** *)

implement
s2exp_typize
  (s2e0) = let
in
//
case+
  s2e0.s2exp_node of
//
| S2Etkname (name) => HITnmd (name)
//
| _ => hitype_undef ()
//
end // end of [s2exp_typize]

(* ****** ****** *)

local

fun auxfldlst (
  out: FILEref
, lhits: labhitypelst, i: int
) : void = let
in
//
case+ lhits of
| list_cons
    (lhit, lhits) => let
    val () =
      if i > 0 then emit_newline (out)
    val HTLABELED (lab, opt, hit) = lhit
    val (
    ) = emit_hitype (out, hit)
    val () = (
      case+ opt of
      | Some (
          name
        ) => emit_text (out, name)
      | None () => emit_label (out, lab)
    ) : void // end of [val]
    val () = emit_text (out, " ;")
  in
    auxfldlst (out, lhits, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxfldlst]

fun auxkey (
  out: FILEref, hit: hitype
) : void = let
in
//
case+ hit of
| HITtyrec
    (knd, lhits) => {
    val () =
      emit_text (out, "struct {")
    val () = auxfldlst (out, lhits, 1)
    val () = emit_text (out, "\n}")
  } // end of [HITtyrec]
| HITtysum (lhits) => {
    val () =
      emit_text (out, "struct {")
    val () = emit_text (out, "\nint tag ;")
    val () = auxfldlst (out, lhits, 1)
    val () = emit_text (out, "\n}")
  } // end of [HITtysum]
| _ => emit_text (out, "(**ERROR**)")
//
end // end of [auxkey]

in // in of [local]

implement
emit_the_typedeflst (out) = let
//
typedef keyitm = @(hitype, hitype)
fun auxlst (
  out: FILEref, kis: List_vt (keyitm)
) : void = let
in
//
case+ kis of
| ~list_vt_cons
    (ki, kis) => let
    val () =
      emit_text (out, "typedef\n")
    val () = auxkey (out, ki.0)
    val () = emit_text (out, " ")
    val () = emit_hitype (out, ki.1)
    val () = emit_text (out, " ;\n")
  in
    auxlst (out, kis)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [auxlst]
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "typedefs-for-tyrecs-and-tysums(beg)\n")
val () = emit_text (out, "*/\n")
val () = auxlst (out, the_hitypemaplst_get ())
val () = emit_text (out, "/*\n")
val () = emit_text (out, "typedefs-for-tyrecs-and-tysums(end)\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [emit_the_typedeflst]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_hitype.dats] *)
