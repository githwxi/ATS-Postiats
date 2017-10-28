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

#define ATS_PACKNAME "ATSLIB.libats.hashtbl_chain"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/hashfun.sats"

(* ****** ****** *)

staload "libats/SATS/hashtbl_chain.sats"

(* ****** ****** *)

#include "./SHARE/hashtbl.hats" // code reuse

(* ****** ****** *)

extern
fun{}
chain_nil
  {key:t0p;itm:vt0p}(): chain(key, itm)
// end of [chain_nil]

extern
fun{
key:t0p;itm:vt0p
} chain_search_ref
  (kxs: !chain(key, itm), k0: key): cPtr0(itm)
// end of [chain_search_ref]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} chain_insert (
  &chain(key, INV(itm)) >> _
, k0: key, x0: itm, res: &itm? >> opt(itm, b)
) : #[b:bool] bool (b) // endfun

extern
fun{
key:t0p;itm:vt0p
} chain_insert_any
  (kxs: &chain(key, itm) >> _, key, itm): void
// end of [chain_insert_any]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} chain_takeout (
  &chain(key, INV(itm)) >> _, k0: key, res: &itm? >> opt(itm, b)
) : #[b:bool] bool (b) // endfun

(* ****** ****** *)

extern
fun
{key:t0p
;itm:vt0p}
{env:vt0p}
chain_foreach_env
(
  kxs: !chain(key, itm) >> _, env: &env >> _
) : void // end of [chain_foreach_env]

(* ****** ****** *)

extern
fun
{key:t0p
;itm:vt0p}
chain_listize (chain(key, itm)): List_vt @(key, itm)

extern
fun
{key:t0p
;itm:vt0p}
{ki2:vt0p}
chain_flistize (kxs: chain(key, itm)): List_vt (ki2)

(* ****** ****** *)

staload
LM = "libats/SATS/linmap_list.sats"

(* ****** ****** *)

implement
{key}(*tmp*)
$LM.equal_key_key (x, y) = equal_key_key<key> (x, y)

(* ****** ****** *)

local
//
assume
chain_vtype (key:t0p, itm:vt0p) = $LM.map (key, itm)
//
in (* in of [local] *)

(* ****** ****** *)

implement
{}(*tmp*)
chain_nil () = $LM.linmap_nil ()

(* ****** ****** *)

implement
{key,itm}
chain_search_ref = $LM.linmap_search_ref<key,itm>

(* ****** ****** *)

implement
{key,itm}
chain_insert = $LM.linmap_insert<key,itm>
implement
{key,itm}
chain_insert_any = $LM.linmap_insert_any<key,itm>

(* ****** ****** *)

implement
{key,itm}
chain_takeout = $LM.linmap_takeout<key,itm>

(* ****** ****** *)

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

(* ****** ****** *)

implement
{key,itm}
chain_listize (kxs) = $LM.linmap_listize (kxs)

implement
{key,itm}{ki2}
chain_flistize (kxs) = let
//
implement
$LM.linmap_flistize$fopr<key,itm><ki2> = hashtbl_flistize$fopr<key,itm><ki2>
//
in
  $LM.linmap_flistize<key,itm><ki2> (kxs)
end // end of [chain_flistize]

end // end of [local]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} chainarr_insert_any
  {m:int | m >= 1} (
  A: !arrayptr (chain(key, itm), m), m: size_t m, k: key, x: itm
) : void // end of [chainarr_insert_any]
extern
fun{
key:t0p;itm:vt0p
} chainarr_insert_chain
  {m:int | m >= 1} (
  A: !arrayptr (chain(key, itm), m), m: size_t m, kxs: chain(key, itm)
) : void // end of [chainarr_insert_chain]

(* ****** ****** *)

implement
{key,itm}
chainarr_insert_any
  (A, m, k, x) = let
