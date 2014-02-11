(*
** Copyright (C) 2011 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** Linear Red-Black Trees
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)
//
// HX-2014-02-11: Ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype} compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

#define BLK 0
#define RED 1
sortdef clr = {c:int | 0 <= c; c <= 1}

datavtype rbtree
(
  a: t@ype+, int(*c*), int(*bh*), int(*v*)
) = // element type, color, black height, violations
  | rbtree_nil (a, BLK, 0, 0) of ()
  | {c,cl,cr:clr} {bh:nat} {v:int}
    {c==BLK && v==0 || c == RED && v==cl+cr}
    rbtree_cons (a, c, bh+1-c, v) of (int c, rbtree0 (a, cl, bh), a, rbtree0 (a, cr, bh))
// end of [rbtree]

where rbtree0 (a:t@ype, c:int, bh:int) = rbtree (a, c, bh, 0)

(* ****** ****** *)

fn{
a:t@ype
} insfix_l // right rotation
  {cl,cr:clr}
  {bh:nat}{v:nat}
  {l,l_c,l_tl,l_x,l_tr:addr}
(
  pf_c: int(BLK) @ l_c
, pf_tl: rbtree (a, cl, bh, v) @ l_tl
, pf_x: a @ l_x
, pf_tr: rbtree (a, cr, bh, 0) @ l_tr
| t: rbtree_cons_unfold (l, l_c, l_tl, l_x, l_tr)
, p_tl: ptr (l_tl)
) : [c:clr] rbtree0 (a, c, bh+1) = let
  #define B BLK
  #define R RED
  #define cons rbtree_cons
in
  case+ !p_tl of
  | @cons (cl as R, tll as @cons (cll as R, _, _, _), _, tlr) => let
//
      val () = cll := B
      prval () = fold@ (tll)
//
      val tl = !p_tl
      val () = !p_tl := tlr
      prval () = fold@ (t)
//
      val () = tlr := t
//
    in
      fold@ (tl); tl
    end // end of [cons (R, cons (R, ...), ...)]
  | @cons (cl as R, tll, _, tlr as @cons (clr as R, tlrl, _, tlrr)) => let
//
      val tl = !p_tl
      val () = !p_tl := tlrr
      prval () = fold@ (t)
      val () = tlrr := t
//
      val tlr_ = tlr
      val () = tlr := tlrl
      val () = cl := B
      prval () = fold@ (tl)
      val () = tlrl := tl
//
    in
      fold@ (tlr_); tlr_
    end // end of [cons (R, ..., cons (R, ...))]
  | _ (*rest-of-cases*) =>> (fold@ (t); t)
end // end of [insfix_l]

fn{
a:t@ype
} insfix_r // left rotation
  {cl,cr:clr}
  {bh:nat}{v:nat}
  {l,l_c,l_tl,l_x,l_tr:addr} (
  pf_c: int(BLK) @ l_c
, pf_tl: rbtree (a, cl, bh, 0) @ l_tl
, pf_x: a @ l_x
, pf_tr: rbtree (a, cr, bh, v) @ l_tr
| t: rbtree_cons_unfold (l, l_c, l_tl, l_x, l_tr)
, p_tr: ptr (l_tr)
) : [c:clr] rbtree0 (a, c, bh+1) = let
  #define B BLK
  #define R RED
  #define cons rbtree_cons
in
  case+ !p_tr of
  | @cons (cr as R, trl, _, trr as @cons (crr as R, _, _, _)) => let
//
      val () = crr := B
      prval () = fold@ (trr)
//
      val tr = !p_tr
      val () = !p_tr := trl
      prval () = fold@ (t)
//
      val () = trl := t
//
    in
      fold@ (tr); tr
    end // end of [cons (R, ..., cons (R, ...))]
  | @cons (cr as R, trl as @cons (crr as R, trll, _, trlr), _, trr) => let
//
      val tr = !p_tr
      val () = !p_tr := trll
      prval () = fold@ (t)
      val () = trll := t
//
      val trl_ = trl
      val () = trl := trlr
      val () = cr := B
      prval () = fold@ (tr)
      val () = trlr := tr
//
    in
      fold@ (trl_); trl_
    end // end of [cons (R, cons (R, ...), ...)]
  | _ (*rest-of-cases*) =>> (fold@ (t); t)
