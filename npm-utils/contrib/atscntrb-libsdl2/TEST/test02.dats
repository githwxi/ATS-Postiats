(*
** Testing the ATS API for SDL2
** Testing the ATS API for SDL2_image
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/SDL.sats"
staload "./../SATS/SDL_image.sats"

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
val W = 640
val H = 480
val xpos = SDL_WINDOWPOS_UNDEFINED
val ypos = SDL_WINDOWPOS_UNDEFINED
val window = 
SDL_CreateWindow
(
  "SDL2/test02", xpos, ypos, W, H, SDL_WINDOW_SHOWN
) (* end of [val] *)
val () = assertloc (ptrcast(window) > 0)
//
val (fpf | screen) = SDL_GetWindowSurface (window)
val ((*void*)) = assertloc (ptrcast(screen) > 0)
//
val image = IMG_Load ("DATA/zoe-2005-10-19-1.png")
val ((*void*)) = assertloc (ptrcast(image) > 0)
var imgrect: SDL_Rect
val () = imgrect.x := 800
val () = imgrect.y := 400
val () = imgrect.w := W and () = imgrect.h := H
val err =
SDL_BlitSurface(image, cptr_rvar(imgrect), screen, cptr_null())
val () = SDL_FreeSurface (image)
//
prval ((*void*)) = fpf (screen)
//
val err = SDL_UpdateWindowSurface (window)
//
val () = SDL_Delay (5000)
//
val () = SDL_DestroyWindow (window)
//
val () = SDL_Quit ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
