(*
** Testing the ATS API for SDL2
*)

(* ****** ****** *)

staload "./../SATS/SDL.sats"

(* ****** ****** *)

val () = let
  var ver: SDL_version
  val () = SDL_GetVersion (ver)
in
  println! ("SDL(version) = ", ver.major, ".", ver.minor, ".", ver.patch)
end // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
