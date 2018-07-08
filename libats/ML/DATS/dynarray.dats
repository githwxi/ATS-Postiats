(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: December, 2015 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
DA = "libats/SATS/dynarray.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/ML/SATS/dynarray.sats"

(* ****** ****** *)
//
extern
castfn
dynarray_encode
  {a:vt@ype}
  ($DA.dynarray(a)): dynarray(a)
//
extern
castfn
dynarray_decode
  {a:vt@ype}
  (DA: dynarray(a)): $DA.dynarray(a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_make_nil
  (cap) = let
//
val DA =
  $DA.dynarray_make_nil(cap)
//
in
  dynarray_encode(DA)
end // end of [dynarray_make_nil]

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_dynarray
  (out, DA) =
{
//
val DA = dynarray_decode(DA)
val () = $DA.fprint_dynarray<a> (out, DA)
prval () = $UN.cast2void(DA)
//
} (* end of [fprint_dynarray] *)

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_dynarray_sep
  (out, DA, sep) =
{
//
val DA = dynarray_decode(DA)
val () = $DA.fprint_dynarray_sep<a> (out, DA, sep)
prval () = $UN.cast2void(DA)
//
} (* end of [fprint_dynarray_sep] *)

(* ****** ****** *)

implement{}
dynarray_get_size
  (DA) = asz where
{
//
val DA = dynarray_decode(DA)
val asz = $DA.dynarray_get_size<> (DA)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_get_size] *)

implement{}
dynarray_get_capacity
  (DA) = cap where
{
//
val DA = dynarray_decode(DA)
val cap = $DA.dynarray_get_capacity<> (DA)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_get_capacity] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_get_at_exn
  (DA, i) = x0 where
{
//
val DA = dynarray_decode(DA)
val x0 =
  $DA.dynarray_get_at_exn<a>(DA, i)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_get_at_exn] *)

implement
{a}(*tmp*)
dynarray_set_at_exn
  (DA, i, x0) = () where
{
//
val DA = dynarray_decode(DA)
val () =
  $DA.dynarray_set_at_exn<a>(DA, i, x0)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_set_at_exn] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_getref_at
  (DA, i) = p0 where
{
//
val DA = dynarray_decode(DA)
val p0 =
  $DA.dynarray_getref_at<a>(DA, i)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_getref_at] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_atbeg
  (DA, x0) = opt where
{
//
val DA = dynarray_decode(DA)
val opt =
  $DA.dynarray_insert_atbeg_opt<a> (DA, x0)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_insert_atbeg] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_atend
  (DA, x0) = opt where
{
//
val DA = dynarray_decode(DA)
val opt =
  $DA.dynarray_insert_atend_opt<a> (DA, x0)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_insert_atend] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_at
  (DA, i, x0) = opt where
{
//
val DA = dynarray_decode(DA)
//
val opt =
  $DA.dynarray_insert_at_opt<a> (DA, i, x0)
//
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_insert_at] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_atbeg
  (DA) = opt where
{
//
val DA = dynarray_decode(DA)
//
val opt =
  $DA.dynarray_takeout_atbeg_opt<a> (DA)
//
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_takeout_atbeg] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_atend
  (DA) = opt where
{
//
val DA = dynarray_decode(DA)
//
val opt =
  $DA.dynarray_takeout_atend_opt<a> (DA)
//
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_takeout_atend] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_at
  (DA, i) = opt where
{
//
val DA = dynarray_decode(DA)
val opt = $DA.dynarray_takeout_at_opt<a> (DA, i)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_takeout_at] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_listize0
  (DA) =
  list0_of_list_vt(xs) where
{
//
val DA = dynarray_decode(DA)
val xs = $DA.dynarray_listize0(DA)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_listize0] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_listize1
  (DA) =
  list0_of_list_vt(xs) where
{
//
val DA = dynarray_decode(DA)
val xs = $DA.dynarray_listize1(DA)
prval () = $UN.cast2void(DA)
//
} (* end of [dynarray_listize1] *)

(* ****** ****** *)

(* end of [dynarray.dats] *)
