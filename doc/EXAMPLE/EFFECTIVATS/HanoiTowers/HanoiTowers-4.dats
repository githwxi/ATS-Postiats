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
//
extern
praxi
ilist_length_nat
{xs:ilist}((*void*)):[ilist_length(xs)>=0] unit_p
//
extern
praxi
ilist_length_take
{xs:ilist}{n:nat | n <= ilist_length(xs)}
(
// argumentless
) : [n==ilist_length(ilist_take(xs, n))] unit_p
extern
praxi
ilist_length_drop
{xs:ilist}{n:nat | n <= ilist_length(xs)}
(
// argumentless
) : [ilist_length(ilist_drop(xs, n))==ilist_length(xs)-n] unit_p
//
extern
praxi
ilist_length_append
{xs,ys:ilist}
(
) : [ilist_length(ilist_append(xs,ys))==ilist_length(xs)+ilist_length(ys)] unit_p
//
extern
praxi
ilist_append_take_eq
  {xs,ys:ilist}():ILISTEQ(xs, ilist_take(ilist_append(xs, ys), ilist_length(xs)))
extern
praxi
ilist_append_drop_eq
  {xs,ys:ilist}():ILISTEQ(ys, ilist_drop(ilist_append(xs, ys), ilist_length(xs)))
//
(* ****** ****** *)

implement
move_n
{n}{p1,p2,p3}
(n, P1, P2, P3) = let
//
prval () =
$solver_assert(ilist_length_nat)
//
in
//
if
(n > 0)
then let
//
stadef p1_take_n = ilist_take(p1,n)
stadef p1_take_n_1 = ilist_take(p1,n-1)
//
stadef p1_drop_n = ilist_drop(p1,n)
stadef p1_drop_n_1 = ilist_drop(p1,n-1)
//
prval
unit_p() = ilist_length_take{p1}{n-1}()
prval
unit_p() = ilist_length_drop{p1}{n-1}()
prval
unit_p() = ilist_length_append{p1_take_n_1,p3}()
//
prval
ILISTEQ() =
$UNSAFE.proof_assert
{ILISTEQ(p1_drop_n,ilist_tail(p1_drop_n_1))}()
//
prval
ILISTEQ() = ilist_append_take_eq{p1_take_n_1,p3}()
prval
ILISTEQ() = ilist_append_drop_eq{p1_take_n_1,p3}()
//
prval
ILISTEQ() =
$UNSAFE.proof_assert
{ILISTEQ
(ilist_append(p1_take_n,p2)
,ilist_append(p1_take_n_1,ilist_cons(ilist_head(p1_drop_n_1),p2)))}()
//
val (P1, P3, P2) = move_n(n-1, P1, P3, P2)
val (P1, P2)     = move_1(P1, P2)
val (P3, P2, P1) = move_n(n-1, P3, P2, P1)
//
in
  (P1, P2, P3)
end // end of [then]
else let
//
prval
ILISTEQ() = $UNSAFE.proof_assert{ILISTEQ(p1,ilist_drop(p1,0))}()
prval
ILISTEQ() = $UNSAFE.proof_assert{ILISTEQ(p2,ilist_append(ilist_take(p1,0),p2))}()
//
in
  (P1, P2, P3)
end // end of [else]
//
end (* end of [move_n] *)

(* ****** ****** *)

(* end of [HanoiTowers-4.dats] *)
