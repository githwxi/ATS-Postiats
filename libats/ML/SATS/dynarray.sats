(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmmhwxiATgmailDOTcom *)
(* Start time: December, 2015 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

#if(0)
//
// HX: in [basis.sats]
//
abstype
dynarray_type
  (a: vt@ype(*inv*)) = ptr
stadef dynarray = dynarray_type
//
#endif

(* ****** ****** *)
//
fun{a:vt0p}
dynarray_make_nil
  (cap: sizeGte(1)): dynarray(a)
//
(* ****** ****** *)
//
(*
fun{}
fprint_array$sep(out: FILEref): void
*)
fun{a:vt0p}
fprint_dynarray
  (out: FILEref, DA: dynarray(a)): void
fun{a:vt0p}
fprint_dynarray_sep
  (out: FILEref, DA: dynarray(a), sep: string): void
//
(* ****** ****** *)
//
fun{}
dynarray_get_size
  {a:vt0p}(DA: dynarray(a)): size_t
fun{}
dynarray_get_capacity
  {a:vt0p}(DA: dynarray(a)): size_t
//
(* ****** ****** *)
//
fun{a:t0p}
dynarray_get_at_exn
  (DA: dynarray(a), i: size_t): (a)
fun{a:t0p}
dynarray_set_at_exn
  (DA: dynarray(a), i: size_t, x: a): void
//
overload [] with dynarray_get_at_exn
overload [] with dynarray_set_at_exn
//
(* ****** ****** *)
//
fun{a:vt0p}
dynarray_getref_at
  (DA: dynarray(a), i: size_t): cPtr0(a)
//
(* ****** ****** *)
//
fun{a:vt0p}
dynarray_insert_atbeg
  (DA: dynarray(a), x0: a): Option_vt(a)
//
fun{a:vt0p}
dynarray_insert_atend
  (DA: dynarray(a), x0: a): Option_vt(a)
//
(* ****** ****** *)
//
overload .insbeg with dynarray_insert_atbeg
overload .insend with dynarray_insert_atend
//
(* ****** ****** *)
//
fun{a:vt0p}
dynarray_insert_at
(
  DA: dynarray(a), i: size_t, x0: a
) : Option_vt(a) // end-of-function
//
(* ****** ****** *)
//
fun{a:vt0p}
dynarray_takeout_atbeg
  (DA: dynarray(INV(a))): Option_vt(a)
fun{a:vt0p}
dynarray_takeout_atend
  (DA: dynarray(INV(a))): Option_vt(a)
//
(* ****** ****** *)
//
fun{a:vt0p}
dynarray_takeout_at
  (DA: dynarray(a), i: size_t): Option_vt(a)
//
(* ****** ****** *)
//
fun{a:t@ype}
dynarray_listize0(DA: dynarray(a)): list0(a)
fun{a:t@ype}
dynarray_listize1(DA: dynarray(a)): list0(a)
//
(* ****** ****** *)

overload .size with dynarray_get_size
overload .capacity with dynarray_get_capacity

(* ****** ****** *)

overload .listize0 with dynarray_listize0
overload .listize1 with dynarray_listize1

(* ****** ****** *)

(* end of [dynarray.sats] *)
