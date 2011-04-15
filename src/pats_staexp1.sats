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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_syntax.sats"

(* ****** ****** *)

typedef fprint_type (a:t@ype) = (FILEref, a) -> void

(* ****** ****** *)

datatype e1xp_node =
  | E1XPapp of (e1xp, location(*arg*), e1xplst)
  | E1XPchar of char
  | E1XPfloat of string
  | E1XPide of symbol
  | E1XPint of string
  | E1XPlist of e1xplst
  | E1XPnone of ()
  | E1XPstring of (string)
  | E1XPundef of () // a special value for marking un-definition
// end of [e1xp_node]

where e1xp: type = '{
  e1xp_loc= location, e1xp_node= e1xp_node
}
and e1xplst: type = List e1xp

fun fprint_e1xp : fprint_type (e1xp)
overload fprint with fprint_e1xp
fun print_e1xp (_: e1xp): void
fun prerr_e1xp (_: e1xp): void
overload print with print_e1xp
overload prerr with prerr_e1xp

fun fprint_e1xplst : fprint_type (e1xplst)
overload fprint with fprint_e1xplst
fun print_e1xplst (_: e1xplst): void
fun prerr_e1xplst (_: e1xplst): void
overload print with print_e1xplst
overload prerr with prerr_e1xplst

(* ****** ****** *)

fun e1xp_app (
  loc: location
, _fun: e1xp, loc_arg: location, _arg: e1xplst
) : e1xp // end of [e1xp_app]
//
fun e1xp_char (loc: location, _: char): e1xp
fun e1xp_float (loc: location, flt: string): e1xp
fun e1xp_ide (loc: location, sym: symbol): e1xp
fun e1xp_int (loc: location, int: string): e1xp
fun e1xp_list (loc: location, es: e1xplst): e1xp
fun e1xp_none (loc: location): e1xp
fun e1xp_string (loc: location, str: string): e1xp
fun e1xp_undef (loc: location): e1xp
//
fun e1xp_true (loc: location): e1xp
and e1xp_false (loc: location): e1xp

(* ****** ****** *)

datatype v1al =
  | V1ALchar of char
  | V1ALfloat of double
  | V1ALint of int
  | V1ALstring of string
// end of [v1al]

val v1al_true : v1al and v1al_false : v1al

(* ****** ****** *)

datatype
s1rt_node =
  | S1RTapp of (s1rt, s1rtlst)
  | S1RTlist of s1rtlst
  | S1RTqid of (s0rtq, symbol)
  | S1RTtype of int(*polarity*)
// end of [s1rt_node]

where s1rt: type = '{
  s1rt_loc= location, s1rt_node= s1rt_node
}

and s1rtlst: type = List s1rt
and s1rtopt: type = Option s1rt
and s1rtlstlst: type = List s1rtlst
and s1rtlstopt: type = Option s1rtlst

typedef s1rtpol = '{
  s1rtpol_loc= location, s1rtpol_srt= s1rt, s1rtpol_pol= int
} // end of [s1rtpol]

(* ****** ****** *)

fun fprint_s1rt : fprint_type (s1rt)
overload fprint with fprint_s1rt
fun print_s1rt (_: s1rt): void
fun prerr_s1rt (_: s1rt): void
overload print with print_s1rt
overload prerr with prerr_s1rt

fun fprint_s1rtlst : fprint_type (s1rtlst)
overload fprint with fprint_s1rtlst
fun print_s1rtlst (_: s1rtlst): void
fun prerr_s1rtlst (_: s1rtlst): void
overload print with print_s1rtlst
overload prerr with prerr_s1rtlst

fun fprint_s1rtopt : fprint_type (s1rtopt)

fun fprint_s1rtlstlst : fprint_type (s1rtlstlst)

(* ****** ****** *)

(*
** HX: functions for constructing sorts
*)

fun s1rt_arrow (loc: location): s1rt

//
// HX: '->' is a special sort constructor
//
fun s1rt_is_arrow (s1t: s1rt): bool

fun s1rt_app (
  loc: location, _fun: s1rt, _arg: s1rtlst
) : s1rt // end of [s1rt_app]

fun s1rt_fun (
  loc: location, arg: s1rt, res: s1rt
) : s1rt // end of [s1rt_fun]

fun s1rt_ide (loc: location, sym: symbol): s1rt
fun s1rt_list (loc: location, s1ts: s1rtlst): s1rt
fun s1rt_qid (loc: location, q: s0rtq, id: symbol): s1rt
(*
fun s1rt_tup (loc: location, s1ts: s1rtlst): s1rt
*)
fun s1rt_type (loc: location, knd: int): s1rt

(* ****** ****** *)

fun s1rtpol_make (loc: location, s1t: s1rt, pol: int): s1rtpol

(* ****** ****** *)

typedef
d1atsrtcon = '{
  d1atsrtcon_loc= location
