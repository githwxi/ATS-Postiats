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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linmap_skiplist.sats"

(* ****** ****** *)
//
macdef i2sz (i) = g1int2uint (,(i))
//
(* ****** ****** *)

implement{key}
compare_key_key
  (k1, k2) = gcompare_val<key> (k1, k2)
// end of [compare_key_key]

(* ****** ****** *)
//
// HX-2012-12-01:
// the file should be included here
// before [map_vtype] is assumed
//
#include "./SHARE/linmap.hats" // code reuse
//
(* ****** ****** *)

implement
linmap_random_initize () =
  ftmp () where {
  extern fun ftmp : () -> void = "atslib_srand48_with_time"
} // end of [linmap_random_initize]

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
node_type (
  key:t@ype, itm:vt@ype+, l:addr, n:int
) // end of [node_type]

stadef node = node_type

typedef
node0 (
  key:t0p
, itm:vt0p
, n:int
) = [l:addr] node (key, itm, l, n)
typedef
node0 (
  key:t0p
, itm:vt0p
) = [l:addr;n:nat] node (key, itm, l, n)

typedef
node1 (
  key:t0p
, itm:vt0p
, n:int
) = [l:agz] node (key, itm, l, n)
typedef
node1 (
  key:t0p
, itm:vt0p
) = [l:agz;n:nat] node (key, itm, l, n)

(* ****** ****** *)

typedef
nodeGt0 (
  key:t0p, itm:vt0p, ni:int
) = [n:int | n > ni] node0 (key, itm, n)

(* ****** ****** *)

extern
castfn
node2ptr
  {key:t0p;itm:vt0p}
  {l:addr}{n:int} (nx: node (key, itm, l, n)):<> ptr (l)
// end of [node2ptr]

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

fun{
} node_null
  {key:t0p;itm:vt0p}{n:nat} .<>.
  (n: int n):<> node (key, itm, null, n) = $UN.castvwtp0 (nullp)
// end of [node_null]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} node_make
  {lgN:int | lgN > 0}
  (k0: key, x0: itm, lgN: int lgN): node1 (key, itm, lgN)
// end of [node_make]

extern
fun{
key:t0p;itm:vt0p
} node_free
  {lgN:int | lgN > 0}
  (nx: node1 (key, itm, lgN), res: &itm? >> itm): void
// end of [node_free]

extern
fun{
key:t0p;itm:vt0p
} node_get_key (nx: node1 (key, itm)):<> key

extern
fun{
key:t0p;itm:vt0p
} node_getref_item (nx: node1 (key, itm)):<> Ptr1

(* ****** ****** *)

abstype
nodearr_type
  (key:t@ype, itm:vt@ype+, int(*size*))
stadef nodearr = nodearr_type

extern
fun nodearr_get_at
  {key:t0p;itm:vt0p}
  {n:int}{i:nat | i < n}
  (nxa: nodearr (key, itm, n), i: int i):<> nodeGt0 (key, itm, i)
// end of [nodearr_get_at]

extern
fun nodearr_set_at
  {key:t0p;itm:vt0p}
  {n:int}{i:nat | i < n}
  (nxa: nodearr (key, itm, n), i: int i, nx0: nodeGt0 (key, itm, i)): void
// end of [nodearr_set_at]

extern
fun nodearr_make // HX: initized with nulls
  {key:t0p;itm:vt0p}{n:nat} (n: int n):<> nodearr (key, itm, n)
// end of [nodearr_make]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} node_get_nodearr
  {n:nat} (nx: node1 (key, itm, n)):<> nodearr (key, itm, n)
// end of [node_get_nodearr]

extern
fun{
key:t0p;itm:vt0p
} node_get_nodeasz {n:nat} (nx: node1 (key, itm, n)):<> int (n)

(* ****** ****** *)
//
// HX: internal representation of a node
//
vtypedef
_node_struct (
  key: t0p, itm: vt0p
) = @{
  key= key, item=itm, nodearr=ptr, nodeasz= int
} // end of [_node_struct]

