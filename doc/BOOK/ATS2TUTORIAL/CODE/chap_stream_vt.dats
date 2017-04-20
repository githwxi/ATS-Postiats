(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
//
fun
from(n: int): stream_vt(int) =
  $ldelay(stream_vt_cons(n, from(n+1)))
//
fun
sieve
(
ns: stream_vt(int)
) : stream_vt(int) = $ldelay
(
let
//
(*
[val-]: no warning message
*)
//
  val
  ns_con = !ns
  val-
  @stream_vt_cons(n0, ns1) = ns_con
//
  val n0_val = n0
  val ns1_val = ns1
//
  val ((*void*)) =
    (ns1 := sieve(stream_vt_filter_cloptr<int>(ns1_val, lam x => x mod n0_val > 0)))
  // end of [val]
//
  prval ((*folded*)) = fold@(ns_con)
//
in
  ns_con
end // end of [let]
,
~ns // [ns] is freed
) (* end of [$ldelay] *) // end of [sieve]
//
val thePrimes = sieve(from(2))
//
(* ****** ****** *)
//
val
p1000 =
(stream_vt_drop_exn(thePrimes, 1000)).head()
//
(* ****** ****** *)

val ((*void*)) = println! ("p1000 = ", p1000)

(* ****** ****** *)
//
implement main0 () = {}
//
(* ****** ****** *)

(* end of [chap_stream_vt.dats] *)
