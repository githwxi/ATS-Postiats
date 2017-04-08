(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: the 26th of July, 2016
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "QueenPuzzle_sol_main"

(* ****** ****** *)

#define N  8        // number of queens
#define :: cons0

(* ****** ****** *)

(* Solving the Queen Puzzle *)

// pop(qs) returns the first element and the rest of the list

extern fun pop: list0(int) -> $tup(int, list0(int))

implement
pop(qs: list0(int)): $tup(int, list0(int)) =
  case+ qs of
  | q :: qs => $tup(q, qs)
  | nil0 () => $tup(~1, nil0)

// is_valid(qs) returns true if no queen can attack another
// only the most recently added queen is checked

extern fun is_valid: list0(int) -> bool

implement
is_valid(qs: list0(int)): bool = 
let
  val len = length(qs)
  val $tup(new_q, rest) = pop(qs)
  fun loop(qs: list0(int), i: int, new_q: int): bool =
  case+ qs of
  | q :: qs => if q = new_q 					// in same column
               then false
               else
                 if len - i = abs(new_q - q)	// in same diagonal
                 then false
                 else loop(qs, i-1, new_q)
  | nil0 () => true
in
  if len = 1 then true else loop(rest, len-1, new_q)
end

// place_nth_queen(qs: list0(int), n: int)
// given a valid solution for n-1 queens encoded by qs
// returns a stream of valid solutions for n queens 
// or stream_nil () in the case that no solution exists

extern fun place_nth_queen: (list0(int), int) -> stream(list0(int))

implement
place_nth_queen(qs: list0(int), n: int): stream(list0(int)) =
let
  fun loop (qs:  list0(int),
            col: int, 
            qss: stream(list0(int))): stream(list0(int)) =
    if col < N
    then if is_valid(col :: qs) 
         then loop(qs, col+1, stream_append(qss, stream_make_sing(col :: qs)))
         else loop(qs, col+1, qss)
    else qss
in
  loop(qs, 0, stream_make_nil ())
end

extern fun stream_build: stream(list0(int)) -> stream(list0(int))

implement
stream_build (qss_prev: stream(list0(int))): stream(list0(int)) =
let
  fun aux (qss_prev: stream(list0(int)),
           qss_next: stream(list0(int))): stream(list0(int)) =
    case+ !qss_prev of
    | stream_cons(qs, qss) => 
        aux(qss, stream_append(qss_next, place_nth_queen(qs, length(qs))))
    | stream_nil () => qss_next
in
  aux (qss_prev, stream_make_nil ())
end

// goal is to produce a stream of all size 8 solutions

extern
fun
QueenPuzzle_solve(): stream(list0(int)) = "mac#"
implement
QueenPuzzle_solve(): stream(list0(int)) =
let
  fun loop(qss: stream(list0(int)), n: int): stream(list0(int)) =
    if n < N-1
    then loop(stream_build(qss), n+1)
    else qss
in
  loop(place_nth_queen(nil0 (), 0), 0)
end

(* ****** ****** *)

val qss = QueenPuzzle_solve()
val ((*void*)) = loop(qss, 0) where
{
  fun loop(qss: stream(list0(int)), n: int): void =
    (
      case+ !qss of
      | stream_nil() => ()
      | stream_cons(qs, qss) => (println! ("n = ", n); loop(qss, n+1))
    )
}

(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
//
eval(fs.readFileSync('./libatscc2js/libatscc2js_all.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/fprint_cats.js').toString());
//
%} // end of [%{^]

(* ****** ****** *)

%{$
//
QueenPuzzle_sol_main(/*void*/);
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [QueenPuzzle_sol.dats] *)
