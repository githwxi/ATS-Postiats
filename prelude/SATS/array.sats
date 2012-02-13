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
#print "Loading [array.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(*
//
// HX: [array_v] can also be defined as follows:
//
dataview
array_v (
  a:viewt@ype+, addr, int
) =
  | {n:int | n >= 0} {l:addr}
    array_v_cons (a, l, n+1) of (a @ l, array_v (a, l+sizeof a, n))
  | {l:addr} array_v_nil (a, l, 0)
// end of [array_v]
*)
viewdef
array_v (a:viewt@ype, l:addr, n:int) = @[a][n] @ l

(* ****** ****** *)

praxi array_v_nil :
  {a:viewt@ype} {l:addr} () -<prf> array_v (a, l, 0)
praxi array_v_unnil :
  {a:viewt@ype} {l:addr} array_v (a, l, 0) -<prf> void

praxi array_v_cons :
  {a:viewt@ype} {l:addr} {n:nat}
  (a @ l, array_v (INV(a), l+sizeof(a), n)) -<prf> array_v (a, l, n+1)
praxi array_v_uncons :
  {a:viewt@ype} {l:addr} {n:int | n > 0}
  array_v (INV(a), l, n) -<prf> (a @ l, array_v (a, l+sizeof(a), n-1))

(* ****** ****** *)

prfun array_v_sing
  {a:viewt@ype} {l:addr} (pf: INV(a) @ l): array_v (a, l, 1)
prfun array_v_unsing
  {a:viewt@ype} {l:addr} (pf: array_v (INV(a), l, 1)): a @ l

(* ****** ****** *)

dataview
arrayopt_v (
  a:viewt@ype+, addr, int, bool
) =
  | {n:nat} {l:addr}
    arrayopt_v_some (a, l, n, true) of array_v (a, l, n)
  | {n:nat} {l:addr}
    arrayopt_v_none (a, l, n, false) of array_v (a?, l, n)
// end of [arrayopt_v]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [array.sats] *)
