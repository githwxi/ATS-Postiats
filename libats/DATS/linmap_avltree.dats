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
//
#define
ATS_PACKNAME
"ATSLIB.libats.linmap_avltree"
//
#define ATS_DYNLOADFLAG 0 // no dynloading
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/SATS/linmap_avltree.sats"
//
(* ****** ****** *)
//
#include
"./SHARE/linmap.hats" // code reuse
#include
"./SHARE/linmap_node.hats" // code reuse
//
(* ****** ****** *)
//
stadef
mytkind = $extkind"atslib_linmap_avltree"
//
(* ****** ****** *)
//
// HX: maximal height difference of two siblings
//
#define HTDF 1
#define HTDF1 (HTDF+1)
#define HTDF_1 (HTDF-1)
//
(* ****** ****** *)
//
datavtype avltree
(
  key: t@ype, itm:vt@ype+, int(*height*)
) =
  | {hl,hr:nat |
     hl <= hr+HTDF;
     hr <= hl+HTDF}
    B (key, itm, 1+max(hl,hr)) of
    (
      int (1+max(hl,hr)), key, itm, avltree (key, itm, hl), avltree (key, itm, hr)
    )
  | E (key, itm, 0) of ((*void*))
// end of [datavtype avltree]
//
(* ****** ****** *)
//
vtypedef
avltree(
  key:t0p, itm:vt0p
) = [h:nat] avltree(key, itm, h)
//
vtypedef
avltree_inc
  (key:t0p, itm:vt0p, h:int) =
  [h1:nat | h <= h1; h1 <= h+1] avltree (key, itm, h1)
//
vtypedef
avltree_dec
  (key:t0p, itm:vt0p, h:int) =
  [h1:nat | h1 <= h; h <= h1+1] avltree (key, itm, h1)
//
(* ****** ****** *)
//
assume
map_vtype
(
  key:t0p, itm: vt0p
) = avltree (key, itm)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
linmap_nil() = E()
implement
{}(*tmp*)
linmap_make_nil() = E()
//
(* ****** ****** *)

implement
{}(*tmp*)
linmap_is_nil (map) =
  case+ map of E _ => true | B _ => false
// end of [linmap_is_nil]

implement
{}(*tmp*)
linmap_isnot_nil (map) =
  case+ map of B _ => true | E _ => false
// end of [linmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
linmap_size
  (map) = let
//
fun aux
(
  t0: !avltree (key, itm), res: size_t
) : size_t = let
in
//
case+ t0 of
| B (
    _, _, _, tl, tr
  ) => let
    val res = succ(res)
    val res = aux (tl, res)
    val res = aux (tr, res)
  in
    res
  end // end of [B]
| E ((*void*)) => res
//
end // end of [aux]
//
in
  $effmask_all (aux (map, i2sz(0)))
end // end of [linmap_size]

(* ****** ****** *)

implement
{key,itm}
linmap_search_ref
  (map, k0) = let
//
fun search
  {h:nat} .<h>. (
  t0: !avltree (key, itm, h)
) :<!wrt> cPtr0(itm) = let
in
//
case+ t0 of
//
| @B (
    _(*h*), k, x, tl, tr
  ) => let
    val sgn =
      compare_key_key<key> (k0, k)
    // end of [val]
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val res = search (tl)
        prval () = fold@ (t0) in res
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val res = search (tr)
        prval () = fold@ (t0) in res
      end // end of [sgn > 0]
    | _ (*sgn = 0*) => let
        val p_x = addr@x
        prval () = fold@ (t0) in $UN.ptr2cptr(p_x)
      end // end of [sgn = 0]
  end // end of [let] // end of [B]
//
| E ((*void*)) => cptr_null{itm}()
//
end // end of [search]
//
in
  search (map)
end // end of [linmap_search_ref]

(* ****** ****** *)

implement
{key,itm}
linmap_freelin
  (map) = let
//
fun aux
  {h:nat} .<h>.
(
  t: avltree (key, itm, h)
) : void = let
in
//
case+ t of
| @B (
    _, k, x, tl, tr
  ) => let
    val () = linmap_freelin$clear<itm> (x)
    val tl = tl and tr = tr
    val () = free@ {..}{0,0} (t)
    val () = aux (tl) and () = aux (tr)
  in
    // nothing
  end // end of [BSTcons]
| ~E ((*void*)) => ()
//
end // end of [aux]
//
in
  $effmask_all (aux (map))
end // end of [linmap_freelin]

(* ****** ****** *)