//
val h = hash_key<key> (k)
val h = g0uint2uint_ulint_size(h)
val i = g1uint_mod (g1ofg0(h), m)
//
val (
  pf0 | p0
) = arrayptr_takeout_viewptr (A)
val (
  pf, fpf | pi
) = array_ptr_takeout (pf0 | p0, i)
val (pf | pi) = viewptr_match (pf | pi)
val () = chain_insert_any<key,itm> (!pi, k, x)
prval () = pf0 := fpf (pf)
prval () = arrayptr_addback (pf0 | A)
//
in
  // nothing
end // end of [chainarr_insert_any]

(* ****** ****** *)

implement
{key,itm}
chainarr_insert_chain
  {m}(A, m, kxs) = let
//
vtypedef
chain = chain(key, itm)
//
fun loop
(
  A: !arrayptr (chain, m), m: size_t m, kxs: List_vt @(key, itm)
) : void = let
in
//
case+ kxs of
| ~list_vt_cons
    ((k, x), kxs) => let
    val () = chainarr_insert_any<key,itm> (A, m, k, x) in loop (A, m, kxs)
  end // end of [list_vt_cons]
| ~list_vt_nil ((*void*)) => ()
//
end // end of [loop]
//
val kxs =
  chain_listize<key,itm> (kxs)
val kxs = list_vt_reverse (kxs)
//
in
  loop (A, m, kxs)
end // end of [chainarr_insert_chain]

(* ****** ****** *)

