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
absvtype pole(n:int) = ptr
//
extern
fun
pole_make{n:nat}
(
  name: string, ndisk: int(n)
) : pole(n) // end-of-fun
//
extern
fun
pole_free{n:nat}(pole(n)): void
//
(* ****** ****** *)
//
extern
fun
move_1{p1,p2:nat|p1 > 0}
(
  P1: !pole(p1) >> pole(p1-1)
, P2: !pole(p2) >> pole(p2+1)
) : void // end-of-function
//
extern
fun
move_n{n:nat}
{p1,p2,p3:nat | p1 >= n}
(
  n: int(n)
, P1: !pole(p1) >> pole(p1-n), P2: !pole(p2) >> pole(p2+n), P3: !pole(p3)
) : void // end-of-function
//
(* ****** ****** *)

local
//
datavtype
pole_(n:int) =
Pole(n) of
(
  string, list_vt(int, n)
) (* end of [pole_] *)
//
assume pole(n:int) = pole_(n)
//
in (* in-of-local *)

(* ****** ****** *)

implement
pole_make
  (name, ndisk) = (
//
Pole(name, list_make_intrange(1, ndisk+1))
//
) (* end of [pole_make] *)

(* ****** ****** *)

implement
pole_free(P) = let
  val+~Pole(_, xs) = P in list_vt_free(xs)
end // end of [pole_free]

(* ****** ****** *)

implement
move_1(P1, P2) = let
//
val+@Pole(n1, rxs) = P1
val n1 = n1
val+~list_vt_cons(x, xs) = rxs
val ((*void*)) = rxs := xs
prval ((*folded*)) = fold@(P1)
//
val+@Pole(n2, rxs) = P2
val n2 = n2
val ((*void*)) = rxs := list_vt_cons(x, rxs)
prval ((*folded*)) = fold@(P2)
//
in
  println! ("Move [", x, "] from [", n1, "] to [", n2, "]")
end // end of [move_1]

end // end of [local]
  
(* ****** ****** *)

implement
move_n
(
  n, P1, P2, P3
) = (
//
if
n > 0
then () where
{
//
val n1 = n - 1
val () = move_n(n1, P1, P3, P2)
val () = move_1(P1, P2)
val () = move_n(n1, P3, P2, P1)
//
} (* end of [then] *)
else () // end of [else]
//
) (* end of [move_n] *)

(* ****** ****** *)

implement main0 () =
{
//
val A =
  pole_make("A", 4)
val B =
  pole_make("B", 0)
val C =
  pole_make("C", 0)
//
val () = move_n(4, A, B, C)
//
val () = pole_free(A)
val () = pole_free(B)
val () = pole_free(C)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [HanoiTowers-3.dats] *)
