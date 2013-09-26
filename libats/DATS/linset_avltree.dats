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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linset_avltree.sats"

(* ****** ****** *)
//
#include "./SHARE/linset.hats" // code reuse
#include "./SHARE/linset_node.hats" // code reuse
//
(* ****** ****** *)

stadef mytkind = $extkind"atslib_linset_avltree"

(* ****** ****** *)
//
// HX: maximal height difference of two siblings
//
#define HTDF 1
#define HTDF1 (HTDF+1)
#define HTDF_1 (HTDF-1)
//
(* ****** ****** *)

datavtype avltree
(
  a:t@ype+, int(*height*)
) =
  | {hl,hr:nat |
     hl <= hr+HTDF;
     hr <= hl+HTDF}
    B (a, 1+max(hl,hr)) of
      (int (1+max(hl,hr)), a, avltree (a, hl), avltree (a, hr))
  | E (a, 0) of ((*void*))
// end of [avltree]

vtypedef
avltree_inc (a:t0p, h:int) =
  [h1:nat | h <= h1; h1 <= h+1] avltree (a, h1)
// end of [avltree_inc]

vtypedef
avltree_dec (a:t0p, h:int) =
  [h1:nat | h1 <= h; h <= h1+1] avltree (a, h1)
// end of [avltree_dec]

(* ****** ****** *)

assume
set_vtype (a:t@ype) = [h:nat] avltree (a, h)

(* ****** ****** *)

implement{} linset_nil () = E ()
implement{} linset_make_nil () = E ()

(* ****** ****** *)

implement{a}
linset_sing (x) = B{a}(1, x, E, E)
implement{a}
linset_make_sing (x) = B{a}(1, x, E, E)

(* ****** ****** *)

implement
{a}(*tmp*)
linset_size
  (xs) = aux (xs) where
{
//
fun aux
  {h:nat} .<h>.
  (t: !avltree (a, h)):<> size_t =
(
  case+ t of
  | B (h, x, tl, tr) => succ(aux (tl) + aux (tr))
  | E ((*void*)) => i2sz(0)
) (* end of [aux] *)
//
} // end of [linset_size]

(* ****** ****** *)

implement{}
linset_is_nil (xs) =
(
  case+ xs of B _ => false | E () => true
)
implement{}
linset_isnot_nil (xs) =
(
  case+ xs of B _ => true | E () => false
)

(* ****** ****** *)

implement{a}
linset_is_member
  (xs, x0) = aux (xs) where
{
//
fun aux {h:nat} .<h>.
  (t: !avltree (a, h)):<> bool = let
in
//
case+ t of
| B (h, x, tl, tr) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn < 0
      then aux (tl)
      else (if sgn > 0 then aux (tr) else true)
    // end of [if]
  end // end of [B]
| E ((*void*)) => false
//
end // end of [aux]
//
} // end of [linset_is_member]

(* ****** ****** *)

implement{a}
linset_copy (xs) = let
//
fun copy
  {h:nat} .<h>.
  (t: !avltree (a, h)):<!wrt> avltree (a, h) =
(
case+ t of
| B (h, x, tl, tr) => B{a}(h, x, copy (tl), copy (tr)) | E () => E ()
) // end of [copy]
in
  copy (xs)
end // end of [linset_copy]

(* ****** ****** *)

implement{a}
linset_free (xs) = let
//
fun free
  {h:nat} .<h>.
  (t: avltree (a, h)):<!wrt> void =
(
case+ t of
| ~B (h, x, tl, tr) => (free (tl); free (tr)) | ~E () => ()
) // end of [free]
in
  free (xs)
end // end of [linset_free]

(* ****** ****** *)

macdef
avlht (t) =
(
case+ ,(t) of B (h, _, _, _) => h | E ((*void*)) => 0
) // end of [avlht]

(* ****** ****** *)

fn{a:t0p}
avltree_height{h:int}(t: !avltree (a, h)):<> int (h) = avlht(t)

(* ****** ****** *)

