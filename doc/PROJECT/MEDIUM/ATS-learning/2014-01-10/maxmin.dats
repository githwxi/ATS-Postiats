(*
** dats -> filename extension
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern fun max (int, int): int
extern fun min (int, int): int

(* ****** ****** *)
//
implement
max (x, y) = if x >= y then x else y
//
implement
min (x, y) = if x <= y then x else y
//
(* ****** ****** *)

implement
main0 (argc, argv) = {
val () = assertloc (argc >= 3)
val x1 = g0string2int (argv[1]): int
val x2 = g0string2int (argv[2]): int
val () = println! ("max(", x1, ", ", x2, ") = ", max(x1, x2))
val () = println! ("min(", x1, ", ", x2, ") = ", min(x1, x2))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [maxmin.dats] *)
