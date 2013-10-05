(*
** for testing [prelude/lazy_vt]
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
val-~Some_vt
  (nns) = stream_vt_drop (nns, 100)
val-~stream_vt_cons (nn, nns) = !nns
val () = ~nns
val () = assertloc (nn = 100 * 100)
//
} (* end of [val] *)

(* ****** ****** *)


(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_lazy_vt.dats] *)
