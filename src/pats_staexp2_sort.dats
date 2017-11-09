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
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE =
"./pats_atspre.dats"
//
(* ****** ****** *)

staload
"./pats_basics.sats"

(* ****** ****** *)
//
staload
SYM = "./pats_symbol.sats"
overload = with $SYM.eq_symbol_symbol
//
(* ****** ****** *)
//
staload
STMP = "./pats_stamp.sats"
//
typedef stamp = $STMP.stamp
overload compare with $STMP.compare_stamp_stamp
//
(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)
//
fun
prerr_interror(): void =
  prerr "INTERROR(pats_staexp2_sort)"
//
(* ****** ****** *)

typedef
s2rtdat_struct = @{
  s2rtdat_sym= symbol // name
, s2rtdat_sconlst= s2cstlst
, s2rtdat_stamp= stamp // unique stamp
} (* end of [s2rtdat_struct] *)

(* ****** ****** *)

local

assume
s2rtdat_type = ref(s2rtdat_struct)

in (* in-of-local *)

implement
s2rtdat_make (id) = let
//
val
stamp =
$STMP.s2rtdat_stamp_make()
//
val (pfgc, pfat | p) = ptr_alloc<s2rtdat_struct> ()
//
prval () = free_gc_elim (pfgc)
//
val () = p->s2rtdat_sym := id
val () = p->s2rtdat_sconlst := list_nil()
val () = p->s2rtdat_stamp := stamp
//
in // in of [let]
  ref_make_view_ptr (pfat | p)
end // end of [s2rtdat_make]

(* ****** ****** *)

implement
s2rtdat_get_sym (s2td) = let
  val (vbox pf | p) = ref_get_view_ptr(s2td) in p->s2rtdat_sym
end // end of [s2rtdat_get_sym]

(* ****** ****** *)

implement
s2rtdat_get_sconlst (s2td) = let
  val (vbox pf | p) = ref_get_view_ptr(s2td) in p->s2rtdat_sconlst
end // end of [s2rtdat_get_sconlst]
implement
s2rtdat_set_sconlst (s2td, s2cs) = let
  val (vbox pf | p) = ref_get_view_ptr(s2td) in p->s2rtdat_sconlst := s2cs
end // end of [s2rtdat_set_sconlst]

(* ****** ****** *)

implement
s2rtdat_get_stamp (s2td) = let
  val (vbox pf | p) = ref_get_view_ptr(s2td) in p->s2rtdat_stamp
end // end of [s2rtdat_get_stamp]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)
//
implement
eq_s2rtdat_s2rtdat
(
  x1, x2
) = (compare_s2rtdat_s2rtdat (x1, x2) = 0)
//
implement
compare_s2rtdat_s2rtdat
(
  x1, x2
) =
$effmask_all
(
  compare(s2rtdat_get_stamp(x1), s2rtdat_get_stamp(x2))
) (* end of [compare_s2rtdat_s2rtdat] *)
//
(* ****** ****** *)

local
//
val s2tb_int: s2rtbas = S2RTBASpre($SYM.symbol_INT)
val s2tb_addr: s2rtbas = S2RTBASpre($SYM.symbol_ADDR)
val s2tb_bool: s2rtbas = S2RTBASpre($SYM.symbol_BOOL)
//
(*
val s2tb_char: s2rtbas = S2RTBASpre ($SYM.symbol_CHAR)
*)
//
val s2tb_real: s2rtbas = S2RTBASpre($SYM.symbol_REAL)
//
val s2tb_float: s2rtbas = S2RTBASpre($SYM.symbol_FLOAT)
val s2tb_string: s2rtbas = S2RTBASpre($SYM.symbol_STRING)
//
val s2tb_cls
  : s2rtbas = S2RTBASpre($SYM.symbol_CLS) // for nominal classes
//
val s2tb_eff
  : s2rtbas = S2RTBASpre($SYM.symbol_EFF) // for sets of effects
//
val s2tb_tkind
  : s2rtbas = S2RTBASpre($SYM.symbol_TKIND) // for template arguments
//
in // in of [local]
//
implement s2rt_int = S2RTbas s2tb_int
implement s2rt_addr = S2RTbas s2tb_addr
implement s2rt_bool = S2RTbas s2tb_bool
//
(*
implement s2rt_char = S2RTbas s2tb_char
*)
//
implement s2rt_real = S2RTbas s2tb_real
//
implement s2rt_float = S2RTbas s2tb_float
implement s2rt_string = S2RTbas s2tb_string
//
implement s2rt_cls = S2RTbas s2tb_cls
//
implement s2rt_eff = S2RTbas s2tb_eff
//
implement s2rt_tkind = S2RTbas s2tb_tkind
//
end // end of [local]

