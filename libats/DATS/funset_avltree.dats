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

#define
ATS_PACKNAME "ATSLIB.libats.funset_avltree"
#define
ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

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
     hl <= hr+HTDF;
     hr <= hl+HTDF}
    B (a, 1+max(hl,hr)) of
      (int (1+max(hl,hr)), a, avltree (a, hl), avltree (a, hr))
  | E (a, 0) of ((*void*))
// end of [avltree]

typedef
avltree_inc (a:t0p, h:int) =
  [h1:nat | h <= h1; h1 <= h+1] avltree (a, h1)
// end of [avltree_inc] // end of [typedef]

typedef
avltree_dec (a:t0p, h:int) =
  [h1:nat | h1 <= h; h <= h1+1] avltree (a, h1)
// end of [avltree_dec] // end of [typedef]

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

implement
{a}(*tmp*)
funset_size
  (xs) = aux (xs) where
{
//
fun aux
  {h:nat} .<h>.
  (t: avltree (a, h)):<> size_t =
(
  case+ t of
  | B (_, _, tl, tr) => succ(aux (tl) + aux (tr))
  | E ((*void*)) => i2sz(0)
) (* end of [aux] *)
//
} // end of [funset_size]

(* ****** ****** *)

implement{}
funset_is_nil (xs) =
(
  case+ xs of B _ => false | E () => true
)
implement{}
funset_isnot_nil (xs) =
(
  case+ xs of B _ => true | E () => false
)

(* ****** ****** *)

implement{a}
funset_is_member
  (xs, x0) = aux (xs) where
{
//
fun aux {h:nat} .<h>.
  (t: avltree (a, h)):<> bool = let
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
} // end of [funset_is_member]

(* ****** ****** *)

macdef
avlht (t) =
(
case+ ,(t) of B (h, _, _, _) => h | E ((*void*)) => 0
) // end of [avlht]

(* ****** ****** *)

fun{a:t0p}
avlmax{h:pos} .<h>.
  (t: avltree (a, h)):<> a = let
//
val+B{..}{hl,hr}(h, x, tl, tr) = t
//
in
//
case+ tr of B _ => avlmax<a> (tr) | E () => x
//
end // end of [avlmax]

(* ****** ****** *)

fun{a:t0p}
avlmin{h:pos} .<h>.
  (t: avltree (a, h)):<> a = let
//
val+B{..}{hl,hr}(h, x, tl, tr) = t
//
in
//
case+ tl of B _ => avlmin<a> (tl) | E () => x
//
end // end of [avlmin]

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
  val hrll = avlht(trll) : int hrll
  and hrlr = avlht(trlr) : int hrlr
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
  and hlrr = avlht(tlrr) : int hlrr
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
| B {..}{hl,hr}
    (h, x, tl, tr) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn < 0 then let
      val [hl:int] tl = insert (tl, found)
      val hl = avlht(tl) : int hl
      and hr = avlht(tr) : int hr
    in
      if hl-hr <= HTDF
        then B{a}(1+max(hl,hr), x, tl, tr)
        else avltree_rrotate<a> (x, hl, tl, hr, tr)
      // end of [if]
    end else if sgn > 0 then let
      val [hr:int] tr = insert (tr, found)
      val hl = avlht(tl) : int hl
      and hr = avlht(tr) : int hr
    in
      if hr-hl <= HTDF
        then B{a}(1+max(hl, hr), x, tl, tr)
        else avltree_lrotate<a> (x, hl, tl, hr, tr)
      // end of [if]
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
avlmaxout{h:pos} .<h>.
(
  t: avltree (a, h), x0: &a? >> a
) :<!wrt> avltree_dec (a, h) = let
//
val+B{..}{hl,hr}(h, x, tl, tr) = t
//
in
//
case+ tr of
| B _ => let
    val [hr:int]
      tr = avlmaxout<a> (tr, x0)
    val hl = avlht(tl) : int(hl)
    and hr = avlht(tr) : int(hr)
  in
    if hl-hr <= HTDF
      then B{a}(1+max(hl,hr), x, tl, tr)
      else avltree_rrotate<a> (x, hl, tl, hr, tr)
    // end of [if]
  end // end of [B]
