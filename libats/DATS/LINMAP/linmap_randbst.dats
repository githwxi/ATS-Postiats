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

staload "libats/SATS/linmap_randbst.sats"

(* ****** ****** *)
//
// HX-2012-12-01:
// the file should be included here
// before [map_viewtype] is assumed
//
#include "./linmap_share.hats" // in current dir
//
(* ****** ****** *)
//
// HX: for linear binary search trees
//
dataviewtype
bstree (
  key:t@ype, itm: viewt@ype+, int(*size*)
) =
  | BSTnil (
      key, itm, 0
    ) of (
      // argmentless
    ) // end of [BSTnil]
  | {nl,nr:nat}
    BSTcons (
      key, itm, 1+nl+nr
    ) of (
      int (1+nl+nr), key, itm, bstree (key, itm, nl), bstree (key, itm, nr)
    ) // end of [BSTcons]
// end of [bstree]
//
(* ****** ****** *)

assume
map_viewtype
  (key:t0p, itm: vt0p) = [n:nat] bstree (key, itm, n)
// end of [map_viewtype]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} bstree_size
  {n:int} .<>. (
  t: !bstree (key, itm, n)
) :<> int n = case+ t of
  | BSTcons (n, _, _, _, _) => n | BSTnil _ => 0 
// end of [bstree_size]

(* ****** ****** *)

implement{} linmap_nil () = BSTnil ()

(* ****** ****** *)

implement{
} linmap_is_nil (map) =
  case+ map of BSTnil _ => true | BSTcons _ => false
// end of [linmap_is_nil]

implement{
} linmap_isnot_nil (map) =
  case+ map of BSTnil _ => false | BSTcons _ => true
// end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size
  (map) = g1int2uint (bstree_size<key,itm> (map))
// end of [linmap_size]

(* ****** ****** *)

local

fun{
key:t0p;itm:t0p
} _free
  {n:nat} .<n>. (
  t: bstree (key, itm, n)
) :<!wrt> void = let
in
//
case+ t of
| ~BSTcons (
    _, _, _, tl, tr
  ) => let
    val () = _free (tl)
    and () = _free (tr) in (*nothing*)
  end // end of [BSTcons]
| ~BSTnil () => ()
//
end // end of [_free]

in // in of [local]

implement
{key,itm}
linmap_free (map) = _free<key,itm> (map)

end // end of [local]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} bstree_search_ref
  {n:nat} .<n>. (
  t: !bstree (key, itm, n), k0: key
) :<> Ptr0 = let
in
//
case+ t of
| @BSTcons (
    _(*sz*), k, x, tl, tr
  ) => let
    val sgn = compare_key_key (k0, k)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val res = bstree_search_ref (tl, k0) in fold@ (t); res
      end // end of [_]
    | _ when sgn > 0 => let
        val res = bstree_search_ref (tr, k0) in fold@ (t); res
      end // end of [_]
    | _ => let
        val res = addr@ (x) in fold@ (t); res
      end // end of [_]
  end // end of [BSTcons]