(* ****** ****** *)

local
//
#include "./pats_basics.hats"
//
val s2tb_prop: s2rtbas = S2RTBASimp(PROP_int, $SYM.symbol_PROP)
val s2tb_prop_pos: s2rtbas = S2RTBASimp(PROP_pos_int, $SYM.symbol_PROP)
val s2tb_prop_neg: s2rtbas = S2RTBASimp(PROP_neg_int, $SYM.symbol_PROP)
//
val s2tb_type: s2rtbas = S2RTBASimp(TYPE_int, $SYM.symbol_TYPE)
val s2tb_type_pos: s2rtbas = S2RTBASimp(TYPE_pos_int, $SYM.symbol_TYPE)
val s2tb_type_neg: s2rtbas = S2RTBASimp(TYPE_neg_int, $SYM.symbol_TYPE)
//
val s2tb_t0ype: s2rtbas = S2RTBASimp(T0YPE_int, $SYM.symbol_T0YPE)
val s2tb_t0ype_pos: s2rtbas = S2RTBASimp(T0YPE_pos_int, $SYM.symbol_T0YPE)
val s2tb_t0ype_neg: s2rtbas = S2RTBASimp(T0YPE_neg_int, $SYM.symbol_T0YPE)
//
val s2tb_types: s2rtbas = S2RTBASimp(TYPES_int, $SYM.symbol_TYPES)
//
val s2tb_view: s2rtbas = S2RTBASimp(VIEW_int, $SYM.symbol_VIEW)
val s2tb_view_pos: s2rtbas = S2RTBASimp(VIEW_pos_int, $SYM.symbol_VIEW)
val s2tb_view_neg: s2rtbas = S2RTBASimp(VIEW_neg_int, $SYM.symbol_VIEW)
//
val s2tb_vtype: s2rtbas = S2RTBASimp(VIEWTYPE_int, $SYM.symbol_VIEWTYPE)
val s2tb_vtype_pos: s2rtbas = S2RTBASimp(VIEWTYPE_pos_int, $SYM.symbol_VIEWTYPE)
val s2tb_vtype_neg: s2rtbas = S2RTBASimp(VIEWTYPE_neg_int, $SYM.symbol_VIEWTYPE)
//
val s2tb_vt0ype: s2rtbas = S2RTBASimp(VIEWT0YPE_int, $SYM.symbol_VIEWT0YPE)
val s2tb_vt0ype_pos: s2rtbas = S2RTBASimp(VIEWT0YPE_pos_int, $SYM.symbol_VIEWT0YPE)
val s2tb_vt0ype_neg: s2rtbas = S2RTBASimp(VIEWT0YPE_neg_int, $SYM.symbol_VIEWT0YPE)
//
in // in of [local]

implement s2rt_prop = S2RTbas(s2tb_prop)
implement s2rt_prop_pos = S2RTbas(s2tb_prop_pos)
implement s2rt_prop_neg = S2RTbas(s2tb_prop_neg)

implement s2rt_type = S2RTbas(s2tb_type)
implement s2rt_type_pos = S2RTbas(s2tb_type_pos)
implement s2rt_type_neg = S2RTbas(s2tb_type_neg)

implement s2rt_t0ype = S2RTbas(s2tb_t0ype)
implement s2rt_t0ype_pos = S2RTbas(s2tb_t0ype_pos)
implement s2rt_t0ype_neg = S2RTbas(s2tb_t0ype_neg)

implement s2rt_types = S2RTbas(s2tb_types)

implement s2rt_view = S2RTbas(s2tb_view)
implement s2rt_view_pos = S2RTbas(s2tb_view_pos)
implement s2rt_view_neg = S2RTbas(s2tb_view_neg)

implement s2rt_vtype = S2RTbas(s2tb_vtype)
implement s2rt_vtype_pos = S2RTbas(s2tb_vtype_pos)
implement s2rt_vtype_neg = S2RTbas(s2tb_vtype_neg)

implement s2rt_vt0ype = S2RTbas(s2tb_vt0ype)
implement s2rt_vt0ype_pos = S2RTbas(s2tb_vt0ype_pos)
implement s2rt_vt0ype_neg = S2RTbas(s2tb_vt0ype_neg)

