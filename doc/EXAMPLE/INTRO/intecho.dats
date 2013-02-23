(* ****** ****** *)
//
// Reading integers from stdin
// Author: Hongwei Xi (February, 2013)
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"
staload "prelude/DATS/filebas.dats"

(* ****** ****** *)

#define ATS_MAINATSFLAG 1

(* ****** ****** *)

implement
main0 (
) = loop () where {
//
fun loop (): void = let
  val () =
    println! ("Please input an integer:")
  var N: int?
  val ans = fileref_load<int> (stdin_ref, N)
in
//
if ans then let
  prval (
  ) = opt_unsome (N)
  val () = println! (N)
in
  loop ()
end else let
  prval (
  ) = opt_unnone (N)
  val () = println! ("Not a valid integer!")
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
} // end of [main0]

(* ****** ****** *)

(* end of [intecho.dats] *)
