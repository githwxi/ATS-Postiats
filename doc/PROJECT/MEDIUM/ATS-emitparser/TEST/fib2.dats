(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern fun fib2 : int -> int
//
implement
fib2 (n) = let
//
fun aux (ff: $tup(int, int), n: int): int =
  if n > 0 then aux ($tup(ff.1, ff.0 + ff.1), n-1) else ff.0
//
in
  aux ($tup(0, 1), n)
end // end of [fib2]
//
(* ****** ****** *)

(* end of [fib2.dats] *)
