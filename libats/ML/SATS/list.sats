(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: December, 2017 *)
(* Authoremail: gmmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.ML"
//
#define
ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
fun{a:t0p}
list_tuple_0(): list(a, 0)
//
fun{a:t0p}
list_tuple_1(x0: a): list(a, 1)
fun{a:t0p}
list_tuple_2(x0: a, x1: a): list(a, 2)
fun{a:t0p}
list_tuple_3(x0: a, x1: a, x2: a): list(a, 3)
//
fun{a:t0p}
list_tuple_4
  (x0: a, x1: a, x2: a, x3: a): list(a, 4)
fun{a:t0p}
list_tuple_5
  (x0: a, x1: a, x2: a, x3: a, x4: a): list(a, 5)
fun{a:t0p}
list_tuple_6
  (x0: a, x1: a, x2: a, x3: a, x4: a, x5: a): list(a, 6)
//
(* ****** ****** *)

(* end of [list.sats] *)
