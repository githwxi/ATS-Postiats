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
// Start Time: April, 2011
//
(* ****** ****** *)

datatype
comarg = COMARGkey of (int, string)

vtypedef
comarglst(n:int) = list_vt(comarg, n)

(* ****** ****** *)
//
fun
comarg_parse(s: string):<> comarg
//
fun
comarglst_parse
  {n:nat}
(
  argc: int(n)
, argv: &(@[string][n])
) :<> list_vt(comarg, n) // endfun
//
(* ****** ****** *)
//
fun
comarg_warning(str: string): void
//
(* ****** ****** *)

fun is_DATS_flag(s: string): bool
fun is_IATS_flag(s: string): bool

(* ****** ****** *)

fun DATS_extract(s: string): Stropt
fun IATS_extract(s: string): Stropt

(* ****** ****** *)
//
// HX:
// For processing command-line
// flag: -DATSXYZ=def or -DATS XYZ=def
//
fun
process_DATS_def(def: string): void
//
// HX:
// For processing command-line
// inclusion path: -IATSpath or -IATS path
//
fun
process_IATS_dir(dir: string): void
//
(* ****** ****** *)
//
fun
process_ATSPKGRELOCROOT((*void*)): void
//
(* ****** ****** *)

(* end of [pats_comarg.sats] *)
