(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: February, 2013 *)

(* ****** ****** *)
//
// HX-2013-08:
// a set is represented as a sorted list in descending order;
// note that descending order is chosen to faciliate set comparison
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linset_listord.sats"

(* ****** ****** *)

#include "./SHARE/linset.hats" // code reuse

(* ****** ****** *)

assume
set_vtype (elt:t@ype) = List0_vt (elt)

(* ****** ****** *)

implement{}
linset_nil () = list_vt_nil ()
implement{}
linset_make_nil () = list_vt_nil ()

(* ****** ****** *)

implement{a}
linset_make_sing
  (x) = list_vt_cons{a}(x, list_vt_nil)
// end of [linset_make_sing]

(* ****** ****** *)

implement{}
linset_is_nil (xs) = list_vt_is_nil (xs)
implement{}
linset_isnot_nil (xs) = list_vt_is_cons (xs)

(* ****** ****** *)

implement{a}
linset_size (xs) =
  let val n = list_vt_length(xs) in i2sz(n) end
// end of [linset]

(* ****** ****** *)

implement{a}
linset_is_member
  (xs, x0) = let
//
fun aux
  {n:nat} .<n>.
(
  xs: !list_vt (a, n)
) :<> bool = let
in
//
case+ xs of
| list_vt_cons (x, xs) => let
    val sgn = compare_elt_elt<a> (x0, x) in
    if sgn > 0 then false else (if sgn < 0 then aux (xs) else true)
  end // end of [list_vt_cons]
| list_vt_nil ((*void*)) => false
//
end // end of [aux]
//
in
  aux (xs)
end // end of [linset_is_member]

(* ****** ****** *)

implement{a} linset_copy (xs) = list_vt_copy<a> (xs)

(* ****** ****** *)

implement{a} linset_free (xs) = list_vt_free<a> (xs)

(* ****** ****** *)

implement{a}
linset_insert
  (xs, x0) = let
//
fun ins
  {n:nat} .<n>. // tail-recursive
(
  xs: &list_vt (a, n) >> list_vt (a, n1)
) : #[n1:nat | n <= n1; n1 <= n+1] bool =
(
case+ xs of
| @list_vt_cons
    (x, xs1) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn > 0 then let
      prval () = fold@ (xs)
      val ((*void*)) = xs := list_vt_cons{a}(x0, xs)
    in
      false
    end else if sgn < 0 then let
      val ans = ins (xs1)
      prval () = fold@ (xs)
    in
      ans
    end else let
      prval () = fold@ (xs)
    in
      true (* [x0] in [xs] *)
    end (* end of [if] *)
  end // end of [list_vt_cons]
| list_vt_nil () => let
    val ((*void*)) = xs := list_vt_cons{a}(x0, xs)
  in
    false
  end // end of [list_vt_nil]
) (* end of [ins] *)
//
in
  $effmask_all (ins (xs))
end // end of [linset_insert]

(* ****** ****** *)

implement{a}
linset_remove
  (xs, x0) = let
//
fun rem
  {n:nat} .<n>. // tail-recursive
(
  xs: &list_vt (a, n) >> list_vt (a, n1)
) : #[n1:nat | n1 <= n; n <= n1+1] bool =
(
case+ xs of
| @list_vt_cons
    (x, xs1) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn > 0 then let
      prval () = fold@ (xs)
    in
      false
    end else if sgn < 0 then let
      val ans = rem (xs1)
      prval () = fold@ (xs)
    in
      ans
    end else let // x0 = x
      val xs1_ = xs1
      val ((*void*)) = free@{a}{0}(xs)
      val () = xs := xs1_
    in
      true // [x0] in [xs]
    end (* end of [if] *)
  end // end of [list_vt_cons]
| list_vt_nil () => false
) (* end of [rem] *)
//
in
  $effmask_all (rem (xs))
end // end of [linset_remove]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeoutmax
  (xs, res) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs1) => let
    val () = xs := xs1
    val () = res := x
    prval () = opt_some{a}(res)
  in
    true
  end // end of [list_vt_cons]
| @list_vt_nil () => let
    prval () = fold@ (xs)
    prval () = opt_none{a}(res)
  in
    false
  end // end of [list_vt_nil]
//
end // end of [linset_takeoutmax]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeoutmin
  (xs, res) = let
in
//
case+ xs of
| list_vt_cons _ => let
    val x =
      list_vt_unextend (xs)
    val () = res := x
    prval () = opt_some{a}(res)
  in
    true
  end // end of [list_vt_cons]
| list_vt_nil () => let
    prval () = opt_none{a}(res)
  in
    false
  end // end of [list_vt_nil]
//
end // end of [linset_takeoutmin]

(* ****** ****** *)

implement
{a}{env}
linset_foreach_env (xs, env) = let
//
implement
list_vt_foreach$fwork<a><env>
  (x, env) = linset_foreach$fwork<a><env> (x, env)
//
in
  list_vt_foreach_env<a><env> (xs, env)
end // end of [linset_foreach_env]

(* ****** ****** *)

implement{a}
linset_listize (xs) = xs

(* ****** ****** *)

implement{a}
linset_listize1 (xs) = list_vt_copy (xs)

(* ****** ****** *)

(* end of [linset_listord.dats] *)
