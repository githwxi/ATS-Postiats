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
(* Start time: December, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.linmap_list"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linmap_list.sats"

(* ****** ****** *)

#include "./SHARE/linmap.hats" // code reuse
#include "./SHARE/linmap_node.hats" // code reuse

(* ****** ****** *)

stadef
mytkind = $extkind"atslib_linmap_list"

(* ****** ****** *)

assume
map_vtype (k:t0p, i:vt0p) = List0_vt @(k, i)

(* ****** ****** *)

implement{}
linmap_nil () = list_vt_nil ()
implement{}
linmap_make_nil () = list_vt_nil ()

(* ****** ****** *)

implement{}
linmap_is_nil
  (map) = ans where {
  val ans = (
    case+ map of list_vt_nil _ => true | list_vt_cons _ => false
  ) : bool // end of [val]
} // end of [linmap_is_nil]

implement{}
linmap_isnot_nil
  (map) = ans where {
  val ans = (
    case+ map of list_vt_nil _ => false | list_vt_cons _ => true
  ) : bool // end of [val]
} // end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size (map) = g1int2uint (list_vt_length (map))

(* ****** ****** *)

implement
{key,itm}
linmap_free (map) = list_vt_free<(key,itm)> (map)

implement
{key,itm}
linmap_freelin (map) = let
//
vtypedef ki = @(key, itm)
fun aux (kxs: List_vt(ki)): void =
(
case+ kxs of
| @list_vt_cons
    (kx, kxs1) => let
    val kxs1 = kxs1
    val () = linmap_freelin$clear<itm> (kx.1)
    val () = free@{ki}{0}(kxs)
  in
    aux (kxs1)
  end // end of [list_vt_cons]
| ~list_vt_nil ((*void*)) => ()
)
//
in
  $effmask_all (aux (map))
end // end of [linmap_freelin]

(* ****** ****** *)

implement
{key,itm}
linmap_insert
  (map, k0, x0, res) = let
//
val nx0 =
  mynode_make_keyitm<key,itm> (k0, x0)
//
val nx1 =
  linmap_insert_ngc<key,itm> (map, nx0)
//
val p1 = mynode2ptr (nx1)
//
in
//
if p1 > 0 then let
  val () =
  res := mynode_getfree_itm (nx1)
  prval () = opt_some{itm}(res)
in
  true
end else let
  prval () = mynode_free_null (nx1)
  prval () = opt_none{itm}(res)
in
  false
end (* end of [if] *)
//
end // end of [linmap_insert]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_any
  (map, k0, x0) = let
//
vtypedef ki = @(key, itm)
val () = map := list_vt_cons{ki}( @(k0, x0), map )
//
in
  // nothing
end // end of [linmap_insert_any]

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach_env
  (map, env) = let
//
vtypedef ki = @(key, itm)
//
implement{ki}{env}
list_vt_foreach$cont (kx, env) = true
implement
list_vt_foreach$fwork<ki><env>
  (kx, env) = linmap_foreach$fwork<key,itm><env> (kx.0, kx.1, env)
//
in
  list_vt_foreach_env<ki><env> (map, env)
end // end of [linmap_foreach_env]

(* ****** ****** *)
//
// HX: [map] is just a list
//
implement
{key,itm}
linmap_listize (map) = map

implement
{key,itm}{ki2}
linmap_flistize (map) = let
//
vtypedef ki = @(key, itm) 
implement
list_vt_mapfree$fopr<ki><ki2>
  (kx) = linmap_flistize$fopr<key,itm><ki2> (kx.0, kx.1)
//
in
  list_vt_mapfree<ki><ki2> (map)
end // end of [linmap_flistize]

(* ****** ****** *)

implement
{key,itm}
linmap_listize1 (map) = list_vt_copy<(key,itm)> (map)

(* ****** ****** *)
//
// HX: functions for processing mynodes
//
(* ****** ****** *)

implement{
} mynode_null
  {key,itm} () = let
//
vtypedef
mynode = mynode(key,itm,null)
//
in
  $UN.castvwtp0{mynode}(the_null_ptr)
end // end of [mynode_null]

(* ****** ****** *)

implement
{key,itm}
mynode_make_keyitm
  (k, x) = let
//
vtypedef ki = @(key, itm)
val nx = list_vt_cons{ki}{0}( @(k, x), _ )
//
in
  $UN.castvwtp0{mynode1(key,itm)}(nx)
end // end of [mynode_make_keyitm]

(* ****** ****** *)

implement
{key,itm}
mynode_get_key
  (nx) = k where {
//
vtypedef ki = @(key, itm)
//
val nx2 = $UN.castvwtp1{List1_vt(ki)}(nx)
//
val+@list_vt_cons (kx, _) = nx2
//
val k = kx.0
//
prval () = fold@ (nx2)
prval () = __assert (nx2) where {
  extern praxi __assert : List1_vt(ki) -<prf> void
} // end of [where] // end of [prval]
//
} // end of [mynode_get_key]

implement
{key,itm}
mynode_getref_itm
  (nx) = p_x where {
//
vtypedef ki = @(key, itm)
//
val nx2 = $UN.castvwtp1{List1_vt(ki)}(nx)
//
val+@list_vt_cons (kx, _) = nx2
//
val p_x = addr@ (kx.1)
val p_x = $UN.cast{cPtr1(itm)}(p_x)
//
prval () = fold@ (nx2)
prval () = __assert (nx2) where {
  extern praxi __assert : List1_vt(ki) -<prf> void
} // end of [where] // end of [prval]
//
} // end of [mynode_getref_itm]

(* ****** ****** *)

implement
{key,itm}
mynode_free_keyitm
  (nx, k0, x0) = () where {
//
vtypedef ki = @(key, itm)
//
val nx = $UN.castvwtp0{List1_vt(ki)}(nx)
//
val+~list_vt_cons (kx, nx2) = nx
val () = k0 := kx.0 and () = x0 := kx.1
prval () = __assert (nx2) where {
  extern praxi __assert : List0_vt(ki) -<prf> void
} // end of [where] // end of [prval]
//
} // end of [mynode_free_keyitm]

(* ****** ****** *)

implement
{key,itm}
mynode_getfree_itm
  (nx) = kx.1 where {
//
vtypedef ki = @(key, itm)
//
val nx = $UN.castvwtp0{List1_vt(ki)}(nx)
//
val+~list_vt_cons (kx, nx2) = nx
//
prval ((*void*)) = $UN.cast2void (nx2)
//
} // end of [mynode_getfree_itm]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ngc
  (map, k0) = let
//
vtypedef ki = @(key, itm)
//
fun loop
  {n:nat} .<n>. (
  kxs: !list_vt (ki, n), k0: key
) :<> Ptr0 = let
in
//
case+ kxs of
| @list_vt_cons
    (kx, kxs1) => let
    val iseq = equal_key_key<key> (kx.0, k0)
  in
    if iseq then let
      prval () = fold@ (kxs)
    in
      $UN.castvwtp1{Ptr1} (kxs)
    end else let
      val res = loop (kxs1, k0)
      prval () = fold@ (kxs) in res
    end // end of [if]
  end // end of [list_vt_cons]
| @list_vt_nil () => let
    prval () = fold@ (kxs) in the_null_ptr
  end // end of [list_vt_cons]
//
end // end of [loop]
//
in
  loop (map, k0) // HX: Ptr1
end // end of [linmap_search_ngc]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_ngc
  (map, nx0) = let
//
val k0 = mynode_get_key (nx0)
val nx1 =
  linmap_takeout_ngc<key,itm> (map, k0)
val () =
  linmap_insert_any_ngc<key,itm> (map, nx0)
//
in
  nx1
end // end of [linmap_insert_ngc]

(* ****** ****** *)

implement
{key,itm}
linmap_insert_any_ngc
  (map, nx0) = let
//
vtypedef ki = @(key, itm)
//
val nx0 = $UN.castvwtp0{List1_vt(ki)}(nx0)
//
val+@list_vt_cons (_, kxs) = nx0
prval () = __assert (kxs) where {
  extern praxi __assert : List0_vt(ki) -<prf> void
} // end of [where] // end of [prval]
//
in
  kxs := map; fold@ (nx0); map := nx0
end // end of [linmap_insert_any_ngc]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout_ngc
  (map, k0) = let
//
vtypedef ki = @(key, itm)
vtypedef mynode0 = mynode0 (key, itm)
vtypedef mynode1 = mynode1 (key, itm)
//
fun loop (
  kxs: &List0_vt (ki) >> _, k0: key
) : mynode0 = let
//
vtypedef kis = List0_vt (ki)
//
in
//
case+ kxs of
| @list_vt_cons
    (kx, kxs1) => let
    val iseq =
      equal_key_key<key> (kx.0, k0)
    // end of [val]
  in
    if iseq then let
      val p1 = $UN.castvwtp1{ptr}(kxs1)
      prval () = fold@ (kxs)
      val res = $UN.castvwtp0{mynode1}(kxs)
      val () = kxs := $UN.castvwtp0{kis}(p1)
    in
      res
    end else let
      val res = loop (kxs1, k0)
      prval () = fold@ (kxs) in res
    end // end of [if]
  end // end of [list_vt_cons]
| @list_vt_nil () => let
    prval () = fold@ (kxs) in mynode_null ()
  end // end of [list_vt_cons]
//
end // end of [loop]
//
in
  loop (map, k0) // HX: mynode0
end // end of [linmap_takeout_ngc]

(* ****** ****** *)

(* end of [linmap_list.dats] *)
