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
(* Start time: May, 2013 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.dynarray"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

%{#
#include "libats/CATS/dynarray.cats"
%} // end of [%{#]

(* ****** ****** *)
//
// HX: for recapacitizing policy
//
fun{} dynarray$recapacitize ((*void*)): int
//
(* ****** ****** *)

absvtype
dynarray_vtype (a:vt@ype+) = ptr
vtypedef
dynarray (a:vt0p) = dynarray_vtype (a)

(* ****** ****** *)

fun{a:vt0p}
dynarray_make_nil (cap: sizeGte(1)): dynarray (a)

(* ****** ****** *)

fun{}
dynarray_free
  {a:t0p} (DA: dynarray (INV(a))):<!wrt> void
// end of [dynarray_free]

(* ****** ****** *)

fun{a:vt0p}
fprint_dynarray
  (out: FILEref, DA: !dynarray (INV(a))): void
// end of [fprint_dynarray]

(* ****** ****** *)

fun{}
dynarray_getfree_arrayptr{a:vt0p}
(
  DA: dynarray (INV(a)), n: &size_t? >> size_t (n)
) :<!wrt> #[n:nat] arrayptr (a, n)

(* ****** ****** *)

fun{}
dynarray_get_array{a:vt0p}
(
  DA: !RD(dynarray (INV(a))), n: &size_t? >> size_t (n)
) :<!wrt> #[l:addr;n:int]
(
  array_v (a, l, n), array_v (a, l, n) -<lin,prf> void | ptr l
) // end of [dynarray_get_array]

(* ****** ****** *)
//
fun{}
dynarray_get_size
  {a:vt0p} (DA: !RD(dynarray (INV(a)))): size_t
fun{}
dynarray_get_capacity
  {a:vt0p} (DA: !RD(dynarray (INV(a)))): size_t
//
(* ****** ****** *)
//
fun{a:vt0p}
dynarray_getref_at
  (DA: !RD(dynarray(INV(a))), i: size_t):<> cPtr0 (a)
//
fun{a:t0p}
dynarray_get_at_exn
  (DA: !RD(dynarray(INV(a))), i: size_t):<!exn> a
fun{a:t0p}
dynarray_set_at_exn
  (DA: !RD(dynarray(INV(a))), i: size_t, x: a):<!exnwrt> void
//
overload [] with dynarray_get_at_exn
overload [] with dynarray_set_at_exn
//
(* ****** ****** *)

fun{a:vt0p}
dynarray_insert_at
(
  DA: !dynarray (INV(a)), i: size_t, x: a, res: &a? >> opt(a, b)
) : #[b:bool] bool (b) // end of [dynarray_insert_at]

(* ****** ****** *)
//
fun{a:vt0p}
dynarray_insert_at_exn
  (DA: !dynarray (INV(a)), i: size_t, x: a): void
fun{a:vt0p}
dynarray_insert_at_opt
  (DA: !dynarray (INV(a)), i: size_t, x: a): Option_vt (a)
//
(* ****** ****** *)

fun{a:vt0p}
dynarray_insert_atbeg_exn (DA: !dynarray (INV(a)), x: a): void
fun{a:vt0p}
dynarray_insert_atbeg_opt (DA: !dynarray (INV(a)), x: a): Option_vt (a)

fun{a:vt0p}
dynarray_insert_atend_exn (DA: !dynarray (INV(a)), x: a): void
fun{a:vt0p}
dynarray_insert_atend_opt (DA: !dynarray (INV(a)), x: a): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
dynarray_inserts_at{n2:int}
(
  DA: !dynarray (INV(a)), i: size_t
, xs: &array(a, n2) >> arrayopt(a, n2, b), n2: size_t (n2)
) : #[b:bool] bool (b) // end of [dynarray_inserts_at]

(* ****** ****** *)

fun{a:vt0p}
dynarray_takeout_at
(
  DA: !dynarray (INV(a)), i: size_t, res: &a? >> opt(a, b)
) : #[b:bool] bool(b) // end of [dynarray_takeout_at]

(* ****** ****** *)
//
fun{a:vt0p}
dynarray_takeout_at_exn
  (DA: !dynarray (INV(a)), i: size_t): (a)
fun{a:vt0p}
dynarray_takeout_at_opt
  (DA: !dynarray (INV(a)), i: size_t): Option_vt (a)
//
(* ****** ****** *)

fun{a:vt0p}
dynarray_takeout_atbeg_exn (DA: !dynarray (INV(a))): (a)
fun{a:vt0p}
dynarray_takeout_atbeg_opt (DA: !dynarray (INV(a))): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
dynarray_takeout_atend_exn (DA: !dynarray (INV(a))): (a)
fun{a:vt0p}
dynarray_takeout_atend_opt (DA: !dynarray (INV(a))): Option_vt (a)

(* ****** ****** *)

fun{a:t0p}
dynarray_filter$pred (x: &a): bool
fun{a:t0p}
dynarray_filter (DA: !dynarray (INV(a))): void

(* ****** ****** *)

fun{a:vt0p}
dynarray_filterlin$pred (x: &a): bool
fun{a:vt0p}
dynarray_filterlin$clear (x: &a >> a?): void
fun{a:vt0p}
dynarray_filterlin (DA: !dynarray (INV(a))): void

(* ****** ****** *)

fun{a:vt0p}
dynarray_reset_capacity
  (DA: !dynarray (INV(a)), m2: sizeGte(1)):<!wrt> bool(*done/ignored*)
// end of [dynarray_reset_capacity]

(* ****** ****** *)

fun{a:vt0p}
dynarray_quicksort$cmp
  (x1: &RD(a), x2: &RD(a)):<> int
fun{a:vt0p}
dynarray_quicksort (DA: !dynarray (INV(a))): void

(* ****** ****** *)

abst@ype
dynarray_struct = $extype"atslib_dynarray_struct"

(* ****** ****** *)

fun{}
dynarray_make2_nil
  {a:vt0p}{l:addr}
(
  pfat: dynarray_struct? @ l | p: ptr l, cap: sizeGte(1)
) : (mfree_ngc_v (l) | dynarray (a))

fun{}
dynarray_getfree2_arrayptr
  {a:vt0p}{l:addr}
(
  pfngc: mfree_ngc_v (l)
| p: ptr l, DA: dynarray (a), n: &size_t? >> size_t n
) : #[n:int] (dynarray_struct? @ l | arrayptr (a, n))

(* ****** ****** *)

(* end of [dynarray.sats] *)
