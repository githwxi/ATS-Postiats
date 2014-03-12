(*
** for testing [prelude/stream_vt]
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
  : stream_vt (int) = $ldelay (stream_vt_cons{int}(n, from(n+1)))
// end of [from]

(* ****** ****** *)

val () =
{
//
val ns = from (0)
val nns =
  stream_vt_map_fun<int><int> (ns, lam x => x * x)
//
val-~Some_vt(nns) =
  stream_vt_drop_opt (nns, 100)
val-~stream_vt_cons (nn, nns) = !nns
val () = ~nns
val () = assertloc (nn = 100 * 100)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val ns1 = from (1)
val ns2 = from (2)
val nns =
  stream_vt_map2_fun<int,int><int> (ns1, ns2, lam (x1, x2) => x1 * x2)
//
val-~Some_vt(nns) =
  stream_vt_drop_opt (nns, 100)
val-~stream_vt_cons (nn, nns) = !nns
val () = ~nns
val () = assertloc (nn = 101 * 102)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_stream_vt.dats] *)
