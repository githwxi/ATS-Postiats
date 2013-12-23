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

dataviewtype
bstree_vt
  (a:t@ype+, int) =
  | {n1,n2:nat}
    bstree_vt_cons (a, 1+n1+n2) of
      (bstree_vt (a, n1), a, bstree_vt (a, n2))
  | bstree_vt_nil (a, 0) of ()
// end of [bstree_vt]

(* ****** ****** *)

fun{a:t@ype}
size {n:nat} .<n>. (
  t: !bstree_vt (a, n)
) : int (n) =
  case+ t of
  | bstree_vt_cons (!p_tl, _, !p_tr) => let
      val n = 1 + size (!p_tl) + size (!p_tr) in fold@ (t); n
    end // end of [bstree_vt_cons]
  | bstree_vt_nil () => (fold@ (t); 0)
// end of [size]

(* ****** ****** *)

fun{a:t@ype}
search {n:nat} .<n>. (
  t: !bstree_vt (a, n), P: (&a) -<cloref> bool
) : Option_vt (a) =
  case+ t of
  | bstree_vt_cons
      (!p_tl, !p_x, !p_tr) =>
      if P (!p_x) then let
        val res = search (!p_tl, P)
        val res = (
          case+ res of
          | ~None_vt () => Some_vt (!p_x) | _ => res
        ) : Option_vt (a)
      in
        fold@ (t); res
      end else let
        val res = search (!p_tr, P) in fold@ (t); res
      end // end of [if]
  | bstree_vt_nil () => (fold@ (t); None_vt ())
// end of [search]

(* ****** ****** *)

typedef cmp (a:t@ype) = (&a, &a) -> int

extern
fun{a:t@ype}
compare (x: &a, y: &a, cmp: cmp (a)): int

(* ****** ****** *)

fun{a:t@ype}
insert {n:nat} .<n>. (
  t: bstree_vt (a, n), x0: &a, cmp: cmp(a)
) : bstree_vt (a, n+1) =
  case+ t of
  | bstree_vt_cons
      (!p_tl, !p_x, !p_tr) => let
      val sgn = compare<a> (x0, !p_x, cmp)
    in
      if sgn <= 0 then let
        val () = !p_tl := insert (!p_tl, x0, cmp)
      in
        fold@ (t); t
      end else let
        val () = !p_tr := insert (!p_tr, x0, cmp)
      in
        fold@ (t); t
      end (* end of [if] *)
    end // end of [bstree_vt_cons]
  | ~bstree_vt_nil () =>
      bstree_vt_cons (bstree_vt_nil, x0, bstree_vt_nil)
    // end of [bstree_vt_nil]
// end of [insert]

(* ****** ****** *)

fun{a:t@ype}
insertRT {n:nat} .<n>. (
  t: bstree_vt (a, n), x0: &a, cmp: cmp(a)
) : bstree_vt (a, n+1) =
  case+ t of
  | bstree_vt_cons
      (!p_tl, !p_x, !p_tr) => let
      val sgn = compare<a> (x0, !p_x, cmp)
    in
      if sgn <= 0 then let
        val tl = insertRT (!p_tl, x0, cmp)
        val+ bstree_vt_cons (_, !p_tll, !p_tlr) = tl
        val () = !p_tl := !p_tlr
        val () = fold@ (t)
        val () = !p_tlr := t
      in
        fold@ (tl); tl
      end else let
        val tr = insertRT (!p_tr, x0, cmp)
        val+ bstree_vt_cons (!p_trl, _, !p_trr) = tr
        val () = !p_tr := !p_trl
        val () = fold@ (t)
        val () = !p_trl := t
      in
        fold@ (tr); tr
      end
    end // end of [bstree_vt_cons]
  | ~bstree_vt_nil () =>
      bstree_vt_cons (bstree_vt_nil, x0, bstree_vt_nil)
    // end of [bstree_vt_nil]
// end of [insertRT]


(* ****** ****** *)

fn{a:t@ype}
lrotate
  {nl,nr:nat | nr > 0}
  {l_tl,l_x,l_tr:addr} (
  pf_tl: bstree_vt (a, nl) @ l_tl
, pf_x: a @ l_x
, pf_tr: bstree_vt (a, nr) @ l_tr
| t: bstree_vt_cons_unfold (l_tl, l_x, l_tr)
, p_tl: ptr l_tl
, p_tr: ptr l_tr
) : bstree_vt (a, 1+nl+nr) = let
  val tr = !p_tr
  val+ bstree_vt_cons (!p_trl, _, !p_trr) = tr
  val () = !p_tr := !p_trl
  val () = fold@ (t)
  val () = !p_trl := t
in
  fold@ (tr); tr
end // end of [lrotate]

fn{a:t@ype}
rrotate
  {nl,nr:nat | nl > 0}
  {l_tl,l_x,l_tr:addr} (
  pf_tl: bstree_vt (a, nl) @ l_tl
, pf_x: a @ l_x
, pf_tr: bstree_vt (a, nr) @ l_tr
| t: bstree_vt_cons_unfold (l_tl, l_x, l_tr)
, p_tl: ptr l_tl
, p_tr: ptr l_tr
) : bstree_vt (a, 1+nl+nr) = let
  val tl = !p_tl
  val+ bstree_vt_cons (!p_tll, x, !p_tlr) = tl
  val () = !p_tl := !p_tlr
  val () = fold@ (t)
  val () = !p_tlr := t
in
  fold@ (tl); tl
end // end of [rrotate]

(* ****** ****** *)

fun{a:t@ype}
insertRT {n:nat} .<n>. (
  t: bstree_vt (a, n), x0: &a, cmp: cmp(a)
) : bstree_vt (a, n+1) =
  case+ t of
  | bstree_vt_cons
      (!p_tl, !p_x, !p_tr) => let
      val sgn = compare<a> (x0, !p_x, cmp)
    in
      if sgn <= 0 then let
        val () = !p_tl := insertRT (!p_tl, x0, cmp)
      in
        rrotate (view@(!p_tl), view@(!p_x), view@(!p_tr) | t, p_tl, p_tr)
      end else let
        val () = !p_tr := insertRT (!p_tr, x0, cmp)
      in
        lrotate (view@(!p_tl), view@(!p_x), view@(!p_tr) | t, p_tl, p_tr)
      end
    end // end of [bstree_vt_cons]
  | ~bstree_vt_nil () =>
      bstree_vt_cons (bstree_vt_nil, x0, bstree_vt_nil)
    // end of [bstree_vt_nil]
// end of [insertRT]

(* ****** ****** *)

(* end of [bstree_vt.dats] *)
