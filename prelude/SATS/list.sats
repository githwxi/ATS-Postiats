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
x:t@ype // type for elements
} list_copy {n:int} (xs: list (x, n)):<> list_vt (x, n)

(* ****** ****** *)

fun{x:t@ype}
list_reverse {n:int} (xs: list (x, n)): list_vt (x, n)

fun{a:t@ype}
list_append1_vt {i,j:int}
  (xs: list_vt (a, i), ys: list (a, j)):<> list (a, i+j)
// end of [list_append1_vt]

fun{a:t@ype}
list_append2_vt {i,j:int}
  (xs: list (a, i), ys: list_vt (a, j)):<> list_vt (a, i+j)
// end of [list_append2_vt]

(* ****** ****** *)

fun{
x:t@ype // type for elements
} list_foreach_funenv
  {v:view}{env:viewtype}{fe:eff} (
  pfv: !v | xs: List (x), f: (!v | x, !env) -<fun,fe> void, env: !env
) :<fe> void // end of [list_foreach_funenv]

fun{
x:t@ype // type for elements
} list_iforeach_funenv
  {v:view}{env:viewtype}{n:nat}{fe:eff} (
  pfv: !v | xs: list (x, n), f: (!v | natLt(n), x, !env) -<fun,fe> void, env: !env
) :<fe> void // end of [list_iforeach_funenv]

(* ****** ****** *)

fun{
x:t@ype}{y:t@ype
} list_map_funenv
  {v:view}{vt:viewtype}{n:int}{fe:eff} (
  pfv: !v | xs: list (x, n), f: (!v | x, !vt) -<fun,fe> y, env: !vt
) : list_vt (y, n) // end of [list_map_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [list.sats] *)
