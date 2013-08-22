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
// HX: shared by linmap_list
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement{key}
equal_key_key = gequal_val<key>
implement{key}
compare_key_key = gcompare_val<key>

(* ****** ****** *)

implement
{key,itm}
linmap_search
  (t, k0, res) = let
//
val p = linmap_search_ref (t, k0)
//
in
//
if cptr2ptr(p) > 0 then let
  val (pf, fpf | p) = $UN.cptr_vtake (p)
  val () = res := !p
  prval () = fpf (pf)
  prval () = opt_some {itm} (res)
in
  true
end else let
  prval () = opt_none {itm} (res)
in
  false
end // end of [if]
//
end // end of [linmap_search]

(* ****** ****** *)

implement
{key,itm}
linmap_search_opt
  (map, k0) = let
//
var res: itm?
val ans = linmap_search (map, k0, res)
//
in
//
if ans then let
  prval () = opt_unsome {itm} (res)
in
  Some_vt {itm} (res)
end else let
  prval () = opt_unnone {itm} (res)
in
  None_vt {itm} ((*void*))
end // end of [if]
//
end // end of [linmap_search_opt]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
//
val p0 = linmap_search_ngc (map, k0)
//
viewtypedef mynode1 = mynode1 (key,itm)
//
in
//
if p0 > 0 then let
//
val nx = $UN.castvwtp0{mynode1}{ptr}(p0)
val p_elt = mynode_getref_itm<key,itm> (nx)
val p0 = $UN.castvwtp0{ptr}{mynode1}(nx)
//
in
  p_elt
end else cptr_null () // end of [if]
//
end // end of [linmap_search_ref]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_opt
  (map, k0, x0) = let
//
var res: itm?
val ans = linmap_insert (map, k0, x0, res)
//
in
//
if ans then let
  prval () = opt_unsome {itm} (res)
in
  Some_vt {itm} (res)
end else let
  prval () = opt_unnone {itm} (res)
in
  None_vt {itm} ((*void*))
end // end of [if]
//
end // end of [linmap_insert_opt]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout
  (map, k0, res) = let
//
val nx =
  linmap_takeout_ngc (map, k0)
val p_nx = mynode2ptr (nx)
//
in
//
if p_nx > 0 then let
  val () =
    res := mynode_getfree_itm (nx)
  // end of [val]
  prval () = opt_some {itm} (res) in true
end else let
  prval () = mynode_free_null (nx)
  prval () = opt_none {itm} (res) in false
end // end of [if]
//
end // end of [linmap_takeout]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout_opt
  (map, k0) = let
//
var res: itm?
val ans = linmap_takeout (map, k0, res)
//
in
//
if ans then let
  prval () = opt_unsome {itm} (res)
in
  Some_vt{itm}(res)
end else let
  prval () = opt_unnone {itm} (res)
in
  None_vt{itm}((*void*))
end // end of [if]
//
end // end of [linmap_takeout_opt]

(* ****** ****** *)

implement
{key,itm}
linmap_remove
  (map, k0) = let
//
var res: itm
val takeout =
  linmap_takeout<key,itm> (map, k0, res)
prval () = opt_clear (res)
//
in
  takeout(*removed*)
end // end of [linmap_remove]

(* ****** ****** *)

implement
{key,itm}
linmap_free (map) = let
//
implement
linmap_freelin$clear<itm> (x) = ()
//
in
  linmap_freelin<key,itm> (map)
end // end of [linmap_free]

(* ****** ****** *)

implement{}
fprint_linmap$sep (out) = fprint (out, "; ")
implement{}
fprint_linmap$mapto (out) = fprint (out, "->")

implement
{key,itm}
fprint_linmap
  (out, map) = let
//
implement
linmap_foreach$fwork<key,itm><int>
  (k, x, env) = {
  val () = if env > 0 then fprint_linmap$sep (out)
  val () = env := env + 1
  val () = fprint_val<key> (out, k)
  val () = fprint_linmap$mapto (out)
  val () = fprint_val<itm> (out, x)
} (* end of [linmap_foreach$fwork] *)
//
var env: int = 0
//
in
  linmap_foreach_env<key,itm><int> (map, env)
end // end of [fprint_linmap]

(* ****** ****** *)

implement
{key,itm}
linmap_foreach
  (map) = let
  var env: void = () in
  linmap_foreach_env<key,itm><void> (map, env)
end // end of [linmap_foreach]

(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in (* in of [local] *)

implement
{key,itm}
linmap_listize1
  (map) = let
//
vtypedef ki = @(key, itm)
vtypedef tenv = $Q.qstruct (ki)
//
implement
linmap_foreach$fwork<key,itm><tenv>
  (k, x, env) = let
in
  $Q.qstruct_insert<ki> (env, @(k, x))
end // end of [linmap_foreach$fwork]
//
var env: $Q.qstruct
val () = $Q.qstruct_initize{ki}(env)
val () = $effmask_all (linmap_foreach_env<key,itm><tenv> (map, env))
val res = $Q.qstruct_takeout_list (env)
prval () = $Q.qstruct_uninitize{ki}(env)
//
in
  res
end // end of [linmap_listize1]

end // end of [local]

(* ****** ****** *)

(* end of [linmap.hats] *)
