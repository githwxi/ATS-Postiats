(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: May, 2013 *)

(* ****** ****** *)

%{#
#include "libats/CATS/dynarray.cats"
%} // end of [%{#]

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)
//
// HX-2013-05:
// for recapacitizing policy
//
fun{} dynarray$recapacitize (): int
//
(* ****** ****** *)

absvtype
dynarray_vtype (a:vt@ype+) = ptr
vtypedef dynarray (a:vt0p) = dynarray_vtype (a)

(* ****** ****** *)

fun{a:vt0p}
dynarray_make_nil (cap: sizeGte(1)): dynarray (a)

(* ****** ****** *)

fun{}
dynarray_free
  {a:t0p} (DA: dynarray (INV(a))):<!wrt> void
// end of [dynarray_free]

(* ****** ****** *)

fun{}
dynarray_getfree_arrayptr{a:vt0p}
(
  DA: dynarray (INV(a)), n: &size_t? >> size_t (n)
) :<!wrt> #[n:int] arrayptr (a, n)

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
dynarray_insert_at_opt
  (DA: !dynarray (INV(a)), i: size_t, x: a): Option_vt (a)

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
dynarray_inserts_at{n:int}
(
  DA: !dynarray (INV(a))
, i: size_t, xs: &array(a, n) >> arrayopt(a, n, b), n: size_t n
) : #[b:bool] bool (b) // end of [dynarray_inserts_at_exn]

(* ****** ****** *)

fun{a:vt0p}
dynarray_takeout_at_opt
  (DA: !dynarray (INV(a)), i: size_t): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
dynarray_takeout_atbeg_opt (DA: !dynarray (INV(a))): Option_vt (a)
fun{a:vt0p}
dynarray_takeout_atend_opt (DA: !dynarray (INV(a))): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
dynarray_reset_capacity
  (DA: !dynarray (INV(a)), m2: sizeGte(1)): bool(*done/ignored*)
// end of [dynarray_reset_capacity]

(* ****** ****** *)

(* end of [dynarray.sats] *)
