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
(* Start time: August, 2013 *)

(* ****** ****** *)
//
// HX: shared by linset_listord (* ordered list *)
// HX: shared by linset_avltree (* AVL-tree-based *)
//
(* ****** ****** *)

implement{a}
compare_elt_elt = gcompare_val_val<a>

(* ****** ****** *)

implement{a}
linset_make_list
  (xs) = res where
{
//
fun loop
(
  xs: List (a), res: &set(a) >> _
) : void = 
(
case+ xs of
| list_cons
    (x, xs) => let
    val _(*exi*) =
      linset_insert (res, x) in loop (xs, res)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
)
//
var res: set(a) = linset_nil ()
val () = $effmask_all (loop (xs, res))
//
} // end of [linset_make_list]

(* ****** ****** *)

implement{a}
linset_isnot_member (xs, x0) = ~linset_is_member (xs, x0)

(* ****** ****** *)

implement{a}
linset_choose_opt
  (xs) = let
//
var x0: a?
val ans = linset_choose<a> (xs, x0)
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [linset_choose_opt]

(* ****** ****** *)

implement{a}
linset_takeoutmax_opt
  (xs) = let
//
var x0: a?
val ans = linset_takeoutmax<a> (xs, x0)
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [linset_takeoutmax_opt]

(* ****** ****** *)

implement{a}
linset_takeoutmin_opt
  (xs) = let
//
var x0: a?
val ans =
  $effmask_wrt (linset_takeoutmin<a> (xs, x0))
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [linset_takeoutmin_opt]

(* ****** ****** *)

implement{}
fprint_linset$sep
  (out) = fprint_string (out, ", ")
implement
{a}(*tmp*)
fprint_linset
  (out, xs) = let
//
implement
linset_foreach$fwork<a><int>
  (x, env) = {
  val () = if env > 0 then fprint_linset$sep (out)
  val () = env := env + 1
  val () = fprint_val<a> (out, x)
} (* end of [linset_foreach$fwork] *)
//
var env: int = 0
//
in
  linset_foreach_env<a><int> (xs, env)
end // end of [fprint_linset]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_foreach (xs) = let
//
var env: void = () in linset_foreach_env<a><void> (xs, env)
//
end // end of [linset_foreach]

(* ****** ****** *)

(* end of [linset.hats] *)
