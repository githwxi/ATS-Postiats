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
fun{a:vt0p}
list_vt_tuple_0(): list_vt(a, 0)
//
fun{a:vt0p}
list_vt_tuple_1(x0: a): list_vt(a, 1)
fun{a:vt0p}
list_vt_tuple_2(x0: a, x1: a): list_vt(a, 2)
fun{a:vt0p}
list_vt_tuple_3(x0: a, x1: a, x2: a): list_vt(a, 3)
//
fun{a:vt0p}
list_vt_tuple_4
  (x0: a, x1: a, x2: a, x3: a): list_vt(a, 4)
fun{a:vt0p}
list_vt_tuple_5
  (x0: a, x1: a, x2: a, x3: a, x4: a): list_vt(a, 5)
fun{a:vt0p}
list_vt_tuple_6
  (x0: a, x1: a, x2: a, x3: a, x4: a, x5: a): list_vt(a, 6)
//
(* ****** ****** *)
//
fun
{a:vt0p}
{b:vt0p}
list_vt_mapfree_method
  {n:nat}
(
  list_vt(INV(a), n), TYPE(b)
) :
(
  (&a >> a?!) -<cloptr1> b
) -<lincloptr1> list_vt(b, n)
//
overload .mapfree with list_vt_mapfree_method
//
(* ****** ****** *)

(* end of [list_vt.sats] *)