macdef
avlht (t) =
(
case+ ,(t) of
| B (h, _, _, _, _) => h | E ((*void*)) => 0
) // end of [avlht]

(* ****** ****** *)
//
fn
{key:t0p
;itm:vt0p}
avltree_height{h:int}
  (t: !avltree (key, itm, h)):<> int (h) = avlht(t)
//
(* ****** ****** *)

(*
** left rotation for restoring height invariant
*)
fn
{key:t0p
;itm:vt0p}
avltree_lrotate
  {hl,hr:nat | hl+HTDF1 == hr}
  {l,l_h,l_k,l_x,l_tl,l_tr:addr}
(
  pf_h: (int?)@l_h
, pf_k: key@l_k, pf_x: itm@l_x
, pf_tl: avltree (key, itm, hl) @ l_tl
, pf_tr: avltree (key, itm, hr) @ l_tr
| p_h: ptr l_h
, hl: int hl, p_tl: ptr l_tl
, hr: int hr, p_tr: ptr l_tr
, t0: B_unfold (l, l_h, l_k, l_x, l_tl, l_tr)
) :<!wrt> avltree_inc (key, itm, hr) = let
  val tr = !p_tr
  val+@B{..}{hrl,hrr}
    (hr2, _, _, trl, trr) = tr
  val hrl = avlht(trl): int(hrl)
  and hrr = avlht(trr): int(hrr)
in
  if hrl <= hrr+HTDF_1 then let
    val hrl1 = hrl + 1
    val () = !p_h := hrl1
    val () = !p_tr := trl
    prval () = fold@ (t0)
    val () = hr2 := 1+max(hrl1, hrr)
    val () = trl := t0
    prval () = fold@ (tr)
  in
    tr // B (1+max(hrl1,hrr), kr, xr, B (hrl1, k, x, tl, trl), trr)
  end else let // [hrl==hrr+HTDF1]: deep rotation
    val trl_ = trl
    val+@B{..}{hrll,hrlr}
      (hrl, _, _, trll, trlr) = trl_
    val hrll = avlht (trll) : int(hrll)
    and hrlr = avlht (trlr) : int(hrlr)
    val () = !p_h := 1+max(hl,hrll)
    val () = !p_tr := trll
    prval () = fold@ (t0)
    val () = hr2 := 1+max(hrlr, hrr)
    val () = trl := trlr
    prval () = fold@ (tr)
    val () = hrl := hr
    val () = trll := t0
    val () = trlr := tr
    prval () = fold@ (trl_)
  in
    trl_ // B (hr, krl, xrl,
         //    B (1+max(hl,hrll), k, x, tl, trll),
         //    B (1+max(hrlr,hrr), kr, xr, trlr, trr))
  end // end of [if]
end // end of [avltree_lrotate]

(* ****** ****** *)

(*
** right rotation for restoring height invariant
*)
fn
{key:t0p
;itm:vt0p}
avltree_rrotate
  {hl,hr:nat | hl == hr+HTDF1}
  {l,l_h,l_k,l_x,l_tl,l_tr:addr}
(
  pf_h: (int?)@l_h
, pf_k: key@l_k, pf_x: itm@l_x
, pf_tl: avltree (key, itm, hl) @ l_tl
, pf_tr: avltree (key, itm, hr) @ l_tr
| p_h: ptr l_h
, hl : int hl, p_tl: ptr l_tl
, hr : int hr, p_tr: ptr l_tr
, t0: B_unfold (l, l_h, l_k, l_x, l_tl, l_tr)
) :<!wrt> avltree_inc (key, itm, hl) = let
  val tl = !p_tl
  val+@B{..}{hll,hlr}
    (hl2, _, _, tll, tlr) = tl
  val hll = avlht(tll): int(hll)
  and hlr = avlht(tlr): int(hlr)
in
  if hll+HTDF_1 >= hlr then let
    val hlr1 = hlr + 1
    val () = !p_h := hlr1
    val () = !p_tl := tlr
    prval () = fold@ (t0)
    val () = hl2 := 1+max(hll,hlr1)
    val () = tlr := t0
    prval () = fold@ (tl)
  in
    tl // B (1+max(hll,hlr1), kl, xl, tll, B (hlr1, x, tlr, tr))
  end else let
    val tlr_ = tlr
    val+@B{..}{hlrl,hlrr}
      (hlr, _, _, tlrl, tlrr) = tlr_
    val hlrl = avlht (tlrl): int(hlrl)
    val hlrr = avlht (tlrr): int(hlrr)
    val () = !p_h := 1+max(hlrr,hr)
    val () = !p_tl := tlrr
    prval () = fold@ (t0)
    val () = hl2 := 1+max(hll,hlrl)
    val () = tlr := tlrl
    prval () = fold@ (tl)
    val () = hlr := hl
    val () = tlrl := tl
    val () = tlrr := t0
    prval () = fold@ (tlr_)
  in
    tlr_ // B (hl, klr, xlr,
         //    B (1+max(hll,hlrl), kl, xl, tll, tlrl),
         //    B (1+max(hlrr,hr), k, x, tlrr, tr))
  end // end of [if]
