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

#include "./mybasis.sats"

(* ****** ****** *)
//
(*
macdef SDL_FIRSTEVENT = $extval (SDL_EventType, "SDL_FIRSTEVENT")
*)
macdef SDL_QUIT = $extval (SDL_EventType, "SDL_QUIT")
macdef SDL_APP_TERMINATING = $extval (SDL_EventType, "SDL_APP_TERMINATING")
macdef SDL_APP_LOWMEMORY = $extval (SDL_EventType, "SDL_APP_LOWMEMORY")
macdef SDL_APP_WILLENTERBACKGROUND = $extval (SDL_EventType, "SDL_APP_WILLENTERBACKGROUND")
macdef SDL_APP_DIDENTERBACKGROUND = $extval (SDL_EventType, "SDL_APP_DIDENTERBACKGROUND")
macdef SDL_APP_WILLENTERFOREGROUND = $extval (SDL_EventType, "SDL_APP_WILLENTERFOREGROUND")
macdef SDL_APP_DIDENTERFOREGROUND = $extval (SDL_EventType, "SDL_APP_DIDENTERFOREGROUND")
macdef SDL_WINDOWEVENT = $extval (SDL_EventType, "SDL_WINDOWEVENT")
macdef SDL_SYSWMEVENT = $extval (SDL_EventType, "SDL_SYSWMEVENT")
macdef SDL_KEYDOWN = $extval (SDL_EventType, "SDL_KEYDOWN")
macdef SDL_KEYUP = $extval (SDL_EventType, "SDL_KEYUP")
macdef SDL_TEXTEDITING = $extval (SDL_EventType, "SDL_TEXTEDITING")
macdef SDL_TEXTINPUT = $extval (SDL_EventType, "SDL_TEXTINPUT")
macdef SDL_MOUSEMOTION = $extval (SDL_EventType, "SDL_MOUSEMOTION")
macdef SDL_MOUSEBUTTONDOWN = $extval (SDL_EventType, "SDL_MOUSEBUTTONDOWN")
macdef SDL_MOUSEBUTTONUP = $extval (SDL_EventType, "SDL_MOUSEBUTTONUP")
macdef SDL_MOUSEWHEEL = $extval (SDL_EventType, "SDL_MOUSEWHEEL")
macdef SDL_JOYAXISMOTION = $extval (SDL_EventType, "SDL_JOYAXISMOTION")
macdef SDL_JOYBALLMOTION = $extval (SDL_EventType, "SDL_JOYBALLMOTION")
macdef SDL_JOYHATMOTION = $extval (SDL_EventType, "SDL_JOYHATMOTION")
macdef SDL_JOYBUTTONDOWN = $extval (SDL_EventType, "SDL_JOYBUTTONDOWN")
macdef SDL_JOYBUTTONUP = $extval (SDL_EventType, "SDL_JOYBUTTONUP")
macdef SDL_JOYDEVICEADDED = $extval (SDL_EventType, "SDL_JOYDEVICEADDED")
macdef SDL_JOYDEVICEREMOVED = $extval (SDL_EventType, "SDL_JOYDEVICEREMOVED")
macdef SDL_CONTROLLERAXISMOTION = $extval (SDL_EventType, "SDL_CONTROLLERAXISMOTION")
macdef SDL_CONTROLLERBUTTONDOWN = $extval (SDL_EventType, "SDL_CONTROLLERBUTTONDOWN")
macdef SDL_CONTROLLERBUTTONUP = $extval (SDL_EventType, "SDL_CONTROLLERBUTTONUP")
macdef SDL_CONTROLLERDEVICEADDED = $extval (SDL_EventType, "SDL_CONTROLLERDEVICEADDED")
macdef SDL_CONTROLLERDEVICEREMOVED = $extval (SDL_EventType, "SDL_CONTROLLERDEVICEREMOVED")
macdef SDL_CONTROLLERDEVICEREMAPPED = $extval (SDL_EventType, "SDL_CONTROLLERDEVICEREMAPPED")
macdef SDL_FINGERDOWN = $extval (SDL_EventType, "SDL_FINGERDOWN")
macdef SDL_FINGERUP = $extval (SDL_EventType, "SDL_FINGERUP")
macdef SDL_FINGERMOTION = $extval (SDL_EventType, "SDL_FINGERMOTION")
macdef SDL_DOLLARGESTURE = $extval (SDL_EventType, "SDL_DOLLARGESTURE")
macdef SDL_DOLLARRECORD = $extval (SDL_EventType, "SDL_DOLLARRECORD")
macdef SDL_MULTIGESTURE = $extval (SDL_EventType, "SDL_MULTIGESTURE")
macdef SDL_CLIPBOARDUPDATE = $extval (SDL_EventType, "SDL_CLIPBOARDUPDATE")
macdef SDL_DROPFILE = $extval (SDL_EventType, "SDL_DROPFILE")
macdef SDL_USEREVENT = $extval (SDL_EventType, "SDL_USEREVENT")
//
(*
macdef SDL_LASTEVENT = $extval (SDL_EventType, "SDL_LASTEVENT")
*)
//
(* ****** ****** *)
//
fun
SDL_EventType_equal
(
  SDL_EventType, SDL_EventType
) :<> bool = "mac#atspre_eq_int_int"
//
fun
SDL_EventType_notequal
(
  SDL_EventType, SDL_EventType
) :<> bool = "mac#atspre_neq_int_int"
//
overload = with SDL_EventType_equal
overload != with SDL_EventType_notequal
//
(* ****** ****** *)
//
fun
SDL_PollEvent
(
  event: &SDL_Event? >> opt(SDL_Event, i > 0)
) : #[i:nat] int(i) = "mac#%" // end-of-function
//
fun
SDL_PollEvent_null ((*void*)): intGte (0) = "mac#%"
//
(* ****** ****** *)

(* end of [SDL_events.sats] *)