(*
** left rotation for restoring height invariant
*)
fn{a:t0p}
avltree_lrotate
  {hl,hr:nat | hl+HTDF1 == hr}
  {l,l_h,l_x,l_tl,l_tr:addr}
(
  pf_h: (int?)@l_h, pf_x: a@l_x
, pf_tl: avltree (a, hl) @ l_tl
, pf_tr: avltree (a, hr) @ l_tr
| p_h: ptr l_h
, hl: int hl, p_tl: ptr l_tl
, hr: int hr, p_tr: ptr l_tr
, t0: B_unfold (l, l_h, l_x, l_tl, l_tr)
) :<!wrt> avltree_inc (a, hr) = let
  val tr = !p_tr
  val+@B{..}{hrl,hrr}
    (hr2, _, trl, trr) = tr
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
    tr // B (1+max(hrl1,hrr), xr, B (hrl1, x, tl, trl), trr)
  end else let // [hrl==hrr+HTDF1]: deep rotation
    val trl_ = trl
    val+@B{..}{hrll,hrlr}
      (hrl, _, trll, trlr) = trl_
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
    trl_ // B (hr, xrl, B (1+max(hl,hrll) x, tl, trll), B (1+max(hrlr,hrr), xr, trlr, trr))
  end // end of [if]
end // end of [avltree_lrotate]

(* ****** ****** *)

(*
** right rotation for restoring height invariant
*)
fn{a:t0p}
avltree_rrotate
  {hl,hr:nat | hl == hr+HTDF1}
  {l,l_h,l_x,l_tl,l_tr:addr}
(
  pf_h: (int?)@l_h, pf_x: a@l_x
, pf_tl: avltree (a, hl) @ l_tl
, pf_tr: avltree (a, hr) @ l_tr
| p_h: ptr l_h
, hl : int hl, p_tl: ptr l_tl
, hr : int hr, p_tr: ptr l_tr
, t0: B_unfold (l, l_h, l_x, l_tl, l_tr)
) :<!wrt> avltree_inc (a, hl) = let
  val tl = !p_tl
  val+@B{..}{hll,hlr}
    (hl2, _, tll, tlr) = tl
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
    tl // B (1+max(hll,hlr1), xl, tll, B (hlr1, x, tlr, tr))
  end else let
    val tlr_ = tlr
    val+@B{..}{hlrl,hlrr}
      (hlr, _, tlrl, tlrr) = tlr_
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
    tlr_ // B (hl, xlr, B (1+max(hll,hlrl), xl, tll, tlrl), B (1+max(hlrr,hr), x, tlrr, tr))
  end // end of [if]
end // end of [avltree_rrotate]

(* ****** ****** *)

implement{a}
linset_insert
  (xs, x0) = insert (xs) where
{
//
fun insert
  {h:nat} .<h>.
(
  t0: &avltree (a, h) >> avltree_inc (a, h)
) :<!wrt> bool = let
in
//
case+ t0 of
//
| @B{..}{hl,hr}
    (h, x, tl, tr) => let
    prval pf_h = view@h
    prval pf_x = view@x
    prval pf_tl = view@tl
    prval pf_tr = view@tr
    val sgn = compare_elt_elt<a> (x0, x)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val ans = insert (tl)
        val hl = avltree_height<a> (tl)
        and hr = avltree_height<a> (tr)
      in
        if hl-hr <= HTDF then let
          val () = h := 1+max(hl,hr)
          prval () = fold@ (t0)
        in
          ans // B (1+max(hl,hr), x, tl, tr)
        end else let // hl==hr+HTDF1
          val p_h = addr@(h)
          val p_tl = addr@(tl)
          val p_tr = addr@(tr)
          val () = t0 := avltree_rrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          ans
        end // end of [if]
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val ans = insert (tr)
        val hl = avltree_height<a> (tl)
        and hr = avltree_height<a> (tr)
      in
        if hr-hl <= HTDF then let
          val () = h := 1+max(hl,hr)
          prval () = fold@ (t0)
        in
          ans // B (1+max(hl, hr), x, tl, tr)
        end else let // hl+HTDF1==hr
          val p_h = addr@(h)
          val p_tl = addr@(tl)
          val p_tr = addr@(tr)
          val () = t0 := avltree_lrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          ans
        end // end of [if]
      end // end of [sgn > 0]
    | _ (*[x0] is found*) => let
        prval () = fold@ (t0)
      in
        true // B (h, x0, tl, tr)
      end // end of [sgn = 0]
  end // end of [B]
//
| ~E () => let
    val () = t0 := B{a}(1, x0, E (), E ())
  in
    false
  end // end of [E]
//
end // end of [insert]
//
} // end of [linset_insert]

