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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)
//
// HX-2013-07:
// generic vector:
// element type, length/size, delta
//
abst@ype
gvector_t0ype (a:t@ype+, n:int, d:int)
//
typedef
gvector (a:t0p, n:int, d:int) = gvector_t0ype (a, n, d)
//
(* ****** ****** *)
//
viewdef
gvector_v
  (a:t0p, l:addr, n:int, d:int) = gvector (a, n, d) @ l
//
(* ****** ****** *)

stadef GV = gvector
stadef GV_v = gvector_v

(* ****** ****** *)
//
praxi
lemma_gvector_param
  {a:t0p}{n:int}{d:int}
  (v: &GV (a, n, d)): [n >= 0; d >= 1] void
praxi
lemma_gvector_v_param
  {a:t0p}{l:addr}{n:int}{d:int}
  (pf: !GV_v (a, l, n, d)): [n >= 0; d >= 1] void
//
(* ****** ****** *)

prfun
gvector2array_v
  {a:t0p}{l:addr}{n:int}
  (pf: GV_v (a, l, n, 1)):<prf> array_v (a, l, n)
// end [gvector2array_v]

prfun
array2gvector_v
  {a:t0p}{l:addr}{n:int}
  (pf: array_v (a, l, n)):<prf> GV_v (a, l, n, 1)
// end [gvector2array_v]

(* ****** ****** *)
//
fun{
a:t0p}{env:vt0p
} gvector_foreach$cont
  {n:int}{d:int} (x: &a, env: &env): bool
fun{
a:t0p}{env:vt0p
} gvector_foreach$fwork
  {n:int}{d:int} (x: &a >> _, env: &env >> _): void
//
fun{a:t0p}
gvector_foreach{n:int}{d:int}
  (vec: &GV (a, n, d) >> _, n: int n, d: int d): natLte(n)
fun{
a:t0p}{env:vt0p
} gvector_foreach_env{n:int}{d:int}
  (vec: &GV (a, n, d) >> _, n: int n, d: int d, env: &(env) >> _): natLte(n)
//
(* ****** ****** *)
//
fun{
a,b:t0p}{env:vt0p
} gvector_foreach2$cont
  {n:int}{d:int} (x: &a, y: &b, env: &env): bool
fun{
a,b:t0p}{env:vt0p
} gvector_foreach2$fwork
  {n:int}{d:int} (x: &a >> _, y: &b >> _, env: &env >> _): void
//
fun{a,b:t0p}
gvector_foreach2
  {n:int}{d1,d2:int}
(
  vec1: &GV (a, n, d1) >> _
, vec2: &GV (b, n, d2) >> _
, n: int (n), d1: int (d1), d2: int (d2)
) : natLte(n) // end of [gvector_foreach2]
fun{
a,b:t0p}{env:vt0p
} gvector_foreach2_env
  {n:int}{d1,d2:int}
(
  vec1: &GV (a, n, d1) >> _
, vec2: &GV (b, n, d2) >> _
, n: int (n), d1: int (d1), d2: int (d2)
, env: &env >> _
) : natLte(n) // end of [gvector_foreach2_env]
//
(* ****** ****** *)

fun{a:t0p}
multo_scalar_gvector
  {n:int}{d:int}
(
  alpha: a, vec: &GV (a, n, d) >> _, n: int(n), d: int(d)
) : void // end of [multo_scalar_gvector]

fun{a:t0p}
multo_scalar_gvector_gvector
  {n:int}{d,d2:int}
(
  alpha: a
, vec: &GV (a, n, d), vec2: &GV (a?, n, d2) >> GV (a, n, d2)
, n: int n, d: int d
) : void // end of [multo_scalar_gvector_gvector]

(* ****** ****** *)
//
// HX: dot product
// HX: inner product
//
fun{a:t0p}
mul_gvector_gvector
  {n:int}{d1,d2:int}
(
  vec1: &gvector (a, n, d1)
, vec2: &gvector (a, n, d2)
, n: int(n), d1: int(d1), d2: int(d2)
) : (a) (* end of [mul_gvector_gvector] *)

(* ****** ****** *)

(* end of [gvector.sats] *)