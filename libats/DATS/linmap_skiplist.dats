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

staload "libats/SATS/linmap.sats"

(* ****** ****** *)

stadef mytkind = $extkind"atslib_linmap_randbst"

(* ****** ****** *)

vtypedef
map (key:t0p, itm:vt0p) = map (mytkind, key, itm)

(* ****** ****** *)
//
macdef i2sz (i) = g1int2uint (,(i))
//
(* ****** ****** *)

implement{}
linmap_skiplist_initize () = ftmp () where {
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
mynode_type
  (key:t@ype, itm:vt@ype+, l:addr, n:int)
stadef mynode = mynode_type

(* ****** ****** *)

typedef
mynode0 (
  key:t0p
, itm:vt0p
, n:int
) = [l:addr] mynode (key, itm, l, n)
typedef
mynode0 (
  key:t0p
, itm:vt0p
) = [l:addr;n:nat] mynode (key, itm, l, n)

typedef
mynode1 (
  key:t0p
, itm:vt0p
, n:int
) = [l:agz] mynode (key, itm, l, n)
typedef
mynode1 (
  key:t0p
, itm:vt0p
) = [l:agz;n:nat] mynode (key, itm, l, n)

(* ****** ****** *)

typedef
mynodeGt0 (
  key:t0p, itm:vt0p, ni:int
) = [n:int | n > ni] mynode0 (key, itm, n)

(* ****** ****** *)

extern
castfn
mynode2ptr
  {key:t0p;itm:vt0p}
  {l:addr}{n:int} (nx: mynode (key, itm, l, n)):<> ptr (l)
// end of [mynode2ptr]

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

fun{
} mynode_null
  {key:t0p;itm:vt0p}{n:nat} .<>.
  (n: int n):<> mynode (key, itm, null, n) = $UN.castvwtp0 (nullp)
// end of [mynode_null]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} mynode_make
  {lgN:int | lgN > 0}
  (k0: key, x0: itm, lgN: int lgN): mynode1 (key, itm, lgN)
// end of [mynode_make]

extern
fun{
key:t0p;itm:vt0p
} mynode_free
  {lgN:int | lgN > 0}
  (nx: mynode1 (key, itm, lgN), res: &itm? >> itm): void
// end of [mynode_free]

extern
fun{
key:t0p;itm:vt0p
} mynode_get_key (nx: mynode1 (key, itm)):<> key

extern
fun{
key:t0p;itm:vt0p
} mynode_getref_item (nx: mynode1 (key, itm)):<> Ptr1

(* ****** ****** *)

abstype
mynodelst_type
  (key:t@ype, itm:vt@ype+, int(*size*))
stadef mynodelst = mynodelst_type

extern
fun mynodelst_get_at
  {key:t0p;itm:vt0p}
  {n:int}{i:nat | i < n}
  (nxa: mynodelst (key, itm, n), i: int i):<> mynodeGt0 (key, itm, i)
// end of [mynodelst_get_at]

extern
fun mynodelst_set_at
  {key:t0p;itm:vt0p}
  {n:int}{i:nat | i < n}
  (nxa: mynodelst (key, itm, n), i: int i, nx0: mynodeGt0 (key, itm, i)): void
// end of [mynodelst_set_at]

extern
fun mynodelst_make // HX: initized with nulls
  {key:t0p;itm:vt0p}{n:nat} (n: int n):<!wrt> mynodelst (key, itm, n)
// end of [mynodelst_make]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} mynode_get_mynodelst
  {n:nat} (nx: mynode1 (key, itm, n)):<> mynodelst (key, itm, n)
// end of [mynode_get_mynodelst]

extern
fun{
key:t0p;itm:vt0p
} mynode_get_mynodelen {n:nat} (nx: mynode1 (key, itm, n)):<> int (n)

(* ****** ****** *)
//
// HX: internal representation of a mynode
//
vtypedef
_mynode_struct (
  key: t0p, itm: vt0p
) = @{
  key= key, item=itm, mynodelst=ptr, mynodelen= int
} // end of [_mynode_struct]

(* ****** ****** *)

implement
{key,itm}
mynode_make
  {lgN} (
  k0, x0, lgN
) = let
  vtypedef VT = _mynode_struct (key, itm)
  val (pfat, pfgc | p) = ptr_alloc<VT> ()
  val () = p->key := k0
  val () = p->item := $UN.castvwtp0{itm?}{itm}(x0)
  val () = p->mynodelst := $UN.cast{ptr}(mynodelst_make(lgN))
  val () = p->mynodelen := lgN
in
  $UN.castvwtp0 {mynode1(key,itm,lgN)} @(pfat, pfgc | p)
end // end of [mynode_make]

(* ****** ****** *)

implement
{key,itm}
mynode_free
  (nx, res) = let
//
  vtypedef VT = _mynode_struct (key, itm)
//
  prval (
    pfat, pfgc | p
  ) = __cast (nx) where {
    extern
    castfn __cast (
      nx: mynode1 (key, itm)
    ) :<> [l:addr] (VT @ l, free_gc_v l | ptr l)
  } // end of [prval]
//
  val () = res := p->item
//
  val () =
    __free (p->mynodelst) where {
    extern fun __free : ptr -<0,!wrt> void = "ats_free_gc"
  } // end of [val]
//
  val () = ptr_free {VT?} (pfgc, pfat | p)
//
in
  // nothing
end // end of [mynode_free]

(* ****** ****** *)

extern
castfn
__cast_mynode
  {key:t0p;itm:vt0p} (
  nx: mynode1 (key, itm)
) :<> [l:addr] (
  _mynode_struct (key, itm) @ l
, _mynode_struct (key, itm) @ l -<lin,prf> void
| ptr l
) // end of [__cast_mynode]

(* ****** ****** *)

implement
{key,itm}
mynode_get_key
  (nx) = let
  val (pf, fpf | p) = __cast_mynode (nx)
  val key = p->key
  prval () = fpf (pf)
in
  key
end // end of [mynode_get_key]

implement
{key,itm}
mynode_getref_item
  (nx) = let
  val (pf, fpf | p) = __cast_mynode (nx)
  val p_item = addr@ (p->item)
  prval () = fpf (pf)
in
  $UN.cast2Ptr1 (p_item)
end // end of [mynode_getref_item]

implement
{key,itm}
mynode_get_mynodelst
  {n} (nx) = let
  val (pf, fpf | p) = __cast_mynode (nx)
  val nxa = p->mynodelst
  prval () = fpf (pf)
in
  $UN.cast {mynodelst(key, itm, n)} (nxa)
end // end of [mynode_get_mynodelst]

implement
{key,itm}
mynode_get_mynodelen
  {n} (nx) = let
  val (pf, fpf | p) = __cast_mynode (nx)
  val len = p->mynodelen
  prval () = fpf (pf)
in
  $UN.cast {int(n)} (len)
end // end of [mynode_get_mynodelen]

(* ****** ****** *)

local

assume
mynodelst_type
  (key:t0p, itm:vt0p, n:int) = arrayref (ptr, n)
// end of [mynodelst_type]

in // in of [local]

implement
mynodelst_make (n) = let
  val asz = i2sz(n) in arrayref_make_elt<ptr> (asz, nullp)
end // end of [mynodelst]

implement
mynodelst_get_at
  {key,itm}{i}
  (nxa, i) = let
  typedef T = mynodeGt0 (key, itm, i)
  val nx0 = $effmask_ref (arrayref_get_at (nxa, i)) in $UN.cast{T}(nx0)
end // end of [mynodelst_get_at]

implement
mynodelst_set_at
  {key,itm}{i}
  (nxa, i, nx0) = let
  val nx0 = $UN.cast{ptr} (nx0) in $effmask_ref (arrayref_set_at (nxa, i, nx0))
end // end of [mynodelst_set_at]

end // end of [local]

(* ****** ****** *)

extern
fun{
key:t0p;itm:vt0p
} mynode_get_next
  {n:int}{ni:nat | ni < n}
  (nx: mynode1 (key, itm, n), ni: int ni):<> mynodeGt0 (key, itm, ni)
// end of [mynode_get_next]

extern
fun{
key:t0p;itm:vt0p
} mynode_set_next
  {n,n1:int}{ni:nat | ni < n} (
  nx: mynode1 (key, itm, n), ni: int ni, nx0: mynodeGt0 (key, itm, ni)
) :<> void // end of [mynode_set_next]

(* ****** ****** *)

datavtype
skiplist (
  key:t@ype, itm:vt@ype+
) = // HX: [lgN] is the *current* highest level
  | {N:nat}{lgN:nat | lgN <= lgMAX}
    SKIPLIST (key, itm) of (size_t(N), int(lgN), mynodelst(key, itm, lgMAX))
// end of [skiplist]

(* ****** ****** *)

(*
assume
map_vtype (tkind, key:t0p, itm:vt0p) = skiplist (key, itm)
*)
extern
praxi
map_foldin
  {k:t0p;i:vt0p} (x: !skiplist (k, i) >> map (k, i)): void
// end of [map_foldin]
extern
praxi
map_unfold
  {k:t0p;i:vt0p} (x: !map (k, i) >> skiplist (k, i)): void
// end of [map_unfold]

extern
castfn
map_encode {k:t0p;i:vt0p} (x: skiplist (k, i)):<> map (k, i)
extern
castfn
map_decode {k:t0p;i:vt0p} (x: map (k, i)):<> skiplist (k, i)

(* ****** ****** *)

implement
linmap_make_nil<mytkind> () =
  map_encode (SKIPLIST (i2sz(0), 0, mynodelst_make (lgMAX)))
// end of [linmap_make_nil]

(* ****** ****** *)

implement
linmap_is_nil<mytkind>
  (map) = let
//
prval () = map_unfold (map)
val SKIPLIST (N, _, _) = map
prval () = map_foldin (map)
//
in
  if N = i2sz(0) then true else false
end // end of [linmap_is_nil]

implement
linmap_isnot_nil<mytkind>
  (map) = let
//
prval () = map_unfold (map)
val SKIPLIST (N, _, _) = map
prval () = map_foldin (map)
//
in
  if N > i2sz(0) then true else false
end // end of [linmap_isnot_nil]

(* ****** ****** *)

implement(k,i)
linmap_size<mytkind><k,i>
  (map) = let
//
prval () = map_unfold (map)
val SKIPLIST (N, _, _) = map
prval () = map_foldin (map)
//
in
  N
end // end of [linmap_size]

(* ****** ****** *)
//
// HX:
// for [mynode_search] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} mynode_search {n:int}
  (nx: mynode1 (key, itm, n), k0: key, ni: natLte n):<> mynode0 (key, itm)
// end of [mynode_search]
extern
fun{
key:t0p;itm:vt0p
} mynodelst_search {n:int}
  (nxa: mynodelst (key, itm, n), k0: key, ni: natLte n):<> mynode0 (key, itm)
// end of [mynodelst_search]

(* ****** ****** *)

implement
{key,itm}
mynode_search
  (nx, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = mynode_get_next (nx, ni1)
  val p_nx1 = mynode2ptr (nx1)
in
//
if p_nx1 > nullp then let
  val k1 = mynode_get_key (nx1)
  val sgn = compare_key_key (k0, k1)
in
  if sgn < 0 then
    mynode_search (nx, k0, ni1)
  else if sgn > 0 then
    mynode_search (nx1, k0, ni)
  else nx1 // end of [if]
end else
  mynode_search (nx, k0, ni1)
// end of [if]
//
end else mynode_null (0)
//
end // end of [mynode_search]

implement
{key,itm}
mynodelst_search
  (nxa, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = mynodelst_get_at (nxa, ni1)
  val p_nx = mynode2ptr (nx)
in
  if p_nx > nullp then let
    val k = mynode_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then
      mynodelst_search (nxa, k0, ni1)
    else if sgn > 0 then
      mynode_search (nx, k0, ni)
    else nx // end of [if]
  end else
    mynodelst_search (nxa, k0, ni1)  
  // end of [if]
end else
  mynode_null (0)
// end of [if]
//
end // end of [mynodelst_search]

(* ****** ****** *)

implement(k,i)
linmap_search_ref<mytkind><k,i>
  (map, k0) = let
//
prval () = map_unfold (map)
//
in
case+ map of
| SKIPLIST
    (N, lgN, nxa) => let
    val nx =
      mynodelst_search (nxa, k0, lgN)
    val p_nx = mynode2ptr (nx)
    val res = (
      if p_nx > nullp
        then mynode_getref_item (nx) else nullp
      // end of [if]
    ) : Ptr0 // end of [val]
    prval () = map_foldin (map)
  in
    res
  end // end of [SKIPLIST]
//
end // end of [linmap_search_ref]

(* ****** ****** *)
//
// HX:
// for [mynode_insert] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} mynode_insert {n:int}{ni:nat | ni <= n} (
  nx: mynode1 (key, itm, n), k0: key, ni: int ni, nx0: mynode1 (key, itm)
) : void // end of [mynode_insert]
extern
fun{
key:t0p;itm:vt0p
} mynodelst_insert {n:int}{ni:nat | ni <= n} (
  nxa: mynodelst (key, itm, n), k0: key, ni: int ni, nx0: mynode1 (key, itm)
) : void // end of [mynodelst_insert]

implement
{key,itm}
mynode_insert
  (nx, k0, ni, nx0) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = mynode_get_next (nx, ni1)
  val p_nx1 = mynode2ptr (nx1)
in
  if p_nx1 > nullp then let
    val k1 = mynode_get_key (nx1)
    val sgn = compare_key_key (k0, k1)
  in
    if sgn <= 0 then let
      val n0 = mynode_get_mynodelen (nx0)
      val () =
        if (n0 >= ni) then {
        val () = mynode_set_next (nx, ni1, nx0)
        val () = mynode_set_next (nx0, ni1, nx1)
      } // end of [if] // end of [val]
    in
      mynode_insert (nx, k0, ni1, nx0)
    end else
      mynode_insert (nx1, k0, ni, nx0)
    // end of [if]
  end else let
    val n0 = mynode_get_mynodelen (nx0)
    val () =
      if (n0 >= ni) then mynode_set_next (nx, ni1, nx0)
    // end of [val]
  in
    mynode_insert (nx, k0, ni1, nx0)
  end // end of [if]
end else (
  // nothing
) // end of [if]
//
end // end of [mynode_insert]

implement
{key,itm}
mynodelst_insert
  (nxa, k0, ni, nx0) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = mynodelst_get_at (nxa, ni1)
  val p_nx = mynode2ptr (nx)
in
  if p_nx > nullp then let
    val k = mynode_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn <= 0 then let
      val n0 = mynode_get_mynodelen (nx0)
      val () =
        if (n0 >= ni) then {
        val () =
          mynodelst_set_at (nxa, ni1, nx0)
        val () = mynode_set_next (nx0, ni1, nx)
      } // end of [if] // end of [val]
    in
      mynodelst_insert (nxa, k0, ni1, nx0)
    end else
      mynode_insert (nx, k0, ni, nx0)
    // end of [if]
  end else let
    val n0 = mynode_get_mynodelen (nx0)
    val () =
      if (n0 >= ni) then mynodelst_set_at (nxa, ni1, nx0)
    // end of [val]
  in
    mynodelst_insert (nxa, k0, ni1, nx0)
  end // end of [if]
end else (
  // nothing
) // end of [if]
//
end // end of [mynodelst_insert]

(* ****** ****** *)

implement(k,i)
linmap_insert<mytkind><k,i>
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
    extern praxi __assert : () -<prf> vtakeout (void, i @ l)
  } // end of [where] // end of [prval]
  val () = res := !p_nx
  prval () = opt_some {i} (res)
  val () = (!p_nx := x0)
  prval () = fpf (pf) // end of [prval]
in
  true
end else let
  val () = linmap_insert_any (map, k0, x0)
  prval () = opt_none {i} (res)
in
  false
end // end of [if]
//
end // end of [linmap_insert]

(* ****** ****** *)

implement(k,i)
linmap_insert_any<mytkind><k,i>
  (map, k0, x0) = let
//
val lgN0 =
  linmap_random_lgN (lgMAX)
val nx0 = mynode_make<k,i> (k0, x0, lgN0)
//
prval () = map_unfold (map)
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
    val () = mynodelst_insert (nxa, k0, lgN0, nx0)
    prval () =
      pridentity (lgN) // opening the type of [lgN]
    // end of [prval]
    prval () = fold@ (map)
    prval () = map_foldin (map)
  in
    // nothing
  end // end of [SKIPLIST]
//
end // end of [linmap_insert_any]

(* ****** ****** *)
//
// HX:
// for [mynode_takeout] to be called, k0 > the key contained in it
//
extern
fun{
key:t0p;itm:vt0p
} mynode_takeout
  {n:int}{ni:nat | ni <= n}
  (nx: mynode1 (key, itm, n), k0: key, ni: int ni): mynodeGt0 (key, itm, 0)
// end of [mynode_takeout]
extern
fun{
key:t0p;itm:vt0p
} mynodelst_takeout
  {n:int}{ni:nat | ni <= n}
  (nxa: mynodelst (key, itm, n), k0: key, ni: int ni): mynodeGt0 (key, itm, 0)
// end of [mynodelst_takeout]

implement
{key,itm}
mynode_takeout
  (nx, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx1 = mynode_get_next (nx, ni1)
  val p_nx1 = mynode2ptr (nx1)
in
  if p_nx1 > nullp then let
    val k1 = mynode_get_key (nx1)
    val sgn = compare_key_key (k0, k1)
  in
    if sgn < 0 then
      mynode_takeout (nx, k0, ni1)
    else if sgn > 0 then
      mynode_takeout (nx1, k1, ni)
    else let // sgn = 0
      val () =
        mynode_set_next (nx, ni1, mynode_get_next (nx1, ni1))
      // end of [val]
    in
      if ni1 > 0 then mynode_takeout (nx, k0, ni1) else nx1
    end // end of [if]
  end else
    mynode_takeout (nx, k0, ni1)
  // end of [if]
end else
  mynode_null (1)
// end of [of]
//
end // end of [mynode_takeout]

implement
{key,itm}
mynodelst_takeout
  (nxa, k0, ni) = let
in
//
if ni > 0 then let
  val ni1 = ni - 1
  val nx = mynodelst_get_at (nxa, ni1)
  val p_nx = mynode2ptr (nx)
in
  if p_nx > nullp then let
    val k = mynode_get_key (nx)
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then
      mynodelst_takeout (nxa, k0, ni1)
    else if sgn > 0 then
      mynode_takeout (nx, k0, ni)
    else let // sgn = 0
      val () = mynodelst_set_at (nxa, ni1, mynode_get_next (nx, ni1))
    in
      if ni1 > 0 then mynodelst_takeout (nxa, k0, ni1) else nx
    end
  end else
    mynodelst_takeout (nxa, k0, ni1)
  // end of [if]
end else
  mynode_null (1)
// end of [if]
//
end // end of [mynodelst_takeout]

(* ****** ****** *)

implement(k,i)
linmap_takeout<mytkind><k,i>
  (map, k0, res) = let
//
prval () = map_unfold (map)
//
in
//
case+ map of
| @SKIPLIST
    (N, lgN, nxa) => let
    val nx = mynodelst_takeout (nxa, k0, lgN)
    val p_nx = mynode2ptr (nx)
  in
    if p_nx > nullp then let
      prval (
      ) = __assert (N) where {
        extern praxi __assert {N:int} (N: size_t N): [N>0] void
      } // end of [prval]
      val () = N := pred (N)
      val () = mynode_free (nx, res)
      prval () = opt_some {i} (res)
      prval () = fold@ (map)
      prval () = map_foldin (map)
    in
      true
    end else let
      prval () = opt_none {i} (res)
      prval () = fold@ (map)
      prval () = map_foldin (map)
    in
      false
    end // end of [if]
  end // end of [SKIPLIST]
//
end // end of [linmap_takeout]

(* ****** ****** *)

implement(k,i,env)
linmap_foreach_env<mytkind><k,i><env>
  (map, env) = let
//
fun
mynode_foreach_env
(
  nx: mynodeGt0 (k, i, 0), env: &env
) : void = let
  val p_nx = mynode2ptr (nx)
in
//
if p_nx > nullp then let
  val k = mynode_get_key (nx)
  val [l:addr]
    p_i = mynode_getref_item (nx)
  val nx1 = mynode_get_next<k,i> (nx, 0)
//
  prval (
    pf, fpf
  ) = __assert () where {
    extern praxi __assert : () -<prf> vtakeout (void, i @ l)
  } // end of [prval]
//
  val test = linmap_foreach$cont<k,i><env> (k, !p_i, env)
in
  if test then let
    val () = linmap_foreach$fwork<k,i><env> (k, !p_i, env)
    prval () = fpf (pf)
  in
    mynode_foreach_env (nx1, env)
  end else let
    prval () = fpf (pf) in (*nothing*)
  end // end of [if]
end else () // end of [if]
//
end // end of [mynode_foreach_env]
//
prval () = map_unfold (map)
//
in
//
case+ map of
| SKIPLIST
    (N, lgN, nxa) => let
    val nx = mynodelst_get_at (nxa, 0)
    val () = mynode_foreach_env (nx, env)
    prval () = map_foldin (map)
  in
    // nothing
  end // end of [SKIPLIST]
//
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement(k,i)
linmap_freelin<mytkind><k,i>
  (map) = let
//
fun
mynode_freelin
(
  nx: mynodeGt0 (k, i, 0)
) : void = let
  val p_nx = mynode2ptr (nx)
in
//
if p_nx > nullp then let
  val [l:addr]
    p_i = mynode_getref_item (nx)
  val nx1 = mynode_get_next<k,i> (nx, 0)
  prval (pf, fpf) = __assert () where {
    extern praxi __assert : () -<prf> (i @ l, i? @ l -<lin,prf> void)
  } // end of [prval]
  val () = linmap_freelin$clear<i> (!p_i)
  prval () = fpf (pf)
  val () =
    __free (nx) where {
    extern fun __free : mynode1 (k, i) -<0,!wrt> void = "mac#ATS_MFREE"
  } // end of [where] // end of [val]
in
  mynode_freelin (nx1)
end else () // end of [if]
//
end // end of [mynode_freelin]
//
val map = map_decode (map)
//
in
//
case+ map of
| ~SKIPLIST
    (N, lgN, nxa) => (
    $effmask_all (mynode_freelin (mynodelst_get_at (nxa, 0)))
  ) // end of [SKIPLIST]
//
end // end of [linmap_freelin]

(* ****** ****** *)

implement(k,i)
linmap_free_ifnil<mytkind><k,i>
  (map) = let
//
vtypedef map = map (k, i)
val map1 =
  __cast (map) where {
  extern castfn __cast : (!map >> map?) -<> map
} // end of [val]
val map1 = map_decode (map1)
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
        extern praxi __free_null : {n:int} mynodelst (k, i, n) -<> void
      } // end of [where] // end of [val]
      prval () = opt_none {map} (map)
    in
      false
    end else let
      prval () = fold@ (map1)
      prval () = map_foldin (map1)
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
