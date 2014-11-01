(*
** Bug in arrays
** of variable-length
*)

(*
** Source:
** reported by Barry Schwartz
** Symptom:
** there is no error message
** issued due to failure to compile
** a stack-allocated array of variable-length
*)

(* ****** ****** *)

(*
** Status: Fixed by HX-2014-10-31
*)

(* ****** ****** *)

fun
foo{n:nat}
  (n: int(n)): void =
{
//
extern
fun
bar
(
  &(@[int?][n]) >> @[int][n]
) : void // end of [bar]
//
var A = @[int][n]((*uninitized*))
val ((*void*)) = bar (A)
//
} (* end of [foo] *)

(* ****** ****** *)

(* end of [bug-2014-10-31.dats] *)
