(*
** A solution to Hanoi Towers
*)

(* ****** ****** *)
//
// HX-2016-02-09:
// For trying out
// external constraint-solvng
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/SATS/ilist_prf.sats"
//
(* ****** ****** *)

abstype pole(ilist)

(* ****** ****** *)

extern
fun
move_1
{ p1,p2:ilist
| ilist_length(p1) > 0
} (
  P1: pole(p1), P2: pole(p2)
) : (pole(ilist_tail(p1)), pole(ilist_cons(ilist_head(p1), p2)))

(* ****** ****** *)

extern
fun
move_n
{ n:nat }
{ p1,p2,p3:ilist
| ilist_length(p1) >= n
} (
  n: int(n)
, P1: pole(p1), P2: pole(p2), P3: pole(p3)
) : (pole(ilist_drop(p1, n)), pole(ilist_append(ilist_take(p1, n), p2)), pole(p3))

(* ****** ****** *)

implement
move_n
(
  n, P1, P2, P3
) = (
//
if
(n > 0)
then let
//
val (P1, P3, P2) = move_n(n-1, P1, P3, P2)
val (P1, P2)     = move_1(P1, P2)
val (P3, P2, P1) = move_n(n-1, P3, P2, P1)
//
in
  (P1, P2, P3)
end // end of [then]
else (P1, P2, P3)
//
) (* end of [move_n] *)

(* ****** ****** *)

(* end of [HanoiTowers-4.dats] *)
