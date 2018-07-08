(* ****** ****** *)
//
// Reported by
// HX-2017-05-19
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
foo_val(x: a): a
//
(* ****** ****** *)
//
fun
xfoo
(x: int): int = x
//
// HX: buggy:
//
implement
foo_val<int> = xfoo
(*
//
// HX: this is okay:
//
implement
foo_val<int>(x) = xfoo(x)
*)
//
(* ****** ****** *)
//
implement main() = foo_val<int>(101)
//
(* ****** ****** *)

(* [bug-2017-05-19.dats] *)
