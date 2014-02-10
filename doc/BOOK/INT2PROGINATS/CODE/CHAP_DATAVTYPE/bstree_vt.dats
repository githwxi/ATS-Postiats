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
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)
//
// HX-2014-02-11: Ported to ATS2
//
(* ****** ****** *)

datavtype
bstree_vt
  (a:t@ype+, int) =
  | bstree_vt_nil (a, 0) of ()
  | {n1,n2:nat}
    bstree_vt_cons (a, 1+n1+n2) of
      (bstree_vt (a, n1), a, bstree_vt (a, n2))
// end of [bstree_vt]

(* ****** ****** *)

fun{
a:t@ype
} size{n:nat} .<n>.
(
  t: !bstree_vt (a, n)
) : int (n) =
  case+ t of
  | bstree_vt_nil () => 0
  | bstree_vt_cons
     (tl, _, tr) => 1 + size (tl) + size (tr)
// end of [size]

(* ****** ****** *)

fun{
a:t@ype
} search
  {n:nat} .<n>.
(
  t: !bstree_vt (a, n), P: (&a) -<cloref> bool
) : Option_vt (a) =
  case+ t of
  | @bstree_vt_cons
      (tl, x, tr) =>
      if P (x) then let
        val res = search (tl, P)
        val res = (
          case+ res of
          | ~None_vt () => Some_vt (x) | _ => res
        ) : Option_vt (a)
      in
        fold@ (t); res
      end else let
        val res = search (tr, P) in fold@ (t); res
      end // end of [if]
  | @bstree_vt_nil () => (fold@ (t); None_vt ())
// end of [search]

(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

fun{
a:t@ype
} insert{n:nat} .<n>.
(
  t: bstree_vt (a, n), x0: &a, cmp: cmp(a)
) : bstree_vt (a, n+1) =
  case+ t of
  | @bstree_vt_cons
      (tl, x, tr) => let
      val sgn = compare<a> (x0, x, cmp)
    in
      if sgn <= 0 then let
        val () = tl := insert (tl, x0, cmp)
      in
        fold@ (t); t
      end else let
        val () = tr := insert (tr, x0, cmp)
      in
        fold@ (t); t
      end (* end of [if] *)
    end // end of [bstree_vt_cons]
  | ~bstree_vt_nil () =>
      bstree_vt_cons (bstree_vt_nil, x0, bstree_vt_nil)
    // end of [bstree_vt_nil]
// end of [insert]

(* ****** ****** *)

fun{
a:t@ype
} insertRT{n:nat} .<n>.
(
  t: bstree_vt (a, n), x0: &a, cmp: cmp(a)
) : bstree_vt (a, n+1) =
  case+ t of
  | @bstree_vt_cons
      (tl, x, tr) => let
      val sgn = compare<a> (x0, x, cmp)
    in
      if sgn <= 0 then let
        val tl_ = insertRT (tl, x0, cmp)
        val+@bstree_vt_cons (_, tll, tlr) = tl_
        val () = tl := tlr
        prval () = fold@ (t)
        val () = tlr := t
      in
        fold@ (tl_); tl_
      end else let
        val tr_ = insertRT (tr, x0, cmp)
        val+@bstree_vt_cons (trl, _, trr) = tr_
        val () = tr := trl
        prval () = fold@ (t)
        val () = trl := t
      in
        fold@ (tr_); tr_
      end
    end // end of [bstree_vt_cons]
  | ~bstree_vt_nil () =>
      bstree_vt_cons (bstree_vt_nil, x0, bstree_vt_nil)
    // end of [bstree_vt_nil]
// end of [insertRT]

(* ****** ****** *)

fn{
a:t@ype
} lrotate
  {l,l_tl,l_x,l_tr:addr} 
  {nl,nr:int | nl >= 0; nr > 0}
(
  pf_tl: bstree_vt (a, nl) @ l_tl
, pf_x: a @ l_x
, pf_tr: bstree_vt (a, nr) @ l_tr
| t: bstree_vt_cons_unfold (l, l_tl, l_x, l_tr)
, p_tl: ptr l_tl
, p_tr: ptr l_tr
) : bstree_vt (a, 1+nl+nr) = let
  val tr = !p_tr
  val+@bstree_vt_cons (trl, _, trr) = tr
  val () = !p_tr := trl
  prval () = fold@ (t); val () = trl := t
in
  fold@ (tr); tr
end // end of [lrotate]

fn{
a:t@ype
} rrotate
  {l,l_tl,l_x,l_tr:addr}
  {nl,nr:int | nl > 0; nr >= 0}
(
  pf_tl: bstree_vt (a, nl) @ l_tl
, pf_x: a @ l_x
, pf_tr: bstree_vt (a, nr) @ l_tr
| t: bstree_vt_cons_unfold (l, l_tl, l_x, l_tr)
, p_tl: ptr l_tl
, p_tr: ptr l_tr
) : bstree_vt (a, 1+nl+nr) = let
  val tl = !p_tl
  val+@bstree_vt_cons (tll, x, tlr) = tl
  val () = !p_tl := tlr
  prval () = fold@ (t); val () = tlr := t
in
  fold@ (tl); tl
end // end of [rrotate]

(* ****** ****** *)

fun{
a:t@ype
} insertRT {n:nat} .<n>.
(
  t: bstree_vt (a, n), x0: &a, cmp: cmp(a)
) : bstree_vt (a, n+1) =
  case+ t of
  | @bstree_vt_cons
      (tl, x, tr) => let
      prval pf_x = view@x
      prval pf_tl = view@tl
      prval pf_tr = view@tr
      val sgn = compare<a> (x0, x, cmp)
    in
      if sgn <= 0 then let
        val () = tl := insertRT<a> (tl, x0, cmp)
      in
        rrotate<a> (pf_tl, pf_x, pf_tr | t, addr@tl, addr@tr)
      end else let
        val () = tr := insertRT<a> (tr, x0, cmp)
      in
        lrotate<a> (pf_tl, pf_x, pf_tr | t, addr@tl, addr@tr)
      end (* end of [if] *)
    end // end of [bstree_vt_cons]
  | ~bstree_vt_nil () =>
      bstree_vt_cons (bstree_vt_nil, x0, bstree_vt_nil)
    // end of [bstree_vt_nil]
// end of [insertRT]

(* ****** ****** *)

(* end of [bstree_vt.dats] *)
