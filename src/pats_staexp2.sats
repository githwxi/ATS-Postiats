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

staload STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp1.sats"

(* ****** ****** *)

abstype s2rtdat_type // boxed
typedef s2rtdat = s2rtdat_type

abstype s2cst_type // assumed in [pats_staexp2_scst.dats]
typedef s2cst = s2cst_type
typedef s2cstlst = List (s2cst)
typedef s2cstopt = Option (s2cst)

abstype s2var_type // assumed in [pats_staexp2_svVar.dats]
typedef s2var = s2var_type
typedef s2varlst = List (s2var)
typedef s2varopt = Option (s2var)
abstype s2varset_type // assumed in [pats_staexp2_svVar.dats]
typedef s2varset = s2varset_type

abstype s2Var_type // assumed in [pats_staexp2_svVar.dats]
typedef s2Var = s2Var_type
typedef s2Varlst = List (s2Var)
typedef s2Varopt = Option (s2Var)
abstype s2Varset_type // assumed in [pats_staexp2_svVar.dats]
typedef s2Varset = s2Varset_type

abstype d2con_type // assumed in [pats_staexp2_dcon.dats]
typedef d2con = d2con_type
typedef d2conlst = List (d2con)

(* ****** ****** *)

datatype s2rtbas =
  | S2RTBASpre of symbol // predicative: bool, char, int, ...
  | S2RTBASimp of (symbol, int(*knd*)) // impredicative sorts
  | S2RTBASdef of s2rtdat // user-defined datasorts
// end of [s2rtbas]

(* ****** ****** *)

abstype s2rtVar // ref (s2rt)

fun eq_s2rtVar_s2rtVar (x1: s2rtVar, x2: s2rtVar): bool
overload = with eq_s2rtVar_s2rtVar
fun compare_s2rtVar_s2rtVar (x1: s2rtVar, x2: s2rtVar): Sgn
overload compare with compare_s2rtVar_s2rtVar

fun s2rtVar_make (loc: location): s2rtVar

(* ****** ****** *)

datatype s2rt =
  | S2RTbas of s2rtbas (* base sort *)
  | S2RTfun of (s2rtlst, s2rt) // function sort
  | S2RTtup of s2rtlst (* tuple sort *)
  | S2RTVar of s2rtVar // HX: unification variable
  | S2RTerr of () // HX: indicating an error
// end of [s2rt]

where
s2rtlst = List (s2rt)
and s2rtopt = Option (s2rt)

(* ****** ****** *)
//
// HX: pre-defined predicative sorts
//
val s2rt_int : s2rt
val s2rt_bool : s2rt
val s2rt_addr : s2rt
val s2rt_char : s2rt
val s2rt_cls : s2rt // classes
val s2rt_eff : s2rt // effects
//
// HX: pre-defined predicative sorts
//
val s2rt_prop : s2rt
val s2rt_type : s2rt
val s2rt_t0ype : s2rt
val s2rt_view : s2rt
val s2rt_viewtype : s2rt
val s2rt_viewt0ype : s2rt
//
val s2rt_types : s2rt
//
(* ****** ****** *)

fun s2rt_err (): s2rt // HX: a placeholder for continuing sort-checking

fun s2rt_delink (x: s2rt): s2rt // HX: shallow removal
fun s2rt_delink_all (x: s2rt): s2rt // HX: perform deep removal

(* ****** ****** *)

fun s2var_make_srt (s2t: s2rt): s2var
fun s2var_make_id_srt (id: symbol, s2t: s2rt): s2var
fun s2var_copy (s2v: s2var): s2var

fun s2var_get_sym (s2v: s2var): symbol
fun s2var_get_srt (s2v: s2var): s2rt
fun s2var_get_tmplev (s2v: s2var): int
fun s2var_set_tmplev (s2v: s2var, lev: int): void
fun s2var_get_sVarset (_: s2var): s2Varset
fun s2var_set_sVarset (_: s2var, _: s2Varset): void
fun s2varlst_set_sVarset (_: s2varlst, _: s2Varset): void
fun s2var_get_stamp (s2v: s2var): stamp

fun lt_s2var_s2var (x1: s2var, x2: s2var): bool
overload < with lt_s2var_s2var
fun lte_s2var_s2var (x1: s2var, x2: s2var): bool
overload <= with lte_s2var_s2var

