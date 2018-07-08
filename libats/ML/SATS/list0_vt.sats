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
(* Start time: January, 2018 *)
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
#define
list0_vt_sing(x)
list0_vt_cons(x, list0_vt_nil())
//
#define
list0_vt_pair(x1, x2)
list0_vt_cons
(x1, list0_vt_cons(x2, list0_vt_nil()))
//
(* ****** ****** *)
//
castfn
list0_vt2t
  {a:t@ype}(list0_vt(INV(a))):<> list0(a)
//
(* ****** ****** *)
//
castfn
g0ofg1_list_vt
  {a:vt@ype}
  (List_vt(INV(a))):<> list0_vt(a)
castfn
g1ofg0_list_vt
  {a:vt@ype}
  (list0_vt(INV(a))):<> List0_vt(a)
//
overload g0ofg1 with g0ofg1_list_vt
overload g1ofg0 with g1ofg0_list_vt
//
(* ****** ****** *)
//
fun
{a:t0p}
list0_vt_free(xs: list0_vt(a)): void
//
(* ****** ****** *)
//
fun
{a:vt0p}
list0_vt_append
  (list0_vt(a), list0_vt(a)): list0_vt(a)
//
(* ****** ****** *)
//
fun
{a:vt0p}
list0_vt_reverse(xs: list0_vt(a)): list0_vt(a)
//
(* ****** ****** *)

(* end of [list0_vt.sats] *)