implement
s2rt_impred (knd) = let
in
//
case+ knd of
//
| PROP_int => s2rt_prop
| TYPE_int => s2rt_type
| T0YPE_int => s2rt_t0ype
| VIEW_int => s2rt_view
| VIEWTYPE_int => s2rt_vtype
| VIEWT0YPE_int => s2rt_vt0ype
//
| PROP_pos_int => s2rt_prop_pos
| PROP_neg_int => s2rt_prop_neg
| TYPE_pos_int => s2rt_type_pos
| TYPE_neg_int => s2rt_type_neg
| T0YPE_pos_int => s2rt_t0ype_pos
| T0YPE_neg_int => s2rt_t0ype_neg
| VIEW_pos_int => s2rt_view_pos
| VIEW_neg_int => s2rt_view_neg
| VIEWTYPE_pos_int => s2rt_vtype_pos
| VIEWTYPE_neg_int => s2rt_vtype_neg
| VIEWT0YPE_pos_int => s2rt_vt0ype_pos
| VIEWT0YPE_neg_int => s2rt_vt0ype_neg
//
| _ => let
//
    val () = prerr_interror ()
    val () = prerr ": s2rt_impred: knd = "
    val () = prerr_int (knd)
    val () = prerr_newline ()
    val () = assertloc (false)
  in
    s2rt_t0ype // HX: this should be deadcode!
  end // end of [_]
//
end // end of [s2rt_impred]

end // end of [local]

(* ****** ****** *)

implement
s2rt_is_int (s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASpre (sym) => sym = $SYM.symbol_INT | _ => false
  ) // end of [S2RTbas]
  | _ => false
) // end of [s2rt_is_int]

implement
s2rt_is_addr (s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASpre (sym) => sym = $SYM.symbol_ADDR | _ => false
  ) // end of [S2RTbas]
  | _ => false
) // end of [s2rt_is_addr]
implement
s2rt_is_bool (s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASpre (sym) => sym = $SYM.symbol_BOOL | _ => false
  ) // end of [S2RTbas]
| _ => false
) // end of [s2rt_is_bool]

(* ****** ****** *)

(*
implement
s2rt_is_char (s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASpre (sym) => sym = $SYM.symbol_CHAR | _ => false
  ) // end of [S2RTbas]
  | _ => false
) // end of [s2rt_is_char]
*)

(* ****** ****** *)

implement
s2rt_is_float
  (s2t) = (
//
case+ s2t of
| S2RTbas(s2tb) =>
  (
    case+ s2tb of
    | S2RTBASpre(sym) =>
        sym = $SYM.symbol_FLOAT
      (* S2RTBASpre *)
    | _ (*non-S2RTBASpre*) => false
  ) (* [S2RTbas] *)
| _ (*non-S2RTbas*) => false
//
) // end of [s2rt_is_float]

(* ****** ****** *)

implement
s2rt_is_dat(s2t) =
(
case+ s2t of
| S2RTbas(s2tb) =>
  (
    case+ s2tb of
    | S2RTBASdef( _ ) => true | _ => false
  ) (* end of [S2RTbas] *)
| _ (*non-S2RTbas*) => false
) // end of [s2rt_is_dat]

(* ****** ****** *)

implement
s2rt_is_fun(s2t) =
(
  case+ s2t of S2RTfun _ => true | _ => false
) // end of [s2rt_is_fun]

implement
s2rt_is_prf(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASimp(knd, _) => test_prfkind(knd) | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
) // end of [s2rt_is_prf]

(* ****** ****** *)

implement
s2rt_is_lin(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASimp(knd, _) => test_linkind(knd) | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
) // end of [s2rt_is_lin]

implement
s2rt_is_nonlin(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASimp(knd, _) => not(test_linkind(knd)) | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
) // end of [s2rt_is_nonlin]

(* ****** ****** *)

implement
s2rt_is_flat(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASimp(knd, _) => test_fltkind(knd) | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
) (* end of [s2rt_is_flat] *)

implement
s2rt_is_boxed(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASimp(knd, _) => test_boxkind(knd) | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
) (* end of [s2rt_is_boxed] *)

(* ****** ****** *)

implement
s2rt_is_tkind(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASpre(sym) => (
      $SYM.eq_symbol_symbol(sym, $SYM.symbol_TKIND)
    ) (* S2RTBASpre *)
  | _ (*non-S2RTBASpre*) => false
  ) // end of [S2ETbas]
