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
//
#define
ATS_PACKNAME
"ATSLIB.libats.funarray"
//
(* ****** ****** *)
//
abstype
funarray_t0ype_int_type
  (a:t@ype+, n:int) = ptr(*boxed*)
//
typedef
funarray
(
  a:t0p, n:int
) = funarray_t0ype_int_type(a, n)
//
typedef
funarray(a:t0p) = [n:int] funarray(a, n)
//
(* ****** ****** *)
//
praxi
lemma_funarray_param
  {a:t0p}{n:int}
  (A: funarray(a, n)): [n >= 0] void
//
(* ****** ****** *)
//
fun{}
funarray_is_nil
  {a:t0p}{n:int}
  (funarray(a, n)):<> bool(n==0)
fun{}
funarray_isnot_nil
  {a:t0p}{n:int}
  (funarray(a, n)):<> bool(n > 0)
//
(* ****** ****** *)
//
fun{}
funarray_nil
  {a:t0p}((*void*)):<> funarray(a, 0)
fun{}
funarray_make_nil
  {a:t0p}((*void*)):<> funarray(a, 0)
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_size
{n:int}(A: funarray(INV(a), n)):<> int(n)
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_get_at{n:int}
  (A: funarray(INV(a), n), i: natLt(n)):<> (a)
//
fun
{a:t0p}
funarray_set_at{n:int}
  (A: &funarray(INV(a), n) >> _, i: natLt(n), x: a): void
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_insert_l{n:int}
(
  A: &funarray(INV(a), n) >> funarray(a, n+1), x: a
) : void // end-of-function
fun
{a:t0p}
funarray_insert_r{n:int}
(
  A: &funarray(INV(a), n) >> funarray(a, n+1), n: int(n), x: a
) : void // end-of-function
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_remove_l{n:pos}
(
  A: &funarray(INV(a), n) >> funarray(a, n-1)
) : (a) // end of [funarray_remove_l]
//
fun
{a:t0p}
funarray_remove_r{n:pos}
(
  A: &funarray(INV(a), n) >> funarray(a, n-1), n: int(n)
) : (a) // end of [funarray_remove_r]
//
(* ****** ****** *)
//
fun{}
fprint_funarray$sep
  (out: FILEref): void // ", "
//
fun{a:t0p}
fprint_funarray
  (FILEref, funarray(INV(a))): void
fun{a:t0p}
fprint_funarray_sep
  (FILEref, funarray(INV(a)), sep: string): void
//
overload fprint with fprint_funarray
//
(* ****** ****** *)
//
fun{
x:t0p
} funarray_foreach(xs: funarray(INV(x))): void
fun{
x:t0p}{env:vt0p
} funarray_foreach_env
  (xs: funarray(INV(x)), env: &(env) >> _): void
//
fun{
x:t0p}{env:vt0p
} funarray_foreach$cont(x: x, env: &env): bool
fun{
x:t0p}{env:vt0p
} funarray_foreach$fwork(x: x, env: &(env) >> _): void
//
(* ****** ****** *)

(* end of [funarray.sats] *)
