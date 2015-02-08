(* ****** ****** *)
//
// A kind of LMS
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
array_tally{n:int}
  (A: arrayref(a, n), n: size_t(n)): a
//
(* ****** ****** *)

implement
{a}(*tmp*)
array_tally
  (A, n) = env where
{
//
var env: a = gnumber_int(0)
//
implement
array_foreach$fwork<a><a>
  (x, env) = env := gadd_val(env, x)
//
val _(*n*) = arrayref_foreach_env(A, n, env)
//
} (* end of [array_tally] *)

(* ****** ****** *)

implement
main0((*void*)) = let
//
val N = 100
val A = arrayref_tabulate_cloref<int>(i2sz(N), lam(i) => sz2i(i)+1)
//
in
  println! ("tally = ", array_tally (A, i2sz(N)))
end (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-2015-02-08.dats] *)