(* ****** ****** *)

implement
{key,itm}
node_make
  {lgN} (
  k0, x0, lgN
) = let
  vtypedef VT = _node_struct (key, itm)
  val (pfat, pfgc | p) = ptr_alloc<VT> ()
  val () = p->key := k0
  val () = p->item := $UN.castvwtp0{itm?}{itm}(x0)
  val () = p->nodearr := $UN.cast{ptr}(nodearr_make(lgN))
  val () = p->nodeasz := lgN
in
  $UN.castvwtp0 {node1(key,itm,lgN)} @(pfat, pfgc | p)
end // end of [node_make]

(* ****** ****** *)

implement
{key,itm}
node_free
  (nx, res) = let
//
  vtypedef VT = _node_struct (key, itm)
//
  prval (
    pfat, pfgc | p
  ) = __cast (nx) where {
    extern
    castfn __cast (
      nx: node1 (key, itm)
    ) :<> [l:addr] (VT @ l, free_gc_v l | ptr l)
  } // end of [prval]
//
  val () = res := p->item
//
  val () =
    __free (p->nodearr) where {
    extern fun __free : ptr -<0,!wrt> void = "ats_free_gc"
  } // end of [val]
//
  val () = ptr_free {VT?} (pfgc, pfat | p)
//
in
  // nothing
end // end of [node_free]

(* ****** ****** *)

extern
castfn
__cast_node
  {key:t0p;itm:vt0p} (
  nx: node1 (key, itm)
) :<> [l:addr] (
  _node_struct (key, itm) @ l
, _node_struct (key, itm) @ l -<lin,prf> void
| ptr l
) // end of [__cast_node]

(* ****** ****** *)

implement
{key,itm}
node_get_key
  (nx) = let
  val (pf, fpf | p) = __cast_node (nx)
  val key = p->key
  prval () = fpf (pf)
in
  key
end // end of [node_get_key]

implement
{key,itm}
node_getref_item
  (nx) = let
  val (pf, fpf | p) = __cast_node (nx)
  val p_item = addr@ (p->item)
  prval () = fpf (pf)
in
  $UN.cast2Ptr1 (p_item)
end // end of [node_getref_item]

implement
{key,itm}
node_get_nodearr
  {n} (nx) = let
  val (pf, fpf | p) = __cast_node (nx)
  val nxa = p->nodearr
  prval () = fpf (pf)
in
  $UN.cast {nodearr(key, itm, n)} (nxa)
end // end of [node_get_nodearr]

implement
{key,itm}
node_get_nodeasz
  {n} (nx) = let
  val (pf, fpf | p) = __cast_node (nx)
  val asz = p->nodeasz
  prval () = fpf (pf)
in
  $UN.cast {int(n)} (asz)
end // end of [node_get_nodeasz]

(* ****** ****** *)

local

assume
nodearr_type
  (key:t0p, itm:vt0p, n:int) = arrayref (ptr, n)
// end of [nodearr_type]

in // in of [local]

implement
nodearr_make (n) = let
  val asz = i2sz(n) in arrayref_make_elt<ptr> (asz, nullp)
end // end of [nodearr]

implement
nodearr_get_at
  {key,itm}{i}
  (nxa, i) = let
  typedef T = nodeGt0 (key, itm, i)
  val nx0 = $effmask_ref (arrayref_get_at (nxa, i)) in $UN.cast{T}(nx0)
end // end of [nodearr_get_at]

implement
nodearr_set_at
  {key,itm}{i}
  (nxa, i, nx0) = let
  val nx0 = $UN.cast{ptr} (nx0) in $effmask_ref (arrayref_set_at (nxa, i, nx0))
end // end of [nodearr_set_at]

end // end of [local]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} node_get_next
  {n:int}{ni:nat | ni < n}
  (nx: node1 (key, itm, n), ni: int ni):<> nodeGt0 (key, itm, ni)
