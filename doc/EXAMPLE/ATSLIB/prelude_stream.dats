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
from (
  n: int
) : stream (int) = let
//
implement
stream_vt_tabulate$fopr<int> (i) = n+i
//
in
  stream_vt2t(stream_vt_tabulate<int> ((*void*)))
end // end of [from]

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
val nns2 =
  stream_map2_fun<int,int><int> (ns, ns, lam (x1, x2) => x1 * x2)
//
val () = assertloc (stream_nth_exn (nns2, 100) = 10000)
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
val () =
  fprint_stream (stdout_ref, nns, 10)
val ((*void*)) = fprintln! (stdout_ref)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_stream.dats] *)
