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
(* Start time: August, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linhashtbl_chain.sats"

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} chain_insert
  (kxs: &chain (key, itm) >> _, key, itm): void
// end of [chain_insert]

(* ****** ****** *)

extern
fun
{key:t0p
;itm:vt0p}
{env:vt0p}
chain_foreach_env
  (kxs: !chain (key, itm) >> _, &env >> _): void
// end of [chain_foreach_env]

(* ****** ****** *)

local

staload
LM = "libats/SATS/linmap_list.sats"

assume
chain_vtype (key:t0p, itm:vt0p) = $LM.map (key, itm)

in (* in of [local] *)

implement
{key,itm}
chain_insert (kxs, k, x) = $LM.linmap_insert_any<key,itm> (kxs, k, x)

implement
{key,itm}{env}
chain_foreach_env
  (kxs, env) = let
//
implement
$LM.linmap_foreach$fwork<key,itm><env> = hashtbl_foreach$fwork<key,itm><env>
//
in
  $LM.linmap_foreach_env<key,itm><env> (kxs, env)
end // end of [chain_foreach_env]

end // end of [local]

(* ****** ****** *)

datavtype hashtbl
(
  key:t@ype, itm:vt@ype+
) =
  {m:int | m >= 1}
  HASHTBL of (
    arrayptr (chain (key, itm), m), size_t m, size_t
  ) (* end of [HASHTBL] *)
// end of [hashtbl]

(* ****** ****** *)

assume
hashtbl_vtype (key:t0p, itm:vt0p) = hashtbl (key, itm)

(* ****** ****** *)

implement
hashtbl_get_size
  (tbl) = let
//
val+HASHTBL(_, _, n) = tbl in (n)
//
end // end of [hashtbl_get_size]

(* ****** ****** *)

implement
hashtbl_get_capacity
  (tbl) = let
//
val+HASHTBL (_, cap, _) = tbl in (cap)
//
end // end of [hashtbl_get_capacity]

(* ****** ****** *)

implement
{key,itm}
hashtbl_foreach
  (tbl) = let
  var env: void = () in
  hashtbl_foreach_env<key,itm><void> (tbl, env)
end // end of [hashtbl_foreach]

(* ****** ****** *)

(* end of [linhashtbl_chain.dats] *)
