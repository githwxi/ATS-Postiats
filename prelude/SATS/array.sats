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
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) *)

(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

viewdef
array_v (a:viewt@ype, n:int, l:addr) = @[a][n] @ l

(* ****** ****** *)

fun{a:t@ype}
array_ptr_get_at
  {n:int} (
  A: &(@[IN(a)][n]), i: sizeLt (n)
) :<> a = "mac#atspre_array_ptr_get_at"

fun{a:t@ype}
array_ptr_set_at
  {n:int} (
  A: &(@[IN(a)][n]), i: sizeLt (n), x: a
) :<> void = "mac#atspre_array_ptr_set_at"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* end of [array.sats] *)
