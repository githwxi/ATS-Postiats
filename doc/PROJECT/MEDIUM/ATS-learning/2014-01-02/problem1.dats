(* ****** ****** *)

(*
Description of the problem:

*)

(* ****** ****** *)

(*
How to compile:
patscc -o problem1 problem1.dats
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

fun
count2 (i: int): int =
(
if i > 0
  then let
    val q = i / 10
    val r = i mod 10
  in
    if r = 2 then count2 (q) + 1 else count2 (q)
  end // end of [then]
  else 0 // end of [else]
// end of [if]
)

implement
main0 () = let
//
fun loop
  (i: int, cnt: int): int = let
  val cnt = cnt + count2 (i)
in
  if cnt <= 22 then loop (i+1, cnt) else i
end // end of [loop]
//
in
  println! ("The answer is [", loop (1, 0), "].")
end // end of [main0]

(* ****** ****** *)

(* end of [problem1.dats] *)
