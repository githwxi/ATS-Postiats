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

implement{}
funmap_isnot_nil
  (xs) = not (funmap_is_nil<> (xs))
// end of [funmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
funmap_search_opt
  (map, k0) = let
  var res: itm?
  val ans = funmap_search (map, k0, res)
in
//
if ans then let
  prval () = opt_unsome {itm} (res)
in
  Some_vt (res)
end else let
  prval () = opt_unnone {itm} (res)
in
  None_vt (*void*)
end // end of [if]
//
end // end of [funmap_search_opt]

(* ****** ****** *)

implement
{key,itm}
funmap_insert_opt
  (map, k0, x0) = let
  var res: itm?
  val ans = funmap_insert (map, k0, x0, res)
in
//
if ans then let
  prval () = opt_unsome {itm} (res)
in
  Some_vt (res)
end else let
  prval () = opt_unnone {itm} (res)
in
  None_vt (*void*)
end // end of [if]
//
end // end of [funmap_insert_opt]

(* ****** ****** *)

implement
{key,itm}
funmap_takeout_opt
  (map, k0) = let
  var res: itm?
  val ans = funmap_takeout (map, k0, res)
in
//
if ans then let
  prval () = opt_unsome {itm} (res)
in
  Some_vt (res)
end else let
  prval () = opt_unnone {itm} (res)
in
  None_vt (*void*)
end // end of [if]
//
end // end of [funmap_takeout_opt]

(* ****** ****** *)

implement
{key,itm}
funmap_remove
  (map, k0) = let
  var res: itm
  val takeout = funmap_takeout<key,itm> (map, k0, res)
  prval () = opt_clear (res)
in
  takeout(*removed*)
end // end of [funmap_remove]

(* ****** ****** *)

implement
{key,itm}{env}
funmap_foreach$cont (k, x, env) = true

(* ****** ****** *)

implement
{key,itm}
funmap_foreach
  (map) = let
//
var env: void = () in funmap_foreach_env<key,itm><void> (map, env)
//
end // end of [funmap_foreach]

(* ****** ****** *)

implement{key,itm}
funmap_listize (xs) = let
  val ys = $effmask_wrt (funmap_listize_vt (xs)) in list_of_list_vt (ys)
end // end of [funmap_listize]

(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in // in of [local]

implement
{key,itm}
funmap_listize_vt
  (map) = let
//
typedef tki = @(key, itm)
//
vtypedef tenv = $Q.Qstruct (tki)
//
implement
funmap_foreach$fwork<key,itm><tenv>
  (k, x, env) = $Q.qstruct_insert<tki> (env, @(k, x))
// end of [funmap_foreach$fwork]
//
var env: $Q.qstruct
val () = $Q.qstruct_initize {tki} (env)
val () = $effmask_all (funmap_foreach_env (map, env))
val res = $Q.qstruct_takeout_list (env)
prval () = $Q.qstruct_uninitize {tki} (env)
//
in
  res
end // end of [funmap_listize_vt]

end // end of [local]

(* ****** ****** *)

(* end of [funmap.hats] *)
