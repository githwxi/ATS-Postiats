(*
** Bug in constraint-solving
*)
(* ****** ****** *)
//
// Reported by HX-2014-03-12
//
(* ****** ****** *)
//
// Status: fixed by HX-2014-03-12 // HX: a typo!!!
//
(* ****** ****** *)

stacst CLS0 : cls
abstype gobjref (cls)

(* ****** ****** *)

extern
fun foo
(
// argumentless
) : [c:cls | c <= CLS0] gobjref (c)

(* ****** ****** *)

fun foo2
  {n: int | n > 0} () =
{
val () = prop_verify {n > 0} ()
val obj = foo ()
val () = prop_verify {n > 0} ()
} (* end of [foo2] *)

(* ****** ****** *)

(* end of [bug-2014-03-11.dats] *)
