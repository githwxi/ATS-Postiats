(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
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

#define ATS_PACKNAME "ATSLIB.libats.funset_avltree"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload "libats/SATS/funset_avltree.sats"

(* ****** ****** *)
//
#include "./SHARE/funset.hats" // code reuse
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

datatype avltree
(
  a:t@ype+, int(*height*)
) =
  | {hl,hr:nat |
     hl <= hr+HTDF; hr <= hl+HTDF}
    B (a, 1+max(hl,hr)) of
      (int (1+max(hl,hr)), a, avltree (a, hl), avltree (a, hr))
  | E (a, 0) of ((*void*))
// end of [avltree]

typedef avltree_inc (a:t0p, h:int) =
  [h1:nat | h <= h1; h1 <= h+1] avltree (a, h1)
// end of [avltree_inc]

typedef avltree_dec (a:t0p, h:int) =
  [h1:nat | h1 <= h; h <= h1+1] avltree (a, h1)
// end of [avltree_dec]

(* ****** ****** *)

assume
set_type (a:t@ype) = [h:nat] avltree (a, h)

(* ****** ****** *)

implement{} funset_nil () = E ()
implement{} funset_make_nil () = E ()

(* ****** ****** *)

implement{a}
funset_sing (x) = B{a}(1, x, E, E)
implement{a}
funset_make_sing (x) = B{a}(1, x, E, E)

(* ****** ****** *)

implement{a}
funset_make_list
  (xs) = res where
{
//
fun loop
  {n:nat} .<n>.
(
  xs: list (a, n), res: &set a >> _
) : void = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val _(*inserted*) = funset_insert<a> (res, x) in loop (xs, res)
  end // end of [list_cons]
| list_nil () => ()
end // end of [loop]
//
var res: set a = funset_nil ()
prval () = lemma_list_param (xs)
val () = $effmask_all (loop (xs, res))
//
} // end of [funset_make_list]

(* ****** ****** *)

implement{}
funset_is_empty (xs) = case+ xs of B _ => false | E () => true
implement{}
funset_isnot_empty (xs) = case+ xs of B _ => true | E () => false 

(* ****** ****** *)

implement{a}
funset_size
  (xs) = aux (xs) where
{
//
fun aux {h:nat} .<h>.
  (t: avltree (a, h)):<> size_t =
(
  case+ t of
  | B (_, _, tl, tr) => succ(aux (tl) + aux (tr))
  | E ((*void*)) => i2sz(0)
) (* end of [aux] *)
//
} // end of [funset_size]

(* ****** ****** *)

implement{a}
funset_is_member
  (xs, x0) = aux (xs) where
{
//
fun aux {h:nat} .<h>.
  (t: avltree (a, h)):<> bool = let
in
  case+ t of
  | B (_, x, tl, tr) => let
      val sgn = compare_elt_elt<a> (x0, x)
    in
      if sgn < 0 then aux (tl) else (if sgn > 0 then aux (tr) else true)
    end
  | E () => false
end // end of [aux]
//
} // end of [funset_is_member]

implement{a}
funset_isnot_member (xs, x0) = ~funset_is_member (xs, x0)

(* ****** ****** *)

macdef
avlht (t) =
(
case+ ,(t) of B (h, _, _, _) => h | E ((*void*)) => 0
)

(* ****** ****** *)

fn{a:t0p}
avltree_height {h:int} (t: avltree (a, h)): int h = avlht (t)

(* ****** ****** *)

(*
** left rotation for restoring height invariant
*)
fn{a:t0p}
avltree_lrotate
  {hl,hr:nat | hl+HTDF1 == hr}
(
  x: a
, hl : int hl
, tl: avltree (a, hl)
, hr : int hr
, tr: avltree (a, hr)
) :<> avltree_inc (a, hr) = let
  val+B{..}{hrl,hrr}(_, xr, trl, trr) = tr
  val hrl = avlht(trl) : int hrl
  and hrr = avlht(trr) : int hrr
in
//
if hrl <= hrr+HTDF_1 then let
  val hrl1 = hrl + 1
in
  B{a}(1+max(hrl1,hrr), xr, B{a}(hrl1, x, tl, trl), trr)
end else let // [hrl=hrr+2]: deep rotation
  val+B{..}{hrll,hrlr}(_(*hrl*), xrl, trll, trlr) = trl
  val hrll = avlht trll : int hrll
  val hrlr = avlht trlr : int hrlr
in
  B{a}(hr, xrl, B{a}(1+max(hl,hrll), x, tl, trll), B{a}(1+max(hrlr,hrr), xr, trlr, trr))
end // end of [if]
//
end // end of [avltree_lrotate]

(* ****** ****** *)

(*
** right rotation for restoring height invariant
*)
fn{a:t0p}
avltree_rrotate
  {hl,hr:nat | hl == hr+HTDF1}
(
  x: a
, hl: int hl
, tl: avltree (a, hl)
, hr: int hr
, tr: avltree (a, hr)
) :<> avltree_inc (a, hl) = let
  val+B{..}{hll,hlr}(_(*hl*), xl, tll, tlr) = tl
  val hll = avlht(tll) : int hll
  and hlr = avlht(tlr) : int hlr
in
//
if hll+HTDF_1 >= hlr then let
  val hlr1 = hlr + 1
in
  B{a}(1+max(hll,hlr1), xl, tll, B{a}(hlr1, x, tlr, tr))
end else let
  val+B{..}{hlrl,hlrr}(_(*hlr*), xlr, tlrl, tlrr) = tlr
  val hlrl = avlht(tlrl) : int hlrl
  val hlrr = avlht(tlrr) : int hlrr
in
  B{a}(hl, xlr, B{a}(1+max(hll,hlrl), xl, tll, tlrl), B{a}(1+max(hlrr,hr), x, tlrr, tr))
end // end of [if]
//
end // end of [avltree_rrotate]

(* ****** ****** *)

implement{a}
funset_insert
  (xs, x0) = found where
{
//
fun insert
  {h:nat} .<h>.
(
  t: avltree (a, h), found: &bool? >> bool
) :<!wrt> avltree_inc (a, h) = let
in
//
case+ t of
| B{..}{hl,hr}
    (h, x, tl, tr) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn < 0 then let
      val [hl:int] tl = insert (tl, found)
      val hl = avlht(tl) : int hl
      and hr = avlht(tr) : int hr
    in
      if hl - hr <= HTDF then begin
        B{a}(1+max(hl,hr), x, tl, tr)
      end else ( // hl = hr+HTDF1
        avltree_rrotate (x, hl, tl, hr, tr)
      ) // end of [if]
    end else if sgn > 0 then let
      val [hr:int] tr = insert (tr, found)
      val hl = avlht(tl) : int hl
      and hr = avlht(tr) : int hr
    in
      if hr - hl <= HTDF then begin
        B{a}(1+max(hl, hr), x, tl, tr)
      end else ( // hl+HTDF1 = hr
        avltree_lrotate (x, hl, tl, hr, tr)
      ) // end of [if]
    end else let (* [k0] already exists *)
      val () = found := true in B{a}(h, x0, tl, tr)
    end // end of [if]
  end // end of [B]
| E ((*void*)) => let // [x0] is not in [xs]
    val () = found := false in B{a}(1, x0, E(), E())
  end // end of [E]
end // end of [insert]
//
var found: bool // uninitialized
val () = (xs := insert (xs, found))
//
} // end of [funset_insert]

(* ****** ****** *)

fun{a:t0p}
avltree_takeout_min
  {h:pos} .<h>. (
  t: avltree (a, h), x0: &a? >> a
) :<!wrt> avltree_dec (a, h) = let
  val+ B{..}{hl,hr}(h, x, tl, tr) = t
in
  case+ tl of
  | B _ => let
      val [hl:int] tl = avltree_takeout_min<a> (tl, x0)
      val hl = avlht(tl) : int hl
      and hr = avlht(tr) : int hr
    in
      if hr - hl <= HTDF then begin
        B (1+max(hl,hr), x, tl, tr)
      end else begin // hl+HTDF1 = hr
        avltree_lrotate (x, hl, tl, hr, tr)
      end // end of [if]
    end // end of [B]
  | E () => (x0 := x; tr)
end // end of [avltree_takeout_min]

(* ****** ****** *)

(* end of [funset_avltree.dats] *)
