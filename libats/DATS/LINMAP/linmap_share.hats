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

implement{key}
compare_key_key
  (k1, k2) = gcompare_val<key> (k1, k2)
// end of [compare_key_key]

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
  prval () = opt_some (res)
in
  true
end else let
  prval () = opt_none (res)
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
linmap_foreach
  (map) = let
//
var env: void = () in linmap_foreach_env<key,itm><void> (map, env)
//
end // end of [linmap_foreach]

(* ****** ****** *)

(* end of [linmap_share.hats] *)
