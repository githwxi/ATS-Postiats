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

implement
{key,itm}
linmap_search
  (t, k0, res) = let
  val [l:addr] p = linmap_search_ref (t, k0)
in
//
if p > 0 then let
  prval (fpf, pf) = __assert () where {
    extern praxi __assert (): (itm @ l -<prf> void, itm @ l)
  } // end of [prval]
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
  var res: itm?
  val ans = linmap_search (map, k0, res)
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
end // end of [linmap_search_opt]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_opt
  (map, k0, x0) = let
  var res: itm?
  val ans = linmap_insert (map, k0, x0, res)
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
end // end of [linmap_insert_opt]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout_opt
  (map, k0) = let
  var res: itm?
  val ans = linmap_takeout (map, k0, res)
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
end // end of [linmap_takeout_opt]

(* ****** ****** *)

implement
{key,itm}
linmap_remove
  (map, k0) = let
  var res: itm
  val takeout = linmap_takeout<key,itm> (map, k0, res)
  prval () = opt_clear (res)
in
  takeout(*removed*)
end // end of [linmap_remove]

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach$cont (k, x, env) = true

(* ****** ****** *)

implement
{key,itm}
linmap_foreach
  (map) = let
//
var env: void = () in linmap_foreach_env<key,itm><void> (map, env)
//
end // end of [linmap_foreach]

(* ****** ****** *)

local

staload Q = "libats/SATS/linqueue_list.sats"

in // in of [local]

implement
{key,itm}
linmap_listize
  (map) = let
//
viewtypedef tki = @(key, itm)
viewtypedef tenv = $Q.QUEUE (tki)
viewtypedef tenv0 = $Q.QUEUETSZ (tki)
//
var env: tenv0
val () = $Q.queue_initize (env)
//
implement
linmap_foreach$fwork<key,itm><tenv>
  (k, x, env) = $Q.queue_insert<tki> (env, @(k, x))
//
val () = $effmask_all (linmap_foreach_env (map, env))
//
in
  $Q.queue_uninitize (env)
end // end of [linmap_listize]

end // end of [local]

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

(* end of [linmap_share.hats] *)
