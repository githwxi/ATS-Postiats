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
  :<!laz> stream (int) = let
//
(*
val () =
$effmask_all (println! ("from: n = ", n))
*)
//
in
  $delay (stream_cons{int}(n, from (n+1)))
end // end of [from]
//
(* ****** ****** *)

val ns = from (2)

(* ****** ****** *)

val-stream_cons(n2, ns) = !ns
val () = println! ("n2 = ", n2)
val-stream_cons(n3, ns) = !ns
val () = println! ("n3 = ", n3)
val-stream_cons(n4, ns) = !ns
val () = println! ("n4 = ", n4)
val-stream_cons(n5, ns) = !ns
val () = println! ("n5 = ", n5)

(* ****** ****** *)

local

implement
stream_filter$pred<int> (n) = g0int_mod (n, 2) = 0

in (* in of [local] *)

val ns2 = stream_filter (ns)
val-stream_cons(n6, ns2) = !ns2
val () = println! ("n6 = ", n6)
val-stream_cons(n8, ns2) = !ns2
val () = println! ("n8 = ", n8)
val-stream_cons(n10, ns2) = !ns2
val () = println! ("n10 = ", n10)

end // end of [local]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [lazytest.dats] *)