| _ (*non-S2RTbas*) => false // end of [_]
) // end of [s2rt_is_tkind]

(* ****** ****** *)

implement
s2rt_is_prgm(s2t) =
(
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of
  | S2RTBASimp(knd, _) => test_prgmkind(knd) | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
) (* end of [s2rt_is_prgm] *)

(* ****** ****** *)

implement
s2rt_is_impred
  (s2t) = (
//
case+ s2t of
| S2RTbas s2tb => (
  case+ s2tb of S2RTBASimp _ => true | _ => false
  ) // end of [S2RTbas]
| _ (*non-S2RTbas*) => false // end of [_]
//
) (* end of [s2rt_is_impred] *)

(* ****** ****** *)

local

fun
s2rt_test_fun
(
  s2t: s2rt, ft: s2rt -> bool
): bool = (
  case+ s2t of
  | S2RTfun(_, s2t) =>
      s2rt_test_fun(s2t, ft)
    // end of [S2RTfun]
  | _ (*non-S2RTfun*) => ft(s2t)
) // end of [s2rt_test_fun]

in (* in-of-local *)
//
implement
s2rt_is_lin_fun
  (s2t) = s2rt_test_fun(s2t, s2rt_is_lin)
//
implement
s2rt_is_flat_fun
  (s2t) = s2rt_test_fun(s2t, s2rt_is_flat)
//
implement
s2rt_is_boxed_fun
  (s2t) = s2rt_test_fun(s2t, s2rt_is_boxed)
//
implement
s2rt_is_tkind_fun
  (s2t) = s2rt_test_fun(s2t, s2rt_is_tkind)
//
implement
s2rt_is_prgm_fun
  (s2t) = s2rt_test_fun(s2t, s2rt_is_prgm)
implement
s2rt_is_impred_fun
  (s2t) = s2rt_test_fun(s2t, s2rt_is_impred)
//
end // end of [local]

(* ****** ****** *)

implement
s2rt_get_pol(s2t) =
(
//
case+ s2t of
| S2RTbas(s2tb) =>
  (
  case+ s2tb of
  | S2RTBASimp(knd, _) => test_polkind(knd) | _ => 0
  ) (* end of [S2RTbas] *)
| _ (* non-S2RTbas *) => 0 // 0: polarity is neutral
//
) (* end of [s2rt_get_pol] *)

(* ****** ****** *)

abstype s2rtnul (l:addr)
typedef s2rtnul = [l:agez] s2rtnul (l)

(* ****** ****** *)

extern
castfn s2rtnul_none (x: ptr null): s2rtnul (null)

extern
castfn s2rtnul_some (x: s2rt): [l:agz] s2rtnul (l)
extern
castfn s2rtnul_unsome {l:agz} (x: s2rtnul l): s2rt

extern
fun s2rtnul_is_null {l:addr}
  (x: s2rtnul (l)): bool (l==null) = "atspre_ptr_is_null"
// end of [s2rtnul_is_null]
extern
fun s2rtnul_isnot_null {l:addr}
  (x: s2rtnul (l)): bool (l > null) = "atspre_ptr_isnot_null"
// end of [s2rtnul_isnot_null]

(* ****** ****** *)

local
//
assume s2rtVar = ref (s2rtnul)
//
in (* in-of-local *)

implement
eq_s2rtVar_s2rtVar
  (x1, x2) = (p1 = p2) where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [eq_s2rtVar_s2rtVar]

implement
compare_s2rtVar_s2rtVar
  (x1, x2) = compare_ptr_ptr (p1, p2) where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [compare_s2rtVar_s2rtVar]

(* ****** ****** *)

implement
s2rtVar_make (loc) = let
  val nul = s2rtnul_none (null) in ref_make_elt (nul)
end // end of [s2rtVar_make]

(* ****** ****** *)

implement
s2rt_delink (s2t0) = let
//
fun
aux
(
  s2t0: s2rt
) : s2rt =
(
case+ s2t0 of
| S2RTVar ref => let
    val s2t = !ref
    val test =
      s2rtnul_isnot_null(s2t)
    // end of [val]
  in
    if test
      then let
        val s2t =
          s2rtnul_unsome(s2t)
        val s2t = aux (s2t)
        val ((*void*)) =
          !ref := s2rtnul_some(s2t)
      in
        s2t
      end // end of [then]
      else s2t0 // end of [else]
    // end of [if]
  end (* S2RTVar *)
| _ (*non-S2RTVar*) => s2t0
) (* end of [aux] *)
//
in
  aux (s2t0)
