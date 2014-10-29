(*
** Bug in embedded templates
*)

(*
** Source:
** reported by Hongwei Xi
*)

(* ****** ****** *)

(*
** Status: There is NO fix as of now
*)

(* ****** ****** *)
//
fun{a:t0p}
foo (x: a) = x
//
(* ****** ****** *)
//
fun{a:t0p}
foo2 (x: a) =
  let fun{} bar2 (): a = x in bar2 () end
//
(* ****** ****** *)
//
extern
fun
foo2_int (x: int): int
//
implement
foo2_int (x) = foo2<int> (x)
//
(* ****** ****** *)

(* end of [bug-2014-10-29.dats] *)
