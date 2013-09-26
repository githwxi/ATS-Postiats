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

#define ATS_PACKNAME "ATSLIB.libats.deqarray"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

%{#
#include "libats/CATS/deqarray.cats"
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
deqarray_vtype (a:vt@ype+, m:int, n:int) = ptr
//
(* ****** ****** *)
//
stadef deqarray = deqarray_vtype
//
vtypedef
deqarray (a:vt0p, m:int) = [n:int] deqarray_vtype (a, m, n)
//
(* ****** ****** *)

abst@ype
deqarray_tsize = $extype"atslib_deqarray_struct"

(* ****** ****** *)

praxi
lemma_deqarray_param
  {a:vt0p}{m,n:int}
  (!deqarray (INV(a), m, m)): [m >= n; n >= 0] void
// end of [lemma_deqarray_param]

(* ****** ****** *)

fun{a:vt0p}
deqarray_make_cap
  {m:int} (cap: size_t(m)):<!wrt> deqarray (a, m, 0)
// end of [deqarray_make_cap]

(* ****** ****** *)

fun
deqarray_make_ngc
  {a:vt0p}
  {l:addr}{m:int}
(
  deqarray_tsize? @ l
| ptr(l), arrayptr(a?, m), size_t(m), sizeof_t(a)
) :<!wrt> (mfree_ngc_v (l) | deqarray (a, m, 0)) = "mac#%"

(* ****** ****** *)

fun
deqarray_free_nil
  {a:vt0p}{m:int}
  (deq: deqarray (a, m, 0)):<!wrt> void = "mac#%"
// end of [deqarray_free_nil]

(* ****** ****** *)
//
fun{a:vt0p}
deqarray_get_size
  {m,n:int} (deq: !deqarray (INV(a), m, n)):<> size_t(n)
fun{a:vt0p}
deqarray_get_capacity
  {m,n:int} (deq: !deqarray (INV(a), m, n)):<> size_t(m)
//
(* ****** ****** *)
//
fun
deqarray_is_nil
  {a:vt0p}{m,n:int}
  (deq: !deqarray (INV(a), m, n)):<> bool (n==0) = "mac#%"
fun
deqarray_isnot_nil
  {a:vt0p}{m,n:int}
  (deq: !deqarray (INV(a), m, n)):<> bool (n > 0) = "mac#%"
//
(* ****** ****** *)
//
fun
deqarray_is_full
  {a:vt0p}{m,n:int}
  (deq: !deqarray (INV(a), m, n)):<> bool (m==n) = "mac#%"
fun
deqarray_isnot_full
  {a:vt0p}{m,n:int}
  (deq: !deqarray (INV(a), m, n)):<> bool (m > n) = "mac#%"
//
(* ****** ****** *)

fun{}
fprint_deqarray$sep (out: FILEref): void
fun{a:vt0p}
fprint_deqarray{m:int}
  (out: FILEref, q: !deqarray (INV(a), m)): void
fun{a:vt0p}
fprint_deqarray_sep{m:int}
  (out: FILEref, q: !deqarray (INV(a), m), sep: string): void
overload fprint with fprint_deqarray
overload fprint with fprint_deqarray_sep

(* ****** ****** *)

fun{a:vt0p}
deqarray_insert
  {m,n:int | m > n}
(
  deq: !deqarray (INV(a), m, n) >> deqarray (a, m, n+1), x0: a
) :<!wrt> void // endfun

(* ****** ****** *)

fun{a:vt0p}
deqarray_insert_opt{m:int}
  (deq: !deqarray (INV(a), m) >> _, x0: a):<!wrt> Option_vt (a)
// end of [deqarray_insert_opt]

(* ****** ****** *)

fun{a:vt0p}
deqarray_takeout
  {m,n:int | n > 0}
(
  deq: !deqarray (INV(a), m, n) >> deqarray (a, m, n-1)
) :<!wrt> (a) // endfun

fun{a:vt0p}
deqarray_takeout_opt{m:int}
  (deq: !deqarray (INV(a), m) >> _):<!wrt> Option_vt (a)
// end of [deqarray_takeout_opt]

(* ****** ****** *)

fun{a:vt0p}
deqarray_getref_top
  {m,n:int | n > 0} (deq: !deqarray (INV(a), m, n)):<> cPtr1 (a)
// end of [deqarray_getref_top]

fun{a:vt0p}
deqarray_getref_bot
  {m,n:int | n > 0} (deq: !deqarray (INV(a), m, n)):<> cPtr1 (a)
// end of [deqarray_getref_bot]

(* ****** ****** *)
//
symintr deqarray_getref_at
//
fun{a:vt0p}
deqarray_getref_at_int
  {m,n:int}{i:nat | i < n}
  (deq: !deqarray(INV(a), m, n), i: int(i)):<> cPtr1 (a)
//
fun{a:vt0p}
deqarray_getref_at_size
  {m,n:int}{i:nat | i < n}
  (deq: !deqarray(INV(a), m, n), i: size_t(i)):<> cPtr1 (a)
//
overload deqarray_getref_at with deqarray_getref_at_int
overload deqarray_getref_at with deqarray_getref_at_size
//
(* ****** ****** *)

(* end of [deqarray.sats] *)
