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
linset_insert_ngc
  (set, nx0) = let
//
val p = mynode2ptr (nx0)
//
implement{a}
mynode_make_elt (x0) = $UN.castvwtp0{mynode1(a)}(p)
//
val x0 = mynode_get_elt (nx0)
val ans = linset_insert (set, x0)
//
in (* in of [let] *)
//
if ans
then nx0 else let
  prval () = $UN.cast2void(nx0) in mynode_null{a}((*void*))
end // end of [if]
//
end // end of [linset_insert_ngc]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_remove
  (xs, x0) = let
//
val nx =
  linset_takeout_ngc (xs, x0)
val p_nx = mynode2ptr (nx)
//
in
//
if p_nx > 0
  then let
    val () = mynode_free (nx) in true
  end // end of [then]
  else let
    prval () = mynode_free_null (nx) in false
  end // end of [else]
// end of [if]
//
end // end of [linset_remove]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeout
  (xs, x0, res) = let
//
val nx =
  linset_takeout_ngc (xs, x0)
val p_nx = mynode2ptr (nx)
//
in
//
if p_nx > 0 then let
  val () =
    res := mynode_getfree_elt (nx)
  // end of [val]
  prval () = opt_some{a}(res) in true
end else let
  prval () = mynode_free_null (nx)
  prval () = opt_none{a}(res) in false
end // end of [if]
//
end // end of [linset_takeout]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeoutmax
  (xs, res) = let
//
val nx =
  linset_takeoutmax_ngc (xs)
val p_nx = mynode2ptr (nx)
//
in
//
if p_nx > 0 then let
  val () =
    res := mynode_getfree_elt (nx)
  // end of [val]
  prval () = opt_some{a}(res) in true
end else let
  prval () = mynode_free_null (nx)
  prval () = opt_none{a}(res) in false
end // end of [if]
//
end // end of [linset_takeoutmax]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeoutmin
  (xs, res) = let
//
val nx =
  linset_takeoutmin_ngc (xs)
val p_nx = mynode2ptr (nx)
//
in
//
if p_nx > 0 then let
  val () =
    res := mynode_getfree_elt (nx)
  // end of [val]
  prval () = opt_some{a}(res) in true
end else let
  prval () = mynode_free_null (nx)
  prval () = opt_none{a}(res) in false
end // end of [if]
//
end // end of [linset_takeoutmin]

(* ****** ****** *)

(* end of [linset_node.hats] *)
