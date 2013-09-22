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

val () =
{
var !p_x: int with pf_x = 0
val p2_x = $showtype (p_x)
prval () = showlvaltype (!p_x)
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [stkalloc.dats] *)