| E () => (x0 := x; tl)
//
end // end of [avlmaxout]

(* ****** ****** *)

fun{a:t0p}
avlminout{h:pos} .<h>.
(
  t: avltree (a, h), x0: &a? >> a
) :<!wrt> avltree_dec (a, h) = let
//
val+B{..}{hl,hr}(h, x, tl, tr) = t
//
in
//
case+ tl of
| B _ => let
    val [hl:int]
      tl = avlminout<a> (tl, x0)
    val hl = avlht(tl) : int(hl)
    and hr = avlht(tr) : int(hr)
  in
    if hr-hl <= HTDF
      then B{a}(1+max(hl,hr), x, tl, tr)
      else avltree_lrotate<a> (x, hl, tl, hr, tr)
    // end of [if]
  end // end of [B]
| E () => (x0 := x; tr)
//
end // end of [avlminout]

(* ****** ****** *)

(*
** left join: height(tl) >= height(tr)
*)
fun{a:t0p}
avltree_ljoin
  {hl,hr:nat | hl >= hr} .<hl>.
(
  x: a, tl: avltree (a, hl), tr: avltree (a, hr)
) :<> avltree_inc (a, hl) = let
  val hl = avlht(tl) : int hl
  and hr = avlht(tr) : int hr
in
//
if hl >= hr + HTDF1 then let
  val+B{..}{hll, hlr}(_, xl, tll, tlr) = tl
  val [hlr:int] tlr = avltree_ljoin<a> (x, tlr, tr)
  val hll = avlht(tll) : int hll
  and hlr = avlht(tlr) : int hlr
in
  if hlr <= hll + HTDF
    then B{a}(max(hll,hlr)+1, xl, tll, tlr)
    else avltree_lrotate<a> (xl, hll, tll, hlr, tlr)
  // end of [if]
end else B{a}(hl+1, x, tl, tr) // end of [if]
//
end // end of [avltree_ljoin]

(* ****** ****** *)

(*
** right join: height(tl) <= height(tr)
*)
fun{a:t0p}
avltree_rjoin
  {hl,hr:nat | hl <= hr} .<hr>.
(
  x: a, tl: avltree (a, hl), tr: avltree (a, hr)
) :<> avltree_inc (a, hr) = let
  val hl = avlht(tl) : int hl
  and hr = avlht(tr) : int hr
in
//
if hr >= hl + HTDF1 then let
  val+B{..}{hrl,hrr}(_, xr, trl, trr) = tr
  val [hrl:int] trl = avltree_rjoin<a> (x, tl, trl)
  val hrl = avlht(trl) : int hrl
  and hrr = avlht(trr) : int hrr
in
  if hrl <= hrr + HTDF
    then B{a}(max(hrl,hrr)+1, xr, trl, trr)
    else avltree_rrotate<a> (xr, hrl, trl, hrr, trr)
  // end of [if]
end else B{a}(hr+1, x, tl, tr) // end of [if]
//
end // end of [avltree_rjoin]

(* ****** ****** *)

fn{a:t0p}
avltree_join3
  {hl,hr:nat}
(
  x: a, tl: avltree (a, hl), tr: avltree (a, hr)
) :<> [
  h:int | hl <= h; hr <= h; h <= max(hl,hr)+1
] avltree (a, h) = let
  val hl = avlht(tl) : int hl
  and hr = avlht(tr) : int hr
in
  if hl >= hr then
    avltree_ljoin<a> (x, tl, tr) else avltree_rjoin<a> (x, tl, tr)
  // end of [if]
end // end of [avltree_join3]

(* ****** ****** *)

fn{a:t0p}
avltree_join2
  {hl,hr:nat}
