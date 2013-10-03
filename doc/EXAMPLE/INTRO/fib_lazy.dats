//
// Lazy-evaluation
//

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val
rec fib0: stream(int) = $delay(stream_cons{int}(0, fib1))
and fib1: stream(int) = $delay(stream_cons{int}(1, fib2))
and fib2: stream(int) = stream_map2_fun<int,int><int> (fib0, fib1, lam (x0, x1) => x0 + x1)

(* ****** ****** *)

implement
main0 () =
(
println! ("Fibonacci(10) = ", stream_nth_exn (fib0, 10)) ; // = 55
println! ("Fibonacci(20) = ", stream_nth_exn (fib0, 20)) ; // = 6765
) // end of [main0]

(* ****** ****** *)

(* end of [fib_lazy.dats] *)
