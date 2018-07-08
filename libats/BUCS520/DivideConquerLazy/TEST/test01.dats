(* ****** ****** *)
(*
** DivideConquer
** of lazy-style:
** Fibonacci numbers
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload $DivideConquerLazy // opening it
//
(* ****** ****** *)
//
extern
fun Fibonacci(int): int
//
(* ****** ****** *)

assume input_t0ype = int
assume output_t0ype = int

(* ****** ****** *)
//
implement
DivideConquerLazy$base_test<>
  (n) =
(
if n >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquerLazy$base_solve<>
(
  n
) = stream_vt_make_sing(n)
//
(* ****** ****** *)
//
implement
DivideConquerLazy$divide<>
(
  n
) = streamize_list_vt_elt($list_vt{int}(n-1, n-2))
//
(* ****** ****** *)

implement
DivideConquerLazy$conquer$combine<>
(
  _, rs
) =
stream_vt_make_sing
  (r1.head() + r2.head()) where
{
//
val-~stream_vt_cons(r1, rs) = !rs
val-~stream_vt_cons(r2, rs) = !rs
val-~stream_vt_nil((*void*)) = !rs
//
}

(* ****** ****** *)

implement
Fibonacci(n) = let
//
(*
implement
DivideConquerLazy$solve_rec<>
  (n) = Fibonacci(n)
*)
//
in
  stream_vt_head_exn(DivideConquerLazy$solve<>(n))
end // end of [Fibonacci]

(* ****** ****** *)

implement
main0() =
{
//
val () =
println! ("Fibonacci(5) = ", Fibonacci(5))
val () =
println! ("Fibonacci(10) = ", Fibonacci(10))
val () =
println! ("Fibonacci(20) = ", Fibonacci(20))
val () =
println! ("Fibonacci(30) = ", Fibonacci(30))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