(* ****** ****** *)

fun{a:t0p}
avltree_maxout
  {h:pos} .<h>.
(
  t0: &avltree (a, h) >> avltree_dec (a, h)
) :<!wrt> mynode1 (a) = let
  val+@B{..}{hl,hr}(h, x, tl, tr) = t0
  prval pf_h = view@h
  prval pf_x = view@x
  prval pf_tl = view@tl
  prval pf_tr = view@tr
in
  case+ tr of
  | B _ => let
      val nx = avltree_maxout<a> (tr)
      val hl = avltree_height<a> (tl)
      and hr = avltree_height<a> (tr)
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
        val () = t0 := avltree_rrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
      in
        nx
      end // end of [if]
    end // end of [B]
  | ~E () => let
      val t0_ = t0
      val () = t0 := tl
    in
      $UN.castvwtp0{mynode1(a)}((pf_h, pf_x, pf_tl, pf_tr | t0_))
    end // end of [E]
end // end of [avltree_maxout]

(* ****** ****** *)

fun{a:t0p}
avltree_minout
  {h:pos} .<h>.
(
  t0: &avltree (a, h) >> avltree_dec (a, h)
) :<!wrt> mynode1 (a) = let
  val+@B{..}{hl,hr}(h, x, tl, tr) = t0
  prval pf_h = view@h
  prval pf_x = view@x
  prval pf_tl = view@tl
  prval pf_tr = view@tr
in
  case+ tl of
  | B _ => let
      val nx = avltree_minout<a> (tl)
      val hl = avltree_height<a> (tl)
      and hr = avltree_height<a> (tr)
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
        val () = t0 := avltree_lrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
      in
        nx
      end // end of [if]
    end // end of [B]
  | ~E () => let
      val t0_ = t0
      val () = t0 := tr
    in
      $UN.castvwtp0{mynode1(a)}((pf_h, pf_x, pf_tl, pf_tr | t0_))
    end // end of [E]
end // end of [avltree_minout]

(* ****** ****** *)

extern
castfn
mynode_decode
  {a:t0p}{l:agz}
  (nx: mynode(INV(a), l)):<> B_pstruct (int?, a, ptr?, ptr?)
// end of [mynode_decode]

(* ****** ****** *)

fn{a:t0p}
avltree_lrcon
  {hl,hr:nat |
   hl <= hr+HTDF;
   hr <= hl+HTDF}
(
  tl: avltree (a, hl)
, tr: avltree (a, hr)
) :<!wrt> avltree_dec (a, 1+max(hl,hr)) =
(
case+ tr of
| B _ => let
    var tr = tr
    val nx =
      avltree_minout<a> (tr)
    // end of [val]
    val t1 = mynode_decode (nx)
    val+B(h1, x1, tl1, tr1) = t1
    prval pf_h1 = view@h1
    prval pf_x1 = view@x1
    prval pf_tl1 = view@tl1
    prval pf_tr1 = view@tr1
    val hl = avltree_height<a> (tl)
    and hr = avltree_height<a> (tr)
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
      avltree_rrotate<a> (pf_h1, pf_x1, pf_tl1, pf_tr1 | p_h1, hl, p_tl1, hr, p_tr1, t1)
    end // end of [if]
  end // end of [B]
| ~E ((*void*)) => tl
) (* end of [avltree_lrcon] *)

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeout_ngc
  (xs, x0) = let
