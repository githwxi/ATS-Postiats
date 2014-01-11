(*
** toothpick problem
*)

(* ****** ****** *)

extern
fun
myfun (h: int, v: int): int

(* ****** ****** *)

implement
myfun (h, v) = h * (v+1) + v * (h+1)

(* ****** ****** *)

(* end of [myfun.dats] *)
