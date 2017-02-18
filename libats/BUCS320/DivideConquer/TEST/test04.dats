(* ****** ****** *)
(*
** DivideConquer
** MacCarthy's 91-function
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
#staload
"./../DATS/DivideConquer.dats"
//
(* ****** ****** *)
//
extern
fun MacCarthy's_91(int): int
//
(* ****** ****** *)

assume input_t0ype = int
assume output_t0ype = int

(* ****** ****** *)
//
implement
DivideConquer$base_test<>
  (n) =
(
if n >= 101 then true else false
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>
  (n) = n - 10
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (n) =
(
g0ofg1($list{int}(n+11))
)
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (_, rs) =
  MacCarthy's_91(r1) where
{
//
val-list0_cons(r1, rs) = rs
//
}

(* ****** ****** *)
//
implement
MacCarthy's_91(n) =
(
  DivideConquer$solve<>(n)
) // end of [MacCarthy's]
//
(* ****** ****** *)

implement
main0() =
{
//
val () =
println! ("MacCarthy's_91(10) = ", MacCarthy's_91(10))
val () =
println! ("MacCarthy's_91(20) = ", MacCarthy's_91(20))
val () =
println! ("MacCarthy's_91(30) = ", MacCarthy's_91(30))
val () =
println! ("MacCarthy's_91(40) = ", MacCarthy's_91(40))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04.dats] *)
