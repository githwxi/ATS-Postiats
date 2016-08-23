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
// Start Time: January, 2013
//
(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

abstype d2cstref_type = ptr
typedef d2cstref = d2cstref_type

(* ****** ****** *)

fun d2cstref_make (name: string): d2cstref

(* ****** ****** *)

fun d2cstref_get_cst (r: d2cstref): d2cst
fun d2cstref_equ_cst (r: d2cstref, d2c: d2cst): bool

(* ****** ****** *)

val the_sizeof_vt0ype_size : d2cstref

(* ****** ****** *)

fun d2cst_is_sizeof (d2c: d2cst): bool // sizeof-template

(* ****** ****** *)

fun dyncst2_initialize ((*void*)): void

(* ****** ****** *)

(* end of [pats_stacst2.sats] *)
