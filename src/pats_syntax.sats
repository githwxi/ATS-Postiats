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
// Start Time: March, 2011
//
(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location
staload LEX = "pats_lexing.sats"
typedef token = $LEX.token
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload FX = "pats_fixity.sats"
typedef assoc = $FX.assoc

(* ****** ****** *)
//
abstype synent // a boxed union
//
castfn synent_encode {a:type} (x: a): synent
castfn synent_decode {a:type} (x: synent): a
//
fun synent_null {a:type} (): a // = null
fun synent_is_null {a:type} (x: a):<> bool
fun synent_isnot_null {a:type} (x: a):<> bool
//
(* ****** ****** *)

datatype
dcstkind =
  | DCKfun of ()
  | DCKval of ()
  | DCKpraxi of ()
  | DCKprfun of ()
  | DCKprval of ()
  | DCKcastfn of ()
// end of [dcstkind]

fun dcstkind_is_fun (dck: dcstkind):<> bool
fun dcstkind_is_val (dck: dcstkind):<> bool
fun dcstkind_is_praxi (dck: dcstkind):<> bool
fun dcstkind_is_prfun (dck: dcstkind):<> bool
fun dcstkind_is_prval (dck: dcstkind):<> bool
fun dcstkind_is_proof (dck: dcstkind):<> bool
fun dcstkind_is_castfn (dck: dcstkind):<> bool

fun fprint_dcstkind
  (out: FILEref, x: dcstkind): void
overload fprint with fprint_dcstkind

fun print_dcstkind (x: dcstkind): void
overload print with print_dcstkind

(* ****** ****** *)

typedef i0nt = '{
  i0nt_loc= location
, i0nt_bas= int
, i0nt_rep= string
, i0nt_sfx= uint
} // end of [i0nt]

fun fprint_i0nt (out: FILEref, x: i0nt): void

(* ****** ****** *)

typedef i0de = '{
  i0de_loc= location, i0de_sym= symbol
} // end of [i0de]

typedef i0delst = List (i0de)

fun fprint_i0de (out: FILEref, x: i0de): void

(* ****** ****** *)

datatype p0rec =
  | P0RECint of int
  | P0RECi0de of i0de
  | P0RECi0de_adj of (i0de, token, i0nt)
  | P0RECi0nt of i0nt
// end of [p0rec]

fun p0rec_emp (): p0rec
fun p0rec_i0nt (int: i0nt): p0rec
fun p0rec_i0de (ide: i0de): p0rec
fun p0rec_i0de_adj (ide: i0de, tok: token, int: i0nt): p0rec

(* ****** ****** *)

datatype f0xty =
  | F0XTYinf of (p0rec, assoc) // infix
  | F0XTYpre of p0rec // prefix
  | F0XTYpos of p0rec // postfix
// end of [f0xty]

fun fprint_f0xty (out: FILEref, x: f0xty): void

(* ****** ****** *)

datatype e0xpactkind =
  | E0XPACTassert | E0XPACTerror | E0XPACTprint
// end of [e0xpactkind]

fun fprint_e0xpactkind (out: FILEref, x: e0xpactkind): void

(* ****** ****** *)

datatype
e0xp_node =
  | E0XPapp of (e0xp, e0xp)
  | E0XPchar of char
  | E0XPeval of e0xp
  | E0XPfloat of string
  | E0XPide of symbol
  | E0XPint of i0nt // [i0nt] is processed later
  | E0XPlist of e0xplst
  | E0XPstring of (string, int(*length*))
// end of [e0xp_node]

where
e0xp = '{
  e0xp_loc= location, e0xp_node= e0xp_node
} // end of [e0xp]

and e0xplst = List (e0xp)
and e0xpopt = Option (e0xp)

fun e0xp_app (_1: e0xp, _2: e0xp): e0xp
fun e0xp_char (_: token): e0xp
fun e0xp_eval (_1: token, _2: e0xp, _3: token): e0xp
fun e0xp_float (_: token): e0xp
fun e0xp_i0de (_: i0de): e0xp
fun e0xp_i0nt (_: i0nt): e0xp
fun e0xp_list (_1: token, _2: e0xplst, _3: token): e0xp
fun e0xp_string (_: token): e0xp

fun fprint_e0xp (out: FILEref, x: e0xp): void

(* ****** ****** *)

datatype
s0exp_node =
  | S0Eint of int
// end of [s0exp_node]

where
s0exp = '{
  s0exp_loc= location, s0exp_node= s0exp_node
} // end of [s0exp]

and s0explst = List (s0exp)
and s0expopt = Option (s0exp)

(* ****** ****** *)

datatype
d0ecl_node =
  | D0Cfixity of (f0xty, i0delst)
  | D0Cnonfix of (i0delst) // absolving fixity status
  | D0Csymintr of (i0delst) // introducing overloading symbols
  | D0Ce0xpdef of (symbol, e0xpopt)
  | D0Ce0xpact of (e0xpactkind, e0xp)
// end of [d0ecl_node]

where
d0ecl = '{
  d0ecl_loc= location, d0ecl_node= d0ecl_node
} // end of [d0ecl]

and d0eclist = List (d0ecl)

fun d0ecl_fixity
  (_1: token, _2: p0rec, _3: i0delst): d0ecl
// end of [d0ecl_fixity]

fun d0ecl_nonfix (_1: token, _2: i0delst): d0ecl
fun d0ecl_symintr (_1: token, _2: i0delst): d0ecl

fun d0ecl_e0xpdef (_1: token, _2: i0de, _3: e0xpopt): d0ecl

fun d0ecl_e0xpact_assert (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_error (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_print (_1: token, _2: e0xp): d0ecl

(* ****** ****** *)

fun fprint_d0ecl (out: FILEref, x: d0ecl): void
fun fprint_d0eclist (out: FILEref, xs: d0eclist): void

(* ****** ****** *)

(* end of [pats_syntax.sats] *)
