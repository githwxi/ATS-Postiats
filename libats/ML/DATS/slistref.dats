(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail:
   gmmhwxiATgmailDOTcom *)
(* Start time: November, 2016 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/slistref.sats"
//
(* ****** ****** *)
//
stadef
slist =
lam(a:vt0ype) => List_vt(a)
//
(* ****** ****** *)
//
assume
slistref_vt0ype_type
  (a:vt0ype) = ref(slist(a))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
slistref_make_nil
  {a}((*void*)) =
  ref<slist(a)>(list_vt_nil())
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
slistref_is_nil
  (stk) =
  list_vt_is_nil(!p) where
{
//
val
(
vbox(pf) | p
) = ref_get_viewptr(stk)
//
} (* end of [slistref_is_nil] *)
//
implement
{a}(*tmp*)
slistref_is_cons
  (stk) =
  list_vt_is_cons(!p) where
{
//
val
(
vbox(pf) | p
) = ref_get_viewptr(stk)
//
} (* end of [slistref_is_cons] *)
implement
{a}(*tmp*)
slistref_isnot_nil
  (stk) =
  list_vt_is_cons(!p) where
{
//
val
(
vbox(pf) | p
) = ref_get_viewptr(stk)
//
} (* end of [slistref_isnot_nil] *)
//
(* ****** ****** *)

implement
{a}(*tmp*)
slistref_length
  (stk) =
  list_vt_length(!p) where
{
//
val
(
vbox(pf) | p
) = ref_get_viewptr(stk)
//
prval() = lemma_list_vt_param(!p)
//
} (* end of [slistref_length] *)  

(* ****** ****** *)
//
implement
{a}(*tmp*)
slistref_insert
  (stk, x0) = () where
{
//
val
(
vbox(pf) | p
) = ref_get_viewptr(stk)
//
prval
(
// argless
) = lemma_list_vt_param(!p)
//
val () =
$effmask_wrt
  (!p := list_vt_cons(x0, !p))
//
} (* end of [slistref_insert] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
slistref_takeout_opt
  (stk) = let
//
val
(
vbox(pf) | p
) = ref_get_viewptr(stk)
//
in
//
case+ !p of
|  list_vt_nil() => None_vt()
| ~list_vt_cons(x0, xs) =>
   $effmask_wrt(!p := xs; Some_vt(x0))
//
end (* end of [slistref_takeout_opt] *)
//
(* ****** ****** *)

(* end of [slistref.dats] *)
