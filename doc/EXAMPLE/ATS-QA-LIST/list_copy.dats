(* ****** ****** *)
//
// HX-2013-08:
//
// How to copy a list?
//
(* ****** ****** *)
//
// HX: the current plan is for this
// to reside in the "cloud" eventually.
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun{a:t0p}
list_copy
  {n:int} (xs: list (INV(a), n)): list (a, n)
// end of [list_copy]

(* ****** ****** *)
//
// HX: this one is non-tail-recursive
//
implement{a}
list_copy (xs) = let
//
fun copy{n:int}
(
  xs: list (a, n)
) : list (a, n) = let
in
//
case+ xs of
| list_cons (x, xs) =>
    list_cons{a}(x, copy (xs))
| list_nil () => list_nil ()
//
end // end of [copy]
//
in
  copy (xs)
end // end of [list_copy]

(* ****** ****** *)

extern
fun{a:t0p}
list_rcopy
  {n:int} (xs: list (INV(a), n)): list_vt (a, n)
// end of [list_copy]

(* ****** ****** *)
//
// HX: this one is tail-recursive
//
implement{a}
list_rcopy (xs) = let
//
fun loop{n1,n2:nat}
(
  xs: list (a, n1), res: list_vt (a, n2)
) : list_vt (a, n1+n2) = let
in
//
case+ xs of
| list_cons (x, xs) =>
    loop (xs, list_vt_cons{a}(x, res))
| list_nil () => res
//
end // end of [loop]
//
prval () = lemma_list_param (xs)
//
in
  loop (xs, list_vt_nil)
end // end of [list_rcopy]

(* ****** ****** *)

extern
fun{a:t0p}
list_copy2
  {n:int} (xs: list (INV(a), n)): list_vt (a, n)
// end of [list_copy2]

(* ****** ****** *)
//
// HX: [list_copy2] does list-traversal twice
//
implement{a}
list_copy2 (xs) = list_vt_reverse (list_rcopy (xs))

(* ****** ****** *)

extern
fun{a:t0p}
list_copy3
  {n:int} (xs: list (INV(a), n)): list_vt (a, n)
// end of [list_copy3]

(* ****** ****** *)
//
// HX: [list_copy3] does list-traversal only once
//
implement{a}
list_copy3 (xs) = let
//
fun loop{n:int}
(
  xs: list (a, n), res: &ptr? >> list_vt (a, n)
) : void = let
in
//
case xs of
| list_cons (x, xs1) =>
  {
    val () =
    res := list_vt_cons{a}{0}(x, _)
    val+list_vt_cons (_, res1) = res
    val ((*void*)) = loop (xs1, res1)
    prval () = fold@ (res)
  } 
| list_nil ((*void*)) => res := list_vt_nil ()
//
end // end of [list_copy3]
//
var res: ptr
val () = loop (xs, res)
//
in
  res
end // end of [list_copy3]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [list_copy.dats] *)
