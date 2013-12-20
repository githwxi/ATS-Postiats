(* ****** ****** *)

fun fact
  {n:nat} .<n>. (n: int n): int =
  if n > 0 then n * fact (n-1) else 1
// end of [fact]

(* ****** ****** *)

(* end of [test01.dats] *)
