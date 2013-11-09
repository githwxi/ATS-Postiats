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
** Functional Red-Black Trees
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef cmp (a:t@ype) = (a, a) -> int

(* ****** ****** *)

extern
fun{a:t@ype}
compare (x: a, y: a, cmp: cmp (a)): int

(* ****** ****** *)

#define BLK 0
#define RED 1
sortdef clr = {c:nat | c <= 1}

datatype rbtree
  (a:t@ype, int(*clr*), int(*bh*)) =
  | {c,cl,cr:clr | cl <= 1-c; cr <= 1-c} {bh:nat}
    rbtree_cons (a, c, bh+1-c) of (int c, rbtree (a, cl, bh), a, rbtree (a, cr, bh))
  | rbtree_nil (a, BLK, 0)
// end of [rbtree]

(* ****** ****** *)

datatype
rbtree (
  a: t@ype
, int(*c*), int(*bh*), int(*v*)
) = // element type, color, black height, violations
  | rbtree_nil (a, BLK, 0, 0) of ()
  | {c,cl,cr:clr} {bh:nat} {v:int}
      {c==BLK && v==0 || c == RED && v==cl+cr}
    rbtree_cons (a, c, bh+1-c, v) of (
      int c, rbtree0 (a, cl, bh), a, rbtree0 (a, cr, bh)
    ) // end of [rbtree_cons]
// end of [rbtree]

where rbtree0 (a:t@ype, c:int, bh:int) = rbtree (a, c, bh, 0)

(* ****** ****** *)

fn{
a:t@ype
} insfix_l // right rotation
  {cl,cr:clr} {bh:nat} {v:nat} (
  tl: rbtree (a, cl, bh, v), x0: a, tr: rbtree (a, cr, bh, 0)
) : [c:clr] rbtree0 (a, c, bh+1) = let
  #define B BLK; #define R RED; #define cons rbtree_cons
in
  case+ (tl, x0, tr) of
  | (cons (R, cons (R, a, x, b), y, c), z, d) =>
      cons (R, cons (B, a, x, b), y, cons (B, c, z, d)) // shallow rot
  | (cons (R, a, x, cons (R, b, y, c)), z, d) =>
      cons (R, cons (B, a, x, b), y, cons (B, c, z, d)) // deep rotation
  | (a, x, b) =>> cons (B, a, x, b)
end // end of [insfix_l]

fn{
a:t@ype
} insfix_r // left rotation
  {cl,cr:clr} {bh:nat} {v:nat} (
  tl: rbtree (a, cl, bh, 0), x0: a, tr: rbtree (a, cr, bh, v)
) : [c:clr] rbtree0 (a, c, bh+1) = let
  #define B BLK; #define R RED; #define cons rbtree_cons
in
  case+ (tl, x0, tr) of
  | (a, x, cons (R, b, y, cons (R, c, z, d))) =>
      cons (R, cons (B, a, x, b), y, cons (B, c, z, d)) // shallow rot
  | (a, x, cons (R, cons (R, b, y, c), z, d)) =>
      cons (R, cons (B, a, x, b), y, cons (B, c, z, d)) // deep rotation
  | (a, x, b) =>> cons (B, a, x, b)
end // end of [insfix_r]

(* ****** ****** *)

extern
fun{a:t@ype}
rbtree_insert
  {c:clr} {bh:nat} (
  t: rbtree0 (a, c, bh), x0: a, cmp: cmp a
) : [bh1:nat] rbtree0 (a, BLK, bh1)

implement{a}
rbtree_insert
  (t, x0, cmp) = let
  #define B BLK; #define R RED
  #define nil rbtree_nil; #define cons rbtree_cons
  fun ins
    {c:clr} {bh:nat} .<bh,c>. (
    t: rbtree0 (a, c, bh), x0: a
  ) :<cloref1> [cl:clr; v:nat | v <= c] rbtree (a, cl, bh, v) =
    case+ t of
    | cons (c, tl, x, tr) => let
        val sgn = compare<a> (x0, x, cmp)
      in
        if sgn < 0 then let
          val [cl:int,v:int] tl = ins (tl, x0)
        in
          if c = B then insfix_l<a> (tl, x, tr)
            else cons{..}{..}{..}{cl} (R, tl, x, tr)
          // end of [if]
        end else if sgn > 0 then let
          val [cr:int,v:int] tr = ins (tr, x0)
        in
          if c = B then insfix_r<a> (tl, x, tr)
            else cons{..}{..}{..}{cr} (R, tl, x, tr)
          // end of [if]
        end else t // end of [if]
      end // end of [cons]
    | nil () => cons{..}{..}{..}{0} (R, nil, x0, nil)
  // end of [ins]
  val t = ins (t, x0)
in
  case+ t of cons (R, tl, x, tr) => cons (B, tl, x, tr) | _ =>> t
end // end of [rbtree_insert]

(* ****** ****** *)

implement
main0 () = () where {
//
typedef T = int
//
val cmp = $extval (cmp(T), "0")
implement compare<T> (x, y, _) = x - y
//
#define nil rbtree_nil
#define cons rbtree_cons
//
var t = nil ()
macdef insert (x) = t := rbtree_insert<T> (t, ,(x), cmp)
val () = insert (0)
val () = insert (3)
val () = insert (2)
val () = insert (5)
val () = insert (4)
val () = insert (8)
val () = insert (7)
val () = insert (6)
val () = insert (9)
val () = insert (1)
//
val () =
prtree (t) where
{
  fun prtree
    {c:clr}{bh:int}
  (
    t: rbtree0 (T, c, bh)
  ) : void =
    case+ t of
    | nil (
      ) => print ("nil")
    | cons (
        c, tl, x, tr
      ) => {
        val () =
        (
          if c = BLK
            then print ("B(") else print ("R(")
          // end of [if]
        ) : void
        val () = prtree (tl)
        val () = print ", "
        val () = print (x)
        val () = print ", "
        val () = prtree (tr)
        val () = print (")")
      } // end of [cons]
  // end of [prtree]
} // end of [val]
//
val () = print_newline ()
//
} // end of [main0]

(* ****** ****** *)

(* end of [rbtree.dats] *)
