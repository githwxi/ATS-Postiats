//
// Fibonacci numbers
//

(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun
Fibonacci
  {n:nat}
  (n: int n): int = let
//
fun loop {
  n,i:nat
| 2 <= i; i <= n
} .<n-i>. (
  fnm1: int, fnm2: int, n: int n, i: int i
) : int =
  if i < n then
    loop (fnm2, fnm1 + fnm2, n, i+1)
  else fnm1 + fnm2
//
in
  if n >= 2 then loop (0, 1, n, 2) else n
end // end of [Fibonacci]

(* ****** ****** *)

implement
main0 () = {
//
val () = assertloc (Fibonacci (10) = 55)
val () = assertloc (Fibonacci (20) = 6765)
//
} // end of [main0]

(* ****** ****** *)

(* end of [program-1-14.dats] *)
