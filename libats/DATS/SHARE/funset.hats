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
(* Start time: December, 2012 *)

(* ****** ****** *)

implement{a}
compare_elt_elt
  (x1, x2) = gcompare_val<a> (x1, x2)
// end of [compare_elt_elt]

(* ****** ****** *)

implement{}
funset_isnot_empty
  (xs) = not (funset_is_empty<> (xs))
// end of [funset_isnot_empty]

(* ****** ****** *)

implement{a}
funset_make_list
  (xs) = set where {
//
typedef set = set (a)
//
fun loop (
  set: &set >> _, xs: List (a)
) : void = let
in
  case+ xs of
  | list_cons (x, xs) => let
      val _(*exi*) = funset_insert<a> (set, x) in loop (set, xs)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [loop]
//
var set
  : set = funset_make_nil ()
//
val () = $effmask_all (loop (set, xs))
//
} // end of [funset_make_list]

(* ****** ****** *)

implement{a}
funset_isnot_member
  (xs, x0) = not (funset_is_member<a> (xs, x0))
// end of [funset_isnot_member]

(* ****** ****** *)

implement{a}
funset_takeoutmax_opt
  (xs) = let
//
var x0: a?
val ans =
  $effmask_wrt (funset_takeoutmax<a> (xs, x0))
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt (*void*)
end (* end of [if] *)
//
end // end of [funset_takeoutmax_opt]

(* ****** ****** *)

implement{a}
funset_takeoutmin_opt
  (xs) = let
//
var x0: a?
val ans =
  $effmask_wrt (funset_takeoutmin<a> (xs, x0))
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt (*void*)
end (* end of [if] *)
//
end // end of [funset_takeoutmin_opt]

(* ****** ****** *)

implement{a}
funset_is_supset
  (xs1, xs2) = funset_is_subset<a> (xs2, xs1)
// end of [funset_is_supset]

(* ****** ****** *)

implement{a}
funset_is_equal (xs1, xs2) = let
  val sgn = funset_compare<a> (xs1, xs2) in sgn = 0
end // end of [funset_equal]

(* ****** ****** *)

(* end of [funset.hats] *)