(
  tl: avltree (a, hl), tr: avltree (a, hr)
) :<> [h:nat | h <= max(hl,hr)+1] avltree (a, h) =
(
case+
  (tl, tr) of
| (E (), _) => tr
| (_, E ()) => tl
| (_, _) =>> let
    var xmin: a // uninitialized
    val tr = $effmask_wrt (avlminout<a> (tr, xmin))
  in
    avltree_join3<a> (xmin, tl, tr)
  end // end of [_, _]
) // end of [avltree_join2]

(* ****** ****** *)

fun{a:t@ype}
avltree_split_at
  {h:nat} .<h>.
(
  t: avltree (a, h), x0: a
, tl0: &ptr? >> avltree (a, hl)
, tr0: &ptr? >> avltree (a, hr)
) :<!wrt>
  #[i,hl,hr:nat | i <= 1; hl <= h; hr <= h] int (i) =
(
case+ t of
| B (_, x, tl, tr) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn < 0 then let
      val i = avltree_split_at<a> (tl, x0, tl0, tr0)
    in
      tr0 := avltree_join3<a> (x, tr0, tr); i
    end else if sgn > 0 then let
      val i = avltree_split_at<a> (tr, x0, tl0, tr0)
    in
      tl0 := avltree_join3<a> (x, tl, tl0); i
    end else (
      tl0 := tl; tr0 := tr; 1 // [x] is found in [t]
    ) // end of [if]
  end // end of [B]
| E ((*void*)) => (tl0 := E (); tr0 := E (); 0)
) // end of [avltree_split_at]

(* ****** ****** *)

implement{a}
funset_remove
  (xs, x0) = let
//
fun remove{h:nat} .<h>.
(
  t: avltree (a, h), found: &bool? >> bool
) :<!wrt> avltree_dec (a, h) = let
in
//
case+ t of
| B {..}{hl,hr}
    (h, x, tl, tr) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    case+ 0 of
    | _ when sgn < 0 => let
        val [hl:int] tl = remove (tl, found)
        val hl = avlht(tl) : int hl
        and hr = avlht(tr) : int hr
      in
        if hr-hl <= HTDF
          then B{a}(1+max(hl,hr), x, tl, tr)
          else avltree_lrotate<a> (x, hl, tl, hr, tr)
        // end of [if]
      end // end of [sgn < 0]
    | _ when sgn > 0 => let
        val [hr:int] tr = remove (tr, found)
        val hl = avlht(tl) : int hl
        and hr = avlht(tr) : int hr
      in
        if hl-hr <= HTDF
          then B{a}(1+max(hl,hr), x, tl, tr)
          else avltree_rrotate<a> (x, hl, tl, hr, tr)
        // end of [if]
      end // end of [sgn > 0]
    | _ (*sgn = 0*) => let
        val () = found := true
      in
        case+ tr of
        | B _ => let
            var xmin: a? // uninitialized
            val [hr:int] tr = avlminout<a> (tr, xmin)
            val hl = avlht(tl) : int (hl)
            and hr = avlht(tr) : int (hr)
          in
            if hl-hr <= HTDF
              then B{a}(1+max(hl,hr), xmin, tl, tr)
              else avltree_rrotate<a> (xmin, hl, tl, hr, tr)
            // end of [if]
          end // end of [B]
        | E _ => tl
      end // end of [sgn = 0]
    end // end of [B]
| E ((*void*)) =>
    let val () = found := false in E () end
  (* end of [E] *)
//
end // end of [remove]
//
var found: bool
val () = (xs := remove (xs, found))
//
in
  found
end // end of [funset_remove]

(* ****** ****** *)

implement{a}
funset_getmax
  (xs, x0) = let
in
//
case+ xs of
| B _ => let
    val () = x0 := avlmax<a> (xs)
    prval () = opt_some{a}(x0) in true
  end // end of [B]
| E _ => let
    prval () = opt_none{a}(x0) in false
  end // end of [E]
//
end // end of [funset_getmax]

(* ****** ****** *)

implement{a}
funset_getmin
  (xs, x0) = let
