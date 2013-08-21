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

#define ATS_PACKNAME "ATSLIB.libats.linhashtbl_chain"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linhashtbl_chain.sats"

(* ****** ****** *)

#include "./SHARE/linhashtbl.hats" // code reuse

(* ****** ****** *)

extern
fun{} chain_nil
  {key:t0p;itm:vt0p}((*void*)): chain (key, itm)
// end of [chain_nil]

extern
fun{
key:t0p;itm:vt0p
} chain_insert
  (kxs: &chain (key, itm) >> _, key, itm): void
// end of [chain_insert]

extern
fun{
key:t0p;itm:vt0p
} chain_listize_free (chain (key, itm)): List_vt @(key, itm)
// end of [chain_listize_free]

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

implement{
} chain_nil () = $LM.linmap_nil ()

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

implement
{key,itm}
chain_listize_free (kxs) = $LM.linmap_listize_free (kxs)

end // end of [local]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} chainarrptr_insert
  {n:int | n >= 1}
(
  A: !arrayptr(chain(key, itm), n), n: size_t n, k: key, x: itm
) : void = let
//
val h = hash_key<key> (k)
val h = g1ofg0 (g0uint2uint_ulint_size(h))
val i = g1uint_mod (h, n)
//
val (
  pf0 | p0
) = arrayptr_takeout_viewptr (A)
val (
  pf, fpf | pi
) = array_ptr_takeout (pf0 | p0, i)
val (pf | pi) = viewptr_match (pf | pi)
val () = chain_insert<key,itm> (!pi, k, x)
prval () = pf0 := fpf (pf)
prval () = arrayptr_addback (pf0 | A)
//
in
  // nothing
end // end of [chainarrptr_insert]

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
{key,itm}
hashtbl_make_nil
  (cap) = let
//
vtypedef chain = chain (key, itm)
//
prval [n0:int]
  EQINT () = eqint_make_guint (cap)
//
val p0 =
$UN.castvwtp0{ptr}(chain_nil{key,itm}())
val A0 = arrayptr_make_elt<ptr> (cap, p0)
val A0 = $UN.castvwtp0{arrayptr(chain, n0)}(A0)
//
in
  HASHTBL (A0, cap, i2sz(0))
end // end of [hashtbl_make_nil]

(* ****** ****** *)

implement
hashtbl_get_size
  (tbl) = let
//
val+HASHTBL(A, cap, n) = tbl in (n)
//
end // end of [hashtbl_get_size]

(* ****** ****** *)

implement
hashtbl_get_capacity
  (tbl) = let
//
val+HASHTBL (A, cap, n) = tbl in (cap)
//
end // end of [hashtbl_get_capacity]

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert_any
  (tbl, k, x) = let
//
val+@HASHTBL (A, cap, n) = tbl
//
val () = n := succ(n)
val () = chainarrptr_insert<key,itm> (A, cap, k, x)
prval () = fold@ (tbl)
//
in
  // nothing
end // end of [hashtbl_insert_any]

(* ****** ****** *)

implement
{key,itm}
hashtbl_foreach
  (tbl) = let
  var env: void = () in
  hashtbl_foreach_env<key,itm><void> (tbl, env)
end // end of [hashtbl_foreach]

(* ****** ****** *)

implement
{key,itm}{env}
hashtbl_foreach_env
  (tbl, env) = let
//
vtypedef
chain = chain (key, itm)
//
val+HASHTBL (A, cap, _) = tbl
//
local
implement{a}{env}
array_foreach$cont (kxs, env) = true
implement
array_foreach$fwork<chain><env>
  (kxs, env) =
  chain_foreach_env<key,itm><env> (kxs, env)
in(* in of [local]*)
val _(*asz*) = arrayptr_foreach_env<chain><env> (A, cap, env)
end // end of [local]
//
in
  // nothing
end // end of [hashtbl_foreach_env]

(* ****** ****** *)

implement
{key,itm}
hashtbl_listize_free
  (tbl) = let
//
vtypedef
chain = chain (key, itm)
//
val+~HASHTBL (A, cap, n) = tbl
//
typedef tenv = ptr
//
vtypedef ki = @(key, itm)
vtypedef tenv2 = List_vt (ki)
//
local
implement{a}{env}
array_rforeach$cont (x, env) = true
implement
array_rforeach$fwork<chain><tenv>
  (kxs, env) = let
  val kxs = $UN.castvwtp1{chain}(kxs)
  val kxs = chain_listize_free<key,itm> (kxs)
  val kxs2 = list_vt_append (kxs, $UN.castvwtp0{tenv2}(env))
  val () = env := $UN.castvwtp0{ptr}(kxs2)
in
  // nothing
end // end of [array_rforeach$fwork]
in(* in of [local] *)
var env: ptr
val () = env := $UN.castvwtp0{ptr}(list_vt_nil)
val _(*cap*) = $effmask_all
  (arrayptr_rforeach_env<chain><tenv> (A, cap, env))
end // end of [local]
//
val () = arrayptr_free ($UN.castvwtp0{arrayptr(ptr,0)}(A))
//
in
  $UN.castvwtp0{tenv2}(env)
end // end of [hashtbl_listize_free]

(* ****** ****** *)

(* end of [linhashtbl_chain.dats] *)