| BSTnil () => the_null_ptr
//
end // end of [bstree_search_ref]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = bstree_search_ref<key,itm> (map, k0)
// end of [linmap_search_ref]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} bstree_insert_atroot
  {n:nat} .<n>. (
  t: &bstree (key, itm, n) >> bstree (key, itm, n+1-i), k0: key, x0: &itm >> opt (itm, i>0)
) :<!wrt> #[i:nat2] int (i) = let
in
//
case+ t of
| @BSTcons (
    n, k, x, tl, tr
  ) => let
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then let
      val ans = bstree_insert_atroot<key,itm> (tl, k0, x0)
    in
      if ans = 0 then let
        val tl_ = tl
        val+ @BSTcons
          (nl, _, _, tll, tlr) = tl_
        // end of [val]
        val n_ = n; val nll = bstree_size (tll)
        val () = tl := tlr
        val () = n := n_ - nll
        prval () = fold@ (t)
        val () = tlr := t
        val () = nl := n_ + 1
        prval () = fold@ (tl_)
        val () = t := tl_
      in
        ans
      end else let
        prval () = fold@ (t) in ans // [x0] is alreay in the tree [t]
      end // end of [if]
    end else if sgn > 0 then let
      val ans = bstree_insert_atroot<key,itm> (tr, k0, x0)
    in
      if ans = 0 then let
        val tr_ = tr
        val+ @BSTcons
          (nr, _, _, trl, trr) = tr_
        // end of [val]
        val n_ = n
        val nrr = bstree_size (trr)
        val () = tr := trl
        val () = n := n_ - nrr
        prval () = fold@ (t)
        val () = trl := t
        val () = nr := n_ + 1
        prval () = fold@ (tr_)
        val () = t := tr_
      in
        ans
      end else let
        prval () = fold@ (t) in ans // [k0] alreay in [t]
      end // end of [if]
    end else let (* sgn = 0 *)
      val x_ = x
      val () = x := x0
      prval () = fold@ (t)
      val () = x0 := x_
      prval () = opt_some {itm} (x0)
    in
      1 // replaced
    end // end of [if]
  end (* end of [BSTcons] *)
| ~BSTnil () => let
    val x0_ = x0
    val () = t := BSTcons (1, k0, x0_, BSTnil (), BSTnil ())
    prval () = opt_none {itm} (x0)
  in
    0 // inserted
  end // end of [BSTnil]
//
end // end of [bstree_insert_atroot]

fun{
key:t0p;itm:vt0p
} bstree_insert_random
  {n:nat} .<n>. (
  t: &bstree (key, itm, n) >> bstree (key, itm, n+1-i), k0: key, x0: &itm >> opt(itm, i>0)
) : #[i:nat2] int (i) = let
in
//
case+ t of
| @BSTcons (
    n, k, x, tl, tr
  ) => let
    val randbit = linmap_random_m_n<> (1, n)
  in
    if randbit = 0 then let
      prval () = fold@ (t) in bstree_insert_atroot<key,itm> (t, k0, x0)
    end else let
      val sgn = compare_key_key (k0, k)
    in
      if sgn < 0 then let
        val ans = bstree_insert_random<key,itm> (tl, k0, x0)
      in
        if ans = 0 then (n := n + 1; fold@ (t); ans) else (fold@ (t); ans)
      end else if sgn > 0 then let
        val ans = bstree_insert_random<key,itm> (tr, k0, x0)
      in
        if ans = 0 then (n := n + 1; fold@ (t); ans) else (fold@ (t); ans)
      end else let // sgn = 0
        prval () = opt_some {itm} (x0)
      in
        fold@ (t); 1 // [k0] is at the root of [t]
      end // end of [if]
    end // end of [if]
  end (* end of [BSTcons] *)
| ~BSTnil () => let
    val x0_ = x0
    val () = t := BSTcons (1, k0, x0_, BSTnil (), BSTnil ())
    prval () = opt_none {itm} (x0)
  in
    0 // inserted
  end (* end of [BSTnil] *)
//
end (* end of [bstree_insert_random] *)

(* ****** ****** *)

implement
{key,itm}
linmap_insert (
  map, k0, x0, res
) = let
  val () = res := x0
  val i = bstree_insert_random (map, k0, res)
in
  if i > 0 then true else false