// end of [node_get_next]

extern
fun{
key:t0p;itm:vt0p
} node_set_next
  {n,n1:int}{ni:nat | ni < n} (
  nx: node1 (key, itm, n), ni: int ni, nx0: nodeGt0 (key, itm, ni)
) :<> void // end of [node_set_next]

(* ****** ****** *)

datavtype
skiplist (
  key:t@ype, itm:vt@ype+
) = // HX: [lgN] is the *current* highest level
  | {N:nat}{lgN:nat | lgN <= lgMAX}
    SKIPLIST (key, itm) of (size_t(N), int(lgN), nodearr(key, itm, lgMAX))
// end of [skiplist]

(* ****** ****** *)

assume
map_vtype
  (key:t0p, itm:vt0p) = skiplist (key, itm)
// end of [map_vtype]

(* ****** ****** *)

implement
{key,itm}
linmap_make_nil () =
  SKIPLIST (i2sz(0), 0, nodearr_make (lgMAX))
// end of [linmap_make_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_is_nil (map) = let
  val SKIPLIST (N, _, _) = map in N = i2sz(0)
end // end of [linmap_is_nil]

implement
{key,itm}
linmap_isnot_nil (map) = let
  val SKIPLIST (N, _, _) = map in N > i2sz(0)
end // end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size (map) =
  let val SKIPLIST (N, _, _) = map in N end
// end of [linmap_size]

(* ****** ****** *)
//
// HX:
// for [node_search] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} node_search {n:int}
  (nx: node1 (key, itm, n), k0: key, ni: natLte n):<> node0 (key, itm)
// end of [node_search]
extern
fun{
key:t0p;itm:vt0p
} nodearr_search {n:int}
  (nxa: nodearr (key, itm, n), k0: key, ni: natLte n):<> node0 (key, itm)
// end of [nodearr_search]

(* ****** ****** *)