end // end of [insfix_r]

(* ****** ****** *)

extern
fun{a:t@ype}
rbtree_insert
  {c:clr} {bh:nat} (
  t: rbtree0 (a, c, bh), x0: &a, cmp: cmp a
) : [bh1:nat] rbtree0 (a, BLK, bh1)

implement{a}
rbtree_insert
  (t, x0, cmp) = let
//
#define B BLK; #define R RED
#define nil rbtree_nil; #define cons rbtree_cons
//
fun ins
  {c:clr}{bh:nat} .<bh,c>.
(
  t: rbtree0 (a, c, bh), x0: &a
) : [cl:clr; v:nat | v <= c] rbtree (a, cl, bh, v) =
(
  case+ t of
  | @cons(c, tl, x, tr) => let
      prval pf_c = view@c
      prval pf_tl = view@tl
      prval pf_x = view@x
      prval pf_tr = view@tr
      val sgn = compare<a> (x0, x, cmp)
    in
      if sgn < 0 then let
        val [cl:int,v:int] tl_ = ins (tl, x0)
        val () = tl := tl_
      in
        if (c = B)
        then (
          insfix_l<a>
            (pf_c, pf_tl, pf_x, pf_tr | t, addr@tl)
          // end of [insfix_l]
        ) else let
          val () = c := R in fold@{a}{..}{..}{cl}(t); t
        end // end of [if]
      end else if sgn > 0 then let
        val [cr:int,v:int] tr_ = ins (tr, x0)
        val () = tr := tr_
      in
        if (c = B)
        then (
          insfix_r<a>
            (pf_c, pf_tl, pf_x, pf_tr | t, addr@tr)
          // end of [insfix_r]
        ) else let
          val () = c := R in fold@{a}{..}{..}{cr}(t); t
        end // end of [if]
      end else (fold@{a}{..}{..}{0} (t); t)
    end // end of [cons]
  | ~nil () => cons{a}{..}{..}{0}(R, nil, x0, nil)
) (* end of [ins] *)
//
val t = ins (t, x0)
//
in
//
case+ t of @cons(c as R, _, _, _) => (c := B; fold@ (t); t) | _ =>> t
//
end // end of [rbtree_insert]

(* ****** ****** *)

fun{
a:t@ype
} rbtree_free
  {c:clr}{bh:int}{v:int}
(
  t: rbtree (a, c, bh, v)
) : void = let
  #define nil rbtree_nil
  #define cons rbtree_cons
in
  case+ t of
  | ~cons (c, tl, x, tr) => (rbtree_free<a> (tl); rbtree_free<a> (tr)) | ~nil () => ()
end // end of [rbtree_free]

(* ****** ****** *)
  
fun{
a:t@ype
} print_rbtree
  {c:clr}{bh:int}{v:int}
(
  t: !rbtree (INV(a), c, bh, v)
) : void = let
  #define nil rbtree_nil
  #define cons rbtree_cons
in
  case+ t of
  | cons
    (
      c, tl, x, tr
    ) => {
      val () =
      (
        if c = BLK
          then print ("B(")
          else print ("R(")
        // end of [val]
      ) : void // end of [val]
      val () = print_rbtree<a> (tl)
      val () = print ", "
      val () = print_val<a> (x)
      val () = print ", "
      val () = print_rbtree<a> (tr)
      val () = print (")")
    } // end of [cons]
  | nil ((*void*)) => print ("nil")
end // end of [print_rbtree]

overload print with print_rbtree
  
(* ****** ****** *)

implement
main0 () =
{
  typedef T = int
  val cmp = $UNSAFE.cast{cmp(T)}(0)
  implement compare<int> (x, y, _) = x - y
//
  #define nil rbtree_nil; #define cons rbtree_cons
//
  var n: int
  var tree = nil ()
  macdef insert (x) = let
    val () = n := ,(x) in tree := rbtree_insert<T> (tree, n, cmp)
  end // end of [insert]
  val () = insert (3)
  val () = insert (2)
  val () = insert (5)
  val () = insert (4)
  val () = insert (8)
  val () = insert (7)
  val () = insert (6)
  val () = insert (9)
  val () = insert (1)
  val () = insert (0)
//
  val () =
    println! ("tree = ", tree)
  // end of [val]
  val () = rbtree_free<T> (tree)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [rbtree.dats] *)
