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
gvector_t0ype (a:t@ype+, n:int, d:int) (* irregular *)
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
stadef GV = gvector_v

(* ****** ****** *)

praxi
gvector_v_nil
  {a:t0p}{l:addr}{d:int | d > 0} (): GV (a, l, 0, d)
praxi
gvector_v_cons
  {a:t0p}{l:addr}{n:int}{d:int}
  (a @ l, GV (INV(a), l+d*sizeof(a), n, d)): GV (a, l, n+1, d)
// end of [gvector_v_cons]

(* ****** ****** *)

praxi
gvector_v_unnil
  {a:t0p}{l:addr}{n:int}{d:int} (pf: GV (a, l, 0, d)): void
praxi
gvector_v_uncons
  {a:t0p}{l:addr}{n:int | n > 0}{d:int}
  (GV (INV(a), l, n, d)): (a @ l, GV (a, l+d*sizeof(a), n-1, d))
// end of [gvector_v_uncons]

(* ****** ****** *)
//
praxi
lemma_gvector_param
  {a:t0p}{n:int}{d:int}
  (v: &GV (INV(a), n, d)): [n >= 0; d >= 1] void
praxi
lemma_gvector_v_param
  {a:t0p}{l:addr}{n:int}{d:int}
  (pf: !GV (INV(a), l, n, d)): [n >= 0; d >= 1] void
//
(* ****** ****** *)

praxi
array2gvector
  {a:t0p}{l:addr}{n:int}
  (A: &array (INV(a), n) >> GV (a, n, 1)): void
// end [array2gvector]

praxi
array2gvector_v
  {a:t0p}{l:addr}{n:int}
  (pf: array_v (INV(a), l, n)):<prf> GV (a, l, n, 1)
// end [array2gvector_v]

(* ****** ****** *)

praxi
gvector2array
  {a:t0p}{l:addr}{n:int}
  (V: &GV (INV(a), n, 1) >> array (a, n)): void
// end [gvector2array]
praxi
gvector2array_v
  {a:t0p}{l:addr}{n:int}
  (pf: GV (INV(a), l, n, 1)):<prf> array_v (a, l, n)
// end [gvector2array_v]

(* ****** ****** *)

fun{}
fprint_gvector$sep (out: FILEref): void

fun{a:t0p}
fprint_gvector{n:int}{d:int}
(
  out: FILEref, V: &GV (INV(a), n, d), int n, int d
) : void // end of [fprint_gvector]

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
  (V: &GV (INV(a), n, d) >> _, n: int n, d: int d): natLte(n)
fun{
a:t0p}{env:vt0p
} gvector_foreach_env{n:int}{d:int}
(
  V: &GV (INV(a), n, d) >> _, n: int n, d: int d, env: &(env) >> _
) : natLte(n) // end of [gvector_foreach_env]
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
  V1: &GV (INV(a), n, d1) >> _
, V2: &GV (INV(b), n, d2) >> _
, n: int (n), d1: int (d1), d2: int (d2)
) : natLte(n) // end of [gvector_foreach2]
fun{
a,b:t0p}{env:vt0p
} gvector_foreach2_env
  {n:int}{d1,d2:int}
(
  V1: &GV (INV(a), n, d1) >> _
, V2: &GV (INV(b), n, d2) >> _
, n: int (n), d1: int (d1), d2: int (d2)
, env: &env >> _
) : natLte(n) // end of [gvector_foreach2_env]
//
(* ****** ****** *)

fun{a:t0p}
multo_scalar_gvector
  {n:int}{d:int}
(
  k: a
, V: &GV (INV(a), n, d) >> _
, n: int(n), d: int(d)
) : void // end of [multo_scalar_gvector]

(* ****** ****** *)

fun{a:t0p}
multo_scalar_gvector_gvector
  {n:int}{d1,d2:int}
(
  k: a
, V1: &GV (INV(a), n, d1)
, V2: &GV (a?, n, d2) >> GV (a, n, d2)
, n: int(n), d1: int(d1), d2: int(d2)
) : void // end of [multo_scalar_gvector_gvector]

(* ****** ****** *)
//
// HX: dot product
// HX: inner product
//
fun{a:t0p}
mul_gvector_gvector_scalar
  {n:int}{d1,d2:int}
(
  V1: &gvector (INV(a), n, d1)
, V2: &gvector (    a , n, d2)
, n: int(n), d1: int(d1), d2: int(d2)
) : (a) (* end of [mul_gvector_gvector_scalar] *)

(* ****** ****** *)

(* end of [gvector.sats] *)