end // end of [s2rt_delink]

implement
s2rt_delink_all
  (s2t0) = let
//
fun
aux (
  s2t0: s2rt, flag: &int
) : s2rt =
(
case+ s2t0 of
| S2RTfun
    (s2ts, s2t) => let
    val
    flag0 = flag
    val s2t = aux(s2t, flag)
    val s2ts = auxlst(s2ts, flag)
  in
    if flag > flag0
      then S2RTfun (s2ts, s2t) else s2t0
    // end of [if]
  end
| S2RTtup(s2ts) => let
    val
    flag0 = flag
    val s2ts = auxlst (s2ts, flag)
  in
    if flag > flag0 then S2RTtup (s2ts) else s2t0
  end
| S2RTVar (ref) => let
    val s2t = !ref
    val isnotnull =
      s2rtnul_isnot_null (s2t)
    // end of [val]
  in
    if isnotnull
      then let
        val s2t =
          s2rtnul_unsome(s2t)
        val s2t = aux (s2t, flag)
        val ((*void*)) =
          !ref := s2rtnul_some(s2t)
        // end of [val]
      in
        flag := flag + 1; s2t
      end // end of [then]
      else s2t0 // end of [else]
    // end of [if]
  end (* S2RTVar *)
| _ (*rest-of-s2rt*) => s2t0
) (* end of [aux] *)
//
and
auxlst
(
  s2ts0: s2rtlst, flag: &int
) : s2rtlst = (
//
case+ s2ts0 of
| list_nil
    ((*void*)) => list_nil()
| list_cons
    (s2t, s2ts) => let
    val
    flag0 = flag
    val s2t = aux (s2t, flag)
    val s2ts = auxlst (s2ts, flag)
  in
    if flag > flag0
      then list_cons(s2t, s2ts) else s2ts0
    // end of [if]
  end // end of [list_cons]
//
) (* end if [auxlst] *)
//
var flag: int = 0
//
in
  aux (s2t0, flag)
end // end of [s2rt_delink_all]

(* ****** ****** *)

implement
s2rtVar_get_s2rt
  (s2tV) = let
  val s2t = !s2tV
  val isnot = s2rtnul_isnot_null(s2t)
in
//
if isnot then s2rtnul_unsome(s2t) else S2RTerr()
//
end // end of [s2rtVar_set_s2rt]

implement
s2rtVar_set_s2rt
  (s2tV, s2t) = let
  val s2t = s2rtnul_some (s2t) in !s2tV := s2t 
end // end of [s2rtVar_set_s2rt]

implement
s2rtVar_occurcheck
  (s2tV, s2t0) = let
//
fun aux (
  s2t0: s2rt
) :<cloref1> bool =
(
//
case+ s2t0 of
//
| S2RTbas _ => false
//
| S2RTfun (s2ts, s2t) =>
  (
    if auxlst (s2ts) then true else aux (s2t)
  ) (* end of [S2RTfun] *)
//
| S2RTtup (s2ts) => auxlst (s2ts)
//
| S2RTVar (s2tV1) =>
  (
    if s2tV = s2tV1
      then true else let
        val s2t1 = !s2tV1
        val isnot = s2rtnul_isnot_null(s2t1)
      in
        if isnot
          then aux (s2rtnul_unsome(s2t1)) else false
        // end of [if]
      end // end of [else]
    // end of [if]
  ) (* end of [S2RTVar] *)
//
| S2RTerr ((*void*)) => false
//
) (* end of [aux] *)
//
and
auxlst
(
  s2ts: s2rtlst
) :<cloref1> bool =
(
//
case+ s2ts of
| list_nil () => false
| list_cons (s2t, s2ts) =>
    if aux (s2t) then true else auxlst (s2ts)
  // end of [list_cons]
//
) (* end of [auxlst] *)
//
in
  aux (s2t0)
end // end of [s2rtVar_occurcheck]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
s2rt_fun (_arg, _res) = S2RTfun (_arg, _res)

implement
s2rt_tup (s2ts) = S2RTtup (s2ts) // HX: tuple sort not yet supported

implement
s2rt_err () = S2RTerr () // HX: error indication

(* ****** ****** *)
//
extern
fun
lte_s2rtbas_s2rtbas
  (s2tb1: s2rtbas, s2tb2: s2rtbas): bool
