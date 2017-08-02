(* ****** ****** *)
(*
Date: 2017-08-01
*)
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

extern
fun
fact : int -> int

(* ****** ****** *)

implement
fact(x) =
if x <= 0
  then 1 else x * fact(x-1)
// end of [if]

(* ****** ****** *)

implement
main0 () =
println!
  ("fact(10) = ", fact(10))
// end of [main0]

(* ****** ****** *)

(* end of [lecture-2017-08-01.dats] *)

