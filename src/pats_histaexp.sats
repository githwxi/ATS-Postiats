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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: July, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

datatype
hitype =
  | HITYPE of (int(*0/1:non/ptr*), string)
// end of [hitype]

fun print_hitype (hse: hitype): void
overload print with print_hitype
fun prerr_hitype (hse: hitype): void
overload prerr with prerr_hitype
fun fprint_hitype : fprint_type (hitype)

(* ****** ****** *)

datatype
hisexp_node =
  | HSEextype of (string(*name*), hisexplstlst)
// end of [hisexp_node]

where hisexp = '{
  hisexp_name= hitype, hisexp_node= hisexp_node
} // end of [hisexp]

and hisexplst = List (hisexp)
and hisexpopt = Option (hisexp)
and hisexplstlst = List (hisexplst)

(* ****** ****** *)

fun print_hisexp (hse: hisexp): void
overload print with print_hisexp
fun prerr_hisexp (hse: hisexp): void
overload prerr with prerr_hisexp
fun fprint_hisexp : fprint_type (hisexp)

fun fprint_hisexplst : fprint_type (hisexplst)

(* ****** ****** *)

(* end of [pats_histaexp.sats] *)
