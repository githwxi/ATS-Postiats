//
// Test code for stack allocation
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

val () =
{
//
var A = @[int](0, 0, 0)
val () = A[1] := 1 and () = A[2] := 2
//
val out = stdout_ref
//
val () = fprint (out, "A = ")
val () = fprint (out, A, i2sz(3))
val () = fprint_newline (out)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
var A = @[int][3]()
prval () = showlvaltype (A)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [stkalloc.dats] *)
