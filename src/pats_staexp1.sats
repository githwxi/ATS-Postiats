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

staload
LOC = "pats_location.sats"
typedef location = $LOC.location

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

datatype e1xp_node =
  | E1XPapp of (e1xp, location(*arg*), e1xplst)
  | E1XPchar of char
  | E1XPfloat of string
  | E1XPide of symbol
  | E1XPint of string
  | E1XPlist of e1xplst
  | E1XPnone of ()
  | E1XPstring of (string, int(*length*))
  | E1XPundef of () // a special value for marking undefinition
// end of [e1xp_node]

where e1xp: type = '{
  e1xp_loc= location, e1xp_node= e1xp_node
}
and e1xplst: type = List e1xp

fun fprint_e1xp
  (out: FILEref, _: e1xp): void
overload fprint with fprint_e1xp

fun fprint_e1xplst
  (out: FILEref, _: e1xplst): void
overload fprint with fprint_e1xplst

fun print_e1xp (_: e1xp): void
fun prerr_e1xp (_: e1xp): void
overload print with print_e1xp
overload prerr with prerr_e1xp

fun print_e1xplst (_: e1xplst): void
fun prerr_e1xplst (_: e1xplst): void
overload print with print_e1xplst
overload prerr with prerr_e1xplst

(* ****** ****** *)

(* end of [pats_staexp1.sats] *)
