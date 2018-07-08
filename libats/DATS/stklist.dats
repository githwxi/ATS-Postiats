(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: September, 2013 *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.stklist"
//
// HX-2017-03-28:
#define // no dynloading
ATS_DYNLOADFLAG 0 // at run-time
//
// HX-2017-03-28:
#define // prefix for external
ATS_EXTERN_PREFIX "atslib_" // names
//  
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/stklist.sats"

(* ****** ****** *)
//
assume
stklist_vtype
  (a:vt0p, n:int) = aPtr1(list_vt(a, n))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
stklist_make_nil
  {a}((*void*)) =
(
aptr_make_elt<
  list_vt(a,0)>(list_vt_nil(*void*))
) (* stklist_make_nil *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
stklist_getfree
  {a}{n}(stk) =
  aptr_getfree_elt<list_vt(a,n)>(stk)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
stklist_is_nil
  {a}{n}(stk) = isnil where
{
//
val p0 = $UN.castvwtp1{ptr}(stk)
//
val xs = $UN.ptr0_get<list_vt(a,n)>(p0)
//
val isnil = list_vt_is_nil(xs)
prval ((*void*)) = $UN.cast2void(xs)
//
} (* end of [stklist_is_nil] *)
//
implement
{}(*tmp*)
stklist_isnot_nil
  {a}{n}(stk) = iscons where
{
//
val p0 = $UN.castvwtp1{ptr}(stk)
//
val xs = $UN.ptr0_get<list_vt(a,n)>(p0)
//
val iscons = list_vt_is_cons(xs)
prval ((*void*)) = $UN.cast2void(xs)
//
} (* end of [stklist_isnot_nil] *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stklist_insert
  {n}(stk, x0) = let
//
prval
((*n>=0*)) =
lemma_stklist_param(stk)
//
val xs =
aptr_get_elt<list_vt(a,n)>(stk)
val xs = list_vt_cons(x0, xs)
//
in
  aptr_set_elt<list_vt(a,n+1)>(stk, xs)
end // end of [stklist_insert]
//
(* ****** ****** *)

implement
{a}(*tmp*)
stklist_takeout
  {n}(stk) = x0 where
{
//
val xs =
aptr_get_elt<list_vt(a,n)>(stk)
//
val+~list_vt_cons(x0, xs) = xs
val () = aptr_set_elt<list_vt(a,n-1)>(stk, xs)
//
} (* end of [stklist_takeout] *)

(* ****** ****** *)

implement
{a}(*tmp*)
stklist_takeout_opt
  (stk) = let
//
prval
((*n>=0*)) =
lemma_stklist_param(stk)
//
val xs =
aptr_get_elt<List0_vt(a)>(stk)
//
in
//
case+ xs of
| list_vt_nil
  (
  ) => None_vt() where
  {
    val () = aptr_set_elt(stk, xs)
  } (* end of [list_vt_nil] *)
| ~list_vt_cons
  (
    x0, xs
  ) => Some_vt(x0) where
  {
    val () = aptr_set_elt(stk, xs)
  } (* end of [list_vt_nil] *)
//
end // end of [stklist_takeout_opt]

(* ****** ****** *)

(* end of [stklist.dats] *)
