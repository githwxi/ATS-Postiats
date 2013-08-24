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

vtypedef avltree_inc (a:t0p, h:int) =
  [h1:nat | h <= h1; h1 <= h+1] avltree (a, h1)
// end of [avltree_inc]

vtypedef avltree_dec (a:t0p, h:int) =
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
  | B (_, _, tl, tr) => succ(aux (tl) + aux (tr))
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
| B (_, x, tl, tr) => let
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
(*
** left rotation for restoring height invariant
*)
fn{a:t0p}
avltree_lrotate
  {hl,hr:nat | hl+HTDF1 == hr}
  {l,l_h,l_k,l_x,l_tl,l_tr:addr}
(
  pf_h: int@l_h, pf_x: a@l_x
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
    tr // B (1+max(hrl1,hrr), kr, xr, B (hrl1, k, x, tl, trl), trr)
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
    trl_ // B (hr, krl, xrl, B (1+max(hl,hrll), k, x, tl, trll), B (1+max(hrlr,hrr), kr, xr, trlr, trr))
  end // end of [if]
end // end of [avltree_lrotate]

(* ****** ****** *)

(*
** right rotation for restoring height invariant
*)
fn{a:t0p}
avltree_rrotate
  {hl,hr:nat | hl == hr+HTDF1}
  {l,l_h,l_k,l_x,l_tl,l_tr:addr}
(
  pf_h: int@l_h, pf_x: a@l_x
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
    tl // B (1+max(hll,hlr1), kl, xl, tll, B (hlr1, k, x, tlr, tr))
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
    tlr_ // B (hl, klr, xlr, B (1+max(hll,hlrl), kl, xl, tll, tlrl), B (1+max(hlrr,hr), k, x, tlrr, tr))
  end // end of [if]
end // end of [avltree_rrotate]

(* ****** ****** *)

implement{a}
linset_copy (xs) = let
//
fun copy
  {h:nat} .<h>.
  (t: !avltree (a, h)):<!wrt> avltree (a, h) =
(
case+ t of
| B (h, x, tl, tr) => B (h, x, copy (tl), copy (tr)) | E () => E ()
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
| ~B (_, _, tl, tr) => (free (tl); free (tr)) | ~E () => ()
) // end of [free]
in
  free (xs)
end // end of [linset_free]

(* ****** ****** *)

implement{a}
linset_insert
  (xs, x0) = insert (xs, x0) where
{
//
fun insert
  {h:nat} .<h>.
(
  t0: &avltree (a, h) >> avltree_inc (a, h), x0: a
) :<!wrt> #[b:bool] bool (b) = let
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
    if sgn < 0 then let
      val ans = insert (tl, x0)
      val hl = avltree_height<a>(tl)
      and hr = avltree_height<a>(tr)
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
        val () = t0 := avltree_rrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
      in
        ans
      end // end of [if]
    end else if sgn > 0 then let
      val ans = insert (tr, x0)
      val hl = avltree_height<a>(tl)
      and hr = avltree_height<a>(tr)
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
        val () = t0 := avltree_lrotate<a> (pf_h, pf_x, pf_tl, pf_tr | p_h, hl, p_tl, hr, p_tr, t0)
      in
        ans
      end // end of [if]
    end else let (* key already exists *)
      prval () = fold@ (t0) in true // B (h, k, x0, tl, tr)
    end // end of [if]
  end // end of [B]
| ~E () => let
    val () = t0 := B{a}(1, x0, E (), E ()) in false
  end // end of [E]
//
end // end of [insert]
//
} // end of [linset_insert]

(* ****** ****** *)

implement
{a}{env}
linset_foreach_env
  (xs, env) = let
//
val p_env = addr@ (env)
//
fun foreach
  {h:nat} .<h>.
(
  t: !avltree (a, h), p_env: ptr
) : void = let
in
//
case+ t of
| B (_, x, tl, tr) => let
//
    val () = foreach (tl, p_env)
//
    val (
      pf, fpf | p_env
    ) = $UN.ptr_vtake (p_env)
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

(* end of [linset_avltree.dats] *)
