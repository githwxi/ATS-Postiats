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
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [arith_prf.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

dataprop
MUL (int, int, int) =
  | {n:int}
    MULbas (0, n, 0)
  | {m:nat}{n:int}{p:int}
    MULind (m+1, n, p+n) of MUL (m, n, p)
  | {m:pos}{n:int}{p:int}
    MULneg (~m, n, ~p) of MUL (m, n, p)
// end of [MUL]

(* ****** ****** *)

praxi mul_make : {m,n:int} () -<prf> MUL (m, n, m*n)
praxi mul_elim : {m,n:int} {p:int} MUL (m, n, p) -<prf> [p == m*n] void

(* ****** ****** *)
//
// HX: (m+i)*n = m*n+i*n
//
praxi mul_add_const {i:int}
  {m,n:int} {p:int} (pf: MUL (m, n, p)):<prf> MUL (m+i, n, p+i*n)
// end of [mul_add_const]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [arith_prf.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [arith_prf.sats] *)
