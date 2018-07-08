(*
** for testing [prelude/intrange]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
implement(env)
intrange_foreach$fwork<env> (i, env) = fprint(out, i)
//
val _ =
intrange_foreach<> (0, 10)
//
val () = fprint_newline(out)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
fun fact
  (n:int): int = let
//
typedef tenv = int
implement
intrange_foreach$fwork<tenv> (i, env) = env := (i+1) * env
//
var env: tenv = 1
val _ = intrange_foreach_env<int> (0, n, env)
//
in
  env
end (* end of [fact] *)
//
val () = assertloc (fact (10) = 1*2*3*4*5*6*7*8*9*10)
//
}

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
implement(env)
intrange_rforeach$fwork<env> (i, env) = fprint(out, i)
//
val _ =
intrange_rforeach<> (0, 10)
//
val () = fprint_newline(out)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
fun fact
  (n:int): int = let
//
typedef tenv = int
implement
intrange_rforeach$fwork<tenv>
  (i, env) = (env := (i+1) * env)
//
var env: tenv = 1
val _ = intrange_rforeach_env<int> (0, n, env)
//
in
  env
end (* end of [fact] *)
//
val () =
assertloc(fact(10) = 10*9*8*7*6*5*4*3*2*1)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val N = 10
//
implement(tenv)
intrange2_foreach$fwork<tenv>
  (i, j, env) =
(
//
if j > 1 then print ' ';
$extfcall(void, "printf", "%dx%d=%02d", i, j, i*j);
if (j+1=N) then println! ();
//
)
//
val () = intrange2_foreach (1, N, 1, N)
//
} (* end of [val] *)

(* ****** ****** *)

local

fun
sieve
(
  xs: stream_vt(int)
) : stream_vt(int) = $ldelay
(
let
  val xs_con = !xs
  val-@stream_vt_cons(x0, xs) = xs_con
  val x0 = x0
  val () = (xs := sieve(stream_vt_filter_cloptr(xs, lam x => x % x0 > 0)))
in
  fold@(xs_con); xs_con
end
,
(~xs) // it is called if the stream is freed
) (* end of [sieve] *)

in (* in-of-local *)

val thePrimes =
  sieve(streamize_intrange_l(2))
val ((*void*)) =
  stream_vt_fprint(thePrimes, stdout_ref, 10)
val ((*void*)) = fprint_newline(stdout_ref)

end // end of [local]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_intrange.dats] *)