//
overload <= with lte_s2rtbas_s2rtbas
//
implement
lte_s2rtbas_s2rtbas
  (s2tb1, s2tb2) =
(
case+
(s2tb1, s2tb2)
of // case+
| (S2RTBASpre id1,
   S2RTBASpre id2) => (id1 = id2)
| (S2RTBASimp(knd1, id1),
   S2RTBASimp(knd2, id2)) => lte_impkind_impkind(knd1, knd2)
| (S2RTBASdef s2td1,
   S2RTBASdef s2td2) => (s2td1 = s2td2)
| (_, _) => false
) (* end of [lte_s2rtbas_s2rtbas] *)
//
(* ****** ****** *)
//
(*
** HX: knd=0/1: dry-run / real-run
*)
extern
fun
s2rt_ltmat (knd: int, s2t1: s2rt, s2t2: s2rt): bool
extern
fun
s2rtlst_ltmat (knd: int, xs1: s2rtlst, xs2: s2rtlst): bool
//
implement
s2rt_ltmat
  (knd, s2t1, s2t2) = let
//
fun
auxVar
(
  knd: int
, s2tV: s2rtVar, s2t: s2rt
) : bool =
(
//
if
(knd > 0)
then let
  val
  test =
  s2rtVar_occurcheck(s2tV, s2t)
in
  if test
    then false else let
    val () = s2rtVar_set_s2rt(s2tV, s2t) in true
  end (* end of [if] *)
end else true // HX: a dry run always succeeds
//
) (* end of [auxVar] *)
//
val s2t1 = s2rt_delink(s2t1)
and s2t2 = s2rt_delink(s2t2)
//
in
//
case+ s2t1 of
| S2RTbas
    (s2tb1) =>
  (
  case+ s2t2 of
  | S2RTbas(s2tb2) => s2tb1 <= s2tb2 | _ => false
  )
| S2RTfun
  (
    s2ts1, s2t1
  ) =>
  (
  case+ s2t2 of
  | S2RTfun
    (
      s2ts2, s2t2
    ) =>
    if s2rtlst_ltmat(knd, s2ts2, s2ts1)
      then s2rt_ltmat(knd, s2t1, s2t2) else false
    // end of [if]
  | _ (*non-S2RTfun*) => false
  )
| S2RTtup(s2ts1) =>
  (
  case+ s2t2 of
  | S2RTtup(s2ts2) => s2rtlst_ltmat(knd, s2ts1, s2ts2) | _ => false
  )
| S2RTVar(s2tV1) =>
  (
  case+ s2t2 of
  | S2RTVar(s2tV2) when s2tV1 = s2tV2 => true | _ => auxVar(knd, s2tV1, s2t2)
  )
//
| S2RTerr ((*void*)) => false
//
end // end of [s2rt_ltmat]
//
(* ****** ****** *)

implement
s2rtlst_ltmat
  (knd, xs1, xs2) =
(
  case+ (xs1, xs2) of
  | (list_nil (),
     list_nil ()) => true
  | (list_cons (x1, xs1),
     list_cons (x2, xs2)) =>
    (
      if s2rt_ltmat (knd, x1, x2) then s2rtlst_ltmat (knd, xs1, xs2) else false
    )
  | (_, _) => false
) (* end of [s2rtlst_ltmat] *)

(* ****** ****** *)

implement s2rt_ltmat0(x1, x2) = s2rt_ltmat(0, x1, x2)
implement s2rt_ltmat1(x1, x2) = s2rt_ltmat(1, x1, x2)

(* ****** ****** *)

local
//
staload
FS = "libats/SATS/funset_avltree.sats"
staload
_(*FS*) = "libats/DATS/funset_avltree.dats"
//
val
cmp =
lam (
  x1: s2rtdat, x2: s2rtdat
) : int =<cloref>
  compare_s2rtdat_s2rtdat (x1, x2)
// end of [val]
//
assume s2rtdatset_type = $FS.set (s2rtdat)
//
in (* in-of-local *)

implement
s2rtdatset_nil
  ((*void*)) = $FS.funset_make_nil ()

implement
s2rtdatset_add
  (xs, x) = xs where {
  var xs = xs
  val _(*rplced*) = $FS.funset_insert (xs, x, cmp)
} (* end of [s2rtdatset_add] *)

implement
s2rtdatset_listize (xs) = $FS.funset_listize (xs)

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_sort.dats] *)
