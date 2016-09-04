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

(*
**
** An array-based deque implementation
**
*)

(* ****** ****** *)

(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start time: September, 2013
**
*)

(* ****** ****** *)

#define
ATS_PACKNAME
"ATSLIB.libats.deqarray"
//
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_"

(* ****** ****** *)

%{#
#include \
"libats/CATS/deqarray.cats"
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
deqarray_vtype
  (a:vt@ype+, m:int, n:int) = ptr
//
(* ****** ****** *)
//
stadef deqarray = deqarray_vtype
//
vtypedef
deqarray(a:vt0p) =
  [m,n:int] deqarray_vtype (a, m, n)
//
(* ****** ****** *)

abst@ype
deqarray_tsize = $extype"atslib_deqarray_struct"

(* ****** ****** *)

praxi
lemma_deqarray_param
  {a:vt0p}{m,n:int}
  (!deqarray(INV(a), m, n)): [m >= n; n >= 0] void
// end of [lemma_deqarray_param]

(* ****** ****** *)

fun{a:vt0p}
deqarray_make_cap
  {m:int} (cap: size_t(m)):<!wrt> deqarray(a, m, 0)
// end of [deqarray_make_cap]

(* ****** ****** *)

fun
deqarray_make_ngc__tsz
  {a:vt0p}
  {l:addr}{m:int}
(
  deqarray_tsize? @ l
| ptr(l), arrayptr(a?, m+1), size_t(m), sizeof_t(a)
) :<!wrt> (mfree_ngc_v (l) | deqarray(a, m, 0)) = "mac#%"

(* ****** ****** *)

fun
deqarray_free_nil
  {a:vt0p}{m:int}
  (deq: deqarray(a, m, 0)):<!wrt> void = "mac#%"
// end of [deqarray_free_nil]

(* ****** ****** *)
//
fun
{a:vt0p}
deqarray_get_size
  {m,n:int}
  (deq: !deqarray(INV(a), m, n)):<> size_t(n)
fun
{a:vt0p}
deqarray_get_capacity
  {m,n:int}
  (deq: !deqarray(INV(a), m, n)):<> size_t(m)
//
(* ****** ****** *)
//
fun
deqarray_is_nil
  {a:vt0p}{m,n:int}
  (deq: !deqarray(INV(a), m, n)):<> bool(n==0) = "mac#%"
fun
deqarray_isnot_nil
  {a:vt0p}{m,n:int}
  (deq: !deqarray(INV(a), m, n)):<> bool(n > 0) = "mac#%"
//
(* ****** ****** *)
//
fun
{a:vt0p}
deqarray_is_full{m,n:int}
  (deq: !deqarray(INV(a), m, n)):<> bool(m==n) = "mac#%"
fun
{a:vt0p}
deqarray_isnot_full{m,n:int}
  (deq: !deqarray(INV(a), m, n)):<> bool(m > n) = "mac#%"
//
(* ****** ****** *)
//
fun{}
fprint_deqarray$sep (out: FILEref): void
fun{a:vt0p}
fprint_deqarray
  (out: FILEref, q: !deqarray(INV(a))): void
fun{a:vt0p}
fprint_deqarray_sep
  (out: FILEref, q: !deqarray(INV(a)), sep: string): void
//
overload fprint with fprint_deqarray
overload fprint with fprint_deqarray_sep
//
(* ****** ****** *)

fun{a:vt0p}
deqarray_insert_atbeg
  {m,n:int | m > n}
(
  deq: !deqarray(INV(a),m,n) >> deqarray(a,m,n+1), x0: a
) :<!wrt> void // endfun

fun{a:vt0p}
deqarray_insert_atbeg_opt
  (deq: !deqarray(INV(a)) >> _, x0: a):<!wrt> Option_vt(a)
// end of [deqarray_insert_atbeg_opt]

(* ****** ****** *)

fun
{a:vt0p}
deqarray_insert_atend
  {m,n:int | m > n}
(
  deq: !deqarray(INV(a),m,n) >> deqarray(a,m,n+1), x0: a
) :<!wrt> void // end-of-fun

fun
{a:vt0p}
deqarray_insert_atend_opt
  (deq: !deqarray(INV(a)) >> _, x0: a):<!wrt> Option_vt(a)
// end of [deqarray_insert_atend_opt]

(* ****** ****** *)

fun
{a:vt0p}
deqarray_takeout_atbeg
  {m,n:int | n > 0}
(
  deq: !deqarray(INV(a),m,n) >> deqarray(a,m,n-1)
) :<!wrt> (a) // end-of-fun

fun
{a:vt0p}
deqarray_takeout_atbeg_opt
  (deq: !deqarray(INV(a)) >> _):<!wrt> Option_vt(a)
// end of [deqarray_takeout_atbeg_opt]

(* ****** ****** *)

fun
{a:vt0p}
deqarray_takeout_atend
  {m,n:int | n > 0}
(
  deq: !deqarray(INV(a),m,n) >> deqarray(a,m,n-1)
) :<!wrt> (a) // end-of-fun

fun
{a:vt0p}
deqarray_takeout_atend_opt
  (deq: !deqarray(INV(a)) >> _):<!wrt> Option_vt(a)
// end of [deqarray_takeout_atend_opt]

(* ****** ****** *)
//
fun
{a:t0p}
deqarray_get_at
  {m,n:int}
  (deq: !deqarray(INV(a), m, n), i: sizeLt(n)):<> (a)
//
fun
{a:t0p}
deqarray_set_at
  {m,n:int}
  (deq: !deqarray(INV(a), m, n), i: sizeLt(n), x: a):<!wrt> void
//
(* ****** ****** *)
//
fun
{a:vt0p}
deqarray_getref_at
  {m,n:int}
  (deq: !deqarray(INV(a), m, n), i: sizeLt(n)):<> cPtr1(a)
//
(* ****** ****** *)
//
fun{
a:vt0p
} deqarray_foreach{m,n:int}
  (deq: !deqarray(INV(a), m, n)): void
fun{
a:vt0p}{env:vt0p
} deqarray_foreach_env{m,n:int}
  (deq: !deqarray(INV(a), m, n), env: &(env) >> _): void
//
fun{
a:vt0p}{env:vt0p
} deqarray_foreach$cont(x: &a, env: &env): bool
fun{
a:vt0p}{env:vt0p
} deqarray_foreach$fwork(x: &a >> _, env: &(env) >> _): void
//
(* ****** ****** *)

(* end of [deqarray.sats] *)
