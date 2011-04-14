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

datatype
d1atarg_node =
  | D1ATARGsrt of s1rtpol
  | D1ATARGidsrt of (symbol, s1rtpol)
// end of [d1atarg_node]

typedef d1atarg = '{
  d1atarg_loc= location, d1atarg_node= d1atarg_node
} // end of [d1atarg]

typedef d1atarglst = List d1atarg
typedef d1atarglstopt = Option d1atarglst

fun d1atarg_srt
  (loc: location, s1tp: s1rtpol): d1atarg
fun d1atarg_idsrt
  (loc: location, sym: symbol, s1tp: s1rtpol): d1atarg
// end of [d1atarg_idsrt]

(* ****** ****** *)

(* end of [pats_staexp1.sats] *)
