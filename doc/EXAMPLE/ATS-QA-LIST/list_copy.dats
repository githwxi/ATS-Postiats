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
#include "share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

extern
fun{a:t0p}
list_copy
  {n:int} (xs: list (a, n)): list (a, n)
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
    list_cons (x, copy (xs))
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
  {n:int} (xs: list (a, n)): list_vt (a, n)
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
  {n:int} (xs: list (a, n)): list_vt (a, n)
// end of [list_copy2]

implement{a}
list_copy2 (xs) = list_vt_reverse (list_rcopy (xs))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [list_last.dats] *)
