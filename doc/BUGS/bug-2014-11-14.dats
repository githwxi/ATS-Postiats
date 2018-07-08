(*
** Bug in compiling
** mutually tail-recursive functions
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
** Source: Reported by HX-2014-11-14
*)

(* ****** ****** *)

(*
//
** Status: HX-2016-06-27: circumvented:
** [fnx] is treated as [fun] for introducing function templates!!!
//
*)

(* ****** ****** *)
//
fun
nop (): void = ()
//
(* ****** ****** *)

(*
fnx
foo (x: int): int =
(
  nop(); foo2 (x, x)
)
and foo2 (x: int, y: int): int = y
*)

(* ****** ****** *)
//
fnx{}
isevn(n: int): bool =
 if n > 0 then isodd(n-1) else true
and
isodd(n: int): bool =
 if n > 0 then isevn(n-1) else false
//
val () = println! ("isevn(100) = ", isevn(100))
val () = println! ("isevn(101) = ", isevn(101))
//
(* ****** ****** *)
//
fnx{}
foobar
  (x: int): int =
(
  nop(); foobar2 (x, x)
)
and foobar2 (x: int, y: int): int = y
//
val x = foobar(0)
val () = println! "foobar(0) = " x
//
(* ****** ****** *)

fun{}
myfoobar
  (x: int): int =
  foobar(x) where
{
//
fnx
foobar (x: int): int =
(
  nop(); foobar2 (x, x)
)
and foobar2 (x: int, y: int): int = y
//
} (* end of [myfoobar] *)
//
val x = myfoobar (0)
val () = println! "myfoobar(0) = " x
//

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2014-11-14.dats] *)
