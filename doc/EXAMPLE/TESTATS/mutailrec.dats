//
// Illustrating mutual tail-recursion
//
// Author: Hongwei Xi (December 31, 2012)
//

(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)
//
(*
[isevn] and [isodd] are defined mutually
tail-recursively, that is, the recursive
calls in their bodies are all tail-calls.
*)
fnx isevn
  (x: int): bool = let
  val () = println! ("isevn: x = ", x)
in
  if x > 0 then isodd (x-1) else true
end // end of [isevn]

(*
Note that [isodd] is *not* available for
subsequent use.
*)
and isodd
  (x: int): bool = let
  val () = println! ("isodd: x = ", x)
in
  if x > 0 then isevn (x-1) else false
end // end of [isodd]

(* ****** ****** *)

implement
main () = 0 where
{
  val N = 9
  val () = assertloc (~isevn(N))
} // end of [main]

(* ****** ****** *)

(* end of [mutailrec.dats] *)
