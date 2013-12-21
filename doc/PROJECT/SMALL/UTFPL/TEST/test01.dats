symintr println

fun fact (n: int): int =
  if n > 0 then n * fact(n-1) else 1

val N = 12
val () = println ("fact(", N, ") = ", fact(N))
