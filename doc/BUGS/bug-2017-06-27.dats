(* ****** ****** *)
//
// Reported by
// HX-2017-06-27
//
(* ****** ****** *)
//
// Fixed by HX-2017-06-27
//
(* ****** ****** *)
//
// It is now required
// that an else-clause is present
// in any ifcase-expression
//
// Without an else-clause in it,
// the code generated from compiling
// an ifcase-expression may be buggy!
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)
//
fun
fact(n: int): int =
ifcase
| (n > 0) => n * fact(n-1)
(*
| (n <= 0) => 1
*)
| _(* else *) => 1
//
(* ****** ****** *)
//
implement
main0() = () where
{
val () = println!("fact(10) = ", fact(10))
}
//
(* ****** ****** *)

(* end of [bug-2017-06-27] *)
