(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#staload
FC =
"./../DATS/fcollect/opverb.dats"
#staload
FC_int0 =
"./../DATS/fcollect/opverb_int0.dats"
#staload
FC_list0 =
"./../DATS/fcollect/opverb_list0.dats"

(* ****** ****** *)

#define N 8

(* ****** ****** *)

abstype board = ptr

(* ****** ****** *)

local

assume
board = list0(int)

in (* in-of-local *)

fun
board_nil
(
): board =
(
  list0_nil()
)
fun
board_cons
( x0: int
, xs: board): board =
(
  list0_cons(x0, xs)
)

implement
$FC.streamize_vt<board><int> =
streamize_list0_elt<int>

end // end of [local]

(* ****** ****** *)

fun
board_fprint
(fr: FILEref, xs: board): void =
(
  $FC.fprint<board><int>(fr, xs)
) where
{
  implement
  $FC.forall<board><int> =
  $FC.rforall<board><int>
  implement
  fprint_val<int>(fr, x) =
  (
  $FC.foreach<int><int>(N)
  ) where
  {
  implement
  $FC.foreach$work<int>(i) =
  fprint_string(fr, ifval(x=i, "Q ", ". "))
  }
  implement
  $FC.fprint$sep<>(fr) = fprint_newline(fr)

} (* board_fprint *)

overload fprint with board_fprint

(* ****** ****** *)
//
fun
board_cons_test
(xs: board, x0: int): bool =
(
$FC.iforall<board><int>(xs)
) where
{
implement
$FC.iforall$test<int>
  (i, x) = (x0 != x && abs(x0-x) != i+1)
}
//
(* ****** ****** *)
//
fun
board_extend_all
( xs
: board )
: list0(board) =
(
$FC.mapopt_list0<int><int><board>
(N)
) where
{
implement
$FC.mapopt_list0$fopr<int><board>
  (x0) =
(
  if
  board_cons_test(xs, x0)
  then Some0_vt(board_cons(x0, xs)) else None0_vt()
)
} (*end of [board_extend_all]*)
//
(* ****** ****** *)

fun
qsolve
(
) : list0(board) =
(
  helper(0)
) where
{
fun
helper
(i: int): list0(board) =
  if
  (i < N)
  then let
    val xss = helper(i+1)
  in
    list0_concat<board>
    (
      $FC.map_list0<list0(board)><board><list0(board)>(xss)
    ) where
    {
      implement
      $FC.map_list0$fopr<board><list0(board)>(xs) = board_extend_all(xs)
    }
  end else list0_sing(board_nil())
} (* end of [qsolve] *)

(* ****** ****** *)

implement
main0() = () where
{
//
(*
val () =
println!
("\
QueenPuzzle: \
not yet ready for testing!\
")(*println!*)
*)
//
val xss = qsolve()
val ((*void*)) =
(
$FC.iforeach<list0(board)><board>(xss)
) where
{
implement
$FC.iforeach$work<board>
  (i, board) =
(
  if i > 0 then
    fprintln!(stdout_ref);
  // end of [if]
  fprintln!
  ( stdout_ref
  , "Solution#", i+1, ": ");
  fprintln!(stdout_ref, board)
)
}
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)