implement
{key,itm}
node_search
  (nx, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = node_get_next (nx, ni1)
  val p_nx1 = node2ptr (nx1)
in
//
if p_nx1 > nullp then let
  val k1 = node_get_key (nx1)
  val sgn = compare_key_key (k0, k1)
in
  if sgn < 0 then
    node_search (nx, k0, ni1)
  else if sgn > 0 then
    node_search (nx1, k0, ni)
  else nx1 // end of [if]
end else
  node_search (nx, k0, ni1)
// end of [if]
//
end else node_null (0)
//
end // end of [node_search]

implement
{key,itm}
nodearr_search
  (nxa, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = nodearr_get_at (nxa, ni1)
  val p_nx = node2ptr (nx)
in
  if p_nx > nullp then let
    val k = node_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then
      nodearr_search (nxa, k0, ni1)
    else if sgn > 0 then
      node_search (nx, k0, ni)
    else nx // end of [if]
  end else
    nodearr_search (nxa, k0, ni1)  
  // end of [if]
end else
  node_null (0)
// end of [if]
//
end // end of [nodearr_search]

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
      nodearr_search (nxa, k0, lgN)
    val p_nx = node2ptr (nx)
  in 
    if p_nx > nullp
      then node_getref_item (nx) else nullp
    // end of [if]
  end // end of [SKIPLIST]
//
end // end of [linmap_search_ref]

(* ****** ****** *)
//
// HX:
// for [node_insert] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} node_insert {n:int}{ni:nat | ni <= n} (
  nx: node1 (key, itm, n), k0: key, ni: int ni, nx0: node1 (key, itm)
) : void // end of [node_insert]
extern
fun{
key:t0p;itm:vt0p
} nodearr_insert {n:int}{ni:nat | ni <= n} (
  nxa: nodearr (key, itm, n), k0: key, ni: int ni, nx0: node1 (key, itm)
) : void // end of [nodearr_insert]

implement
{key,itm}
node_insert
  (nx, k0, ni, nx0) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = node_get_next (nx, ni1)
  val p_nx1 = node2ptr (nx1)
in
  if p_nx1 > nullp then let
    val k1 = node_get_key (nx1)
    val sgn = compare_key_key (k0, k1)
  in
    if sgn <= 0 then let
      val n0 = node_get_nodeasz (nx0)
      val () =
        if (n0 >= ni) then {
        val () = node_set_next (nx, ni1, nx0)
        val () = node_set_next (nx0, ni1, nx1)
      } // end of [if] // end of [val]
    in
      node_insert (nx, k0, ni1, nx0)
    end else
      node_insert (nx1, k0, ni, nx0)
    // end of [if]
  end else let
    val n0 = node_get_nodeasz (nx0)
    val () =
      if (n0 >= ni) then node_set_next (nx, ni1, nx0)
    // end of [val]
  in
    node_insert (nx, k0, ni1, nx0)
  end // end of [if]
end else (
  // nothing
) // end of [if]
//
end // end of [node_insert]

implement
{key,itm}
nodearr_insert
  (nxa, k0, ni, nx0) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = nodearr_get_at (nxa, ni1)
  val p_nx = node2ptr (nx)
in
  if p_nx > nullp then let
    val k = node_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn <= 0 then let
      val n0 = node_get_nodeasz (nx0)
      val () =
        if (n0 >= ni) then {
        val () =
          nodearr_set_at (nxa, ni1, nx0)
        val () = node_set_next (nx0, ni1, nx)
      } // end of [if] // end of [val]
    in
      nodearr_insert (nxa, k0, ni1, nx0)
    end else
      node_insert (nx, k0, ni, nx0)
    // end of [if]
  end else let
    val n0 = node_get_nodeasz (nx0)
    val () =
      if (n0 >= ni) then nodearr_set_at (nxa, ni1, nx0)
    // end of [val]
  in
    nodearr_insert (nxa, k0, ni1, nx0)
  end // end of [if]
end else (
  // nothing
) // end of [if]
//
end // end of [nodearr_insert]

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
  prval (pf, fpf) = __assert () where {
    extern praxi __assert : () -<prf> (itm @ l, itm @ l -<lin,prf> void)
  } // end of [prval]
  val () = res := !p_nx
  prval () = opt_some {itm} (res)
  val () = !p_nx := x0
  prval () = fpf (pf)
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
val nx0 = node_make<key,itm> (k0, x0, lgN0)
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
    val () = nodearr_insert (nxa, k0, lgN0, nx0)
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
// for [node_takeout] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} node_takeout
  {n:int}{ni:nat | ni <= n}
  (nx: node1 (key, itm, n), k0: key, ni: int ni): nodeGt0 (key, itm, 0)
// end of [node_takeout]
extern
fun{
key:t0p;itm:vt0p
} nodearr_takeout
  {n:int}{ni:nat | ni <= n}
  (nxa: nodearr (key, itm, n), k0: key, ni: int ni): nodeGt0 (key, itm, 0)
// end of [nodearr_takeout]

implement
{key,itm}
node_takeout
  (nx, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = node_get_next (nx, ni1)
  val p_nx1 = node2ptr (nx1)
in
  if p_nx1 > nullp then let
    val k1 = node_get_key (nx1)
    val sgn = compare_key_key (k0, k1)
  in
    if sgn < 0 then
      node_takeout (nx, k0, ni1)
    else if sgn > 0 then
      node_takeout (nx1, k1, ni)
    else let // sgn = 0
      val () =
        node_set_next (nx, ni1, node_get_next (nx1, ni1))
      // end of [val]
    in
      if ni1 > 0 then node_takeout (nx, k0, ni1) else nx1
    end // end of [if]
  end else
    node_takeout (nx, k0, ni1)
  // end of [if]
end else
  node_null (1)
// end of [of]
//
end // end of [node_takeout]

implement
{key,itm}
nodearr_takeout
  (nxa, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = nodearr_get_at (nxa, ni1)
  val p_nx = node2ptr (nx)
in
  if p_nx > nullp then let
    val k = node_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then
      nodearr_takeout (nxa, k0, ni1)
    else if sgn > 0 then
      node_takeout (nx, k0, ni)
    else let // sgn = 0
      val () = nodearr_set_at (nxa, ni1, node_get_next (nx, ni1))
    in
      if ni1 > 0 then nodearr_takeout (nxa, k0, ni1) else nx
    end
  end else
    nodearr_takeout (nxa, k0, ni1)
  // end of [if]
end else
  node_null (1)
// end of [if]
//
end // end of [nodearr_takeout]

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
    val nx = nodearr_takeout (nxa, k0, lgN)
    val p_nx = node2ptr (nx)
  in
    if p_nx > nullp then let
      prval () = __assert (N) where {
        extern praxi __assert {N:int} (N: size_t N): [N>0] void
      } // end of [prval]
      val () = N := pred (N)
      val () = node_free (nx, res)
      prval () = opt_some {itm} (res)
      prval () = fold@ (map)
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
fun node_foreach_env (
  nx: nodeGt0 (key, itm, 0), env: &env
) : void = let
  val p_nx = node2ptr (nx)
in
//
if p_nx > nullp then let
  val k = node_get_key (nx)
  val [l:addr]
    p_i = node_getref_item (nx)
  val nx1 = node_get_next<key,itm> (nx, 0)
//
  prval (
    pf, fpf
  ) = __assert () where {
    extern praxi __assert : () -<prf> (itm @ l, itm @ l -<lin,prf> void)
  } // end of [prval]
//
  val test = linmap_foreach$cont<key,itm><env> (k, !p_i, env)
in
  if test then let
    val () = linmap_foreach$fwork<key,itm><env> (k, !p_i, env)
    prval () = fpf (pf)
  in
    node_foreach_env (nx1, env)
  end else let
    prval () = fpf (pf) in (*nothing*)
  end // end of [if]
end else () // end of [if]
//
end // end of [node_foreach_env]
//
in
//
case+ map of
| SKIPLIST
    (N, lgN, nxa) => let
    val nx = nodearr_get_at (nxa, 0)
  in
    node_foreach_env (nx, env)
  end // end of [SKIPLIST]
//
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}
linmap_freelin
  (map) = let
//
fun node_freelin (
  nx: nodeGt0 (key, itm, 0)
) : void = let
  val p_nx = node2ptr (nx)
in
//
if p_nx > nullp then let
  val [l:addr]
    p_i = node_getref_item (nx)
  val nx1 = node_get_next<key,itm> (nx, 0)
  prval (pf, fpf) = __assert () where {
    extern praxi __assert : () -<prf> (itm @ l, itm? @ l -<lin,prf> void)
  } // end of [prval]
  val () = linmap_freelin$clear<itm> (!p_i)
  prval () = fpf (pf)
  val () =
    __free (nx) where {
    extern fun __free : node1 (key, itm) -<0,!wrt> void = "ats_free_gc"
  } // end of [where] // end of [val]
in
  node_freelin (nx1)
end else () // end of [if]
//
end // end of [node_freelin]
//
in
//
case+ map of
| ~SKIPLIST
    (N, lgN, nxa) => (
    $effmask_all (node_freelin (nodearr_get_at (nxa, 0)))
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
val map1 =
  __cast (map) where {
  extern castfn __cast : (!map >> map?) -<> map
}
//
in
//
case+ map1 of
| @SKIPLIST
    (N, lgN, nxa) => let
  in
    if N = i2sz(0) then let
      val nxa_ = nxa
      val () =
        free@ {..}{0}{0} (map1)
      val () =
        __free_null (nxa_) where {
        extern praxi __free_null : {n:int} nodearr (key, itm, n) -<> void
      } // end of [where] // end of [val]
      prval () = opt_none {map} (map)
    in
      false
    end else let
      prval () = fold@ (map1)
      prval () =
        __assert (map, map1) where {
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
