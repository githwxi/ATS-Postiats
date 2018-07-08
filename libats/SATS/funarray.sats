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
farray_t0ype_int_type
(a:t@ype+, n:int) = ptr(*boxed*)
//
typedef
farray (
  a:t0p, n:int
) = farray_t0ype_int_type(a, n)
//
typedef
farray(a:t0p) = [n:int] farray(a, n)
//
(* ****** ****** *)
//
praxi
lemma_farray_param
  {a:t0p}{n:int}
  (A: farray(a, n)): [n >= 0] void
//
(* ****** ****** *)
//
fun{}
farray_is_nil
  {a:t0p}{n:int}
  (farray(a, n)):<> bool(n==0)
fun{}
farray_isnot_nil
  {a:t0p}{n:int}
  (farray(a, n)):<> bool(n > 0)
//
(* ****** ****** *)
//
fun
{a:t0p}
farray_size
{n:int}(A: farray(INV(a), n)):<> int(n)
//
overload size with farray_size
overload .size with farray_size
//
(* ****** ****** *)
//
fun{}
farray_nil
  {a:t0p}((*void*)):<> farray(a, 0)
fun{}
farray_make_nil
  {a:t0p}((*void*)):<> farray(a, 0)
//
(* ****** ****** *)
//
fun
{a:t0p}
farray_make_list
  {n:int}(xs: list(a, n)):<> farray(a, n)
//
(* ****** ****** *)
//
fun
{a:t0p}
farray_get_at{n:int}
(A: farray(INV(a), n), i: natLt(n)):<> (a)
//
fun
{a:t0p}
farray_set_at{n:int}
(A: &farray(INV(a), n) >> _, i: natLt(n), x: a):<!wrt> void
//
overload [] with farray_get_at
overload [] with farray_set_at
//
(* ****** ****** *)
//
fun
{a:t0p}
farray_getopt_at
{n:int}{i:nat}
(A: farray(INV(a), n), i: int(i)):<> option_vt(a, i < n)
//
fun
{a:t0p}
farray_setopt_at
{n:int}{i:nat}
(A: &farray(INV(a), n) >> _, i: int(i), x: a):<!wrt> bool(i < n)
//
overload getopt_at with farray_getopt_at
overload setopt_at with farray_setopt_at
//
(* ****** ****** *)
//
fun
{a:t0p}
farray_insert_l{n:int}
(
 A: &farray(INV(a), n) >> farray(a, n+1), x: a
) : void // end-of-function
fun
{a:t0p}
farray_insert_r{n:int}
(
 A: &farray(INV(a), n) >> farray(a, n+1), n: int(n), x: a
) : void // end-of-function
//
(* ****** ****** *)
//
fun
{a:t0p}
farray_remove_l{n:pos}
  (A: &farray(INV(a), n) >> farray(a, n-1)): a
// end of [farray_remove_l]
//
fun
{a:t0p}
farray_remove_r{n:pos}
  (A: &farray(INV(a), n) >> farray(a, n-1), n: int(n)): a
// end of [farray_remove_r]
//
(* ****** ****** *)
//
fun{}
fprint_farray$sep
  (out: FILEref): void // ", "
//
fun{a:t0p}
fprint_farray(FILEref, farray(INV(a))): void
fun{a:t0p}
fprint_farray_sep
  (FILEref, farray(INV(a)), sep: string): void
//
overload fprint with fprint_farray
//
(* ****** ****** *)
//
fun{
x:t0p
} farray_listize
  {n:int}(xs: farray(x, n)): list_vt(x, n)
//
(* ****** ****** *)
//
fun{
x:t0p
} farray_foreach(xs: farray(INV(x))): void
fun{
x:t0p}{env:vt0p
} farray_foreach_env
  (xs: farray(INV(x)), env: &(env) >> _): void
//
fun{
x:t0p}{env:vt0p
} farray_foreach$cont(x: x, env: &env): bool
fun{
x:t0p}{env:vt0p
} farray_foreach$fwork(x: x, env: &(env) >> _): void
//
(* ****** ****** *)

(* end of [funarray.sats] *)
