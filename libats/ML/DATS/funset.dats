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
//
// HX-2012-12: the set implementation is based on AVL trees
//
(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload FS =
  "libats/SATS/funset_avltree.sats"
// end of [FS]

(* ****** ****** *)

staload "libats/ML/SATS/funset.sats"

(* ****** ****** *)

assume set_t0ype_type (a:t0p) = $FS.set (a)

(* ****** ****** *)

implement{a}
funset_is_member
  (xs, x0, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_is_member (xs, x0)
end // end of [funset_is_member]

implement{a}
funset_isnot_member
  (xs, x0, cmp) = ~funset_is_member (xs, x0, cmp)
// end of [funset_isnot_member]

(* ****** ****** *)

implement{a}
funset_insert
  (xs, x0, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $effmask_all ($FS.funset_insert (xs, x0))
end // end of [funset_insert]

(* ****** ****** *)

implement{a}
funset_remove
  (xs, x0, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $effmask_all ($FS.funset_remove (xs, x0))
end // end of [funset_remove]

(* ****** ****** *)

implement{a}
funset_union
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_union (xs1, xs2)
end // end of [funset_union]

implement{a}
funset_intersect
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_intersect (xs1, xs2)
end // end of [funset_intersect]

implement{a}
funset_diff
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_diff (xs1, xs2)
end // end of [funset_diff]

implement{a}
funset_symdiff
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_symdiff (xs1, xs2)
end // end of [funset_symdiff]

(* ****** ****** *)

implement{a}
funset_is_equal
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_is_equal (xs1, xs2)
end // end of [funset_is_equal]

(* ****** ****** *)

implement{a}
funset_is_subset
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_is_subset (xs1, xs2)
end // end of [funset_is_subset]

implement{a}
funset_is_supset
  (xs1, xs2, cmp) = funset_is_subset (xs2, xs1, cmp)
// end of [funset_is_supset]

(* ****** ****** *)

implement{a}
funset_compare
  (xs1, xs2, cmp) = let
//
implement
$FS.compare_elt_elt<a> (x1, x2) = cmp (x1, x2)
//
in
  $FS.funset_compare (xs1, xs2)
end // end of [funset_compare]

(* ****** ****** *)

implement{a}
funset_listize (xs) = let
  val ys = $FS.funset_listize (xs) in list0_of_list_vt (ys)
end // end of [funset_listize]

(* ****** ****** *)

(* end of [funset.dats] *)
