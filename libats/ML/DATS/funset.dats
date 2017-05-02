(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: December, 2012 *)

(* ****** ****** *)
//
// HX-2012-12: the set implementation is based on AVL trees
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
FS =
"libats/SATS/funset_avltree.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/ML/SATS/funset.sats"

(* ****** ****** *)

implement{a}
compare_elt_elt = gcompare_val_val<a>
implement{a}
$FS.compare_elt_elt = compare_elt_elt<a>

(* ****** ****** *)

assume set_type (a:t0p) = $FS.set (a)

(* ****** ****** *)

implement{}
funset_nil () = $FS.funset_nil ()
implement{}
funset_make_nil () = $FS.funset_make_nil ()

(* ****** ****** *)

implement{a}
funset_sing (x) = $FS.funset_sing<a> (x)
implement{a}
funset_make_sing (x) = $FS.funset_make_sing<a> (x)

(* ****** ****** *)

implement{a}
funset_make_list
  (xs) = let
//
val xs = g1ofg0_list(xs)
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_make_list<a>(xs)
end // end of [funset_make_list]

(* ****** ****** *)
//
implement{}
fprint_funset$sep
  (out) =
  fprint_string (out, ", ")
//
implement{a}
fprint_funset
  (out, xs) = let
//
implement
$FS.fprint_funset$sep<>
  (out) = fprint_funset$sep<>(out)
//
in
  $FS.fprint_funset<a>(out, xs)
end // end of [fprint_funset]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
funset_is_nil
  (xs) = $FS.funset_is_nil<>(xs)
implement
{}(*tmp*)
funset_isnot_nil
  (xs) = $FS.funset_isnot_nil<>(xs)
//
(* ****** ****** *)

implement
{a}(*tmp*)
funset_size(xs) = $FS.funset_size<a>(xs)

(* ****** ****** *)
//
implement
{a}(*tmp*)
funset_is_member
  (xs, x0) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_is_member<a>(xs, x0)
end // end of [funset_is_member]
//
implement
{a}(*tmp*)
funset_isnot_member
  (xs, x0) = ~funset_is_member<a>(xs, x0)
//
(* ****** ****** *)

implement
{a}(*tmp*)
funset_insert
  (xs, x0) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_insert<a>(xs, x0)
end // end of [funset_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_remove
  (xs, x0) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_remove<a>(xs, x0)
end // end of [funset_remove]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_getmax_opt = $FS.funset_getmax_opt<a>
implement
{a}(*tmp*)
funset_getmin_opt = $FS.funset_getmin_opt<a>

(* ****** ****** *)

implement
{a}(*tmp*)
funset_takeoutmax_opt = $FS.funset_takeoutmax_opt<a>
implement
{a}(*tmp*)
funset_takeoutmin_opt = $FS.funset_takeoutmin_opt<a>

(* ****** ****** *)

implement
{a}(*tmp*)
funset_union
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_union<a>(xs1, xs2)
end // end of [funset_union]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_intersect
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_intersect<a>(xs1, xs2)
end // end of [funset_intersect]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_differ
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_differ<a>(xs1, xs2)
end // end of [funset_differ]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_symdiff
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_symdiff<a>(xs1, xs2)
end // end of [funset_symdiff]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_equal
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_equal<a>(xs1, xs2)
end // end of [funset_equal]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_compare
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_compare<a>(xs1, xs2)
end // end of [funset_compare]

(* ****** ****** *)
//
implement
{a}(*tmp*)
funset_is_subset
  (xs1, xs2) = let
//
implement
$FS.compare_elt_elt<a> = compare_elt_elt<a>
//
in
  $FS.funset_is_subset<a>(xs1, xs2)
end // end of [funset_is_subset]
//
implement
{a}(*tmp*)
funset_is_supset
  (xs1, xs2) = funset_is_subset<a>(xs2, xs1)
//
(* ****** ****** *)

implement
{a}(*tmp*)
funset_foreach(xs) = let
//
var env: void = ((*void*))
//
in
  funset_foreach_env<a><void>(xs, env)
end // end of [funset_foreach]

implement
{a}{env}
funset_foreach_env(xs, env) = let
//
implement
$FS.funset_foreach$fwork<a><env>
  (x, env) = funset_foreach$fwork<a><env>(x, env)
//
in
  $FS.funset_foreach_env<a><env>(xs, env)
end // end of [funset_foreach_env]

implement
{a}(*tmp*)
funset_foreach_cloref
  (xs, fwork) = let
//
var env: void = ((*void*))
//
implement
(env)(*tmp*)
$FS.funset_foreach$fwork<a><env>(x, env) = fwork(x)
//
in
  $FS.funset_foreach_env<a><void> (xs, env)
end // end of [funset_foreach_cloref]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_tabulate_cloref
  {n}(n, fopr) = let
//
implement
$FS.funset_tabulate$fopr<a>(i) = fopr($UN.cast{natLt(n)}(i))
//
in
  $FS.funset_tabulate<a> (n)
end // end of [funset_tabulate]

(* ****** ****** *)
//
implement
{a}(*tmp*)
funset_listize
  (xs) = (
//
$effmask_wrt
(
  list0_of_list_vt{a}($FS.funset_listize<a>(xs))
) (* $effmask_wrt *)
//
) (* funset_listize *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
funset_streamize
  (xs) = $effmask_wrt($FS.funset_streamize<a>(xs))
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
funset_make_module
  ((*void*)) = $rec
{
//
nil = funset_nil{a}
,
sing = funset_sing<a>
,
make_list = funset_make_list<a>
,
size = funset_size<a>
,
is_nil = funset_is_nil{a}
,
isnot_nil = funset_isnot_nil{a}
,
insert= funset_insert<a>
,
remove= funset_remove<a>
,
union= funset_union<a>
,
intersect= funset_intersect<a>
,
listize = funset_listize<a>
,
streamiize = funset_streamize<a>
//
} (* end of [funset_make_module] *)
//
(* ****** ****** *)

(* end of [funset.dats] *)
