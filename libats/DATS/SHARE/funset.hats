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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: December, 2012 *)

(* ****** ****** *)

implement
{a}(*tmp*)
compare_elt_elt = gcompare_val_val<a>

(* ****** ****** *)

implement
{}(*tmp*)
funset_isnot_nil (xs) = not(funset_is_nil (xs))

(* ****** ****** *)

implement
{a}(*tmp*)
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
var set: set = funset_make_nil ()
//
val ((*void*)) = $effmask_all (loop (set, xs))
//
} // end of [funset_make_list]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_isnot_member
  (xs, x0) = not (funset_is_member<a> (xs, x0))
// end of [funset_isnot_member]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_getmax_opt
  (xs) = let
//
var x0: a?
val ans =
  $effmask_wrt (funset_getmax<a> (xs, x0))
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [funset_getmax_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_getmin_opt
  (xs) = let
//
var x0: a?
val ans =
  $effmask_wrt (funset_getmin<a> (xs, x0))
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [funset_getmin_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
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
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [funset_takeoutmax_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
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
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [funset_takeoutmin_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_equal
  (xs1, xs2) = let
  val sgn = funset_compare<a> (xs1, xs2) in sgn = 0
end // end of [funset_equal]

(* ****** ****** *)
//
implement
{a}(*tmp*)
funset_is_supset
  (xs1, xs2) = funset_is_subset<a>(xs2, xs1)
//
(* ****** ****** *)

implement
{a}(*tmp*)
funset_foreach (xs) = let
//
var env: void = () in funset_foreach_env<a><void> (xs, env)
//
end // end of [funset_foreach]

(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_funset$sep
  (out) = fprint_string (out, ", ")
//
implement
{a}(*tmp*)
fprint_funset
  (out, xs) = let
//
implement
funset_foreach$fwork<a><int>
  (x, env) = {
  val () =
  if env > 0
    then fprint_funset$sep (out)
  // end of [val]
  val () = env := env + 1
  val () = fprint_val<a> (out, x)
} (* end of [funset_foreach$fwork] *)
//
var env: int = 0
//
in
  funset_foreach_env<a><int> (xs, env)
end // end of [fprint_funset]
//
implement
{a}(*tmp*)
fprint_funset_sep
  (out, xs, sep) = let
//
implement{}
fprint_funset$sep(out) = fprint_string(out, sep)
//
in
  fprint_funset<a> (out, xs)
end // end of [fprint_set]
//
(* ****** ****** *)

implement
{a}(*tmp*)
funset_tabulate
  {n}(n) = res where
{
//
fun
loop
{ i:nat
| i <= n
} .<n-i>.
(
  i: int(i), n: int(n), res: &set(a) >> _
) : void = (
//
if
i < n
then let
//
val x(*a*) =
  funset_tabulate$fopr<a> (i)
//
val _(*bool*) = funset_insert<a>(res, x)
//
in
  loop(i+1, n, res)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
var
res: set(a) = funset_make_nil()
//
val ((*void*)) = loop(0, n, res)
//
} (* end of [funset_tabulate] *)

(* ****** ****** *)

implement
{a}(*tmp*)
funset_listize
  (xs) = let
//
implement
funset_flistize$fopr<a><a>(x) = x
//
in
  $effmask_all(funset_flistize<a>(xs))
end // end of [funset_listize]

(* ****** ****** *)

local
//
staload Q =
"libats/SATS/qlist.sats"
//
in (* in of [local] *)

implement
{a}{b}(*tmp*)
funset_flistize
  (xs) = res where
{
//
vtypedef
tenv = $Q.qstruct(b)
//
implement
(env)(*tmp*)
funset_foreach$fwork<a><env>
  (x, env) = let
//
val
(pf, fpf | p) =
$UN.ptr_vtake{tenv}(addr@(env))
//
val y =
  funset_flistize$fopr<a><b>(x)
//
val () = $Q.qstruct_insert<b>(!p, y)
//
prval ((*returned*)) = fpf( pf )
//
in
  // nothing
end (* end of [funset_foreach$fwork] *)
//
var env: $Q.qstruct
//
val () = $Q.qstruct_initize{b}(env)
val () = funset_foreach_env<a><tenv>(xs, env)
//
val res = $Q.qstruct_takeout_list(env)
//
prval () = lemma_list_vt_param(res)
prval () = $Q.qstruct_uninitize{b}(env)
//
} (* end of [funset_flistize] *)

end // end of [local]

(* ****** ****** *)

(* end of [funset.hats] *)
