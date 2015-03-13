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
(* Start time: March, 2015 *)

(* ****** ****** *)
//
// HX-2015-03-12:
// For quickly building a hashmap interface
//
(* ****** ****** *)
//
(*
typedef elt = int/...
*)
//
(* ****** ****** *)
//
abstype
myset_type = ptr
//
typedef
myset = myset_type
//
(* ****** ****** *)
//
extern
fun
myfunset_make_nil():<> myset
extern
fun
myfunset_make_sing(elt): myset
//
(* ****** ****** *)

extern
fun
myfunset_make_list(List(elt)): myset

(* ****** ****** *)
//
extern
fun
fprint_myfunset
  (out: FILEref, xs: myset): void
//
overload fprint with fprint_myfunset
//
(* ****** ****** *)
//
extern
fun
myfunset_size(myset): size_t
//
overload .size with myfunset_size
//
(* ****** ****** *)
//
extern
fun
myfunset_is_member(myset, elt): bool
and
myfunset_isnot_member(myset, elt): bool
//
overload .is_member with myfunset_is_member
overload .isnot_member with myfunset_isnot_member
//
(* ****** ****** *)
//
extern
fun
myfunset_insert
  (xs: &myset >> _, x0: elt): bool
//
overload .insert with myfunset_insert
//
(* ****** ****** *)
//
extern
fun
myfunset_remove
  (xs: &myset >> _, x0: elt): bool
//
overload .remove with myfunset_remove
//
(* ****** ****** *)
//
extern
fun
myfunset_foreach_cloref
  (xs: myset, fwork: (elt) -<cloref1> void): void
//
overload .foreach_cloref with myfunset_foreach_cloref
//
(* ****** ****** *)
//
extern
fun
{res:t@ype}
myfunset_foldleft_cloref
(
  xs: myset, ini: res, fopr: (res, elt) -<cloref1> res
) : res // end of [myfunset_foldleft_cloref]
//
(*
overload .foldleft_cloref with myfunset_foldleft_cloref
*)
//
(* ****** ****** *)
//
extern
fun
myfunset_listize(myset): List0(elt)
//
overload .listize with myfunset_listize
//
(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/funset.sats"
//
staload _ = "libats/DATS/funset_avltree.dats"
//
staload _(*anon*) = "libats/ML/DATS/funset.dats"
//
assume myset_type = set_type(elt)
//
in (* in-of-local *)
//
implement
myfunset_make_nil() = funset_make_nil{elt}()
implement
myfunset_make_sing(x) = funset_make_sing<elt>(x)
implement
myfunset_make_list(xs) = funset_make_list<elt>(g0ofg1(xs))
//
implement
fprint_myfunset(out, xs) = fprint_funset<elt>(out, xs)
//
implement
myfunset_size(xs) = funset_size<elt>(xs)
//
implement
myfunset_is_member
  (xs, x0) = funset_is_member<elt>(xs, x0)
implement
myfunset_isnot_member
  (xs, x0) = funset_isnot_member<elt>(xs, x0)
//
implement
myfunset_insert(xs, x0) = funset_insert<elt>(xs, x0)
//
implement
myfunset_remove(xs, x0) = funset_remove<elt>(xs, x0)
//
implement
myfunset_foreach_cloref
  (xs, fwork) = funset_foreach_cloref<elt> (xs, fwork)
//
implement
{res}(*tmp*)
myfunset_foldleft_cloref
  (xs, ini, fopr) = r0 where
{
//
var r0: res = ini
val p_r0 = addr@r0
val ((*void*)) =
myfunset_foreach_cloref
(
  xs, lam(x) => $UN.ptr0_set<res>(p_r0, fopr($UN.ptr0_get<res>(p_r0), x))
) (* end of [myfunset_foreach_cloref] *) // end of [val]
//
} (* end of [myfunset_foldleft_cloref] *)
//
implement
myfunset_listize(xs) = g1ofg0(funset_listize<elt>(xs))
//
end // end of [local]

(* ****** ****** *)

(* end of [myfunset.hats] *)
