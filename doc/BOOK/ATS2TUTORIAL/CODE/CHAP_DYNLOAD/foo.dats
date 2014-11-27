(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val x = 1000
val y = x + x // = 2000
val z = y * y // = 4000000

(* ****** ****** *)
//
extern
fun sum_x_y_z (): int
//
implement sum_x_y_z () = x + y + z
//
(* ****** ****** *)

(* end of [foo.dats] *)

