(*
** for testing [prelude/stream]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

fun
from (n: int)
  : stream (int) = $delay (stream_cons{int}(n, from(n+1)))
// end of [from]

(* ****** ****** *)

val () =
{
//
val ns = from (0)
val nns =
  stream_map_fun<int><int> (ns, lam x => x * x)
//
val () = assertloc (stream_nth_exn (nns, 100) = 10000)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val ns1 = from (1)
val ns2 = from (2)
val nns =
  stream_map2_fun<int,int><int> (ns1, ns2, lam (x1, x2) => x1 * x2)
//
val () = assertloc (stream_nth_exn (nns, 100) = 101 * 102)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_stream.dats] *)
