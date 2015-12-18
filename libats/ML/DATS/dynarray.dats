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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: December, 2015 *)

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

(* ****** ****** *)

staload "libats/ML/SATS/dynarray.sats"

(* ****** ****** *)
//
extern
castfn
dynarray_encode
  {a:vt@ype}($DA.dynarray(a)): dynarray(a)
//
extern
castfn
dynarray_decode
  {a:vt@ype}(DA: dynarray(a)): $DA.dynarray(a)
//
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

(* end of [dynarray.dats] *)

