//
// ProjectEuler: Problem 6
// Finding the difference (1+...+n)^2 - (1^2+...+n^2)
//

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Time: August, 2010 // the first solution
//
(* ****** ****** *)
//
staload _(*anon*) = "prelude/DATS/integer.dats"
staload _(*anon*) = "prelude/DATS/intrange.dats"
//
(* ****** ****** *)

fn sumf {n:nat}
  (n: int n, f: int -<fun> int):<> int = let
//
implement
intrange_foreach$fwork<int> (i, env) = env := env + f(i+1)
//
var env: int = 0
val _(*ignored*) =
  $effmask_all (intrange_foreach_env<int> (0, n, env))
//
in
  env
end // end of [sumf]

(* ****** ****** *)

macdef
square (x) = let val x = ,(x) in x * x end

(* ****** ****** *)

implement
main0 (
) = () where {
  #define N 100
  val sum1 = sumf {..} (N, lam x => x)
  val sum2 = sumf {..} (N, lam x => x * x)
  val diff = square (sum1) - sum2
  val () = assertloc (diff = square (N*(N+1)/2) - N*(N+1)*(2*N+1)/6)
  val () = println! "(1 + ... + " N ")^2 - (1^2 + ... + " N "^2) = " diff
} // end of [main]

(* ****** ****** *)

(* end of [problem6-hwxi.dats] *)