//
fun takeout{h:nat} .<h>.
(
  t0: &avltree (a, h) >> avltree_dec (a, h)
) :<!wrt> mynode0(a) = let
//
in
//
case+ t0 of
| @B{..}{hl,hr}
    (h, x, tl, tr) => let
    prval pf_h = view@h
    prval pf_x = view@x
    prval pf_tl = view@tl
    prval pf_tr = view@tr
    val sgn = compare_elt_elt<a> (x0, x)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val nx = takeout (tl)
        val hl = avltree_height<a> (tl)
        and hr = avltree_height<a> (tr)
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
          val () = t0 := avltree_lrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          nx
        end // end of [if]
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val nx = takeout (tr)
        val hl = avltree_height<a> (tl)
        and hr = avltree_height<a> (tr)
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
          val () = t0 := avltree_rrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
        in
          nx
        end // end of [if]
      end // end of [sgn > 0]
    | _ (*[x0] is found*) => let
        val t0_ = t0
        val () = t0 := avltree_lrcon<a> (tl, tr)
      in
        $UN.castvwtp0{mynode1(a)}((pf_h, pf_x, pf_tl, pf_tr | t0_))
      end // end of [sgn = 0]
    // end of [case]
  end // end of [B]
| E ((*void*)) => mynode_null ()
//
end // end of [takeout]
//
in
  takeout (xs)
end // end of [linset_takeout_ngc]

(* ****** ****** *)

implement
{a}{env}
linset_foreach_env
  (xs, env) = let
//
val p_env = addr@env
//
fun foreach
  {h:nat} .<h>.
(
  t0: !avltree (a, h), p_env: ptr
) : void = let
in
//
case+ t0 of
| B (h, x, tl, tr) => let
//
    val () = foreach (tl, p_env)
//
    val (
      pf, fpf | p_env
    ) = $UN.ptr_vtake{env}(p_env)
    val () = linset_foreach$fwork<a><env> (x, !p_env)
    prval () = fpf (pf)
//
    val () = foreach (tr, p_env)
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
end // end of [linset_foreach_env]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_listize
  (xs) = let
//
fun aux
  {h:nat} .<h>.
(
  t: avltree (a, h), res: List0_vt(a)
) :<> List0_vt(a) = let
in
//
case+ t of
| ~B (_, x, tl, tr) => let
    val res = aux (tr, res)
    val res = list_vt_cons{a}(x, res)
    val res = aux (tl, res)
  in
    res
  end // end of [B]
| ~E ((*void*)) => res
//
end // end of [aux]
//
in
  aux (xs, list_vt_nil)
end // end of [linset_listize]

(* ****** ****** *)

implement{a}
linset_avltree_height (xs) = avlht (xs)

(* ****** ****** *)
//
// HX: functions for handling mynodes
//
(* ****** ****** *)

implement{
} mynode_null{a} () =
  $UN.castvwtp0{mynode(a,null)}(the_null_ptr)
// end of [mynode_null]

(* ****** ****** *)

implement{
} mynode_free{a} (nx) =
{
//
val+~B(_, _, tl, tr) = $UN.castvwtp0{avltree(a,1)}(nx)
//
prval ((*void*)) = $UN.cast2void (tl)
prval ((*void*)) = $UN.cast2void (tr)
//
} (* end of [mynode_free] *)

(* ****** ****** *)

implement
{a}(*tmp*)
mynode_getfree_elt (nx) = x where
{
//
val+~B(_, x, tl, tr) = $UN.castvwtp0{avltree(a,1)}(nx)
//
prval ((*void*)) = $UN.cast2void (tl)
prval ((*void*)) = $UN.cast2void (tr)
//
} (* end of [mynode_getfree_elt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeoutmax_ngc
  (xs) = let
in
//
case+ xs of
| B _ => avltree_maxout<a> (xs)
| E _ => mynode_null{a}((*void*))
//
end // end of [linset_takeoutmax]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_takeoutmin_ngc
  (xs) = let
in
//
case+ xs of
| B _ => avltree_minout<a> (xs)
| E _ => mynode_null{a}((*void*))
//
end // end of [linset_takeoutmin]

(* ****** ****** *)

(* end of [linset_avltree.dats] *)
