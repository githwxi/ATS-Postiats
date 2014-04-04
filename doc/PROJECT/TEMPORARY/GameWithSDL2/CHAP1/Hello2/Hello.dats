(*
** Game Development with SDL2
*)

(* ****** ****** *)

#define
ATS_PACKNAME "SDL2_Hello"

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "{$SDL2}/SATS/SDL.sats"

(* ****** ****** *)

staload "./../Game/Game.sats"
staload "./../Game/Game.dats"

(* ****** ****** *)

staload Window =
{
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
staload "{$SDL2}/SATS/SDL.sats"
//
vtypedef objptr(l:addr) = SDL_Window_ptr(l)
#include "{$LIBATSHWXI}/globals/HATS/gobjptr.hats"
//
} (* end of [Window] *)

(* ****** ****** *)

staload Renderer =
{
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
staload "{$SDL2}/SATS/SDL.sats"
//
vtypedef objptr(l:addr) = SDL_Renderer_ptr(l)
#include "{$LIBATSHWXI}/globals/HATS/gobjptr.hats"
//
} (* end of [Renderer] *)

(* ****** ****** *)

staload isRunning =
{
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
typedef T = bool
//
fun initize (x: &T? >> T): void = x := false
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [isRunning] *)

(* ****** ****** *)

implement{
} Game_init () =
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
val r = Uint8(~1)
val g = Uint8(~1)
val b = Uint8(~1)
val a = Uint8(255)
val err =
SDL_SetRenderDrawColor (Renderer, r, g, b, a)
val () = assertloc (err = 0)
//
val () = $Window.initset (Window)
val () = $Renderer.initset (Renderer)
//
val () = $isRunning.set (true)
//
} (* end of [Game_init] *)

(* ****** ****** *)

implement{}
Game_loop$isRunning () = $isRunning.get ()

(* ****** ****** *)

implement{
} Game_loop$render () =
{
//
val (fpf | Renderer) =
  $Renderer.vtakeout ((*void*))
val () =
  assertloc (ptrcast (Renderer) > 0)
//
val () =
  assertloc (SDL_RenderClear (Renderer) = 0)
//
val () = SDL_RenderPresent (Renderer)
//
prval ((*void*)) = fpf (Renderer)
//
} (* end of [Game_loop$render] *)

(* ****** ****** *)

implement{
} Game_loop$handleEvents
  ((*void*)) = let
//
var event: SDL_Event?
val status = SDL_PollEvent (event)
//
in
//
if status > 0 then let
  prval () = opt_unsome (event)
in
  case+ event.type of
  | t when t = SDL_QUIT => $isRunning.set (false)
  | _(*ignored*) => ()
end else let
  prval () = opt_unnone (event)
in
  // nothing
end // end of [if]
//
end // end of [Game_loop$handleEvents]

(* ****** ****** *)

implement{
} Game_loop$update () = ()

(* ****** ****** *)

implement{
} Game_cleanup () =
{
//
val () = SDL_DestroyWindow ($Window.takeout())
val () = SDL_DestroyRenderer ($Renderer.takeout())
//
val () = SDL_Quit ((*void*))
//
} (* end of [Game_cleanup] *)

(* ****** ****** *)

implement
main0 () = () where
{
//
val () = Game_main ()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Hello.dats] *)
