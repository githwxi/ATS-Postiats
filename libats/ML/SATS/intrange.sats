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

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
fun{}
int_repeat_lazy
  (n: int, f: lazy(void)): void
fun{}
int_repeat_cloref
  (n: int, f: cfun0 (void)): void
//
overload repeat with int_repeat_lazy
overload repeat with int_repeat_cloref
//
(* ****** ****** *)
//
fun{}
int_foreach_cloref
  (n: int, f: cfun1 (int, void)): void
//
overload foreach with int_foreach_cloref
//
(* ****** ****** *)
//
fun{}
intrange_foreach_cloref
  (l: int, r: int, f: cfun1 (int, void)): void
//
(* ****** ****** *)

(* end of [intrange.sats] *)