end // end of [avltree_rrotate]

(* ****** ****** *)

implement
{key,itm}
linmap_insert
  (map, k0, x0, res) = let
//
fun insert
  {h:nat} .<h>.
(
  t0: &avltree (key, itm, h) >> avltree_inc (key, itm, h), k0: key, x0: &(itm) >> opt(itm, b)
) :<!wrt> #[b:bool] bool(b) = let
in
//
case+ t0 of
//
| @B{..}{hl,hr}
    (h, k, x, tl, tr) => let
    prval pf_h = view@h
    prval pf_k = view@k
    prval pf_x = view@x
    prval pf_tl = view@tl
    prval pf_tr = view@tr
    val sgn = compare_key_key<key> (k0, k)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val ans = insert (tl, k0, x0)
        val hl = avltree_height<key,itm> (tl)
        and hr = avltree_height<key,itm> (tr)
      in
        if hl-hr <= HTDF then let
          val () = h := 1+max(hl,hr)
          prval () = fold@ (t0)
        in
          ans // B (1+max(hl,hr), k, x, tl, tr)
        end else let // hl==hr+HTDF1
          val p_h = addr@(h)
          val p_tl = addr@(tl)
          val p_tr = addr@(tr)
          val () = t0 := avltree_rrotate<key,itm> (pf_h, pf_k, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          ans
        end // end of [if]
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val ans = insert (tr, k0, x0)
        val hl = avltree_height<key,itm> (tl)
        and hr = avltree_height<key,itm> (tr)
      in
        if hr-hl <= HTDF then let
          val () = h := 1+max(hl,hr)
          prval () = fold@ (t0)
        in
          ans // B (1+max(hl, hr), k, x, tl, tr)
        end else let // hl+HTDF1==hr
          val p_h = addr@(h)
          val p_tl = addr@(tl)
          val p_tr = addr@(tr)
          val () = t0 := avltree_lrotate<key,itm> (pf_h, pf_k, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          ans
        end // end of [if]
      end // end of [sgn > 0]
    | _ (*[k0] is found*) => let
        val x_ = x
        val () = x := x0
        val () = x0 := x_
        prval () = fold@ (t0)
        prval () = opt_some{itm}(x0)
      in
        true // B (h, k, x, tl, tr)
      end // end of [sgn = 0]
  end // end of [B]
//
| ~E () => let
    val x0_ = x0
    val () = t0 := B{key,itm}(1, k0, x0_, E (), E ())
    prval () = opt_none{itm}(x0)
  in
    false
  end // end of [E]
//
end // end of [insert]
//
val () = res := x0
//
in
  insert (map, k0, res)
end // end of [linmap_insert]

(* ****** ****** *)

fun
{key:t0p
;itm:vt0p}
avltree_maxout
  {h:pos} .<h>.
(
  t0: &avltree (key, itm, h) >> avltree_dec (key, itm, h)
) :<!wrt> mynode1 (key, itm) = let
  val+@B{..}{hl,hr}(h, k, x, tl, tr) = t0
  prval pf_h = view@h
  prval pf_k = view@k
  prval pf_x = view@x
  prval pf_tl = view@tl
  prval pf_tr = view@tr
in
  case+ tr of
  | B _ => let
      val nx = avltree_maxout<key,itm> (tr)
      val hl = avltree_height<key,itm> (tl)
      and hr = avltree_height<key,itm> (tr)
    in
      if hl-hr <= HTDF then let
        val () = h := 1+max(hl,hr)
        prval () = fold@ (t0) // B (1+max(hl,hr), x, tl, tr)
      in
        nx
      end else let
        val p_h = addr@h
        val p_tl = addr@tl
        val p_tr = addr@tr
        val () = t0 := avltree_rrotate<key,itm> (pf_h, pf_k, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
      in
        nx
      end // end of [if]
    end // end of [B]
  | ~E () => let
      val t0_ = t0
      val () = t0 := tl
    in
      $UN.castvwtp0{mynode1(key,itm)}((pf_h, pf_k, pf_x, pf_tl, pf_tr | t0_))
    end // end of [E]
end // end of [avltree_maxout]

(* ****** ****** *)

fun
{key:t0p
;itm:vt0p}
avltree_minout
  {h:pos} .<h>.
(
  t0: &avltree (key, itm, h) >> avltree_dec (key, itm, h)
) :<!wrt> mynode1 (key, itm) = let
  val+@B{..}{hl,hr}(h, k, x, tl, tr) = t0
  prval pf_h = view@h
  prval pf_k = view@k
  prval pf_x = view@x
  prval pf_tl = view@tl
  prval pf_tr = view@tr
in
  case+ tl of
  | B _ => let
      val nx = avltree_minout<key,itm> (tl)
      val hl = avltree_height<key,itm> (tl)
      and hr = avltree_height<key,itm> (tr)
    in
      if hr-hl <= HTDF then let
        val () = h := 1+max(hl,hr)
        prval () = fold@ (t0) // B (1+max(hl,hr), x, tl, tr)
      in
        nx
      end else let
        val p_h = addr@h
        val p_tl = addr@tl
        val p_tr = addr@tr
        val () = t0 := avltree_lrotate<key,itm> (pf_h, pf_k, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
      in
        nx
      end // end of [if]
    end // end of [B]
  | ~E () => let
      val t0_ = t0
      val () = t0 := tr
    in
      $UN.castvwtp0{mynode1(key,itm)}((pf_h, pf_k, pf_x, pf_tl, pf_tr | t0_))
    end // end of [E]
end // end of [avltree_minout]

(* ****** ****** *)

extern
castfn
mynode_decode
  {key:t0p;itm:vt0p}{l:agz}
  (nx: mynode(key, INV(itm), l)):<> B_pstruct (int?, key, itm, ptr?, ptr?)
// end of [mynode_decode]

(* ****** ****** *)

fn
{key:t0p
;itm:vt0p}
avltree_lrcon
  {hl,hr:nat |
   hl <= hr+HTDF;
   hr <= hl+HTDF}
(
  tl: avltree (key, itm, hl)
, tr: avltree (key, itm, hr)
) :<!wrt> avltree_dec (key, itm, 1+max(hl,hr)) =
(
case+ tr of
| B _ => let
    var tr = tr
    val nx =
      avltree_minout<key,itm> (tr)
    // end of [val]
    val t1 = mynode_decode (nx)
    val+B(h1, k1, x1, tl1, tr1) = t1
    prval pf_h1 = view@h1
    prval pf_k1 = view@k1
    prval pf_x1 = view@x1
    prval pf_tl1 = view@tl1
    prval pf_tr1 = view@tr1
    val hl = avltree_height<key,itm> (tl)
    and hr = avltree_height<key,itm> (tr)
    val () = tl1 := tl and () = tr1 := tr 
  in
    if hl-hr <= HTDF then let
      val () = h1 := 1+max(hl,hr)
      prval () = fold@ (t1)
    in
      t1
    end else let
      val p_h1 = addr@h1
      val p_tl1 = addr@tl1
      val p_tr1 = addr@tr1
    in
      avltree_rrotate<key,itm> (pf_h1, pf_k1, pf_x1, pf_tl1, pf_tr1 | p_h1, hl, p_tl1, hr, p_tr1, t1)
    end // end of [if]
  end // end of [B]
| ~E ((*void*)) => tl
) (* end of [avltree_lrcon] *)

(* ****** ****** *)

implement
{key,itm}
linmap_takeout_ngc
  (xs, k0) = let
//
fun takeout{h:nat} .<h>.
(
  t0: &avltree (key, itm, h) >> avltree_dec (key, itm, h)
) :<!wrt> mynode0(key, itm) = let
//
in
//
case+ t0 of
| @B{..}{hl,hr}
    (h, k, x, tl, tr) => let
    prval pf_h = view@h
    prval pf_k = view@k
    prval pf_x = view@x
    prval pf_tl = view@tl
    prval pf_tr = view@tr
    val sgn = compare_key_key<key> (k0, k)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val nx = takeout (tl)
        val hl = avltree_height<key,itm> (tl)
        and hr = avltree_height<key,itm> (tr)
      in
        if hr-hl <= HTDF then let
          val () = h := 1+max(hl,hr)
          prval () = fold@ (t0)
        in
          nx
        end else let
          val p_h = addr@(h)
          val p_tl = addr@(tl)
          val p_tr = addr@(tr)
          val () = t0 := avltree_lrotate<key,itm> (pf_h, pf_k, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          nx
        end // end of [if]
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val nx = takeout (tr)
        val hl = avltree_height<key,itm> (tl)
        and hr = avltree_height<key,itm> (tr)
      in
        if hl-hr <= HTDF then let
          val () = h := 1+max(hl,hr)
          prval () = fold@ (t0)
        in
          nx
        end else let
          val p_h = addr@(h)
          val p_tl = addr@(tl)
          val p_tr = addr@(tr)
          val () = t0 := avltree_rrotate<key,itm> (pf_h, pf_k, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          nx
        end // end of [if]
      end // end of [sgn > 0]
    | _ (*[x0] is found*) => let
        val t0_ = t0
        val () = t0 := avltree_lrcon<key,itm> (tl, tr)
      in
        $UN.castvwtp0{mynode1(key,itm)}((pf_h, pf_k, pf_x, pf_tl, pf_tr | t0_))
      end // end of [sgn = 0]
    // end of [case]
  end // end of [B]
| E ((*void*)) => mynode_null ()
//
end // end of [takeout]
//
in
  takeout (xs)
end // end of [linmap_takeout_ngc]

(* ****** ****** *)

implement
{key,itm}{env}
linmap_foreach_env
  (xs, env) = let
//
val p_env = addr@env
//
fun foreach
  {h:nat} .<h>.
(
  t0: !avltree (key, itm, h), p_env: ptr
) : void = let
in
//
case+ t0 of
| @B (h, k, x, tl, tr) => let
//
    val () = foreach (tl, p_env)
//
    val (
      pf, fpf | p_env
    ) = $UN.ptr_vtake{env}(p_env)
    val () = linmap_foreach$fwork<key,itm><env> (k, x, !p_env)
    prval () = fpf (pf)
//
    val () = foreach (tr, p_env)
//
    prval () = fold@ (t0)
//
  in
    // nothing
  end // end of [B]
| E ((*void*)) => ()
//
end // end of [foreach]
//
in
  foreach (xs, p_env)
end // end of [linmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}{ki2}
linmap_flistize
  (map) = let
//
vtypedef ki = @(key, itm)
//
fun aux
  {h:nat} .<h>. (
  t: avltree (key, itm, h), res: List0_vt (ki2)
) : List0_vt (ki2) = let
in
//
case+ t of
| ~B (
    _, k, x, tl, tr
  ) => res where {
    val res = aux (tl, res)
    val kx2 = linmap_flistize$fopr<key,itm><ki2> (k, x)
    val res = list_vt_cons{ki2}(kx2, res)
    val res = aux (tr, res)
  } // end of [BSTcons]
| ~E ((*void*)) => res
//
end // end of [aux]
//
val res = aux (map, list_vt_nil ())
//
in
  list_vt_reverse (res)
end // end of [linmap_flistize]

(* ****** ****** *)
//
// HX: functions for processing mynodes
//
(* ****** ****** *)

implement
{}(*tmp*)
mynode_null{key,itm} () =
  $UN.castvwtp0{mynode(key,itm,null)}(the_null_ptr)
// end of [mynode_null]

(* ****** ****** *)

implement
{key,itm}
mynode_getref_itm
  (nx) = let
//
val t0 =
  $UN.castvwtp1{avltree(key,itm,1)}(nx)
val+@B(_, k, x, tl, tr) = t0; val p_x = addr@(x)
prval ((*void*)) = fold@(t0)
prval ((*void*)) = $UN.cast2void (t0)
//
in
  $UN.ptr2cptr{itm}(p_x)
end (* end of [mynode_getfree_itm] *)

(* ****** ****** *)

implement
{key,itm}
mynode_free_keyitm
  (nx, k0, x0) = () where
{
//
val+~B(_, k, x, tl, tr) = $UN.castvwtp0{avltree(key,itm,1)}(nx)
val () = k0 := k and () = x0 := x
prval ((*void*)) = $UN.cast2void (tl)
prval ((*void*)) = $UN.cast2void (tr)
//
} (* end of [mynode_free_keyitm] *)

(* ****** ****** *)

implement
{key,itm}
mynode_getfree_itm (nx) = x where
{
//
val+~B(_, k, x, tl, tr) = $UN.castvwtp0{avltree(key,itm,1)}(nx)
//
prval ((*void*)) = $UN.cast2void (tl)
prval ((*void*)) = $UN.cast2void (tr)
//
} (* end of [mynode_getfree_itm] *)

(* ****** ****** *)

(* end of [linmap_avltree.dats] *)
