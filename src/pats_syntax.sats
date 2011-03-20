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
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

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

typedef i0de = '{
  i0de_loc= location, i0de_sym= symbol
} // end of [i0de]

fun fprint_i0de (out: FILEref, x: i0de): void

(* ****** ****** *)

datatype
e0xp_node =
//
  | E0XPnone of ()
//
  | E0XPapp of (e0xp, e0xp)
  | E0XPchar of char
  | E0XPeval of e0xp
  | E0XPfloat of string
(*
  | E0XPide of sym_t
*)
  | E0XPint of string
  | E0XPlist of e0xplst
  | E0XPstring of (string, int(*length*))
// end of [e0xp_node]

where
e0xp = '{
  e0xp_loc= location, e0xp_node= e0xp_node
} // end of [e0xp]

and e0xplst = List (e0xp)

fun e0xp_none (loc: location): e0xp
fun e0xp_char (loc: location, c: char): e0xp
fun e0xp_list (loc: location, es: e0xplst): e0xp
fun e0xp_string (loc: location, s: string): e0xp

(* ****** ****** *)

datatype
s0exp_node =
//
  | S0Enone of ()
//
  | S0Eint of int
// end of [s0exp_node]

where
s0exp = '{
  s0exp_loc= location, s0exp_node= s0exp_node
} // end of [s0exp]

and s0explst = List (s0exp)
and s0expopt = Option (s0exp)

(* ****** ****** *)

datatype synent =
  | SYNnone of ()
  | SYNi0de of i0de
  | SYNe0xp of e0xp
  | SYNs0exp of s0exp
// end of [synent]

viewtypedef synentlst_vt = List_vt (synent)

(* ****** ****** *)

fun fprint_synent
  (out: FILEref, ent: synent): void
overload fprint with fprint_synent
fun print_synent (ent: synent): void
overload print with print_synent

(* ****** ****** *)

(* end of [pats_syntax.sats] *)
