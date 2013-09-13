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

(*
** HX-2013-08:
** This one by Robert Jenkins
** is a full-avalanche hash function
*)
/*
uint32_t
atscntrb_inthash_jenkins
  (uint32_t a)
{
  a = (a+0x7ed55d16) + (a<<12);
  a = (a^0xc761c23c) ^ (a>>19);
  a = (a+0x165667b1) + (a<< 5);
  a = (a+0xd3a2646c) ^ (a<< 9);
  a = (a+0xfd7046c5) + (a<< 3);
  a = (a^0xb55a4f09) ^ (a>>16);
  return a;
}
*/
extern
fun{}
inthash_jenkins (uint32): uint32
implement{}
inthash_jenkins (a) =
  $extfcall (uint32, "atscntrb_inthash_jenkins", a)
//
(* ****** ****** *)

extern
fun{}
string_hash_multiplier
(
  K: ulint, H0: ulint, str: string
) :<> ulint // endfun
implement{}
string_hash_multiplier (K, H0, str) = let
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
if c > CNUL then
(
  loop (ptr_succ<char> (p), K*res + $UN.cast{ulint}(c))
) else res // end of [if]
//
end // end of [loop]
//
in
  $effmask_all(loop (string2ptr(str), H0))
end // end of [string_hash_multiplier]

(* ****** ****** *)
//
// HX: 31 and 37 are top choices
//
implement
hash_key<string> (str) =
  string_hash_multiplier (31UL, 61803398875UL, str)
//
(* ****** ****** *)

implement{key} equal_key_key = gequal_val<key>

(* ****** ****** *)

implement{}
hashtbl$recapacitize () = 1 // default policy

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

implement
{key,itm}
hashtbl_foreach
  (tbl) = let
  var env: void = () in
  hashtbl_foreach_env<key,itm><void> (tbl, env)
end // end of [hashtbl_foreach]

(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in (* in of [local] *)

implement
{key,itm}
hashtbl_listize1
  (tbl) = let
//
vtypedef ki = @(key, itm)
vtypedef tenv = $Q.qstruct (ki)
//
implement(env)
hashtbl_foreach$fwork<key,itm><env>
  (k, x, env) = let
//
val (
  pf, fpf | p
) = $UN.ptr_vtake{tenv}(addr@(env))
val () = $Q.qstruct_insert<ki> (env, @(k, x))
prval () = fpf (pf)
//
in
  // nothing
end // end of [hashtbl_foreach$fwork]
//
var env: $Q.qstruct
val () = $Q.qstruct_initize{ki}(env)
val () = $effmask_all (hashtbl_foreach_env<key,itm><tenv> (tbl, env))
val res = $Q.qstruct_takeout_list (env)
prval () = $Q.qstruct_uninitize{ki}(env)
//
prval () = lemma_list_vt_param (res)
//
in
  res
end // end of [hashtbl_listize1]

end // end of [local]

(* ****** ****** *)

(* end of [linhashtbl.hats] *)
