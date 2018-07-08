(*
** A solution to Hanoi Towers
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
datatype
pole = Pole of
(
  string(*name*), ref(list0(int))
) (* end of [Pole] *)
//
(* ****** ****** *)

extern
fun
move_1(P1: pole, P2: pole): void

(* ****** ****** *)

implement
move_1(P1, P2) = let
//
val Pole(n1, r1) = P1
val-cons0(x, xs) = !r1
val ((*void*)) = !r1 := xs
//
val Pole(n2, r2) = P2
val ((*void*)) = !r2 := cons0(x, !r2)
//
in
  println! ("Move [", x, "] from [", n1, "] to [", n2, "]")
end // end of [move_1]

(* ****** ****** *)
//
extern
fun
move_n
(
  n: int, P1: pole, P2: pole, P3: pole
) : void
//
implement
move_n
(
  n, P1, P2, P3
) = (
//
if n > 0 then
{
  val n1 = n - 1
  val () = move_n(n1, P1, P3, P2)
  val () = move_1(P1, P2)
  val () = move_n(n1, P3, P2, P1)
}
//
) (* end of [move_n] *)
//
(* ****** ****** *)
//
val disks = list0_make_intrange(1, 5)
//
val Pole1 = Pole("A", ref(disks))
val Pole2 = Pole("B", ref(list0_nil))
val Pole3 = Pole("C", ref(list0_nil))
//
(* ****** ****** *)
//
implement main0 () =
{
  val () = move_n(4, Pole1, Pole2, Pole3)
}
//
(* ****** ****** *)

(* end of [HanoiTowers-1.dats] *)