, d1atsrtcon_sym= symbol
, d1atsrtcon_arg= s1rtlst
} // end of [d1atsrtcon]

typedef d1atsrtconlst = List d1atsrtcon

fun d1atsrtcon_make (
  loc: location, name: symbol, arg: s1rtlst
) : d1atsrtcon // end of [d1atsrtcon_make]

fun fprint_d1atsrtcon : fprint_type (d1atsrtcon)

(* ****** ****** *)

typedef
d1atsrtdec = '{
  d1atsrtdec_loc= location
, d1atsrtdec_sym= symbol
, d1atsrtdec_con= d1atsrtconlst
} // end of [d1atsrtdec]

typedef d1atsrtdeclst = List d1atsrtdec

fun d1atsrtdec_make (
  loc: location, name: symbol, conlst: d1atsrtconlst
) : d1atsrtdec // end of [d1atsrtdec]

fun fprint_d1atsrtdec : fprint_type (d1atsrtdec)

(* ****** ****** *)

datatype s1exp_node =
  | S1Eapp of (
      s1exp, location(*arg*), s1explst
    ) // static application
//
  | S1Eint of i0nt // integer constant
  | S1Echar of c0har // character constant
//
  | S1Esqid of (s0taq, symbol) // qualified static identifer
  | S1Elist of (int(*npf*), s1explst)
  | S1Eann of (s1exp, s1rt) // static expression with annotate sort
// end of [s1exp_node]

and s1rtext_node =
  | S1TEsrt of s1rt
  | S1TEsub of (symbol, s1rtext, s1explst)
(*
  | S1TElam of (s1arglst, s1rtext)
  | S1TEapp of (s1rtext, s1explst)
*)
// end of [s1rtext_node]

and s1qua_node =
  | S1Qprop of s1exp | S1Qvars of (i0delst, s1rtext)
// end of [s1qua_node]

where
s1exp = '{
  s1exp_loc= location, s1exp_node= s1exp_node
}
and s1explst = List (s1exp)
and s1expopt = Option (s1exp)
and s1explstlst = List (s1explst)

and s1rtext = '{
  s1rtext_loc= location, s1rtext_node= s1rtext_node
}

and s1qua = '{
  s1qua_loc= location, s1qua_node= s1qua_node
}
and s1qualst = List (s1qua)
and s1qualstlst = List (s1qualst)

(* ****** ****** *)

fun s1exp_app (
  loc: location, _fun: s1exp, loc_arg: location, _arg: s1explst
) : s1exp // end of [s1exp_app]

fun s1exp_int (loc: location, int: i0nt): s1exp
fun s1exp_char (loc: location, char: c0har): s1exp

fun s1exp_ide (loc: location, id: symbol): s1exp
fun s1exp_sqid (loc: location, sq: s0taq, id: symbol): s1exp

fun s1exp_list (loc: location, xs: s1explst): s1exp
fun s1exp_list2 (loc: location, xs1: s1explst, xs2: s1explst): s1exp

fun s1exp_ann (loc: location, s1e: s1exp, s1t: s1rt): s1exp

fun fprint_s1exp : fprint_type (s1exp)
fun fprint_s1explst : fprint_type (s1explst)

(* ****** ****** *)

fun s1rtext_srt (loc: location, s1t: s1rt): s1rtext
fun s1rtext_sub (
  loc: location, sym: symbol, s1te: s1rtext, s1ps: s1explst
) : s1rtext // end of [s1rtext_sub]

fun fprint_s1rtext : fprint_type (s1rtext)

(* ****** ****** *)

fun s1qua_prop (loc: location, s1p: s1exp): s1qua
fun s1qua_vars (loc: location, ids: i0delst, s1te: s1rtext): s1qua

fun fprint_s1qua : fprint_type (s1qua)

(* ****** ****** *)

typedef
s1rtdef = '{
  s1rtdef_loc= location
, s1rtdef_sym= symbol
, s1rtdef_def= s1rtext
} // end of [s1rtdef]

typedef s1rtdeflst = List s1rtdef

fun s1rtdef_make (loc: location, sym: symbol, s0te: s1rtext): s1rtdef

fun fprint_s1rtdef : fprint_type (s1rtdef)

(* ****** ****** *)

typedef
s1tacst = '{ // static constant declaration
  s1tacst_loc= location
, s1tacst_sym= symbol
, s1tacst_arg= s1rtlstlst
, s1tacst_res= s1rt
} // end of [s1tacst]

typedef s1tacstlst = List s1tacst

fun s1tacst_make (
  loc: location, sym: symbol, arg: s1rtlstlst, res: s1rt
) : s1tacst // end of [s1tacst_make]

fun fprint_s1tacst : fprint_type (s1tacst)

(* ****** ****** *)

(* end of [pats_staexp1.sats] *)
