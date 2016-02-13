(*
** A solution to Hanoi Towers
*)

(* ****** ****** *)
//
// HX-2016-02-12:
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

absvtype pole(ilist)

(* ****** ****** *)

extern
fun
move_1
{ p1,p2:ilist
| ilist_length(p1) > 0
} (
  P1: !pole(p1) >> pole(ilist_tail(p1))
, P2: !pole(p2) >> pole(ilist_cons(ilist_head(p1), p2))
) : void // end of [move_1]

(* ****** ****** *)

extern
fun
move_n
{ n:nat }
{ p1,p2,p3:ilist
| ilist_length(p1) >= n
} (
  n: int(n)
, P1: !pole(p1) >> pole(ilist_drop(p1, n))
, P2: !pole(p2) >> pole(ilist_append(ilist_take(p1, n), p2))
, P3: !pole(p3) >> pole(p3)
) : void // end of [move_n]

(* ****** ****** *)
//
extern
praxi
ilist_take_0{xs:ilist}
(
// argumentless
) :ILISTEQ(ilist_take(xs,0),ilist_nil())
//
extern
praxi
ilist_drop_0
  {xs:ilist}():ILISTEQ(xs,ilist_drop(xs,0))
//
(* ****** ****** *)
//
extern
praxi
ilist_length_nat
{xs:ilist}():[ilist_length(xs)>=0] unit_p
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
// argumentless
) : [ilist_length(ilist_append(xs,ys))==ilist_length(xs)+ilist_length(ys)] unit_p
//
(* ****** ****** *)
//
extern
praxi
ilist_append_nil{xs:ilist}():ILISTEQ(xs, ilist_append(ilist_nil(), xs))
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
prval
unit_p() = ilist_length_nat{p1}()
prval
unit_p() = ilist_length_nat{p2}()
prval
unit_p() = ilist_length_nat{p3}()
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
val () = move_n(n-1, P1, P3, P2)
val () = move_1(P1, P2)
val () = move_n(n-1, P3, P2, P1)
//
in
  // nothing
end // end of [then]
else let
//
prval ILISTEQ() = ilist_take_0{p1}()
prval ILISTEQ() = ilist_drop_0{p1}()
prval ILISTEQ() = ilist_append_nil{p2}()
//
in
  // nothing
end // end of [else]
//
end (* end of [move_n] *)

(* ****** ****** *)

(* end of [HanoiTowers-3-2.dats] *)
