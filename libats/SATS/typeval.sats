(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmmhwxiATgmailDOTcom
// Start Time: March, 2015
//
(* ****** ****** *)

abstype Z() and S(type)

(* ****** ****** *)
//
#define fS(n)
  if n > 0 then S(fS(n-1)) else Z()
//
(* ****** ****** *)
//
dataprop
tieq(type, int) =
  | TIEQZ (Z(), 0)
  | {t:type}{n:nat}
    TIEQS(S(t), n+1) of tieq(t, n)
//
(* ****** ****** *)
//
fun
{t:type}
tieq2int
  {n:int}
  (pf: tieq(t, n) | (*void*)): int(n)
//
(* ****** ****** *)
//
fun
{a:vt0p}
{t:type}
sarray_foreach
  {n:int}
(
  pf: tieq(t, n)| A0: &array(a, n), env: ptr
) : void // end-of-fun
//
fun
{a:vt0p}
sarray_foreach$fwork(x: &a >> _, env: ptr): void
//
(* ****** ****** *)
//
fun
{a:vt0p}
{t:type}
sarray_foreach2
  {n:int}
(
  pf: tieq(t, n)
| A0: &array(a, n), A1: &array(a, n), env: ptr
) : void // end-of-fun
//
fun
{a:vt0p}
sarray_foreach2$fwork(x0: &a >> _, x1: &a >> _, env: ptr): void
//
(* ****** ****** *)

(* end of [typeval.sats] *)
