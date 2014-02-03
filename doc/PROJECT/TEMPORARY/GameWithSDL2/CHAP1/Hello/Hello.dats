(*
** Game Development with SDL2
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "{$SDL2}/SATS/SDL.sats"

(* ****** ****** *)

staload Window = "./Hello_Window.dats"
staload Renderer = "./Hello_Renderer.dats"

(* ****** ****** *)

fun step1 (): void =
{
val err =
  SDL_Init (SDL_INIT_EVERYTHING)
//
val () = assertloc (err >= 0)
//
val title = "Chapter 1: Setting up SDL"
val x = $extval (int, "SDL_WINDOWPOS_CENTERED")
val y = $extval (int, "SDL_WINDOWPOS_CENTERED")
val flags = SDL_WINDOW_SHOWN
val Window = SDL_CreateWindow (title, x, y, 640, 480, flags)
//
val () = assertloc (ptrcast(Window) > 0)
//
val Renderer = SDL_CreateRenderer(Window, ~1, (Uint32)0)
//
val () = assertloc (ptrcast(Renderer) > 0)
//
val err =
SDL_SetRenderDrawColor
  (Renderer, (Uint8)0, (Uint8)0, (Uint8)0, (Uint8)255)
val () = assertloc (err = 0)
//
val () = $Window.initset (Window)
val () = $Renderer.initset (Renderer)
//
//
} (* end of [val] *)

(* ****** ****** *)

fun step2 () =
{
//
val (fpf | Renderer) = $Renderer.vtakeout ()
val ((*void*)) = assertloc (ptrcast (Renderer) > 0)
//
val err =
SDL_RenderClear (Renderer)
val () = assertloc (err = 0)
//
val () = SDL_RenderPresent (Renderer)
//
prval ((*void*)) = fpf (Renderer)
//
} (* end of [val] *)

(* ****** ****** *)

implement
main0 () = () where
{
//
val () = step1 ()
val () = step2 ()
val () = SDL_Delay ((Uint32)5000)
val ((*void*)) = SDL_Quit ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Hello.dats] *)
