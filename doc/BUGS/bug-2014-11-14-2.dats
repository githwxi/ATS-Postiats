(*
** Bug in compiling
** mutually tail-recursive functions
*)

(* ****** ****** *)

(*
** Source: Reported by HX-2014-11-14-2
*)

(* ****** ****** *)

(*
** Status: It is fixed by HX-2014-11-14
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)
//
fnx
foo(x: int): int = foo2 (x)
//
and
foo2(x: int): int =
let fun bar (): int = x in bar () end
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2014-11-14-2.dats] *)