in
//
case+ xs of
| B _ => let
    val () = x0 := avlmin<a> (xs)
    prval () = opt_some{a}(x0) in true
  end // end of [B]
| E _ => let
    prval () = opt_none{a}(x0) in false
  end // end of [E]
//
end // end of [funset_getmin]

(* ****** ****** *)

implement{a}
funset_takeoutmax
  (xs, x0) = let
in
//
case+ xs of
| B _ => let
    val (
    ) = xs := avlmaxout<a> (xs, x0)
    prval ((*void*)) = opt_some{a}(x0)
  in
    true
  end // end of [B]
| E _ => let
    prval () = opt_none{a}(x0)
  in
    false
  end // end of [E]
//
end // end of [funset_takeoutmax]

(* ****** ****** *)

implement{a}
funset_takeoutmin
  (xs, x0) = let
in
//
case+ xs of
| B _ => let
    val (
    ) = xs := avlminout<a> (xs, x0)
    prval ((*void*)) = opt_some{a}(x0)
  in
    true
  end // end of [B]
| E _ => let
    prval () = opt_none{a}(x0)
  in
    false
  end // end of [E]
//
end // end of [funset_takeoutmin]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_union
  (t1, t2) = let
//
fun aux
  {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1)
, t2: avltree (a, h2)
) :<!wrt> [h:nat] avltree (a, h) =
(
  case+ (t1, t2) of
  | (E (), _) => t2
  | (_, E ()) => t1
  | (_, _) =>> let
      val+B (_, x1, t1l, t1r) = t1
      var t2l0: ptr and t2r0: ptr
      val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
      val t12l = aux (t1l, t2l0) and t12r = aux (t1r, t2r0)
    in
      avltree_join3<a> (x1, t12l, t12r)
    end // end of [_, _]
) // end of [aux] // [aux] is a keyword
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_union]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_intersect
  (t1, t2) = let
//
fun aux
  {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1), t2: avltree (a, h2)
) :<!wrt> [h:nat] avltree (a, h) = let
in
//
case+
  (t1, t2) of
| (E (), _) => E ()
| (_, E ()) => E ()
| (_, _) =>> let
    val+B (_, x1, t1l, t1r) = t1
    var t2l0: ptr and t2r0: ptr
    val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
    val t12l = aux (t1l, t2l0) and t12r = aux (t1r, t2r0)
  in
    if i = 0 then
      avltree_join2<a> (t12l, t12r) else avltree_join3<a> (x1, t12l, t12r)
    // end of [if]
  end // end of [_, _]
end // end // end of [aux]
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_intersect]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_differ
  (t1, t2) = let
//
fun aux
  {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1), t2: avltree (a, h2)
) :<!wrt> [h:nat] avltree (a, h) = let
in
//
case+
  (t1, t2) of
| (E (), _) => E ()
| (_, E ()) => t1
| (_, _) =>> let
    val+B (_, x1, t1l, t1r) = t1
    var t2l0: ptr and t2r0: ptr
    val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
    val t12l = aux (t1l, t2l0) and t12r = aux (t1r, t2r0)
  in
    if i > 0 then
      avltree_join2<a> (t12l, t12r) else avltree_join3<a> (x1, t12l, t12r)
    // end of [if]
  end // end of [_, _]
//
end // end of [aux]
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_differ]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_symdiff
  (t1, t2) = let
//
fun aux {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1), t2: avltree (a, h2)
) :<!wrt> [h:nat] avltree (a, h) = let
in
//
case+
  (t1, t2) of
| (E (), _) => t2
| (_, E ()) => t1
| (_, _) =>> let
    val+B (_, x1, t1l, t1r) = t1
    var t2l0: ptr and t2r0: ptr
    val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
    val t12l = aux (t1l, t2l0) and t12r = aux (t1r, t2r0)
  in
    if i > 0 then
      avltree_join2<a> (t12l, t12r) else avltree_join3<a> (x1, t12l, t12r)
    // end of [if]
  end // end of [_, _]
