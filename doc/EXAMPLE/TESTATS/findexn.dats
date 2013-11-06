//
// Some code involving a local exception
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: November, 2013
//
(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/basics.dats"
staload
_(*anon*) = "prelude/DATS/integer.dats"
staload
_(*anon*) = "prelude/DATS/float.dats"

(* ****** ****** *)

implement{a}
list_find_exn
  (xs) = let
//
exception Found of (a)
//
// HX: this is a terrible style of implementation
//
fun
loop {n:nat} .<n>.
  (xs: list(a, n)):<!exn> void =
(
  case+ xs of
  | list_nil () => ()
  | list_cons (x, xs) =>
      if list_find$pred<a> (x) then $raise Found(x) else loop (xs)
    // end of [list_cons]
) (* end of [loop] *)
//
prval () = lemma_list_param (xs)
//
in
//
try
  let val () = loop (xs) in $raise ListSubscriptExn() end
with
  | ~Found(x) => x
//
end // end of [list_find_exn]

(* ****** ****** *)

implement
list_find$pred<int> (x) = x >= 5
val xs = $list{int}(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
val-5 = list_find_exn<int> (xs)

(* ****** ****** *)

implement
list_find$pred<double> (x) = x >= 5.0
val xs = $list{double}(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
val-5.0 = list_find_exn<double> (xs)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [findexn.dats] *)
