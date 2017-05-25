(* ****** ****** *)
//
// Computing the factorials
//
// Author: Hongwei Xi (January 2013)
//
(* ****** ****** *)
(*
//
// HX-2017-05-22:
// For remote typechecking only!
//
##myatsccdef=\
curl --data-urlencode mycode@$1 \
http://www.ats-lang.org/SERVER/MYCODE/atslangweb_patsopt_tcats_0_.php | \
php -R 'if (\$argn != \"\") echo(json_decode(urldecode(\$argn))[1].\"\\n\");'
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun fact
  {n:nat}
  (n: int n): int = let
//
val A = arrayptr_make_intrange<> (0, n)
//
typedef a = int
typedef tenv = int
implement
array_foreach$fwork<a><tenv> (x, env) = env := env * (x+1)
//
var env: tenv = 1
//
val _ = arrayptr_foreach_env<a><tenv> (A, g1int2uint(n), env)
//
val () = arrayptr_free (A)
//
in
  env
end // end of [fact]

(* ****** ****** *)

implement
main0 () = {
  val N = 12
  val () = assertloc (fact(N) = 1*1*2*3*4*5*6*7*8*9*10*11*12)
} // end of [main]

(* ****** ****** *)

(* end of [fact3.dats] *)
