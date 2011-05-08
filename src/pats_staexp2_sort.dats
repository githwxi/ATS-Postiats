(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

local

val s2tb_int: s2rtbas = S2RTBASpre ($SYM.symbol_INT)
val s2tb_bool: s2rtbas = S2RTBASpre ($SYM.symbol_BOOL)
val s2tb_addr: s2rtbas = S2RTBASpre ($SYM.symbol_ADDR)
val s2tb_char: s2rtbas = S2RTBASpre ($SYM.symbol_CHAR)
val s2tb_cls: s2rtbas = S2RTBASpre ($SYM.symbol_CLS)
val s2tb_eff: s2rtbas = S2RTBASpre ($SYM.symbol_EFF)

in // in of [local]

implement s2rt_int = S2RTbas s2tb_int
implement s2rt_bool = S2RTbas s2tb_bool
implement s2rt_addr = S2RTbas s2tb_addr
implement s2rt_char = S2RTbas s2tb_char
implement s2rt_cls = S2RTbas s2tb_cls
implement s2rt_eff = S2RTbas s2tb_eff

end // end of [local]

(* ****** ****** *)

local
//
#include "pats_basics.hats"
//
val s2tb_prop: s2rtbas = S2RTBASimp ($SYM.symbol_PROP, PROP_int)
val s2tb_type: s2rtbas = S2RTBASimp ($SYM.symbol_TYPE, TYPE_int)
val s2tb_t0ype: s2rtbas = S2RTBASimp ($SYM.symbol_T0YPE, T0YPE_int)
val s2tb_view: s2rtbas = S2RTBASimp ($SYM.symbol_VIEW, VIEW_int)
val s2tb_viewtype: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWTYPE, VIEWTYPE_int)
val s2tb_viewt0ype: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWT0YPE, VIEWT0YPE_int)
//
val s2tb_types: s2rtbas = S2RTBASimp ($SYM.symbol_TYPES, T0YPE_int)
//
in // in of [local]

implement s2rt_prop = S2RTbas s2tb_prop
implement s2rt_type = S2RTbas s2tb_type
implement s2rt_t0ype = S2RTbas s2tb_t0ype
implement s2rt_view = S2RTbas s2tb_view
implement s2rt_viewtype = S2RTbas s2tb_viewtype
implement s2rt_viewt0ype = S2RTbas s2tb_viewt0ype

implement s2rt_types = S2RTbas s2tb_types

end // end of [local]

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

assume s2rtVar = ref (s2rtnul)

in // in of [local]

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
  fun aux (s2t0: s2rt): s2rt =
    case+ s2t0 of
    | S2RTVar r => let
        val s2t = !r
        val test = s2rtnul_isnot_null (s2t)
      in
        if test then let
          val s2t = s2rtnul_unsome (s2t)
          val s2t = aux (s2t)
          val () = !r := s2rtnul_some (s2t)
        in
          s2t
        end else s2t0
      end (* S2RTVar *)
    | _ => s2t0 // end of [_]
  // end of [aux]
in
  aux (s2t0)
end // end of [s2rt_delink]

implement
s2rt_delink_all (s2t0) = let
//
  fun aux (
    flag: &int, s2t0: s2rt
  ) : s2rt =
    case+ s2t0 of
    | S2RTfun (s2ts, s2t) => let
        val flag0 = flag
        val s2ts = auxlst (flag, s2ts)
        val s2t = aux (flag, s2t)
      in
        if flag > flag0 then S2RTfun (s2ts, s2t) else s2t0
      end
    | S2RTtup (s2ts) => let
        val flag0 = flag
        val s2ts = auxlst (flag, s2ts)
      in
        if flag > flag0 then S2RTtup (s2ts) else s2t0
      end
    | S2RTVar r => let
        val s2t = !r
        val isnotnull = s2rtnul_isnot_null (s2t)
      in
        if isnotnull then let
          val s2t = s2rtnul_unsome (s2t)
          val s2t = aux (flag, s2t)
          val () = !r := s2rtnul_some (s2t)
          val () = flag := flag + 1
        in
          s2t
        end else s2t0 // end of [if]
      end (* S2RTVar *)
    | _ => s2t0
  (* end of [aux] *)
//
  and auxlst (
    flag: &int, s2ts0: s2rtlst
  ) : s2rtlst =
    case+ s2ts0 of
    | list_cons (s2t, s2ts) => let
        val flag0 = flag
        val s2t = aux (flag, s2t)
        val s2ts = auxlst (flag, s2ts)
      in
        if flag > flag0 then list_cons (s2t, s2ts) else s2ts0
      end
    | list_nil () => list_nil ()
  (* end if [auxlst] *)
//
  var flag: int = 0
//
in
  aux (flag, s2t0)
end // end of [s2rt_delink_all]

end // end of [local]

(* ****** ****** *)

implement s2rt_err () = S2RTerr ()

(* ****** ****** *)

(* end of [pats_staexp2_sort.dats] *)
