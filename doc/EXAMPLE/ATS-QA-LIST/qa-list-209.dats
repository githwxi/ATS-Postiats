(* ****** ****** *)
//
// HX-2014-02-25
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val hundred = 100
//
val () = println! ("hundred = ", hundred)
//
val () =
{
fun print_int
  (x: int): void = ignoret ($extfcall(int, "printf", "%04X", x))
overload print with print_int of 1000000
//
val () = println! ("hundred = ", hundred)
}
//
val () = println! ("hundred = ", hundred)

(* ****** ****** *)

val digits = let
  val xs = list_make_intrange(0, 10) in list_vt2t{int}(xs)
end // end of [val]

(* ****** ****** *)

val () = println! ("digits = ", digits)

(* ****** ****** *)

val () = let
//
implement
fprint_val<int> (out, i) =
  ignoret($extfcall(int, "fprintf", out, "%04X", i))
//
in
  println! ("digits = ", digits)
end // end of [val]

(* ****** ****** *)

val () = println! ("digits = ", digits)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [qa-list-209.dats] *)
