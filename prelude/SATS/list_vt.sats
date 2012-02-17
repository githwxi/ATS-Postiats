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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

fun{
a:viewt@ype
} list_vt_append
  {n1,n2:nat} (
  xs1: list_vt (a, n1), xs2: list_vt (a, n2)
) : list_vt (a, n1+n2) // end of [list_vt_append]

(* ****** ****** *)

fun{
x:viewt@ype
} list_vt_reverse
  {n:nat} (xs: list_vt (x, n)): list_vt (x, n)
// end of [list_vt_reverse]

fun{a:viewt@ype}
list_vt_reverse_append {m,n:nat}
  (xs: list_vt (a, m), ys: list_vt (a, n)): list_vt (a, m+n)
// end of [list_vt_reverse_append]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [list_vt.sats] *)
