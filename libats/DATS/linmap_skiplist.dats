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

(* Author: Adam Udi *)
(* Authoremail: adamudi AT bu DOT edu *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)

(* Start time: December, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linmap_skiplist.sats"

(* ****** ****** *)

#include "./SHARE/linmap.hats" // code reuse

(* ****** ****** *)

stadef mytkind = $extkind"atslib_linmap_randbst"

(* ****** ****** *)
//
macdef i2sz (i) = g1int2uint (,(i))
//
(* ****** ****** *)

implement{}
linmap_skiplist_initize () = let
//
val (
) = ftmp () where {
  extern fun ftmp : () -> void = "mac#atslib_srand48_with_time"
} (* end of [val] *)
//
in
end // end of [linmap_skiplist_initize]

(* ****** ****** *)

#define lgMAX 40 // HX: it should be enough: 2^40 >= 10^12 :)

(* ****** ****** *)

extern
fun linmap_random_lgN
  {n:int | n >= 1} (lgMAX: int (n)): intBtwe (1, n)
// end of [linmap_random_lgN]

local

staload "libc/SATS/stdlib.sats"

in // in of [local]

implement
linmap_random_lgN
  (n) = let
//
fun loop
  {n:int}
  {i:int | 1 <= i; i <= n}
  .<n-i>. (
  n: int n, i: int i, r: double
) :<> intBtwe (1, n) =
  if i < n then
    if (r <= 0.5) then loop (n, i+1, r+r) else i
  else n // end of [if]
// end of [loop]
//
val r = drand48 () // HX: containing ref-effect!
//
in
  loop (n, 1, r)
end // end of [linmap_random_lgN]

end // end of [local]

(* ****** ****** *)

abstype
sknode_type
  (key:t@ype, itm:vt@ype+, l:addr, n:int)
stadef sknode = sknode_type

(* ****** ****** *)

typedef
sknode0 (
  key:t0p
, itm:vt0p
, n:int
) = [l:addr] sknode (key, itm, l, n)
typedef
sknode0 (
  key:t0p
, itm:vt0p
) = [l:addr;n:nat] sknode (key, itm, l, n)

typedef
sknode1 (
  key:t0p
, itm:vt0p
, n:int
) = [l:agz] sknode (key, itm, l, n)
typedef
sknode1 (
  key:t0p
, itm:vt0p
) = [l:agz;n:nat] sknode (key, itm, l, n)

(* ****** ****** *)

typedef
sknodeGt0 (
  key:t0p, itm:vt0p, ni:int
) = [n:int | n > ni] sknode0 (key, itm, n)

(* ****** ****** *)

extern
castfn
sknode2ptr
  {key:t0p;itm:vt0p}
  {l:addr}{n:int} (nx: sknode (key, itm, l, n)):<> ptr (l)
// end of [sknode2ptr]

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

fun{
} sknode_null
  {key:t0p;itm:vt0p}{n:nat} .<>.
  (n: int n):<> sknode (key, itm, null, n) = $UN.castvwtp0 (nullp)
// end of [sknode_null]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} sknode_make
  {lgN:int | lgN > 0}
  (k0: key, x0: itm, lgN: int lgN): sknode1 (key, itm, lgN)
// end of [sknode_make]

extern
fun{
key:t0p;itm:vt0p
} sknode_free
  {lgN:int | lgN > 0}
  (nx: sknode1 (key, itm, lgN), res: &itm? >> itm): void
// end of [sknode_free]

extern
fun{
key:t0p;itm:vt0p
} sknode_get_key (nx: sknode1 (key, itm)):<> key

extern
fun{
key:t0p;itm:vt0p
} sknode_getref_item (nx: sknode1 (key, itm)):<> Ptr1

(* ****** ****** *)

abstype
sknodelst_type
  (key:t@ype, itm:vt@ype+, int(*size*))
stadef sknodelst = sknodelst_type

extern
fun sknodelst_get_at
  {key:t0p;itm:vt0p}
  {n:int}{i:nat | i < n}
  (nxa: sknodelst (key, itm, n), i: int i):<> sknodeGt0 (key, itm, i)
// end of [sknodelst_get_at]

extern
fun sknodelst_set_at
  {key:t0p;itm:vt0p}
  {n:int}{i:nat | i < n}
  (nxa: sknodelst (key, itm, n), i: int i, nx0: sknodeGt0 (key, itm, i)): void
// end of [sknodelst_set_at]

extern
fun sknodelst_make // HX: initized with nulls
  {key:t0p;itm:vt0p}{n:nat} (n: int n):<!wrt> sknodelst (key, itm, n)
// end of [sknodelst_make]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} sknode_get_sknodelst
  {n:nat} (nx: sknode1 (key, itm, n)):<> sknodelst (key, itm, n)
// end of [sknode_get_sknodelst]

extern
fun{
key:t0p;itm:vt0p
} sknode_get_sknodelen {n:nat} (nx: sknode1 (key, itm, n)):<> int (n)

(* ****** ****** *)
//
// HX: internal representation of a sknode
//
vtypedef
_sknode_struct (
  key: t0p, itm: vt0p
) = @{
  key= key, item=itm, sknodelst=ptr, sknodelen= int
} // end of [_sknode_struct]

(* ****** ****** *)

implement
{key,itm}
sknode_make
  {lgN} (
  k0, x0, lgN
) = let
  vtypedef VT = _sknode_struct (key, itm)
  val (pfat, pfgc | p) = ptr_alloc<VT> ()
  val () = p->key := k0
  val () = p->item := $UN.castvwtp0{itm?}{itm}(x0)
  val () = p->sknodelst := $UN.cast{ptr}(sknodelst_make(lgN))
  val () = p->sknodelen := lgN
in
  $UN.castvwtp0 {sknode1(key,itm,lgN)} @(pfat, pfgc | p)
end // end of [sknode_make]

(* ****** ****** *)

implement
{key,itm}
sknode_free
  (nx, res) = let
//
  vtypedef VT = _sknode_struct (key, itm)
//
  prval (
    pfat, pfgc | p
  ) = __cast (nx) where {
    extern
    castfn __cast (
      nx: sknode1 (key, itm)
    ) :<> [l:addr] (VT @ l, free_gc_v l | ptr l)
  } // end of [prval]
//
  val () = res := p->item
//
  val () =
    __free (p->sknodelst) where {
    extern fun __free : ptr -<0,!wrt> void = "ats_free_gc"
  } // end of [val]
//
  val () = ptr_free {VT?} (pfgc, pfat | p)
//
in
  // nothing
end // end of [sknode_free]

(* ****** ****** *)

extern
castfn
__cast_sknode
  {key:t0p;itm:vt0p} (
  nx: sknode1 (key, itm)
) :<> [l:addr] (
  _sknode_struct (key, itm) @ l
, _sknode_struct (key, itm) @ l -<lin,prf> void
| ptr l
) // end of [__cast_sknode]

(* ****** ****** *)

implement
{key,itm}
sknode_get_key
  (nx) = let
  val (pf, fpf | p) = __cast_sknode (nx)
  val key = p->key
  prval () = fpf (pf)
in
  key
end // end of [sknode_get_key]

implement
{key,itm}
sknode_getref_item
  (nx) = let
  val (pf, fpf | p) = __cast_sknode (nx)
  val p_item = addr@ (p->item)
  prval () = fpf (pf)
in
  $UN.cast2Ptr1 (p_item)
end // end of [sknode_getref_item]

implement
{key,itm}
sknode_get_sknodelst
  {n} (nx) = let
  val (pf, fpf | p) = __cast_sknode (nx)
  val nxa = p->sknodelst
  prval () = fpf (pf)
in
  $UN.cast {sknodelst(key, itm, n)} (nxa)
end // end of [sknode_get_sknodelst]

implement
{key,itm}
sknode_get_sknodelen
  {n} (nx) = let
  val (pf, fpf | p) = __cast_sknode (nx)
  val len = p->sknodelen
  prval () = fpf (pf)
in
  $UN.cast {int(n)} (len)
end // end of [sknode_get_sknodelen]

(* ****** ****** *)

local

assume
sknodelst_type
  (key:t0p, itm:vt0p, n:int) = arrayref (ptr, n)
// end of [sknodelst_type]

in // in of [local]

implement
sknodelst_make (n) = let
  val asz = i2sz(n) in arrayref_make_elt<ptr> (asz, nullp)
end // end of [sknodelst]

implement
sknodelst_get_at
  {key,itm}{i}
  (nxa, i) = let
  typedef T = sknodeGt0 (key, itm, i)
  val nx0 = $effmask_ref (arrayref_get_at (nxa, i)) in $UN.cast{T}(nx0)
end // end of [sknodelst_get_at]

implement
sknodelst_set_at
  {key,itm}{i}
  (nxa, i, nx0) = let
  val nx0 = $UN.cast{ptr} (nx0) in $effmask_ref (arrayref_set_at (nxa, i, nx0))
end // end of [sknodelst_set_at]

end // end of [local]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} sknode_get_next
  {n:int}{ni:nat | ni < n}
  (nx: sknode1 (key, itm, n), ni: int ni):<> sknodeGt0 (key, itm, ni)
// end of [sknode_get_next]

extern
fun{
key:t0p;itm:vt0p
} sknode_set_next
  {n,n1:int}{ni:nat | ni < n} (
  nx: sknode1 (key, itm, n), ni: int ni, nx0: sknodeGt0 (key, itm, ni)
) :<> void // end of [sknode_set_next]

(* ****** ****** *)

datavtype
skiplist (
  key:t@ype, itm:vt@ype+
) = // HX: [lgN] is the *current* highest level
  | {N:nat}{lgN:nat | lgN <= lgMAX}
    SKIPLIST (key, itm) of (size_t(N), int(lgN), sknodelst(key, itm, lgMAX))
// end of [skiplist]

(* ****** ****** *)

assume
map_vtype
  (key:t0p, itm:vt0p) = skiplist (key, itm)
// end of [map_vtype]

(* ****** ****** *)

implement{}
linmap_make_nil () =
  SKIPLIST (i2sz(0), 0, sknodelst_make (lgMAX))
// end of [linmap_make_nil]

(* ****** ****** *)

implement{}
linmap_is_nil (map) = let
//
val SKIPLIST (N, _, _) = map
//
in
  if N = i2sz(0) then true else false
end // end of [linmap_is_nil]

implement{}
linmap_isnot_nil (map) = let
//
val SKIPLIST (N, _, _) = map
//
in
  if N > i2sz(0) then true else false
end // end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size (map) = let
  val SKIPLIST (N, _, _) = map in N
end // end of [linmap_size]

(* ****** ****** *)
//
// HX:
// for [sknode_search] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} sknode_search {n:int}
  (nx: sknode1 (key, itm, n), k0: key, ni: natLte n):<> sknode0 (key, itm)
// end of [sknode_search]
extern
fun{
key:t0p;itm:vt0p
} sknodelst_search {n:int}
  (nxa: sknodelst (key, itm, n), k0: key, ni: natLte n):<> sknode0 (key, itm)
// end of [sknodelst_search]

(* ****** ****** *)

implement
{key,itm}
sknode_search
  (nx, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = sknode_get_next (nx, ni1)
  val p_nx1 = sknode2ptr (nx1)
in
//
if p_nx1 > nullp then let
  val k1 = sknode_get_key (nx1)
  val sgn = compare_key_key (k0, k1)
in
  if sgn < 0 then
    sknode_search (nx, k0, ni1)
  else if sgn > 0 then
    sknode_search (nx1, k0, ni)
  else nx1 // end of [if]
end else
  sknode_search (nx, k0, ni1)
// end of [if]
//
end else sknode_null (0)
//
end // end of [sknode_search]

implement
{key,itm}
sknodelst_search
  (nxa, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = sknodelst_get_at (nxa, ni1)
  val p_nx = sknode2ptr (nx)
in
  if p_nx > nullp then let
    val k = sknode_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then
      sknodelst_search (nxa, k0, ni1)
    else if sgn > 0 then
      sknode_search (nx, k0, ni)
    else nx // end of [if]
  end else
    sknodelst_search (nxa, k0, ni1)  
  // end of [if]
end else
  sknode_null (0)
// end of [if]
//
end // end of [sknodelst_search]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
in
//
case+ map of
| SKIPLIST
    (N, lgN, nxa) => let
    val nx =
      sknodelst_search (nxa, k0, lgN)
    val p_nx = sknode2ptr (nx)
    val res = (
      if p_nx > nullp
        then sknode_getref_item (nx) else nullp
      // end of [if]
    ) : Ptr0 // end of [val]
  in
    res
  end // end of [SKIPLIST]
//
end // end of [linmap_search_ref]

(* ****** ****** *)
//
// HX:
// for [sknode_insert] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} sknode_insert {n:int}{ni:nat | ni <= n} (
  nx: sknode1 (key, itm, n), k0: key, ni: int ni, nx0: sknode1 (key, itm)
) : void // end of [sknode_insert]
extern
fun{
key:t0p;itm:vt0p
} sknodelst_insert {n:int}{ni:nat | ni <= n} (
  nxa: sknodelst (key, itm, n), k0: key, ni: int ni, nx0: sknode1 (key, itm)
) : void // end of [sknodelst_insert]

implement
{key,itm}
sknode_insert
  (nx, k0, ni, nx0) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = sknode_get_next (nx, ni1)
  val p_nx1 = sknode2ptr (nx1)
in
  if p_nx1 > nullp then let
    val k1 = sknode_get_key (nx1)
    val sgn = compare_key_key (k0, k1)
  in
    if sgn <= 0 then let
      val n0 = sknode_get_sknodelen (nx0)
      val () =
        if (n0 >= ni) then {
        val () = sknode_set_next (nx, ni1, nx0)
        val () = sknode_set_next (nx0, ni1, nx1)
      } // end of [if] // end of [val]
    in
      sknode_insert (nx, k0, ni1, nx0)
    end else
      sknode_insert (nx1, k0, ni, nx0)
    // end of [if]
  end else let
    val n0 = sknode_get_sknodelen (nx0)
    val () =
      if (n0 >= ni) then sknode_set_next (nx, ni1, nx0)
    // end of [val]
  in
    sknode_insert (nx, k0, ni1, nx0)
  end // end of [if]
end else (
  // nothing
) // end of [if]
//
end // end of [sknode_insert]

implement
{key,itm}
sknodelst_insert
  (nxa, k0, ni, nx0) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = sknodelst_get_at (nxa, ni1)
  val p_nx = sknode2ptr (nx)
in
  if p_nx > nullp then let
    val k = sknode_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn <= 0 then let
      val n0 = sknode_get_sknodelen (nx0)
      val () =
        if (n0 >= ni) then {
        val () =
          sknodelst_set_at (nxa, ni1, nx0)
        val () = sknode_set_next (nx0, ni1, nx)
      } // end of [if] // end of [val]
    in
      sknodelst_insert (nxa, k0, ni1, nx0)
    end else
      sknode_insert (nx, k0, ni, nx0)
    // end of [if]
  end else let
    val n0 = sknode_get_sknodelen (nx0)
    val () =
      if (n0 >= ni) then sknodelst_set_at (nxa, ni1, nx0)
    // end of [val]
  in
    sknodelst_insert (nxa, k0, ni1, nx0)
  end // end of [if]
end else (
  // nothing
) // end of [if]
//
end // end of [sknodelst_insert]

(* ****** ****** *)

implement
{key,itm}
linmap_insert
  (map, k0, x0, res) = let
//
val [l:addr]
  p_nx = linmap_search_ref (map, k0)
// end of [val]
//
in
//
if p_nx > nullp then let
  prval (
    pf, fpf
  ) = __assert () where {
    extern praxi __assert : () -<prf> vtakeout (void, itm @ l)
  } // end of [where] // end of [prval]
  val () = res := !p_nx
  prval () = opt_some {itm} (res)
  val () = (!p_nx := x0)
  prval () = fpf (pf) // end of [prval]
in
  true
end else let
  val () = linmap_insert_any (map, k0, x0)
  prval () = opt_none {itm} (res)
in
  false
end // end of [if]
//
end // end of [linmap_insert]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_any
  (map, k0, x0) = let
//
val lgN0 =
  linmap_random_lgN (lgMAX)
// end of [val]
//
val nx0 = sknode_make<key,itm> (k0, x0, lgN0)
//
in
//
case+ map of
| @SKIPLIST
    (N, lgN, nxa) => let
    val () = N := succ (N)
    val () =
      if :(
        lgN: natLte (lgMAX)
      ) =>
        (lgN < lgN0) then lgN := lgN0
      // end of [if]
    val () = sknodelst_insert (nxa, k0, lgN0, nx0)
    prval () =
      pridentity (lgN) // opening the type of [lgN]
    // end of [prval]
    prval () = fold@ (map)
  in
    // nothing
  end // end of [SKIPLIST]
//
end // end of [linmap_insert_any]

(* ****** ****** *)
//
// HX:
// for [sknode_takeout] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} sknode_takeout
  {n:int}{ni:nat | ni <= n}
  (nx: sknode1 (key, itm, n), k0: key, ni: int ni): sknodeGt0 (key, itm, 0)
// end of [sknode_takeout]
extern
fun{
key:t0p;itm:vt0p
} sknodelst_takeout
  {n:int}{ni:nat | ni <= n}
  (nxa: sknodelst (key, itm, n), k0: key, ni: int ni): sknodeGt0 (key, itm, 0)
// end of [sknodelst_takeout]

implement
{key,itm}
sknode_takeout
  (nx, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = sknode_get_next (nx, ni1)
  val p_nx1 = sknode2ptr (nx1)
in
  if p_nx1 > nullp then let
    val k1 = sknode_get_key (nx1)
    val sgn = compare_key_key (k0, k1)
  in
    if sgn < 0 then
      sknode_takeout (nx, k0, ni1)
    else if sgn > 0 then
      sknode_takeout (nx1, k1, ni)
    else let // sgn = 0
      val () =
        sknode_set_next (nx, ni1, sknode_get_next (nx1, ni1))
      // end of [val]
    in
      if ni1 > 0 then sknode_takeout (nx, k0, ni1) else nx1
    end // end of [if]
  end else
    sknode_takeout (nx, k0, ni1)
  // end of [if]
end else
  sknode_null (1)
// end of [of]
//
end // end of [sknode_takeout]

implement
{key,itm}
sknodelst_takeout
  (nxa, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = sknodelst_get_at (nxa, ni1)
  val p_nx = sknode2ptr (nx)
in
  if p_nx > nullp then let
    val k = sknode_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then
      sknodelst_takeout (nxa, k0, ni1)
    else if sgn > 0 then
      sknode_takeout (nx, k0, ni)
    else let // sgn = 0
      val () = sknodelst_set_at (nxa, ni1, sknode_get_next (nx, ni1))
    in
      if ni1 > 0 then sknodelst_takeout (nxa, k0, ni1) else nx
    end
  end else
    sknodelst_takeout (nxa, k0, ni1)
  // end of [if]
end else
  sknode_null (1)
// end of [if]
//
end // end of [sknodelst_takeout]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout
  (map, k0, res) = let
in
//
case+ map of
| @SKIPLIST
    (N, lgN, nxa) => let
    val nx = sknodelst_takeout (nxa, k0, lgN)
    val p_nx = sknode2ptr (nx)
  in
    if p_nx > nullp then let
      prval (
      ) = __assert (N) where {
        extern praxi __assert {N:int} (N: size_t N): [N>0] void
      } // end of [prval]
      val () = N := pred (N)
      prval () = fold@ (map)
      val () = sknode_free (nx, res)
      prval () = opt_some {itm} (res)
    in
      true
    end else let
      prval () = fold@ (map)
      prval () = opt_none {itm} (res)
    in
      false
    end // end of [if]
  end // end of [SKIPLIST]
//
end // end of [linmap_takeout]

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach_env
  (map, env) = let
//
fun
sknode_foreach_env
(
  nx: sknodeGt0 (key, itm, 0), env: &env
) : void = let
  val p_nx = sknode2ptr (nx)
in
//
if p_nx > nullp then let
  val k = sknode_get_key (nx)
  val [l:addr]
    p_i = sknode_getref_item (nx)
  val nx1 = sknode_get_next<key,itm> (nx, 0)
//
  prval (
    pf, fpf
  ) = __assert () where {
    extern praxi __assert : () -<prf> vtakeout (void, itm @ l)
  } // end of [prval]
//
  val test = linmap_foreach$cont<key,itm><env> (k, !p_i, env)
in
  if test then let
    val () = linmap_foreach$fwork<key,itm><env> (k, !p_i, env)
    prval () = fpf (pf)
  in
    sknode_foreach_env (nx1, env)
  end else let
    prval () = fpf (pf) in (*nothing*)
  end // end of [if]
end else () // end of [if]
//
end // end of [sknode_foreach_env]
//
in
//
case+ map of
| SKIPLIST
    (N, lgN, nxa) => let
    val nx = sknodelst_get_at (nxa, 0)
    val () = sknode_foreach_env (nx, env)
  in
    // nothing
  end // end of [SKIPLIST]
//
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}
linmap_freelin
  (map) = let
//
fun
sknode_freelin
(
  nx: sknodeGt0 (key, itm, 0)
) : void = let
  val p_nx = sknode2ptr (nx)
in
//
if p_nx > nullp then let
  val [l:addr]
    p_i = sknode_getref_item (nx)
  val nx1 = sknode_get_next<key,itm> (nx, 0)
  prval (pf, fpf) = __assert () where {
    extern praxi __assert : () -<prf> (itm @ l, itm? @ l -<lin,prf> void)
  } // end of [prval]
  val () = linmap_freelin$clear<itm> (!p_i)
  prval () = fpf (pf)
  val () =
    __free (nx) where {
    extern fun __free : sknode1 (key, itm) -<0,!wrt> void = "mac#ATS_MFREE"
  } // end of [where] // end of [val]
in
  sknode_freelin (nx1)
end else () // end of [if]
//
end // end of [sknode_freelin]
//
in
//
case+ map of
| ~SKIPLIST
    (N, lgN, nxa) => (
    $effmask_all (sknode_freelin (sknodelst_get_at (nxa, 0)))
  ) // end of [SKIPLIST]
//
end // end of [linmap_freelin]

(* ****** ****** *)

implement
{key,itm}
linmap_free_ifnil
  (map) = let
//
vtypedef map = map (key, itm)
val map2 =
  __cast (map) where {
  extern castfn __cast : (!map >> map?) -<> map
} // end of [where] // end of [val]
//
in
//
case+ map2 of
| @SKIPLIST
    (N, lgN, nxa) => let
  in
    if N = i2sz(0) then let
      val nxa_ = nxa
      val () =
        free@ {..}{0}{0} (map2)
      val () =
        __free_null (nxa_) where {
        extern praxi __free_null : {n:int} sknodelst (key, itm, n) -<> void
      } // end of [where] // end of [val]
      prval () = opt_none {map} (map)
    in
      false
    end else let
      prval () = fold@ (map2)
      prval () =
        __assert (map, map2) where {
        extern praxi __assert : (!map? >> map, map) -<prf> void
      } // end of [val]
      prval () = opt_some {map} (map)
    in
      true
    end // end of [if]
  end // end of [SKIPLIST]
//
end // end of [linmap_free_ifnil]

(* ****** ****** *)

(* end of [linmap_skiplist.dats] *)
