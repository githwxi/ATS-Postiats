(* ****** ****** *)

abstype OBJ

(* ****** ****** *)

symintr true
symintr false
symintr println

(* ****** ****** *)

fun isevn (n) = if n > 0 then isodd (n-1) else true
and isodd (n) = if n > 0 then isevn (n-1) else false

(* ****** ****** *)

val () = println ("isevn(100) = ", isevn(100))
val () = println ("isodd(100) = ", isodd(100))

(* ****** ****** *)

(* end of [test04.dats] *)
