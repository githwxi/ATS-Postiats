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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

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

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_histaexp.sats"

(* ****** ****** *)

staload
TYER = "./pats_typerase.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

datatype hitype =
//
  | HITnmd of (string)
//
  | HITapp of (hitype, hitypelst)
//
  | HITtyarr of (hitype, s2explst)
//
  | HITtyrec of (labhitypelst)
  | HITtysum of (int(*tagged*), labhitypelst)
  | HITtyexn of (labhitypelst)
//
  | HITtyvar of (s2var) (* for substitution *)
//
  | HITrefarg of (int(*knd*), hitype)
//
  | HITundef of (stamp, hisexp)
//
  | HITnone of ()
// end of [hitype]

and labhitype =
  | HTLABELED of (label, Option(string), hitype)
// end of [labhitype]

where
hitypelst = List (hitype)
and
labhitypelst = List (labhitype)

(* ****** ****** *)

assume hitype_type = hitype

(* ****** ****** *)

implement
fprint_hitype
  (out, hit) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ hit of
//
| HITnmd (name) => {
    val () = prstr "HITnmd("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
//
| HITapp (
    hit_fun, hits_arg
  ) => {
    val () = prstr "HITapp("
    val () = fprint_hitype (out, hit_fun)
    val () = prstr "; "
    val () = fprint_hitypelst (out, hits_arg)
    val () = prstr ")"
  }
//
| HITtyarr
    (hit, s2es) => {
    val () = prstr "HITtyarr("
    val () = fprint_hitype (out, hit)
    val () = prstr "["
    val () = fpprint_s2explst (out, s2es)
    val () = prstr "]"
    val () = prstr ")"
  }
//
| HITtyrec (lhits) => {
    val () = prstr "HITtyrec("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| HITtysum (tag, lhits) => {
    val () = prstr "HITtysum("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| HITtyexn (lhits) => {
    val () = prstr "HITtyexn("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| HITtyvar (s2v) => {
    val () = prstr "HITtyvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  }
//
| HITrefarg (knd, hit) => {
    val () = prstr "HITrefarg("
    val () = fprint_int (out, knd)
    val () = prstr ", "
    val () = fprint_hitype (out, hit)
    val () = prstr ")"
  }
//
| HITundef
    (stamp, hse) => {
    val () = prstr "HITundef("
    val () = fprint_hisexp (out, hse)
    val () = prstr ")"
  }
//
| HITnone () => prstr "HITnone()"
//
end // end of [fprint_hitype]

implement
fprint_hitypelst
  (out, hits) = $UT.fprintlst (out, hits, ", ", fprint_hitype)
// end of [fprint_hitypelst]

implement
print_hitype (hit) = fprint_hitype (stdout_ref, hit)
implement
prerr_hitype (hit) = fprint_hitype (stderr_ref, hit)

(* ****** ****** *)

extern
fun hitype_none (): hitype
extern
fun hitype_tybox (): hitype
extern
fun hitype_undef (hse: hisexp): hitype

extern
fun eq_hitype_hitype (x1: hitype, x2: hitype): bool

(* ****** ****** *)

extern
fun s2exp_typize (flag: int, s2e: s2exp): hitype

(* ****** ****** *)
//
extern
fun emit_hitypelst_sep
  (out: FILEref, hits: hitypelst, sep: string): void
//
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
| HITapp
    (_fun1, _arg1) => (
  case+ x2 of
  | HITapp
      (_fun2, _arg2) => let
      val () = aux (_fun1, _fun2) in auxlst (_arg1, _arg2)
    end // end of [HITapp]
  | _ => abort ()
  ) // end of [HITapp]
//
| HITtyarr _ => abort ()
//
| HITtyrec (lxs1) => (
  case+ x2 of
  | HITtyrec (lxs2) => auxlablst (lxs1, lxs2)
  | _ => abort ()
  ) // end of [HITtyrec]
//
| HITtysum
    (tgd1, lxs1) => (
  case+ x2 of
  | HITtysum (tgd2, lxs2) =>
      if tgd1 = tgd2 then auxlablst (lxs1, lxs2) else abort ()
    // end of [HITtysum]
  | _ => abort ()
  ) // end of [HITtysum]
//
| HITtyexn
    (lxs1) => (
  case+ x2 of
  | HITtyexn (lxs2) => auxlablst (lxs1, lxs2)
  | _ => abort ()
  ) // end of [HITtyexn]
//
| HITtyvar (s2v1) => (
  case+ x2 of
  | HITtyvar (s2v2) => if s2v1 != s2v2 then abort ()
  | _ => abort ()
  )
//
| HITrefarg
    (knd1, hit1) => (
  case+ x2 of
  | HITrefarg (knd2, hit2) =>
      if knd1 = knd2 then aux (hit1, hit2) else abort ()
    // end of [HITrefarg]
  | _ => abort ()
  ) // end of [HITrefarg]
//
| HITundef (n1, _) => (
  case+ x2 of
  | HITundef (n2, _) => if (n1 != n2) then abort ()
  | _ => abort ()
  ) // end of [HITundef]
//
| HITnone () => abort ()
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
fun hitype_hash (hit: hitype): ulint

local

fun auxint (
  hval: &ulint, int: int
) : void = let
  val int = $UN.cast2ulint (int)
in
  hval := (hval << 8) + hval + int // hval = 65*hval + int
end // end of [auxint]

fun auxstr (
  hval: &ulint, str: string
) : void = let
//
val isnot = string_isnot_empty (str)
//
in
//
if isnot then let
  val p = $UN.cast2Ptr1 (str)
  val c = $UN.ptrget<char> (p)
  val c = $UN.cast2ulint (c)
  val () = hval := (hval << 5) + hval + c
  val str = $UN.cast{string} (p+1)
in
  auxstr (hval, str)
end else () // end of [if]
//
end // end of [auxstr]

fun auxsym (
  hval: &ulint, sym: symbol
) : void =
  auxstr (hval, $SYM.symbol_get_name (sym))
// end of [auxsym]

fun aux (
  hval: &ulint, hit0: hitype
) : void = let
in
//
case+ hit0 of
| HITnmd
    (name) => auxstr (hval, name)
//
| HITapp
    (_fun, _arg) => let
    val () = aux (hval, _fun)
    val () = auxlst (hval, _arg)
  in
    auxstr (hval, "postiats_app")
  end // end of [HITapp]
//
| HITtyarr
    (hit_elt, _) => let
    val () = aux (hval, hit_elt)
  in
    auxstr (hval, "postiats_tyarr")
  end // end of [HITtyarr]
//
| HITtyrec
    (lhits) => let
    val () = auxlablst (hval, lhits)
  in
    auxstr (hval, "postiats_tyrec")
  end // end of [HITtyrec]
| HITtysum
    (tgd, lhits) => let
    val () = auxint (hval, tgd)
    val () = auxlablst (hval, lhits)
  in
    auxstr (hval, "postiats_tysum")
  end // end of [HITtysum]
| HITtyexn
    (lhits) => let
    val () = auxlablst (hval, lhits)
  in
    auxstr (hval, "postiats_tyrexn")
  end // end of [HITtyexn]
//
| HITtyvar (s2v) => let
    val stamp = s2var_get_stamp (s2v)
  in
    auxint (hval, $STMP.stamp_get_int (stamp))
  end // end of [HITtyvar]
//
| HITrefarg
    (knd, hit) => let
    val () = aux (hval, hit)
  in
    if knd = 0
      then auxstr (hval, "atsrefarg0_type")
      else auxstr (hval, "atsrefarg1_type")
    // end of [if]
  end // end of [HITrefarg]
//
| HITundef
    (stamp, hse) =>
    auxint (hval, $STMP.stamp_get_int (stamp))
  // end of [HITundef]
//
| HITnone () => auxstr (hval, "postiats_none")
//
end // end of [aux]

and auxlst (
  hval: &ulint, hits: hitypelst
) : void = let
in
//
case+ hits of
| list_cons
    (hit, hits) => {
    val () = aux (hval, hit)
    val () = auxlst (hval, hits)
  } // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

and auxlab (
  hval: &ulint, lhit: labhitype
) : void = let
//
val+HTLABELED
  (l, opt, hit) = lhit
val opt = $LAB.label_get_int (l)
val () = (
  case+ opt of
  | ~Some_vt (x) => auxint (hval, x) | ~None_vt () => ()
) : void // end of [val]
val opt = $LAB.label_get_sym (l)
val () = (
  case+ opt of
  | ~Some_vt (x) => auxsym (hval, x) | ~None_vt () => ()
) : void // end of [val]
//
in
  aux (hval, hit)
end // end of [auxlab]

and auxlablst (
  hval: &ulint, lhits: labhitypelst
) : void = let
in
//
case+ lhits of
| list_cons
    (lhit, lhits) => let
    val () = auxlab (hval, lhit) in auxlablst (hval, lhits)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlablst]

in (* in of [local] *)

implement
hitype_hash (hit) = let
  var hval
    : ulint = 618034ul // HX: randomly chosen
  val () = aux (hval, hit)
in
  hval
end // end of [hitype_hash]

end // end of [local]

(* ****** ****** *)

extern
fun the_hitypemaplst_get (): List_vt @(hitype, hitype)

extern
fun the_hitypemap_search (hit: hitype): Option_vt (hitype)
extern
fun the_hitypemap_insert (hit: hitype, hit2: hitype): void

(* ****** ****** *)

local

(* ****** ****** *)
//
// HX-2013-01:
// Using hashtable in ATS is really difficult!
//
(* ****** ****** *)

%{^
typedef ats_ptr_type hitype ;
%} // end of [%{^]

(* ****** ****** *)

abstype hitype_t = $extype"hitype"
extern castfn hitype_encode (x: hitype):<> hitype_t
extern castfn hitype_decode (x: hitype_t):<> hitype
overload encode with hitype_encode
overload decode with hitype_decode

(* ****** ****** *)

typedef key = hitype_t
typedef itm = hitype(*unnamed*)

(* ****** ****** *)
//
staload H = "libats/SATS/hashtable_chain.sats"
staload _(*anon*) = "libats/DATS/hashtable_chain.dats"
//
implement
$H.hash_key<key>
  (k, fhash) = let
  val k = decode (k) in $effmask_all (hitype_hash (k))
end // end of [hask_key]
implement
$H.equal_key_key<key>
  (k1, k2, keqfn) = let
  val k1 = decode (k1)
  and k2 = decode (k2) in
  $effmask_all (eq_hitype_hitype (k1, k2))
end // end of [equal_key_key]
//
val the_hitypemap = let
  typedef fhash = $H.hash (key)
  val fhash = $UN.cast{fhash}(null)
  typedef keqfn = $H.eqfn (key)
  val keqfn = $UN.cast{keqfn}(null)
in
  $H.hashtbl_make {key,itm} (fhash, keqfn)
end // end of [val]
//
val the_hitypemap =
  $H.HASHTBLref_make_ptr {key,itm} (the_hitypemap)
//
(* ****** ****** *)
//
vtypedef
keyitmlst = List_vt @(hitype, hitype)
val the_hitypemaplst = ref<keyitmlst> (list_vt_nil)
//
(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
the_hitypemaplst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_hitypemaplst)
val kis = !p
val (
) = !p := list_vt_nil ()
//
in
  list_vt_reverse (kis)
end // end of [the_hitypemaplst_get]

(* ****** ****** *)

implement
the_hitypemap_search (hit) = let
  val (
    fpf | ptbl
  ) = $H.HASHTBLref_takeout_ptr (the_hitypemap)
  var res: itm?
  val hit = encode (hit)
  val ans = $H.hashtbl_search (ptbl, hit, res)
  prval () = fpf (ptbl)
in
  if ans then let
    prval () = opt_unsome{itm}(res) in Some_vt (res)
  end else let
    prval () = opt_unnone{itm}(res) in None_vt (*none*)
  end // end of [if]
end // end of [the_hitypemap_search]

(* ****** ****** *)

implement
the_hitypemap_insert
  (hit, hit2) = let
//
val (
  fpf | ptbl
) = $H.HASHTBLref_takeout_ptr (the_hitypemap)
val hit1 = encode (hit)
val () = $H.hashtbl_insert (ptbl, hit1, hit2)
prval () = fpf (ptbl)
//
val (
  vbox pf | plst
) = ref_get_view_ptr (the_hitypemaplst)
val () = !plst := list_vt_cons ( @(hit, hit2), !plst )
//
in
  // nothing
end // end of [the_hitypemap_insert]

end // end of [local]

(* ****** ****** *)

implement
hitype_none () = HITnone ()

implement
hitype_tybox () = HITnmd ("atstype_boxed")

implement
hitype_undef (hse) = let
  val s = $STMP.hitype_stamp_make () in HITundef (s, hse)
end // end of [hitype_undef]

(* ****** ****** *)

extern
fun emit_s2var
  (out: FILEref, s2v: s2var): void
implement
emit_s2var
  (out, s2v) = let
  val sym = s2var_get_sym (s2v)
  val name = $SYM.symbol_get_name (sym)
in
  emit_ident (out, name)
end // end of [emit_s2var]

(* ****** ****** *)

implement
emit_hitype
  (out, hit0) = let
in
//
case+ hit0 of
//
| HITnmd (name) => emit_text (out, name)
//
| HITapp
    (_fun, _arg) => let
    val () = emit_hitype (out, _fun)
    val () = emit_text (out, "(")
    val () = emit_hitypelst_sep (out, _arg, ", ")
    val () = emit_text (out, ")")
  in
    // nothing
  end // end of [HITapp]
//
| HITtyarr
    (hit, _) => {
    val () =
      emit_text (out, "atstyarr_type(")
    val ((*void*)) = emit_hitype (out, hit)
    val ((*void*)) = emit_text (out, ")")
  } (* end of [HITtyarr] *)
//
| HITtyrec _ => emit_text (out, "atstyrec_type(*ERROR*)")
| HITtysum _ => emit_text (out, "atstysum_type(*ERROR*)")
| HITtyexn _ => emit_text (out, "atstyexn_type(*ERROR*)")
//
| HITtyvar (s2v) => {
    val () = emit_text (out, "atstyvar_type")
    val (
    ) = (
      emit_lparen (out); emit_s2var (out, s2v); emit_rparen (out)
    ) (* end of [val] *)
  } (* end of [HITtyvar] *)
//
| HITrefarg (knd, hit) => let
    val () = (
      if knd = 0
        then emit_text (out, "atsrefarg0_type(")
        else emit_text (out, "atsrefarg1_type(")
      // end of [if]
    ) : void // end of [val]
    val () = emit_hitype (out, hit)
    val () = emit_rparen (out)
  in
    // nothing
  end // end of [HITrefarg]
//
| HITundef (_, hse) => let
    val () =
      emit_text (out, "postiats_undef(")
    val ((*void*)) = fprint_hisexp (out, hse)
    val ((*void*)) = emit_text (out, ")")
  in
    // nothing
  end // end of [HITundef]
//
| HITnone () => emit_text (out, "postiats_none()")
//
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
val hit = hisexp_typize (1, hse)
//
(*
val () = println! ("emit_hisexp: hse = ", hse)
val () = println! ("emit_hisexp: hit = ", hit)
*)
//
in
//
case+ hit of
| HITundef _ =>
  (
    emit_text (out, "HITundef("); fprint_hisexp (out, hse); emit_text (out, ")")
  ) // end of [HITundef]
| _ => emit_hitype (out, hit)
//
end // end of [emit_hisexp]

(* ****** ****** *)

implement
emit_hisexplst_sep
  (out, hses, sep) = let
//
fun loop (
  out: FILEref
, hses: hisexplst, sep: string, i: int
) : void = let
in
//
case+ hses of
| list_cons
    (hse, hses) => let
    val () =
      if i > 0
        then emit_text (out, sep)
      // end of [if]
    val () = emit_hisexp (out, hse)
  in
    loop (out, hses, sep, i+1)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [loop]
//
in
  loop (out, hses, sep, 0)
end // end of [emit_hisexplst_sep]

(* ****** ****** *)

implement
emit_hisexp_sel
  (out, hse) = let
//
val hit = hisexp_typize (0, hse)
//
(*
val () = println! ("emit_hisexp_sel: hse = ", hse)
val () = println! ("emit_hisexp_sel: hit = ", hit)
*)
//
in
//
case+ hit of
| HITundef _ =>
  (
    emit_text (out, "HITundef("); fprint_hisexp (out, hse); emit_text (out, ")")
  ) // end of [HITundef]
| _ => emit_hitype (out, hit)
//
end // end of [emit_hisexp_sel]

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

extern
fun hitype_gen_tysum (): hitype
implement
hitype_gen_tysum () = let
  val n = $STMP.hitype_stamp_make ()
  val name = $STMP.tostring_prefix_stamp ("postiats_tysum_", n)
in
  HITnmd (name)
end // end of [hitype_gen_tysum]

extern
fun hitype_gen_tyexn (): hitype
implement
hitype_gen_tyexn () = let
  val n = $STMP.hitype_stamp_make ()
  val name = $STMP.tostring_prefix_stamp ("postiats_tyexn_", n)
in
  HITnmd (name)
end // end of [hitype_gen_tyexn]

(* ****** ****** *)

implement
s2exp_typize
  (flag, s2e0) = let
in
//
case+
  s2e0.s2exp_node of
//
| S2Eextype (name, _) => HITnmd (name)
| S2Eextkind (name, _) => HITnmd (name)
//
| S2Eat _ => hitype_none ()
| S2EVar _ => hitype_none ()
//
| _ => let
    val hse0 = $TYER.s2exp_tyer_shallow ($LOC.location_dummy, s2e0)
  in
    hisexp_typize (flag, hse0)
  end // end of [_]
//
end // end of [s2exp_typize]

(* ****** ****** *)

local

fun aux
(
  flag: int, hse0: hisexp
) : hitype = let
(*
val () = println! ("aux: hse0 = ", hse0)
*)
val HITNAM (knd, fin, name) = hse0.hisexp_name
//
in
//
case+ hse0.hisexp_node of
| _ when
    (fin > 0) => HITnmd (name)
//
| HSEcst (s2c) => aux_s2cst (s2c)
//
| HSEapp (_fun, _arg) =>
    HITapp (aux (flag, _fun), auxlst (flag, _arg))
  // end of [HSEapp]
//
| HSEtyabs (sym) => let
    val name =
      $SYM.symbol_get_name (sym) in HITnmd (name)
    // end of [val]
  end // end of [HSEtyabs]
//
| HSEtyarr _ => aux_tyarr (flag, hse0)
//
| HSEtyrec _ => aux_tyrec (flag, hse0)
//
| HSEtyrecsin (lhse) => let
    val HSLABELED (lab, opt, hse) = lhse in aux (flag, hse)
  end // end of [HSEtyrecsin]
//
| HSEtysum (d2c, _) =>
  (
    if d2con_is_con (d2c)
      then aux_tysum (flag, hse0) else aux_tyexn (flag, hse0)
    // end of [if]
  ) // end of [HSEtysum]
//
| HSErefarg (knd, hse) => let
    val hit = aux (flag, hse) in HITrefarg (knd, hit)
  end // end of [HSErefarg]
//
| HSEs2exp (s2e) => let
    val hit = s2exp_typize (flag, s2e) in
    case+ hit of HITnone () => hitype_undef (hse0) | _ => (hit)
  end // end of [HSEs2exp]
//
| HSEtyvar (s2v) => HITtyvar (s2v)
//
| _ => hitype_undef (hse0)
//
end // end of [aux]

and aux_s2cst
  (s2c: s2cst): hitype = let
in
//
case+ 0 of
| _ when
    s2cst_is_datype (s2c) => hitype_tybox ()
| _ => let
    val sym = s2cst_get_sym (s2c)
    val name =
      $SYM.symbol_get_name (sym) in HITnmd (name)
    // end of [val]
  end // end of [_]
//
end // end of [aux_s2cst]

and aux_tyarr
(
  flag: int, hse0: hisexp
) : hitype = let
//
val-HSEtyarr
  (hse_elt, dim) = hse0.hisexp_node
val hit_elt = aux (flag+1, hse_elt)
//
in
  HITtyarr (hit_elt, dim)
end // end of [aux_tyarr]

and aux_tyrec
(
  flag: int, hse0: hisexp
) : hitype = let
//
val-HSEtyrec
  (knd, lxs) = hse0.hisexp_node
in
//
case+ knd of
//
| TYRECKINDbox () =>
    if flag > 0 then
      hitype_tybox () else aux_tyrec2 (flag, lxs)
    // end of [if]
| TYRECKINDbox_lin () =>
    if flag > 0 then
      hitype_tybox () else aux_tyrec2 (flag, lxs)
    // end of [if]
//
| TYRECKINDflt0 () => aux_tyrec2 (flag, lxs)
| TYRECKINDflt1 (stamp) => aux_tyrec2 (flag, lxs)
| TYRECKINDflt_ext (name) => HITnmd (name)
//
end // end of [aux_tyrec]

and aux_tyrec2
(
  flag: int, lxs: labhisexplst
) : hitype = let
  val lys = auxlablst (flag, lxs)
  val hit0 = HITtyrec (lys)
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
end // end of [aux_tyrec2]

and aux_tysum
(
  flag: int, hse0: hisexp
) : hitype = let
//
val-HSEtysum
  (d2c, lxs) = hse0.hisexp_node
val isbox =
  (if flag > 0 then true else false): bool
//
in
//
if isbox
  then hitype_tybox ()
  else let
  val tgd = (
    if d2con_is_tagless (d2c) then 0 else 1
  ) : int // end of [val]
  val lys = auxlablst (flag, lxs)
  val hit0 = HITtysum (tgd, lys)
  val opt = the_hitypemap_search (hit0)
in
  case+ opt of
  | ~None_vt () => let
      val hit1 = hitype_gen_tysum ()
      val () = the_hitypemap_insert (hit0, hit1)
    in
      hit1
    end // end of [None_vt]
  | ~Some_vt (hit0) => hit0
end // end of [if]
//
end // end of [aux_tysum]

and aux_tyexn
(
  flag: int, hse0: hisexp
) : hitype = let
//
val-HSEtysum
  (d2c, lxs) = hse0.hisexp_node
val isbox =
  (if flag > 0 then true else false): bool
//
in
//
if isbox
  then hitype_tybox ()
  else let
  val lys = auxlablst (flag, lxs)
  val hit0 = HITtyexn (lys)
  val opt = the_hitypemap_search (hit0)
in
  case+ opt of
  | ~None_vt () => let
      val hit1 = hitype_gen_tyexn ()
      val () = the_hitypemap_insert (hit0, hit1)
    in
      hit1
    end // end of [None_vt]
  | ~Some_vt (hit0) => hit0
end // end of [if]
//
end // end of [aux_tyexn]

and auxlst
(
  flag: int, xs: hisexplst
) : hitypelst = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val y = aux (flag+1, x)
    val ys = auxlst (flag, xs)
  in
    list_cons (y, ys)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]

and auxlablst
(
  flag: int, lxs: labhisexplst
) : labhitypelst = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val+HSLABELED (l, opt, x) = lx
    val y = aux (flag+1, x)
    val ly = HTLABELED (l, opt, y)
    val lys = auxlablst (flag, lxs)
  in
    list_cons (ly, lys)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlablst]

in (* in of [local] *)

implement
hisexp_typize (flag, x) = aux (flag, x)

end // end of [local]

(* ****** ****** *)

local

fun auxfld (
  out: FILEref
, lhit: labhitype
) : void = let
//
val+HTLABELED (lab, opt, hit) = lhit
//
var isa: bool = false
var dim: s2explst = list_nil ()
//
val (
) = (
  case+ hit of
  | HITtyarr (
      hit_elt, s2es
    ) => {
      val () = isa := true
      val () = dim := s2es
      val () = emit_hitype (out, hit_elt)
    } // end of [HITtyarr]
  | _ => emit_hitype (out, hit)
) : void // end of [val]
//
val (
) = emit_text (out, " ")
val (
) = (
  case+ opt of
  | Some (
      name
    ) => emit_text (out, name)
  | None (
    ) => emit_labelext (out, 0(*extknd*), lab)
) : void // end of [val]
//
val () = (
  if isa
    then emit_text (out, "[]")
  // end of [if]
) : void // end of [val]
//
val () = emit_text (out, "; ")
//
in
  // nothing
end // end of [auxfld]

fun auxfldlst (
  out: FILEref
, lhits: labhitypelst, i: int
) : void = let
in
//
case+ lhits of
| list_cons
    (lhit, lhits) => let
    val+HTLABELED
      (lab, opt, hit) = lhit
    val () =
      if i > 0 then emit_newline (out)
    // end of [val]
    val () = auxfld (out, lhit)
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
| HITtyrec (lhits) => {
    val () = emit_text (out, "struct {")
    val () = auxfldlst (out, lhits, 1)
    val () = emit_text (out, "\n}")
  } // end of [HITtyrec]
| HITtysum (tgd, lhits) => {
    val () = emit_text (out, "struct {\n")
    val () = fprintf (out, "#if(%i)\n", @(tgd))
    val () = emit_text (out, "int contag ;\n")
    val () = emit_text (out, "#endif")
    val () = auxfldlst (out, lhits, 1)
    val () = emit_text (out, "\n}")
  } // end of [HITtysum]
| HITtyexn (lhits) => {
    val () = emit_text (out, "struct {\n")
    val () = emit_text (out, "int exntag ;\n")
    val () = emit_text (out, "char *exnmsg ;")
    val () = auxfldlst (out, lhits, 1)
    val () = emit_text (out, "\n}")
  } // end of [HITtyexn]
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
