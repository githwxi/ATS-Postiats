abstype OBJ

fun fact (n) =
  if n > 0 then n * fact(n-1) else 1

val fact10 = fact (10)

val () = print ("fact(10) = ")
val () = print (fact(10))
val () = print_newline ((*void*))

