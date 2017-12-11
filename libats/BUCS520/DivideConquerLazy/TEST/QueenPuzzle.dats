(* ****** ****** *)
(*
//
Testing DivideConquerLazy
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
extern
fun
QueenPuzzle_solve
(
// argumentless
) : stream_vt(list0(int))
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload $DivideConquerLazy // opening it
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)

assume
input_t0ype = list0(int)
assume
output_t0ype = list0(int)

(* ****** ****** *)
//
implement
DivideConquerLazy$base_test<>
  (xs) = (length(xs) = N)
implement
DivideConquerLazy$base_solve<>
  (xs) = stream_vt_make_sing(xs)
//
(* ****** ****** *)

implement
DivideConquerLazy$divide<>
  (xs) =
  aux(0) where
{
//
fun
aux
(
 i: int
) : stream_vt(input) = let
//
fun
test
(
xs: list0(int), d: int
) : bool =
(
  case+ xs of
  | list0_nil() => true
  | list0_cons(x, xs) =>
      if (x != i && abs(x-i) != d) then test(xs, d+1) else false
    // end of [list0_cons]
)
//
in
//
$ldelay
(
if
(i < N)
then
(
if
test(xs, 1)
then
stream_vt_cons
  (list0_cons(i, xs), aux(i+1))
// end-of-then
else !(aux(i+1))
)
else stream_vt_nil(*void*)
)
//
end // end of [aux]
//
} (* end of [DivideConquerLazy_divide] *)
//
(* ****** ****** *)
//
implement
DivideConquerLazy$conquer$combine<>
  (x0, rs) = stream_vt_concat<output>(rs)
//
(* ****** ****** *)
//
implement
QueenPuzzle_solve() =
  DivideConquerLazy$solve<>(list0_nil())
//
(* ****** ****** *)

implement
main0((*void*)) = 
{
//
val () =
(
QueenPuzzle_solve()
).iforeach()
(
lam(i, xs) =>
(
if
(i > 0)
then
println!
(
// argless
) ;
println!
(
"Solutin#", i+1
) ;
(xs).rforeach()
(
lam x =>
(
(x).repeat()(lam() => print ". ");
print "Q ";
(N-1-x).repeat()(lam() => print ". "); println!()
) (* lam *)
) (* rforeach *)
) (* lam *)
) (* iforeach *)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)
