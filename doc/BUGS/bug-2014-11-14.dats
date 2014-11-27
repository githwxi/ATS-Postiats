(*
** Bug in compiling
** mutually tail-recursive functions
*)

(* ****** ****** *)

(*
** Source: Reported by HX-2014-11-14
*)

(* ****** ****** *)

(*
** Status: It is fixed by HX-2014-11-14
*)

(* ****** ****** *)

extern
fun nop (): void

(* ****** ****** *)

fnx
foo (x: int): int =
(
  nop(); foo2 (x, x)
)
and foo2 (x: int, y: int): int = y

(* ****** ****** *)

fnx{}
foobar (x: int): int =
(
  nop(); foobar2 (x, x)
)
and foobar2 (x: int, y: int): int = y

(* ****** ****** *)

val x = foobar (0)

(* ****** ****** *)

(* end of [bug-2014-11-14.dats] *)
