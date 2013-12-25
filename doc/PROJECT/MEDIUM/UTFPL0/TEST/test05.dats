(* ****** ****** *)

symintr true
symintr false
symintr print
symintr println

(* ****** ****** *)

fun fib (n) = let
//
fun loop (f1, f2, n) =
  if n > 0 then loop (f2, f1+f2, n-1) else f1
//
in
  loop (0, 1, n)
end // end of [fib]

(* ****** ****** *)

fun fib2 (n) = let
//
fun loop (f12, n) =
  if n > 0 then loop ((f12.1, f12.0+f12.1), n-1) else f12.0
//
in
  loop ((0, 1), n)
end // end of [fib2]

(* ****** ****** *)

val () = println ("fib(20) = ", fib(20))  
val () = println ("fib2(20) = ", fib2(20))  
  
(* ****** ****** *)

(* end of [test05.dats] *)
