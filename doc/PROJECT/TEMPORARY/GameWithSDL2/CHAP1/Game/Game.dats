(*
** Game Development with SDL2
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./Game.sats"

(* ****** ****** *)

implement{
} Game_loop () = let
//
val cont = Game_loop$isRunning ()
//
in
//
if cont then let
  val () =
    Game_loop$handleEvents ()
  // end of [val]
  val () = Game_loop$update ()
  val () = Game_loop$render ()
in
  Game_loop ()
end else ((*void*))
//
end // end of [Game_loop]

(* ****** ****** *)

implement{
} Game_main () =
{
//
val () = Game_init ()
val () = Game_loop ()
val () = Game_cleanup ()
//
} (* end of [Game_main] *)

(* ****** ****** *)

(* end of [Game.dats] *)
