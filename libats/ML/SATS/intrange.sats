(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom*)
(* Start time: September, 2014 *)

(* ****** ****** *)
//
// HX-2013-04:
// intrange (l, r) is for integers i satisfying l <= i < r
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.ML"
#define
ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
fun{}
int_repeat_lazy
  (n: int, f: lazy (void)): void
fun{}
int_repeat_cloref
  (n: int, f: cfun0 (void)): void
//
overload repeat with int_repeat_lazy
overload repeat with int_repeat_cloref
overload .repeat with int_repeat_cloref
//
(* ****** ****** *)
//
fun{}
int_forall_cloref
  (n: int, f: cfun1 (int, bool)): bool
fun{}
int_forall_method
  (n: int) (f: cfun1 (int, bool)): bool
//
overload .forall with int_forall_method
//
(* ****** ****** *)
//
fun{}
int_foreach_cloref
  (n: int, f: cfun1 (int, void)): void
fun{}
int_foreach_method
  (n: int) (f: cfun1 (int, void)): void
//
overload .foreach with int_foreach_method
//
(* ****** ****** *)
//
fun{res:vt0p}
int_foldleft_cloref
  (n: int, ini: res, f: cfun2 (res, int, res)): res
//
fun{res:vt0p}
int_foldleft_method
  (int, TYPE(res))(ini: res, f: cfun2 (res, int, res)): res
//
overload .foldleft with int_foldleft_method
//
(* ****** ****** *)
//
fun{}
intrange_forall_cloref
  (l: int, r: int, f: cfun1 (int, bool)): bool
fun{}
intrange_forall_method
  (lr: @(int, int)) (f: cfun1 (int, bool)): bool
//
overload .forall with intrange_forall_method
//
(* ****** ****** *)
//
fun{}
intrange_foreach_cloref
  (l: int, r: int, f: cfun1 (int, void)): void
fun{}
intrange_foreach_method
  (lr: @(int, int)) (f: cfun1 (int, void)): void
//
overload .foreach with intrange_foreach_method
//
(* ****** ****** *)
//
fun{res:vt0p}
intrange_foldleft_cloref
  (l: int, r: int, ini: res, f: cfun2 (res, int, res)): res
//
fun{res:vt0p}
intrange_foldleft_method
  ((int, int), TYPE(res))(ini: res, f: cfun2 (res, int, res)): res
//
overload .foldleft with intrange_foldleft_method
//
(* ****** ****** *)
//
fun{}
int_streamGte(n: int): stream(int)
//
overload .streamGte with int_streamGte
//
(* ****** ****** *)
//
fun{a:t0p}
int_list_map_cloref
  (n: intGte(0), f: cfun(int, a)): list0(a)
fun{a:t0p}
int_list_map_method
  (n: intGte(0), TYPE(a))(f: cfun(int, a)): list0(a)
//
overload .list_map with int_list_map_method
//
(* ****** ****** *)
//
fun{a:t0p}
int_array_map_cloref
  (n: intGte(0), f: cfun(size_t, a)): array0(a)
fun{a:t0p}
int_array_map_method
  (n: intGte(0), TYPE(a))(f: cfun(size_t, a)): array0(a)
//
overload .array_map with int_array_map_method
//
(* ****** ****** *)
//
fun{a:t0p}
int_stream_map_cloref
  (n: intGte(0), f: cfun(int, a)): stream(a)
fun{a:t0p}
int_stream_map_method
  (n: intGte(0), TYPE(a))(f: cfun(int, a)): stream(a)
//
overload .stream_map with int_stream_map_method
//
(* ****** ****** *)
//
fun{}
int2_foreach_cloref
  (n1: int, n2: int, f: cfun2(int, int, void)): void
//
fun{}
intrange2_foreach_cloref
  (l1: int, r1: int, l2: int, r2: int, f: cfun2(int, int, void)): void
//
(* ****** ****** *)

(* end of [intrange.sats] *)
