(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

(* ****** ****** *)
//
#staload FC =
"libats/ATS2/SATS/fcntainer.sats"
//
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/main.dats"
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/list0.dats"
(*
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/array0.dats"
*)
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/integer.dats"
(*
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/intrange.dats"
*)
//
(* ****** ****** *)

#define N 8
typedef board = list0(int)

(* ****** ****** *)
//
fun
board_extend_test
(xs: board, x0: int): bool =
$FC.iforall_cloref<board><int>
(xs, lam(i, x) => (x0 != x && abs(x0-x) != i+1))
//
(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println!
("\
QueenPuzzle: \
not yet ready for testing!\
")(*println!*)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)
