(*
** Testing the ATS API for SDL2
*)

(* ****** ****** *)

staload "./../SATS/SDL.sats"

(* ****** ****** *)

val () = let
  var ver: SDL_version
  val () = SDL_VERSION (ver)
  val () =
  println! ("SDL(VERSION) = ", ver.major, ".", ver.minor, ".", ver.patch)
  val () = SDL_GetVersion (ver)
  val () =
  println! ("SDL(GetVersion) = ", ver.major, ".", ver.minor, ".", ver.patch)
in
  // nothing
end // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
