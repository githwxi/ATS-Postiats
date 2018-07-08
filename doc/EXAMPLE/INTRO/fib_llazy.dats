//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
//
// Lazy-evaluation
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

#define nil stream_vt_nil
#define cons stream_vt_cons
#define :: stream_vt_cons

(* ****** ****** *)

fun fib0(): stream_vt(int) = $ldelay(stream_vt_cons{int}(0, fib1()))
and fib1(): stream_vt(int) = $ldelay(stream_vt_cons{int}(1, fib2()))
and fib2(): stream_vt(int) = stream_vt_map2_fun<int,int><int> (fib0(), fib1(), lam (x0, x1) => x0 + x1)

(* ****** ****** *)

fun{a:t0p}
stream_vt_nth
(
  xs0: stream_vt a, i: intGte(0)
) : a = let
  val xs0_con = !xs0
in
//
case+ xs0_con of
| ~(x :: xs) =>
  (
    if i = 0
      then (~xs; x) else stream_vt_nth<a> (xs, i-1)
    // end of [if]
  ) // end of [::]
| ~nil ((*void*)) => $raise StreamSubscriptExn(*void*)
end // end of [stream_vt_nth]

(* ****** ****** *)

implement
main0 () =
(
println! ("Fibonacci(10) = ", stream_vt_nth<int> (fib0(), 10)) ; // = 55
println! ("Fibonacci(20) = ", stream_vt_nth<int> (fib0(), 20)) ; // = 6765
) // end of [main0]

(* ****** ****** *)

(* end of [fib_llazy.dats] *)
