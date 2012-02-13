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
#print "Loading [array_prf.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

prfun
array_v_split
  {a:viewt@ype}
  {l:addr}
  {n:int} {i:nat | i <= n}
  {ofs:int} (
  pfmul: MUL (i, sizeof a, ofs), pfarr: array_v (INV(a), l, n)
) :<prf> @(
  array_v (a, l, i), array_v (a, l+ofs, n-i)
) // end of [array_v_split]

prfun
array_v_unsplit
  {a:viewt@ype}
  {l:addr}
  {n1,n2:int}
  {ofs:int} (
  pfmul: MUL (n1, sizeof a, ofs)
, pf1arr: array_v (INV(a), l, n1), pf2arr: array_v (a, l+ofs, n2)
) :<prf> array_v (a, l, n1+n2) // end of [array_v_unsplit]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array_prf.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [array_prf.sats] *)
