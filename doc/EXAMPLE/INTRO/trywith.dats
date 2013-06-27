//
// Some code involving try-with-expressions
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: June, 2013
//
(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/list.dats"
staload
_(*anon*) = "prelude/DATS/arrayptr.dats"
staload
_(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

val x =
(
try
  list_head_exn<int> (list_nil)
with
| exn => ifListSubscriptExn{int}(exn, ~1)
) (* end of [val] *)
val () = println! ("x = ", x)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [trywith.dats] *)
