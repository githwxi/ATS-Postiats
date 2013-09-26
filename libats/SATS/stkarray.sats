(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
** Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

(*
**
** An array-based stack implementation
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

#define ATS_PACKNAME "ATSLIB.libats.stkarray"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

%{#
#include "libats/CATS/stkarray.cats"
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
stkarray_vtype (a:vt@ype+, m:int, n:int) = ptr
//
(* ****** ****** *)
//
stadef stkarray = stkarray_vtype
//
vtypedef
stkarray (a:vt0p) = [m,n:int] stkarray_vtype (a, m, n)
//
(* ****** ****** *)

abst@ype
stkarray_tsize = $extype"atslib_stkarray_struct"

(* ****** ****** *)

praxi
lemma_stkarray_param
  {a:vt0p}{m,n:int}
  (!stkarray (INV(a), m, n)): [m >= n; n >= 0] void
// end of [lemma_stkarray_param]

(* ****** ****** *)

fun{a:vt0p}
stkarray_make_cap
  {m:int} (cap: size_t(m)):<!wrt> stkarray (a, m, 0)
// end of [stkarray_make_cap]

(* ****** ****** *)

fun
stkarray_make_ngc
  {a:vt0p}
  {l:addr}{m:int}
(
  stkarray_tsize? @ l
| ptr(l), arrayptr(a?, m), size_t(m), sizeof_t(a)
) :<!wrt> (mfree_ngc_v (l) | stkarray (a, m, 0)) = "mac#%"

(* ****** ****** *)

fun
stkarray_free_nil
  {a:vt0p}{m:int}
  (stk: stkarray (a, m, 0)):<!wrt> void = "mac#%"
// end of [stkarray_free_nil]

fun
stkarray_getfree_arrayptr
  {a:vt0p}{m,n:int}
  (stk: stkarray (a, m, n)):<!wrt> arrayptr (a, n) = "mac#%"
// end of [stkarray_getfree_arrayptr]

(* ****** ****** *)
//
fun{a:vt0p}
stkarray_get_size
  {m,n:int} (stk: !stkarray (INV(a), m, n)):<> size_t(n)
fun{a:vt0p}
stkarray_get_capacity
  {m,n:int} (stk: !stkarray (INV(a), m, n)):<> size_t(m)
//
(* ****** ****** *)

fun stkarray_get_ptrbeg{a:vt0p}
  {m,n:int} (stk: !stkarray (INV(a), m, n)):<> Ptr1 = "mac#%"
// end of [stkarray_get_ptrbeg]

(* ****** ****** *)
//
fun
stkarray_is_nil
  {a:vt0p}{m,n:int}
  (stk: !stkarray (INV(a), m, n)):<> bool (n==0) = "mac#%"
fun
stkarray_isnot_nil
  {a:vt0p}{m,n:int}
  (stk: !stkarray (INV(a), m, n)):<> bool (n > 0) = "mac#%"
//
(* ****** ****** *)
//
fun
stkarray_is_full
  {a:vt0p}{m,n:int}
  (stk: !stkarray (INV(a), m, n)):<> bool (m==n) = "mac#%"
fun
stkarray_isnot_full
  {a:vt0p}{m,n:int}
  (stk: !stkarray (INV(a), m, n)):<> bool (m > n) = "mac#%"
//
(* ****** ****** *)

fun{}
fprint_stkarray$sep (out: FILEref): void
fun{a:vt0p}
fprint_stkarray
  (out: FILEref, stk: !stkarray (INV(a))): void
fun{a:vt0p}
fprint_stkarray_sep
  (out: FILEref, stk: !stkarray (INV(a)), sep: string): void
overload fprint with fprint_stkarray
overload fprint with fprint_stkarray_sep

(* ****** ****** *)

fun{a:vt0p}
stkarray_insert
  {m,n:int | m > n}
(
  stk: !stkarray (INV(a), m, n) >> stkarray (a, m, n+1), x0: a
) :<!wrt> void // endfun

(* ****** ****** *)

fun{a:vt0p}
stkarray_insert_opt
  (stk: !stkarray (INV(a)) >> _, x0: a):<!wrt> Option_vt (a)
// end of [stkarray_insert_opt]

(* ****** ****** *)

fun{a:vt0p}
stkarray_takeout
  {m,n:int | n > 0}
(
  stk: !stkarray (INV(a), m, n) >> stkarray (a, m, n-1)
) :<!wrt> (a) // endfun

fun{a:vt0p}
stkarray_takeout_opt
  (stk: !stkarray (INV(a)) >> _):<!wrt> Option_vt (a)
// end of [stkarray_takeout_opt]

(* ****** ****** *)

fun{a:vt0p}
stkarray_getref_top
  {m,n:int | n > 0} (stk: !stkarray (INV(a), m, n)):<> cPtr1 (a)
// end of [stkarray_getref_top]

(* ****** ****** *)
//
symintr stkarray_getref_at
//
fun{a:vt0p}
stkarray_getref_at_int
  {m,n:int}{i:nat | i < n}
  (stk: !stkarray(INV(a), m, n), i: int(i)):<> cPtr1 (a)
//
fun{a:vt0p}
stkarray_getref_at_size
  {m,n:int}{i:nat | i < n}
  (stk: !stkarray(INV(a), m, n), i: size_t(i)):<> cPtr1 (a)
//
overload stkarray_getref_at with stkarray_getref_at_int
overload stkarray_getref_at with stkarray_getref_at_size
//
(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} stkarray_foreach$cont (x: &a, env: &env): bool
fun{
a:vt0p}{env:vt0p
} stkarray_foreach$fwork (x: &a >> _, env: &(env) >> _): void
fun{
a:vt0p
} stkarray_foreach{m,n:int}
  (stk: !stkarray (INV(a), m, n)): sizeLte(n)
fun{
a:vt0p}{env:vt0p
} stkarray_foreach_env{m,n:int}
  (stk: !stkarray (INV(a), m, n), env: &(env) >> _): sizeLte(n)

(* ****** ****** *)

(* end of [stkarray.sats] *)
