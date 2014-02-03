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
SDL_Renderer_ptr2ptr
  {l:addr}(!SDL_Renderer_ptr(l)):<> ptr(l)
//
overload ptrcast with SDL_Renderer_ptr2ptr
//
(* ****** ****** *)

typedef SDL_RendererFlags = Uint32

(* ****** ****** *)
//
macdef
SDL_RENDERER_SOFTWARE =
$extval (SDL_RendererFlags, "SDL_RENDERER_SOFTWARE")
//
macdef
SDL_RENDERER_ACCELERATED =
$extval (SDL_RendererFlags, "SDL_RENDERER_ACCELERATED")
//
macdef
SDL_RENDERER_PRESENTVSYNC =
$extval (SDL_RendererFlags, "SDL_RENDERER_PRESENTVSYNC")
//
macdef
SDL_RENDERER_TARGETTEXTURE =
$extval (SDL_RendererFlags, "SDL_RENDERER_TARGETTEXTURE")
//
(* ****** ****** *)

fun SDL_CreateRenderer
(
  window: !SDL_Window_ptr1, index: int, flags: Uint32
) : SDL_Renderer_ptr0 = "mac#%" // end-of-fun

(* ****** ****** *)

fun SDL_DestroyRenderer (SDL_Renderer_ptr0): void = "mac#%"

(* ****** ****** *)

fun
SDL_SetRenderDrawColor
(
  !SDL_Renderer_ptr1, r: Uint8, g: Uint8, b: Uint8, a: Uint8
) : int = "mac#%" // end of [SDL_SetRenderDrawColor]

fun
SDL_GetRenderDrawColor
(
  renderer: !SDL_Renderer_ptr1
, r: &Uint8? >> _, g: &Uint8? >> _, b: &Uint8? >> _, a: &Uint8? >> _
) : int = "mac#%" // end of [SDL_GetRenderDrawColor]

(* ****** ****** *)

fun SDL_RenderClear
  (renderer: !SDL_Renderer_ptr1): int = "mac#%" // HX: succ/fail: 0/-1
// end of [SDL_RenderClear]

(* ****** ****** *)

fun SDL_RenderPresent (renderer: !SDL_Renderer_ptr1): void = "mac#%"

(* ****** ****** *)

(* end of [SDL_render.sats] *)
