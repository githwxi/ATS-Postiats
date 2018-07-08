(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Python3
//
(* ****** ****** *)
(*
** Copyright (C) 2011 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** Example: Eight Queens Puzzle
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2
** by Hongwei Xi (gmhwxiATgmailDOTcom)
** Time: March 24, 2013
*)

(* ****** ****** *)
//
#define
LIBATSCC2PY3_targetloc
"$PATSHOME\
/contrib/libatscc2py3/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PY3}/staloadall.hats"
//
(* ****** ****** *)

#define N 8 // HX: this should not be changed!

(* ****** ****** *)

typedef
int8 = $tup (
  int, int, int, int, int, int, int, int
) // end of [int8]

fun print_dots
  (i: int): void =
  if i > 0 then (print ". "; print_dots (i-1)) else ()
// end of [print_dots]

fun print_row
  (i: int): void = begin
  print_dots (i); print "Q "; print_dots (N-i-1); print "\n";
end // end of [print_row]

fun print_board
  (bd: int8): void = begin
  print_row (bd.0); print_row (bd.1); print_row (bd.2); print_row (bd.3);
  print_row (bd.4); print_row (bd.5); print_row (bd.6); print_row (bd.7);
  print_newline ()
end // end of [print_board]

(* ****** ****** *)

fun board_get
  (bd: int8, i: int): int =
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

fun board_set
  (bd: int8, i: int, j:int): int8 = let
  val '(x0, x1, x2, x3, x4, x5, x6, x7) = bd
in
  case+ i of
  | 0 => let
      val x0 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [0]
  | 1 => let
      val x1 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [1]
  | 2 => let
      val x2 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [2]
  | 3 => let
      val x3 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [3]
  | 4 => let
      val x4 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [4]
  | 5 => let
      val x5 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [5]
  | 6 => let
      val x6 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [6]
  | 7 => let
      val x7 = j in
      $tup(x0, x1, x2, x3, x4, x5, x6, x7)
    end // end of [7]
  | _ (*error*) => bd
end // end of [board_set]

(* ****** ****** *)

fun
safety_test1
(
  i0: int, j0: int, i1: int, j1: int
) : bool =
(*
** [abs]: the absolute value function
*)
  j0 <> j1 andalso abs (i0 - i1) <> abs (j0 - j1)
// end of [safety_test1]

fun
safety_test2
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
  if j < N then let
    val test = safety_test2 (i, j, bd, i-1)
  in
    if test then let
      val bd1 = board_set (bd, i, j)
    in
      if i+1 = N then let
        val () = print! ("Solution #", nsol+1, ":\n")
        val () = print_board (bd1)
      in
        search (bd, i, j+1, nsol+1)
      end else
        search (bd1, i+1, 0(*j*), nsol) // positioning next piece
      // end of [if]
    end else
      search (bd, i, j+1, nsol)
  end else
  (
    if i > 0 then
      search (bd, i-1, board_get (bd, i-1) + 1, nsol)
    else nsol // end of [if]
  )
// end of [search]

(* ****** ****** *)
//
extern 
fun
main0_py
(
// argless
) : void = "mac#main0_py"
//
implement
main0_py () =
{
  val nsol = search ($tup(0, 0, 0, 0, 0, 0, 0, 0), 0, 0, 0)
} (* end of [main0_py] *)
//
(* ****** ****** *)

%{^
import sys
######
from libatscc2py3_all import *
######
sys.setrecursionlimit(1000000)
######
%} // end of [%{^]

(* ****** ****** *)

%{$
######
main0_py()
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [queens.dats] *)
