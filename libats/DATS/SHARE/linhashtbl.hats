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
//
// HX: shared by linhashtbl_chain
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun{}
string_hash_33 (str: string):<> ulint

(* ****** ****** *)

implement{}
string_hash_33 (str) = let
//
#define CNUL '\000'
//
fun loop
(
  p: ptr, res: ulint
) : ulint = let
  val c = $UN.ptr0_get<char> (p)
in
//
if c > CNUL then let
  val res = (res << 5) + res
in
  loop (ptr_succ<char> (p), res + $UN.cast{ulint}(c))
end else res // end of [if]
//
end // end of [loop]
//
in
  $effmask_all(loop (string2ptr(str), 314159265359UL))
end // end of [string_hash_33]

(* ****** ****** *)

implement
hash_key<string> = string_hash_33<>

(* ****** ****** *)

implement{key} equal_key_key = gequal_val<key>

(* ****** ****** *)

implement
{key,itm}
hashtbl_search
  (t, k0, res) = let
//
val p = hashtbl_search_ref (t, k0)
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
end // end of [hashtbl_search]

(* ****** ****** *)

implement
{key,itm}
hashtbl_search_opt
  (tbl, k0) = let
  var res: itm?
  val ans = hashtbl_search (tbl, k0, res)
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
end // end of [hashtbl_search_opt]

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert_opt
  (tbl, k0, x0) = let
//
var res: itm?
val ans =
  hashtbl_insert (tbl, k0, x0, res)
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
end // end of [hashtbl_insert_opt]

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout_opt
  (tbl, k0) = let
//
var res: itm?
val ans = hashtbl_takeout (tbl, k0, res)
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
end // end of [hashtbl_takeout_opt]

(* ****** ****** *)

implement
{key,itm}
hashtbl_remove
  (tbl, k0) = let
//
var res: itm
val takeout =
  hashtbl_takeout<key,itm> (tbl, k0, res)
prval () = opt_clear (res)
//
in
  takeout(*removed*)
end // end of [hashtbl_remove]

(* ****** ****** *)

implement
{key,itm}
hashtbl_foreach
  (tbl) = let
  var env: void = () in
  hashtbl_foreach_env<key,itm><void> (tbl, env)
end // end of [hashtbl_foreach]

(* ****** ****** *)

implement{}
fprint_hashtbl$sep (out) = fprint (out, "; ")
implement{}
fprint_hashtbl$mapto (out) = fprint (out, "->")

implement
{key,itm}
fprint_hashtbl
  (out, tbl) = let
//
implement
hashtbl_foreach$fwork<key,itm><int>
  (k, x, env) = {
  val () = if env > 0 then fprint_hashtbl$sep (out)
  val () = env := env + 1
  val () = fprint_val<key> (out, k)
  val () = fprint_hashtbl$mapto (out)
  val () = fprint_val<itm> (out, x)
} (* end of [hashtbl_foreach$fwork] *)
//
var env: int = 0
//
in
  hashtbl_foreach_env<key,itm><int> (tbl, env)
end // end of [fprint_hashtbl]

(* ****** ****** *)

(* end of [linhashtbl.hats] *)
