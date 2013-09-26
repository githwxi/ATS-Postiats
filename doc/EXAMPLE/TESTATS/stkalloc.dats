//
// Test code for stack allocation
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

val () =
{
var x: int = 0
prval () = showlvaltype (x)
} (* end of [val] *)

(* ****** ****** *)

val () =
{
var !p_x: int = 0
prval () = showlvaltype (!p_x)
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

val () =
{
//
var A = @[int][3](1)
prval () = showlvaltype (A)
//
val out = stdout_ref
//
val () =
(
  fprint (out, "A = "); fprint (out, A, 3); fprint_newline (out)
)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
var A = @[int](0, 0, 0)
val () = A[1] := 1 and () = A[2] := 2
//
val out = stdout_ref
//
val () =
(
  fprint (out, "A = "); fprint (out, A, 3); fprint_newline (out)
)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [stkalloc.dats] *)
