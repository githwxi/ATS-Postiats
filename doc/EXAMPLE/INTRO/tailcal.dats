//
// Some code involving tail-call optimization
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

(*
fun tally
  (n: int): llint =
  if n > 0 then g0int2int_int_llint(n) + tally (n-1) else 0LL
// end of [tally]
*)

(* ****** ****** *)

fun tally
  (n: int): llint = let
//
fun loop
  (n: int, res: llint): llint =
  if n > 0 then loop (n-1, g0int2int_int_llint(n) + res) else res
//
in
  loop (n, 0LL)
end // end of [tally]

(* ****** ****** *)

implement
main0 () =
{
//
val N = 1000000
val () = println! ("tally(", N, ") = ", tally (N))
//
} // end of [main0]

(* ****** ****** *)

(* end of [tailcal.dats] *)
