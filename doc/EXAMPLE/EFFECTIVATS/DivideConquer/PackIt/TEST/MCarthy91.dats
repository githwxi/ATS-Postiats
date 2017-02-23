(* ****** ****** *)
(*
** DivideConquer:
** MacCarthy'1 91-function
**
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
#include "./../mylibies.hats"
//
(*
//
// If the package
// [effectivats-divideconquer]
// is npm-installed,
// please use this version:
//
#include
"{$PATSHOMELOCS}\
/effectivats-divideconquer/mylibies.hats"
//
*)
(* ****** ****** *)

#staload $DivideConquer

(* ****** ****** *)
//
extern
fun MCarthy91(int): int
//
(* ****** ****** *)

assume input_t0ype = int
assume output_t0ype = int

(* ****** ****** *)
//
implement
DC_base_test<>
  (n) =
(
if n <= 100
  then false else true
// end of [if]
)
//
(* ****** ****** *)
//
implement
DC_base_solve<>
  (n) = n - 10
//
(* ****** ****** *)
//
implement
DC_divide<>(n) =
  g0ofg1($list{int}(n+11))
//
(* ****** ****** *)

implement
DC_conquer_combine<>
  (_, rs) = MCarthy91(r1) where
{
//
val-list0_cons(r1, rs) = rs
//
}

(* ****** ****** *)
//
implement
MCarthy91(n) = DC_solve<>(n)
//
(* ****** ****** *)

implement
main0() =
{
//
val () =
println! ("MCarthy91(5) = ", MCarthy91(5))
val () =
println! ("MCarthy91(10) = ", MCarthy91(10))
val () =
println! ("MCarthy91(20) = ", MCarthy91(20))
val () =
println! ("MCarthy91(30) = ", MCarthy91(30))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [MCarthy91.dats] *)
