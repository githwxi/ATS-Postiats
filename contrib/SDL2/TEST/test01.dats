(*
** Testing the ATS API for SDL2
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/SDL.sats"

(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)

implement
main0 () = () where
{
//
val err = SDL_Init (SDL_INIT_VIDEO)
val ((*void*)) = assertloc (err >= 0)
//
val xpos = SDL_WINDOWPOS_UNDEFINED
val ypos = SDL_WINDOWPOS_UNDEFINED
val window = 
SDL_CreateWindow
(
  "SDL2/test01", xpos, ypos, 640, 480, SDL_WINDOW_SHOWN
) (* end of [val] *)
val () = assertloc (ptrcast(window) > 0)
//
val (fpf | screen) = SDL_GetWindowSurface (window)
val ((*void*)) = assertloc (ptrcast(screen) > 0)
//
val image = SDL_LoadBMP ("DATA/hello_world.bmp")
val ((*void*)) = assertloc (ptrcast(image) > 0)
val err =
SDL_BlitSurface(image, cptr_null(), screen, cptr_null())
val () = SDL_FreeSurface (image)
//
prval ((*void*)) = fpf (screen)
//
val err = SDL_UpdateWindowSurface (window)
//
val () = SDL_Delay (2000)
//
val () = SDL_DestroyWindow (window)
//
val () = SDL_Quit ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
