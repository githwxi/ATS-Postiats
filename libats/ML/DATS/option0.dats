(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: July, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/option0.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
option0_some(x) = Some0{a}(x)
//
implement{}
option0_none ((*void*)) = None0((*void*))
//
(* ****** ****** *)

implement{}
option0_is_some(opt) =
(
//
case+ opt of
| Some0 _ => true | None0 _ => false
//
) // end of [option0_is_some]

implement{}
option0_is_none(opt) =
(
//
case+ opt of
| Some0 _ => false | None0 _ => true
//
) // end of [option0_is_none]

(* ****** ****** *)

implement
{a}(*tmp*)
option0_unsome_exn (opt) =
(
case+ opt of
| Some0(x) => x | None0() => $raise NotSomeExn()
) // end of [option0_unsome_exn]

(* ****** ****** *)

implement
{a}{b}
option0_map (opt, f) =
(
case+ opt of
| Some0(x) => Some0{b}(f(x)) | None0() => None0()
) (* end of [option0_map] *)

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_option0
  (out, opt) =
  fprint_option(out, g1ofg0_option(opt))
// end of [fprint_option0]

(* ****** ****** *)

implement(a)
fprint_val<option0(a)> = fprint_option0

(* ****** ****** *)

(* end of [option0.dats] *)
