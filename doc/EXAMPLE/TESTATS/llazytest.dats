//
// Test code for lazy-evaluation
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
from{n:int}
  (n: int n)
  :<!laz> stream_vt (int) = let
//
(*
val () =
$effmask_all (println! ("from: n = ", n))
*)
//
in
  $ldelay (stream_vt_cons{int}(n, from (n+1)))
end // end of [from]
//
(* ****** ****** *)

implement
main0 () =
{
//
val ns = from (2)
val-~stream_vt_cons (n2, ns) = !ns
val ((*void*)) = println! ("n2 = ", n2)
val-~stream_vt_cons (n3, ns) = !ns
val ((*void*)) = println! ("n3 = ", n3)
val-~stream_vt_cons (n4, ns) = !ns
val ((*void*)) = println! ("n4 = ", n4)
val () = ~ns
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [llazytest.dats] *)
