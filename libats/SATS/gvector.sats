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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.gvector"

(* ****** ****** *)
//
// HX-2013-07:
// generic vector:
// element type, length/size, delta
//
abst@ype
gvector_t0ype (a:t@ype, n:int, d:int) (*irregular*)
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

stadef GVT = gvector
stadef GVT = gvector_v

(* ****** ****** *)
//
praxi
lemma_gvector_param
  {a:t0p}{n:int}{d:int}
  (v: &GVT(a, n, d)): [n >= 0; d >= 1] void
praxi
lemma_gvector_v_param
  {a:t0p}{l:addr}{n:int}{d:int}
  (pf: !GVT(a, l, n, d)): [n >= 0; d >= 1] void
//
(* ****** ****** *)
//
(*
// HX-2013-07:
// Don't use [gmatrix_initize]
// unless you know what you are doing
*)
praxi
gvector_initize
  {a:t0p}{n:int}{d:int}
  (&GVT(a?, n, d) >> GVT(a, n, d)): void
praxi
gvector_uninitize
  {a:t0p}{n:int}{d:int}
  (&GVT(a, n, d) >> GVT(a?, n, d)): void
//
(* ****** ****** *)

praxi
array2gvector
  {a:t0p}{l:addr}{n:int}
  (A: &array(INV(a), n) >> GVT(a, n, 1)): void
// end [array2gvector]
praxi
array2gvector_v
  {a:t0p}{l:addr}{n:int}
  (pf: array_v(INV(a), l, n)):<prf> GVT(a, l, n, 1)
// end [array2gvector_v]

(* ****** ****** *)

praxi
gvector2array
  {a:t0p}{l:addr}{n:int}
  (V: &GVT(a, n, 1) >> array (a, n)): void
// end [gvector2array]
praxi
gvector2array_v
  {a:t0p}{l:addr}{n:int}
  (pf: GVT(a, l, n, 1)):<prf> array_v (a, l, n)
// end [gvector2array_v]

(* ****** ****** *)
//
praxi
gvector_v_renil
  {a1,a2:t0p}
  {l:addr}{n:int}{d:int} (pf: GVT(a1, l, 0, d)): GVT(a2, l, 0, d)
//
praxi
gvector_v_cons
  {a:t0p}{l:addr}{n:int}{d:int}
(
  pf1: a @ l, pf2: GVT(a, l+d*sizeof(a), n, d)
) : GVT(a, l, n+1, d) // endfun
praxi
gvector_v_uncons
  {a:t0p}{l:addr}
  {n:int | n > 0}{d:int}
  (pf: GVT(a, l, n, d)): (a @ l, GVT(a, l+d*sizeof(a), n-1, d))
//
(* ****** ****** *)

praxi
gvector_v_split
  {a:t0p}
  {l:addr}
  {n:int}{d:int}
  {i:nat | i <= n}
  (GVT(a, l, n, d)): (GVT(a, l, i, d), GVT(a, l+i*d*sizeof(a), n-i, d))
// end of [gvector_v_split]
praxi
gvector_v_unsplit
  {a:t0p}
  {l:addr}
  {n1,n2:int}{d:int}
  (GVT(a, l, n1, d), GVT(a, l+n1*d*sizeof(a), n2, d)): GVT(a, l, n1+n2, d)
// end of [gvector_v_unsplit]

(* ****** ****** *)

fun{a:t0p}
gvector_get_at
  {n:int}{d:int}
(
  V: &GVT(a, n, d), d: int d, i: natLt(n)
) : a // end of [gvector_get_at]
fun{a:t0p}
gvector_set_at
  {n:int}{d:int}
(
  V: &GVT(a, n, d), d: int d, i: natLt(n), x: a
) : void // end of [gvector_set_at]

fun{a:t0p}
gvector_getref_at
  {n:int}{d:int}
  (V: &GVT(a, n, d), d: int d, i: natLt(n)): cPtr1(a)
// end of [gvector_getref_at]

(* ****** ****** *)

fun{}
fprint_gvector$sep (out: FILEref): void

fun{a:t0p}
fprint_gvector{n:int}{d:int}
(
  out: FILEref, V: &GVT(a, n, d), int n, int d
) : void // end of [fprint_gvector]

(* ****** ****** *)

fun{a:t0p}
gvector_copyto
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1)
, V2: &GVT(a?, n, d2) >> GVT(a, n, d2), int(n), int(d1), int(d2)
) : void // end of [gvector_copyto]

fun{a:t0p}
gvector_exchange
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1), V2: &GVT(a, n, d2), int(n), int(d1), int(d2)
) : void // end of [gvector_exchange]

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
  (V: &GVT(a, n, d) >> _, n: int n, d: int d): natLte(n)
fun{
a:t0p}{env:vt0p
} gvector_foreach_env{n:int}{d:int}
(
  V: &GVT(a, n, d) >> _, n: int n, d: int d, env: &(env) >> _
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
  V1: &GVT(a, n, d1) >> _
, V2: &GVT(b, n, d2) >> _
, n: int (n), d1: int (d1), d2: int (d2)
) : natLte(n) // end of [gvector_foreach2]
fun{
a,b:t0p}{env:vt0p
} gvector_foreach2_env
  {n:int}{d1,d2:int}
(
  V1: &GVT(a, n, d1) >> _
, V2: &GVT(b, n, d2) >> _
, n: int (n), d1: int (d1), d2: int (d2)
, env: &env >> _
) : natLte(n) // end of [gvector_foreach2_env]
//
(* ****** ****** *)

(* end of [gvector.sats] *)