//
end // end of [aux]
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_symdiff]

(* ****** ****** *)

implement{a}
funset_equal
  (t1, t2) = let
//
fun aux
  {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1), t2: avltree (a, h2)
) :<!wrt> bool = let
in
//
case+
  (t1, t2) of
| (E _, E _) => true
| (E _, B _) => false
| (B _, E _) => false
| (_, _) =>> let
    val+B(_, x1, t1l, t1r) = t1
    var t2l0: ptr and t2r0: ptr
    val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
  in
    if i > 0 then
      (if aux (t1l, t2l0) then aux (t1r, t2r0) else false)
    else false // end of [if]
  end // end of [_, _]
//
end // end of [aux]    
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_equal]

(* ****** ****** *)

implement{a}
funset_compare
  (t1, t2) = let
//
fun aux
  {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1), t2: avltree (a, h2)
) :<!wrt> Sgn = let
in
//
case+
  (t1, t2) of
| (E _, E _) => 0
| (E _, B _) => ~1
| (B _, E _) => 1
| (_, _) =>> let
    val+B(_, x1, t1l, t1r) = t1
    var t2l0: ptr and t2r0: ptr
    val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
  in
    if i = 0 then let
      val sgn_r = aux (t1r, t2r0)
    in
      if sgn_r >= 0 then 1 else ~1
    end else let
      val sgn_r = aux (t1r, t2r0)
    in
      if sgn_r = 0 then aux (t1l, t2l0) else sgn_r
    end (* end of [if] *)
  end // end of [_, _]
//
end // end of [aux]    
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_compare]

(* ****** ****** *)

implement{a}
funset_is_subset
  (t1, t2) = let
//
fun aux
  {h1,h2:nat} .<h1>.
(
  t1: avltree (a, h1), t2: avltree (a, h2)
) :<!wrt> bool = let
in
//
case+
  (t1, t2) of
| (E (), _) => true
| (_, E ()) => false
| (_, _) =>> let
    val+B(_, x1, t1l, t1r) = t1
    var t2l0: ptr and t2r0: ptr
    val i = avltree_split_at<a> (t2, x1, t2l0, t2r0)
  in
    if i > 0 then
      (if aux (t1l, t2l0) then aux (t1r, t2r0) else false)
    else false // end of [if]
  end // end of [_, _]
//
end // end of [test]    
//
in
//
$effmask_wrt (aux (t1, t2))
//
end // end of [funset_is_subset]

(* ****** ****** *)

implement
{a}{env}
funset_foreach_env
  (xs, env) = let
//
val p_env = addr@(env)
//
fun foreach
  {h:nat} .<h>.
(
  t: avltree (a, h), p_env: ptr
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
    val () = funset_foreach$fwork<a><env> (x, !p_env)
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
end // end of [funset_foreach_env]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_listize
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
| B (_, x, tl, tr) => let
    val res = aux (tr, res)
    val res = list_vt_cons{a}(x, res)
    val res = aux (tl, res)
  in
    res
  end // end of [B]
| E ((*void*)) => res
//
end // end of [aux]
//
in
  aux (xs, list_vt_nil)
end // end of [funset_listize]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_streamize
  (xs) = let
//
fun
auxmain{h:nat}
(
t0: avltree (a, h)
) : stream_vt(a) =
(
//
case+ t0 of
//
| E () =>
  stream_vt_make_nil()
//
| B (
    _, x, tl, tr
  ) => stream_vt_append
  (
    auxmain(tl)
  , $ldelay(stream_vt_cons{a}(x, auxmain(tr)))
  ) (* stream_vt_append *)
//
) (* end of [auxmain] *)
//
in
  $effmask_all(auxmain(xs))
end // end of [funset_streamize]

(* ****** ****** *)

implement
{a}(*tmp*)
funset_avltree_height (xs) = avlht (xs)

(* ****** ****** *)

(* end of [funset_avltree.dats] *)
