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

typedef cmp (a:t@ype) = (&a, &a) -> int

(* ****** ****** *)

extern
fun{a:t@ype} compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

#define BLK 0
#define RED 1
sortdef clr = {c:int | 0 <= c; c <= 1}

dataviewtype
rbtree (
  a: t@ype+, int(*c*), int(*bh*), int(*v*)
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

fn{a:t@ype}
insfix_l // right rotation
  {cl,cr:clr}
  {bh:nat}
  {v:nat}
  {l_c,l_tl,l_x,l_tr:addr} (
  pf_c: int(BLK) @ l_c
, pf_tl: rbtree (a, cl, bh, v) @ l_tl
, pf_x: a @ l_x
, pf_tr: rbtree (a, cr, bh, 0) @ l_tr
| t: rbtree_cons_unfold (l_c, l_tl, l_x, l_tr)
, p_tl: ptr (l_tl)
) : [c:clr] rbtree0 (a, c, bh+1) = let
  #define B BLK
  #define R RED
  #define cons rbtree_cons
in
  case+ !p_tl of
  | cons (!p_cl as R, !p_tll as cons (!p_cll as R, _, _, _), _, !p_tlr) => let
//
      val () = !p_cll := B
      val () = fold@ (!p_tll)
//
      val tl = !p_tl
      val () = !p_tl := !p_tlr
      val () = fold@ (t)
//
      val () = !p_tlr := t
    in
      fold@ (tl); tl
    end // end of [cons (R, cons (R, ...), ...)]
  | cons (!p_cl as R, !p_tll, _, !p_tlr as cons (!p_clr as R, !p_tlrl, _, !p_tlrr)) => let
//
      val tl = !p_tl
      val () = !p_tl := !p_tlrr
      val () = fold@ (t)
      val () = !p_tlrr := t
//
      val tlr = !p_tlr
      val () = !p_tlr := !p_tlrl
      val () = !p_cl := B
      val () = fold@ (tl)
      val () = !p_tlrl := tl
//
    in
      fold@ (tlr); tlr
    end // end of [cons (R, ..., cons (R, ...))]
  | _ =>> (fold@ (t); t)
end // end of [insfix_l]

(* ****** ****** *)

fn{a:t@ype}
insfix_r // left rotation
  {cl,cr:clr}
  {bh:nat}
  {v:nat}
  {l_c,l_tl,l_x,l_tr:addr} (
  pf_c: int(BLK) @ l_c
, pf_tl: rbtree (a, cl, bh, 0) @ l_tl
, pf_x: a @ l_x
, pf_tr: rbtree (a, cr, bh, v) @ l_tr
| t: rbtree_cons_unfold (l_c, l_tl, l_x, l_tr)
, p_tr: ptr (l_tr)
) : [c:clr] rbtree0 (a, c, bh+1) = let
  #define B BLK
  #define R RED
  #define cons rbtree_cons
in
  case+ !p_tr of
  | cons (!p_cr as R, !p_trl, _, !p_trr as cons (!p_crr as R, _, _, _)) => let
//
      val () = !p_crr := B
      val () = fold@ (!p_trr)
//
      val tr = !p_tr
      val () = !p_tr := !p_trl
      val () = fold@ (t)
//
      val () = !p_trl := t
    in
      fold@ (tr); tr
    end // end of [cons (R, ..., cons (R, ...))]
  | cons (!p_cr as R, !p_trl as cons (!p_crr as R, !p_trll, _, !p_trlr), _, !p_trr) => let
//
      val tr = !p_tr
      val () = !p_tr := !p_trll
      val () = fold@ (t)
      val () = !p_trll := t
//
      val trl = !p_trl
      val () = !p_trl := !p_trlr
      val () = !p_cr := B
      val () = fold@ (tr)
      val () = !p_trlr := tr
//
    in
      fold@ (trl); trl
    end // end of [cons (R, cons (R, ...), ...)]
  | _ =>> (fold@ (t); t)
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
  {c:clr} {bh:nat} .<bh,c>. (
  t: rbtree0 (a, c, bh), x0: &a
) :<cloref1> [cl:clr; v:nat | v <= c] rbtree (a, cl, bh, v) =
  case+ t of
  | cons (
      !p_c, !p_tl, !p_x, !p_tr
    ) => let
      val sgn = compare<a> (x0, !p_x, cmp)
    in
      if sgn < 0 then let
        val [cl,v:int] tl = ins (!p_tl, x0)
        val () = !p_tl := tl
      in
        if !p_c = B then
          insfix_l (view@(!p_c), view@(!p_tl), view@(!p_x), view@(!p_tr) | t, p_tl)
        else let
          val () = !p_c := R in fold@ {a}{..}{..}{cl} (t); t
        end // end of [if]
      end else if sgn > 0 then let
        val [cr,v:int] tr = ins (!p_tr, x0)
        val () = !p_tr := tr
      in
        if !p_c = B then
          insfix_r (view@(!p_c), view@(!p_tl), view@(!p_x), view@(!p_tr) | t, p_tr)
        else let
          val () = !p_c := R in fold@ {a}{..}{..}{cr} (t); t
        end // end of [if]
      end else (fold@ {a}{..}{..}{0} (t); t) // end of [if]
    end // end of [cons]
  | ~nil () => cons {..}{..}{..}{0} (R, nil, x0, nil)
// end of [ins]
val t = ins (t, x0)
//
in
//
case+ t of cons (!p_c as R, _, _, _) => (!p_c := B; fold@ (t); t) | _ =>> t
//
end // end of [rbtree_insert]

(* ****** ****** *)

implement
main () = () where {
  val cmp = $extval (cmp(int), "0")
  implement compare<int> (x, y, _) = x - y
//
  #define nil rbtree_nil; #define cons rbtree_cons
//
  var n: int
  var t = nil ()
  macdef insert (x) = let
    val () = n := ,(x) in t := rbtree_insert (t, n, cmp)
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
  val () = prtree (t) where {
    typedef T = int
    fun prtree {c:clr} {bh:int} (t: rbtree0 (T, c, bh)) =
      case+ t of
      | ~cons (c, tl, x, tr) => {
          val () = if c = BLK then print ("B(") else print ("R(")
          val () = prtree (tl)
          val () = print ", "
          val () = print (x)
          val () = print ", "
          val () = prtree (tr)
          val () = print (")")
        } // end of [cons]
      | ~nil () => print ("nil")
    // end of [prtree]
  } // end of [val]
  val () = print_newline ()
//
} // end of [main]

(* ****** ****** *)

(* end of [rbtree.dats] *)
