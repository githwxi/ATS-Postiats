(* ****** ****** *)
//
// API in ATS for SDL2
//
(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi (gmhwxiDOTgmailDOTcom)
*)

(* ****** ****** *)

#include "./mybasis.sats"

(* ****** ****** *)
//
castfn
SDL_Window_ptr2ptr
  {l:addr}(!SDL_Window_ptr(l)):<> ptr(l)
//
overload ptrcast with SDL_Window_ptr2ptr
//
(* ****** ****** *)

typedef SDL_WindowFlags = Uint32
macdef
SDL_WINDOW_FULLSCREEN = $extval (SDL_WindowFlags, "SDL_WINDOW_FULLSCREEN")
macdef
SDL_WINDOW_OPENGL = $extval (SDL_WindowFlags, "SDL_WINDOW_OPENGL")
macdef
SDL_WINDOW_SHOWN = $extval (SDL_WindowFlags, "SDL_WINDOW_SHOWN")
macdef
SDL_WINDOW_HIDDEN = $extval (SDL_WindowFlags, "SDL_WINDOW_HIDDEN")
macdef
SDL_WINDOW_BORDERLESS = $extval (SDL_WindowFlags, "SDL_WINDOW_BORDERLESS")
macdef
SDL_WINDOW_RESIZABLE = $extval (SDL_WindowFlags, "SDL_WINDOW_RESIZABLE")
macdef
SDL_WINDOW_MINIMIZED = $extval (SDL_WindowFlags, "SDL_WINDOW_MINIMIZED")
macdef
SDL_WINDOW_MAXIMIZED = $extval (SDL_WindowFlags, "SDL_WINDOW_MAXIMIZED")
macdef
SDL_WINDOW_INPUT_GRABBED = $extval (SDL_WindowFlags, "SDL_WINDOW_INPUT_GRABBED")
macdef
SDL_WINDOW_INPUT_FOCUS = $extval (SDL_WindowFlags, "SDL_WINDOW_INPUT_FOCUS")
macdef
SDL_WINDOW_MOUSE_FOCUS = $extval (SDL_WindowFlags, "SDL_WINDOW_MOUSE_FOCUS")
macdef
SDL_WINDOW_FULLSCREEN_DESKTOP = $extval (SDL_WindowFlags, "SDL_WINDOW_FULLSCREEN_DESKTOP")
macdef
SDL_WINDOW_FOREIGN = $extval (SDL_WindowFlags, "SDL_WINDOW_FOREIGN")
macdef
SDL_WINDOW_ALLOW_HIGHDPI = $extval (SDL_WindowFlags, "SDL_WINDOW_ALLOW_HIGHDPI")

(* ****** ****** *)

fun SDL_CreateWindow
(
  title: NSH(string), x: int, y: int, w: int, h: int, flags: Uint32
) : SDL_Window_ptr0 = "mac#%" // end of [SDL_CreateWindow]

(* ****** ****** *)

fun SDL_DestroyWindow (SDL_Window_ptr0): void = "mac#%"

(* ****** ****** *)

fun SDL_GetWindowSurface
  (win: !SDL_Window_ptr1): [l:addr] vttakeout0(SDL_Surface_ptr(l)) = "mac#%"
// end of [SDL_GetWindowSurface]

(* ****** ****** *)

(* end of [SDL_video.sats] *)
