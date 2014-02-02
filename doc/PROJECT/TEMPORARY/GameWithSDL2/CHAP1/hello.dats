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

staload Window = "./hello_Window.dats"
staload Renderer = "./hello_Renderer.dats"

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
val g_pWindow =
  SDL_CreateWindow (title, x, y, 640, 480, SDL_WINDOW_SHOWN)
//
val () = assertloc (ptrcast(g_pWindow) > 0)
//
val g_pRenderer = SDL_CreateRenderer(g_pWindow, ~1, (Uint32)0)
//
val () = assertloc (ptrcast(g_pRenderer) > 0)
//
val () = $Window.initset (g_pWindow)
val () = $Renderer.initset (g_pRenderer)
//
} (* end of [val] *)

(* ****** ****** *)

fun step2 () =
{
//
val (fpf | g_pRenderer) = $Renderer.vtakeout ()
//
val err =
SDL_SetRenderDrawColor
  (g_pRenderer, (Uint8)0, (Uint8)0, (Uint8)0, (Uint8)255)
val () = assertloc (err = 0)
//
val err =
SDL_RenderClear (g_pRenderer)
val () = assertloc (err = 0)
//
val () = SDL_RenderPresent (g_pRenderer)
//
prval () = fpf (g_pRenderer)
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

(* end of [hello.dats] *)
