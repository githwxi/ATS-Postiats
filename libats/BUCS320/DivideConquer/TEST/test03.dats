(* ****** ****** *)
(*
** DivideConquer
** (of CPS-style)
** with memoization:
** Fibonacci numbers
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
#staload
"./../DATS/DivideConquer_memo.dats"
#staload
"./../DATS/DivideConquer_cont.dats"
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
DivideConquer$base_test<>
  (n) =
(
if n >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>
  (n) = n
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (n) =
(
g0ofg1($list{int}(n-1, n-2))
)
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (_, rs) = r1 + r2 where
{
//
val-list0_cons(r1, rs) = rs
val-list0_cons(r2, rs) = rs
//
}

(* ****** ****** *)
//
implement
Fibonacci(n) = let
//
val n = g1ofg0(n)
val () = assertloc(n >= 0)
//
val
theTable =
hashtbl_make_nil(i2sz(n+1))
//
val () = $tempenver(theTable)
//
implement
DivideConquer_memo$table_get<>
  ((*void*)) = theTable
implement
DivideConquer_memo$table_set<>
  (theTable) = ((*void*))
//
//
in
  DivideConquer$solve<>(n)
end // end of [Fibonacci]
//
(* ****** ****** *)

implement
main0() =
{
//
val () =
println! ("Fibonacci(10) = ", Fibonacci(10))
val () =
println! ("Fibonacci(20) = ", Fibonacci(20))
val () =
println! ("Fibonacci(30) = ", Fibonacci(30))
val () =
println! ("Fibonacci(40) = ", Fibonacci(40))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)
