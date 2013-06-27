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
_(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

exception A and B

(* ****** ****** *)

fun ftest
  (x: int): int =
(
  try (
    if aux (x) = 0 then 0 else $raise (B)
  ) with ~A () => 0
) // end of [ftest1]

and aux (x: int): int = if x = 0 then $raise (A) else 1

(* ****** ****** *)

val out = stdout_ref
val () = fprintln! (out, "ftest(0) = ", ftest (0))
val () = fprintln! (out, "ftest(1) = ", ftest (1))

(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/list.dats"
val _ = list_head_exn<int> (list_nil)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [trywith.dats] *)