end // end of [linmap_insert]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} bstree_join_random
  {nl,nr:nat} .<nl+nr>. (
  tl: bstree (key, itm, nl), tr: bstree (key, itm, nr)
) : bstree (key, itm, nl+nr) = let
in
//
case+ tl of
//
| @BSTcons (
    nl, _, _, tll, tlr
  ) => (
  case+ tr of
  | @BSTcons (
      nr, _, _, trl, trr
    ) => let
      val n = nl + nr
      val randbit = linmap_random_m_n<> (nl, nr)
    in
      if randbit = 0 then let
        prval () = fold@ (tr)
        val () = tlr := bstree_join_random (tlr, tr)
        val () = nl := n
        prval () = fold@ (tl)
      in
        tl
      end else let
        prval () = fold@ tl
        val () = trl := bstree_join_random (tl, trl)
        val () = nr := n
        prval () = fold@ (tr)
      in
        tr
      end // end of [if]
    end (* end of [BSTcons] *)
  | ~BSTnil () => let
      val () = fold@ (tl) in tl
    end // end of [BSTnil]
  ) (* end of [BSTcons] *)
//
| ~BSTnil () => tr
//
end // end of [bstree_join_random]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} bstree_remove_random
  {n:nat} .<n>. (
  t: &bstree (key, itm, n) >> bstree (key, itm, n-i), k0: key, x0: &(itm?) >> opt (itm, i>0)
) : #[i:nat2 | i <= n] int (i) = let
in
//
case+ t of
| @BSTcons {..} {nl,nr}
    (n, k, x, tl, tr) => let
    val sgn = compare_key_key (k0, k)
  in
    if sgn < 0 then let
      val ans = bstree_remove_random<key,itm> (tl, k0, x0)
      val () = n := n - ans
      prval () = fold@ (t)
    in
      ans
    end else if sgn > 0 then let
      val ans = bstree_remove_random<key,itm> (tr, k0, x0)
      val () = n := n - ans
      prval () = fold@ (t)
    in
      ans
    end else let
      val () = x0 := x
      prval () = opt_some (x0)
      val t_new = bstree_join_random<key,itm> (tl, tr)
      val () = free@ {key,itm} {0,0} (t)
      val () = t := t_new
    in
      1 (* removed *)
    end // end of [0]
  end (* end of [BSTcons] *)
| BSTnil () => let
    prval () = opt_none {itm} (x0) in 0 // not(removed)
  end // end of [BSTnil]
//
end // end of [bstree_remove_random]

(* ****** ****** *)

implement
{key,itm}
linmap_takeout
  (map, k0, res) = let
  val i = bstree_remove_random<key,itm> (map, k0, res)
in
  if i > 0 then true else false
end // end of [linmap_takeout]

implement
{key,itm}
linmap_remove
  (map, k0) = let
  var res: itm
  val i = bstree_remove_random<key,itm> (map, k0, res)
  prval () = opt_clear (res)
in
  if i > 0 then true else false
end // end of [linmap_remove]

(* ****** ****** *)

implement
{key,itm}
linmap_listize
  (map) = let
//
typedef ki = @(key, itm)
//
fun aux
  {m,n:nat} .<n>. (
  t: !bstree (key, itm, n), res: list_vt (ki, m)
) :<> list_vt (ki, m+n) = let
in
//
case+ t of
| BSTcons (
    _, k, i, tl, tr
  ) => res where {
    val res = aux (tr, res)
    val res = list_vt_cons ((k, i), res)
    val res = aux (tl, res)
  } // end of [BSTcons]
| BSTnil () => res
//
end // end of [aux]
//
in
  aux (map, list_vt_nil ())
end // end of [linmap_listize]

implement
{key,itm}
linmap_listize_free
  (map) = let
//
viewtypedef ki = @(key, itm)
//
fun aux
  {m,n:nat} .<n>. (
  t: bstree (key, itm, n), res: list_vt (ki, m)
) :<!wrt> list_vt (ki, m+n) = let
in
//
case+ t of
| ~BSTcons (
    _, k, i, tl, tr
  ) => res where {
    val res = aux (tr, res)
    val res = list_vt_cons ((k, i), res)
    val res = aux (tl, res)
  } // end of [BSTcons]
| ~BSTnil () => res
//
end // end of [aux]
//
in
  aux (map, list_vt_nil ())
end // end of [linmap_listize_free]

(* ****** ****** *)

(* end of [linmap_randbst.dats] *)
