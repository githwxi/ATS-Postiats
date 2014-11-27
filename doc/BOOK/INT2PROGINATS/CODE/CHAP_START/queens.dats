(*
**
** A template for
** a single-file ATS program
**
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

#define N 8 // HX: it should not change!

(* ****** ****** *)

typedef int8 =
(
  int, int, int, int, int, int, int, int
) (* end of [int8] *)

(* ****** ****** *)

fun print_dots (i: int): void =
  if i > 0 then (print ". "; print_dots (i-1)) else ()
// end of [print_dots]

fun print_row (i: int): void = begin
  print_dots (i); print "Q "; print_dots (N-i-1); print '\n';
end // end of [print_row]

fun print_board (bd: int8): void = begin
  print_row (bd.0); print_row (bd.1); print_row (bd.2); print_row (bd.3);
  print_row (bd.4); print_row (bd.5); print_row (bd.6); print_row (bd.7);
  print_newline ()
end // end of [print_board]

(* ****** ****** *)

fun
board_get
(
  bd: int8, i: int
) : int =
  if i = 0 then bd.0
  else if i = 1 then bd.1
  else if i = 2 then bd.2
  else if i = 3 then bd.3
  else if i = 4 then bd.4
  else if i = 5 then bd.5
  else if i = 6 then bd.6
  else if i = 7 then bd.7
  else 0 // end of [if]
// end of [board_get]

fun
board_set
(
  bd: int8, i: int, j:int
) : int8 = let
  val (x0, x1, x2, x3, x4, x5, x6, x7) = bd
in
  if i = 0 then let
    val x0 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 1 then let
    val x1 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 2 then let
    val x2 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 3 then let
    val x3 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 4 then let
    val x4 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 5 then let
    val x5 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 6 then let
    val x6 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 7 then let
    val x7 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else bd // end of [if]
end // end of [board_set]

(* ****** ****** *)

fun safety_test1
(
  i0: int, j0: int, i1: int, j1: int
) : bool =
(*
** [abs]: the absolute value function
*)
  j0 <> j1 andalso abs (i0 - i1) <> abs (j0 - j1)
// end of [safety_test1]

fun safety_test2
(
  i0: int, j0: int, bd: int8, i: int
) : bool =
  if i >= 0 then
    if safety_test1 (i0, j0, i, board_get (bd, i))
      then safety_test2 (i0, j0, bd, i-1) else false
    // end of [if]
  else true // end of [if]
// end of [safety_test2]

(* ****** ****** *)

fun search
(
  bd: int8, i: int, j: int, nsol: int
) : int =
//
if (
j < N
) then (
  if safety_test2 (i, j, bd, i-1)
    then let
      val bd1 = board_set (bd, i, j)
    in
      if i+1 = N then let
        val () = print!
          ("This is solution no. ", nsol+1, ":\n\n")
        val () = print_board (bd1) in search (bd, i, j+1, nsol+1)
      end else search (bd1, i+1, 0, nsol)
    end // end of [then]
    else search (bd, i, j+1, nsol)
) else (
  if i > 0
    then search (bd, i-1, board_get (bd, i-1) + 1, nsol) else nsol
  // end of [if]
) (* end of [if] *)
//
// end of [search]

(* ****** ****** *)

val () = print_board @(0, 1, 2, 3, 4, 5, 6, 7)
val nsol = search ((0, 0, 0, 0, 0, 0, 0, 0), 0, 0, 0)

(* ****** ****** *)

implement main0 () = () // a dummy implementation for [main]

(* ****** ****** *)

(* end of [queens.dats] *)