datavtype hashtbl
(
  key:t@ype, itm:vt@ype+
) =
  {m:int | m >= 1}
  HASHTBL of (
    arrayptr (chain(key, itm), m), size_t m, size_t
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
vtypedef
chain = chain(key, itm)
//
prval [m:int]
  EQINT () = eqint_make_guint (cap)
//
val p0 =
$UN.castvwtp0{ptr}(chain_nil{key,itm}())
val A0 = arrayptr_make_elt<ptr> (cap, p0)
val A0 = $UN.castvwtp0{arrayptr(chain, m)}(A0)
//
in
  HASHTBL(A0, cap, i2sz(0))
end // end of [hashtbl_make_nil]

(* ****** ****** *)

implement
{}(*tmp*)
hashtbl_get_size
  (tbl) = let
//
val+
HASHTBL
(A, cat, ntot) = tbl in g1ofg0(ntot)
//
end // end of [hashtbl_get_size]

(* ****** ****** *)

implement
{}(*tmp*)
hashtbl_get_capacity
  (tbl) = let
//
val+HASHTBL(A, cap, _) = tbl in (cap)
//
end // end of [hashtbl_get_capacity]

(* ****** ****** *)

implement
{key,itm}
hashtbl_search_ref
  (tbl, k) = let
//
val+HASHTBL(A, cap, n) = tbl
//
val h = hash_key<key> (k)
val h = g0uint2uint_ulint_size(h)
val i = g1uint_mod (g1ofg0(h), cap)
//
val (
  pf0 | p0
) = arrayptr_takeout_viewptr (A)
val (
  pf, fpf | pi
) = array_ptr_takeout (pf0 | p0, i)
val (pf | pi) = viewptr_match (pf | pi)
val cptr = chain_search_ref<key,itm> (!pi, k)
prval () = pf0 := fpf (pf)
prval () = arrayptr_addback (pf0 | A)
//
in
  cptr
end // end of [hashtbl_search_ref]

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert
  (tbl, k, x, res) = let
//
val+@HASHTBL(A, cap, n) = tbl
//
val h = hash_key<key> (k)
val h = g0uint2uint_ulint_size(h)
val i = g1uint_mod (g1ofg0(h), cap)
//
val (
  pf0 | p0
) = arrayptr_takeout_viewptr (A)
val (
  pf, fpf | pi
) = array_ptr_takeout (pf0 | p0, i)
val (pf | pi) = viewptr_match (pf | pi)
val ans = chain_insert<key,itm> (!pi, k, x, res)
prval () = pf0 := fpf (pf)
prval () = arrayptr_addback (pf0 | A)
//
val () = if not(ans) then n := succ(n) // inserted
//
prval () = fold@ (tbl)
//
val () =
if not(ans) then (
if hashtbl$recapacitize() > 0
  then ignoret(hashtbl_adjust_capacity<key,itm> (tbl))
) (* end of [if] *)
//
in
  ans
end // end of [hashtbl_insert]

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert_any
  (tbl, k, x) = let
//
val+@HASHTBL(A, cap, n) = tbl
//
val h = hash_key<key> (k)
val h = g0uint2uint_ulint_size(h)
val i = g1uint_mod (g1ofg0(h), cap)
//
val (
  pf0 | p0
) = arrayptr_takeout_viewptr (A)
val (
  pf, fpf | pi
) = array_ptr_takeout (pf0 | p0, i)
val (pf | pi) = viewptr_match (pf | pi)
val () = chain_insert_any<key,itm> (!pi, k, x)
prval () = pf0 := fpf (pf)
prval () = arrayptr_addback (pf0 | A)
//
val () = n := succ(n) // insertion is always done
//
prval () = fold@ (tbl)
//
val () =
if hashtbl$recapacitize() > 0
  then ignoret(hashtbl_adjust_capacity<key,itm> (tbl))
//
in
  // nothing
end // end of [hashtbl_insert_any]

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout
  (tbl, k, res) = let
//
val+@HASHTBL(A, cap, n) = tbl
//
val h = hash_key<key> (k)
val h = g0uint2uint_ulint_size(h)
val i = g1uint_mod (g1ofg0(h), cap)
//
val (
  pf0 | p0
) = arrayptr_takeout_viewptr (A)
val (
  pf, fpf | pi
) = array_ptr_takeout (pf0 | p0, i)
val (pf | pi) = viewptr_match (pf | pi)
val ans = chain_takeout<key,itm> (!pi, k, res)
prval () = pf0 := fpf (pf)
prval () = arrayptr_addback (pf0 | A)
//
val () = if ans then n := pred(n) // removed
//
prval () = fold@ (tbl)
//
in
  ans
end // end of [hashtbl_takeout]

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout_all
  (tbl) = let
//
vtypedef
chain = chain(key, itm)
//
typedef tenv = ptr
//
vtypedef ki = @(key, itm)
vtypedef tenv2 = List0_vt (ki)
//
val+@HASHTBL(A, cap, n) = tbl
//
local
implement
{a}{env}
array_rforeach$cont(x, env) = true
implement
(a:viewtype)
array_rforeach$fwork<a><tenv>
  (kxs, env) = let
  val kxs2 = $UN.castvwtp0{chain}(kxs)
  val () = kxs := $UN.castvwtp0{a}(chain_nil())
  val kxs2 = chain_listize<key,itm> (kxs2)
  val kxs2 = list_vt_append (kxs2, $UN.castvwtp0{tenv2}(env))
  val () = env := $UN.castvwtp0{ptr}(kxs2)
in
  // nothing
end // end of [array_rforeach$fwork]
in (* in of [local] *)
var env: ptr
val () = env := $UN.castvwtp0{ptr}(list_vt_nil)
val _(*cap*) = $effmask_all
  (arrayptr_rforeach_env<chain><tenv> (A, cap, env))
end // end of [local]
//
val () = n := i2sz(0)
//
prval () = fold@ (tbl)
//
in
  $UN.castvwtp0{tenv2}(env)
end // end of [hashtbl_takeout_all]

(* ****** ****** *)

implement
{key,itm}
hashtbl_reset_capacity
  (tbl, cap2) = let
//
vtypedef
chain = chain(key, itm)
//
val+@HASHTBL(A0, cap0, n) = tbl
//
prval [m2:int]
  EQINT () = eqint_make_guint (cap2)
//
val p0 =
$UN.castvwtp0{ptr}(chain_nil{key,itm}())
val A2 = arrayptr_make_elt<ptr> (cap2, p0)
val A2 = $UN.castvwtp0{arrayptr(chain, m2)}(A2)
//
fun loop
(
  p: ptr, m: size_t
, A2: !arrayptr (chain, m2)
) : void = let
in
//
if m > 0 then let
//
val kxs = $UN.ptr0_get<chain> (p)
val () = chainarr_insert_chain<key,itm> (A2, cap2, kxs)
//
in
  loop (ptr0_succ<chain> (p), pred(m), A2)
end // end of [if]
//
end // end of [loop]
//
val A = A0
val cap = cap0
val () = loop (ptrcast(A), cap, A2)
val () = arrayptr_free ($UN.castvwtp0{arrayptr(ptr,0)}(A))
//
val () = A0 := A2
val () = cap0 := cap2
//
prval () = fold@ (tbl)
//
in
  true(*always*)
end // end of [hashtbl_reset_capacity]

(* ****** ****** *)
//
// HX: please reimplement it if needed
//
implement
{key,itm}
hashtbl_adjust_capacity
  (tbl) = let
//
val+HASHTBL(A, cap, n) = tbl
//
in
//
if i2sz(5) * cap <= n
  then hashtbl_reset_capacity (tbl, cap + cap) else false
//
end // end of [hashtbl_adjust_capacity]

(* ****** ****** *)

implement
{key,itm}{env}
hashtbl_foreach_env
  (tbl, env) = let
//
vtypedef
chain = chain(key, itm)
//
val+HASHTBL(A, cap, _) = tbl
//
local
implement
{a}{env}
array_foreach$cont(kxs, env) = true
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
hashtbl_listize
  (tbl) = let
//
vtypedef
chain = chain(key, itm)
//
val+~HASHTBL(A, cap, _) = tbl
//
typedef tenv = ptr
//
vtypedef ki = @(key, itm)
vtypedef tenv2 = List0_vt (ki)
//
local
implement
{a}{env}
array_rforeach$cont(x, env) = true
implement
array_rforeach$fwork<chain><tenv>
  (kxs, env) = let
  val kxs = $UN.castvwtp1{chain}(kxs)
  val kxs2 = chain_listize<key,itm> (kxs)
  val kxs2 = list_vt_append(kxs2, $UN.castvwtp0{tenv2}(env))
  val ((*set*)) = env := $UN.castvwtp0{ptr}(kxs2)
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
val () = arrayptr_free($UN.castvwtp0{arrayptr(ptr,0)}(A))
//
in
  $UN.castvwtp0{tenv2}(env)
end // end of [hashtbl_listize]

(* ****** ****** *)

implement
{key,itm}{ki2}
hashtbl_flistize
  (tbl) = let
//
vtypedef
chain = chain(key, itm)
//
val+~HASHTBL(A, cap, n) = tbl
//
typedef tenv = ptr
//
vtypedef tenv2 = List0_vt (ki2)
//
local
//
implement
{a}{env}
array_rforeach$cont(x, env) = true
implement
array_rforeach$fwork<chain><tenv>
  (kxs, env) = let
  val kxs = $UN.castvwtp1{chain}(kxs)
  val kxs2 =
    chain_flistize<key,itm><ki2> (kxs)
  val kxs2 =
    list_vt_append (kxs2, $UN.castvwtp0{tenv2}(env))
  val ((*void*)) = env := $UN.castvwtp0{ptr}(kxs2)
in
  // nothing
end // end of [array_rforeach$fwork]
//
in(* in of [local] *)
//
var env: ptr
//
val () = (env := $UN.castvwtp0{ptr}(list_vt_nil))
//
val _(*cap*) =
$effmask_all
  (arrayptr_rforeach_env<chain><tenv> (A, cap, env))
//
end // end of [local]
//
val () = arrayptr_free ($UN.castvwtp0{arrayptr(ptr,0)}(A))
//
in
  $UN.castvwtp0{tenv2}(env)
end // end of [hashtbl_flistize]

(* ****** ****** *)

(* end of [hashtbl_chain.dats] *)