fun compare_s2var_s2var (x1: s2var, x2: s2var): Sgn
overload compare with compare_s2var_s2var

(* ****** ****** *)

fun fprint_s2var : fprint_type (s2var)
fun fprint_s2varlst : fprint_type (s2varlst)

(* ****** ****** *)

fun s2var_is_boxed (s2v: s2var): bool
fun s2var_is_unboxed (s2v: s2var): bool

(* ****** ****** *)
//
// HX: [s2Var] is assumed in [pats_staexp2_sVar.dats]
//
fun s2Var_make_srt (loc: location, s2t: s2rt): s2Var
fun s2Var_make_var (loc: location, s2v: s2var): s2Var

(* ****** ****** *)

fun s2Var_get_srt (s2V: s2Var): s2rt
fun s2Var_get_stamp (s2V: s2Var): stamp

(* ****** ****** *)

fun lt_s2Var_s2Var (x1: s2Var, x2: s2Var): bool
overload < with lt_s2Var_s2Var
fun lte_s2Var_s2Var (x1: s2Var, x2: s2Var): bool
overload <= with lte_s2Var_s2Var

fun compare_s2Var_s2Var (x1: s2Var, x2: s2Var): Sgn
overload compare with compare_s2Var_s2Var

(* ****** ****** *)

fun fprint_s2Var : fprint_type (s2Var)

(* ****** ****** *)

fun s2Varset_make_nil (): s2Varset

(* ****** ****** *)
//
// HX-2011-05-02:
// [filenv] contains the following
// [s2rtenv], [s2expenv] and [d2expenv]
//
abstype filenv_type
typedef filenv = filenv_type

(* ****** ****** *)

datatype
s2itm = // static items
  | S2ITMcst of s2cstlst
  | S2ITMdatconptr of d2con
  | S2ITMdatcontyp of d2con
  | S2ITMe1xp of e1xp
  | S2ITMfil of filenv
  | S2ITMvar of s2var
// end of [s2itm]

typedef s2itmlst = List s2itm
viewtypedef s2itmopt_vt = Option_vt (s2itm)

(* ****** ****** *)

abstype intinf_type
typedef intinf = intinf_type

(* ****** ****** *)

datatype
s2exp_node =
//
  | S2Eint of int // integer
  | S2Eintinf of intinf // integer of flexible precision
  | S2Echar of char // character
//
  | S2Ecst of s2cst // constant
//
  | S2Evar of s2var // variable
  | S2EVar of s2Var // existential variable
//
  | S2Etup of (s2explst) // tuple
  | S2Etylst of (s2explst) // type list
//
  | S2Edatconptr of (* unfolded datatype *)
      (d2con, s2explst) (* constructor and addrs of arguments *)
  | S2Edatcontyp of (* unfolded datatype *)
      (d2con, s2explst) (* constructor and types of arguments *)
//
  | S2Eexi of ( // exist. quantified type
      s2varlst(*vars*), s2explst(*props*), s2exp(*body*)
    ) // end of [S2Euni]
  | S2Euni of ( // universally quantified type
      s2varlst(*vars*), s2explst(*props*), s2exp(*body*)
    ) // end of [S2Euni]
//
  | S2Evararg of s2exp // variadic argument type
//
  | S2Ewth of (s2exp, wths2explst) // the result part of a fun type
// end of [s2exp_node]

and s2rtext = (* extended sort *)
  | S2TEsrt of s2rt
  | S2TEsub of (s2var, s2rt, s2explst)
  | S2TEerr of ()
// end of [s2rtext]

and wths2explst =
  | WTHS2EXPLSTnil of ()
  | WTHS2EXPLSTcons_some of (int(*refval*), s2exp, wths2explst)
  | WTHS2EXPLSTcons_none of wths2explst
// end of [wths2explst]

where
s2exp = '{
  s2exp_srt= s2rt, s2exp_node= s2exp_node
} // end of [s2exp]
and s2explst = List (s2exp)
and s2expopt = Option (s2exp)

and s2rtextopt_vt = Option_vt (s2rtext)

(* ****** ****** *)

(* end of [pats_staexp2.sats] *)
