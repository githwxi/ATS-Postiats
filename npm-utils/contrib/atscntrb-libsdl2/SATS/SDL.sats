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
** Author: Hongwei Xi
** Authoremail: gmhwxiDOTgmailDOTcom
*)

(* ****** ****** *)

%{#
//
#include "atscntrb-libsdl2/CATS/SDL.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.SDL2" // package name
#define ATS_EXTERN_PREFIX "atscntrb_SDL2_" // prefix for external names"

(* ****** ****** *)

#include "./mybasis.sats"

(* ****** ****** *)

#include "./SDL_error.sats"
#include "./SDL_events.sats"
#include "./SDL_render.sats"
#include "./SDL_rwops.sats"
#include "./SDL_surface.sats"
#include "./SDL_timer.sats"
#include "./SDL_version.sats"
#include "./SDL_video.sats"

(* ****** ****** *)

macdef SDL_INIT_TIMER = $extval (Uint32, "SDL_INIT_TIMER")
macdef SDL_INIT_AUDIO = $extval (Uint32, "SDL_INIT_AUDIO")
macdef SDL_INIT_VIDEO = $extval (Uint32, "SDL_INIT_VIDEO")
macdef SDL_INIT_JOYSTICK = $extval (Uint32, "SDL_INIT_JOYSTICK")
macdef SDL_INIT_HAPTIC = $extval (Uint32, "SDL_INIT_HAPTIC")
macdef SDL_INIT_GAMECONTROLLER = $extval (Uint32, "SDL_INIT_GAMECONTROLLER")
macdef SDL_INIT_EVENTS = $extval (Uint32, "SDL_INIT_EVENTS")
macdef SDL_INIT_NOPARACHUTE = $extval (Uint32, "SDL_INIT_NOPARACHUTE")
macdef SDL_INIT_EVERYTHING = $extval (Uint32, "SDL_INIT_EVERYTHING")

(* ****** ****** *)

fun SDL_Init (flags: Uint32): int = "mac#%"
fun SDL_InitSubSystem (flags: Uint32): int = "mac#%"

(* ****** ****** *)

fun SDL_Quit ((*void*)): void = "mac#%"
fun SDL_QuitSubSystem (flags: Uint32): void = "mac#%"

(* ****** ****** *)

fun SDL_WasInit (flags: Uint32): Uint32 = "mac#%"

(* ****** ****** *)

(* end of [SDL.sats] *)
