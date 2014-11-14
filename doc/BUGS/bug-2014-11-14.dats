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
** Status: NOT FIXED YET
*)

(* ****** ****** *)

extern
fun nop (): void

fnx
foo (x: int): int =
(
  nop(); foo2 (x, x)
)
and foo2 (x: int, y: int): int = x + y

(* ****** ****** *)

(* end of [bug-2014-11-14.dats] *)
