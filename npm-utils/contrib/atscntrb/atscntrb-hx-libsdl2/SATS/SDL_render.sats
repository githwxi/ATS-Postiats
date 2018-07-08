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
castfn
SDL_Texture_ptr2ptr
  {l:addr}(!SDL_Texture_ptr(l)):<> ptr(l)
castfn
SDL_Renderer_ptr2ptr
  {l:addr}(!SDL_Renderer_ptr(l)):<> ptr(l)
//
overload ptrcast with SDL_Texture_ptr2ptr
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
//  
typedef SDL_TextureAccess = int
//
macdef
SDL_TEXTUREACCESS_STATIC =
$extval (SDL_TextureAccess, "SDL_TEXTUREACCESS_STATIC")
macdef
SDL_TEXTUREACCESS_STREAMING =
$extval (SDL_TextureAccess, "SDL_TEXTUREACCESS_STREAMING")
macdef
SDL_TEXTUREACCESS_TARGET =
$extval (SDL_TextureAccess, "SDL_TEXTUREACCESS_TARGET")
//
(* ****** ****** *)
//
abst@ype
SDL_TextureModulate = int
//
macdef
SDL_TEXTUREMODULATE_NONE =
$extval (SDL_TextureModulate, "SDL_TEXTUREMODULATE_NONE")
macdef
SDL_TEXTUREMODULATE_COLOR =
$extval (SDL_TextureModulate, "SDL_TEXTUREMODULATE_COLOR")
macdef
SDL_TEXTUREMODULATE_ALPHA =
$extval (SDL_TextureModulate, "SDL_TEXTUREMODULATE_ALPHA")
//
(* ****** ****** *)

abst@ype SDL_RendererFlip = int
//
macdef
SDL_FLIP_NONE = $extval (SDL_RendererFlip, "SDL_FLIP_NONE")
macdef
SDL_FLIP_HORIZONTAL = $extval (SDL_RendererFlip, "SDL_FLIP_HORIZONTAL")
macdef
SDL_FLIP_VERTICAL = $extval (SDL_RendererFlip, "SDL_FLIP_VERTICAL")
//
(* ****** ****** *)

fun SDL_GetNumRenderDrivers ((*void*)): int = "mac#%"

fun SDL_GetRenderDriverInfo
(
  index: int, info: &SDL_RendererInfo? >> opt(SDL_RendererInfo, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // end-of-funp

(* ****** ****** *)

fun SDL_CreateRenderer
(
  window: !SDL_Window_ptr1, index: int, flags: Uint32
) : SDL_Renderer_ptr0 = "mac#%" // end-of-fun

(* ****** ****** *)

fun SDL_CreateSoftwareRenderer
  (sf: !SDL_Surface_ptr1): SDL_Renderer_ptr0 = "mac#%"
// end of [SDL_CreateSoftwareRenderer]

(* ****** ****** *)

fun SDL_DestroyRenderer (SDL_Renderer_ptr0): void = "mac#%"

(* ****** ****** *)

fun SDL_GetRenderer
  (win: !SDL_Window_ptr1): SDL_Renderer_ptr0 = "mac#%"

fun SDL_GetRendererInfo
(
  rndr: !SDL_Renderer_ptr1
, info: &SDL_RendererInfo? >> opt(SDL_RendererInfo, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // end-of-fun

fun SDL_GetRendererOutputSize
  (rndr: !SDL_Renderer_ptr1, w: &int? >> _, h: &int? >> _): int = "mac#%"
// end of [SDL_GetRendererOutputSize]

(* ****** ****** *)

fun
SDL_CreateTexture
(
  rndr: !SDL_Renderer_ptr1, format: Uint32, access: int, w: int, h: int
) : SDL_Texture_ptr0 = "mac#%" // end-of-fun

fun
SDL_CreateTextureFromSurface
  (rndr: !SDL_Renderer_ptr1, sf: !SDL_Surface_ptr1): SDL_Texture_ptr0 = "mac#%"
// end of [SDL_CreateTextureFromSurface]  

(* ****** ****** *)

fun SDL_DestroyTexture (SDL_Texture_ptr0): void = "mac#%"

(* ****** ****** *)

fun
SDL_QueryTexture
(
  text: !SDL_Texture_ptr1
, format: cPtr0(Uint32), access: cPtr0(int), w: &int? >> _, h: &int? >> _
) : int = "mac#%" // end of [SDL_QueryTexture]

(* ****** ****** *)

fun SDL_SetTextureColorMod
  (text: !SDL_Texture_ptr1, r: Uint8, g: Uint8, b: Uint8): int = "mac#%"
// end of [SDL_SetTextureColorMod]

fun SDL_GetTextureColorMod
(
  text: !SDL_Texture_ptr1, r: &Uint8? >> _, g: &Uint8? >> _, b: &Uint8? >> _
) : int = "mac#%" // end of [SDL_GetTextureColorMod]

(* ****** ****** *)

fun SDL_SetTextureAlphaMod
  (text: !SDL_Texture_ptr1, alpha: Uint8): int = "mac#%"
// end of [SDL_SetTextureAlphaMod]

fun SDL_GetTextureAlphaMod
  (text: !SDL_Texture_ptr1, alpha: &Uint8? >> _): int = "mac#%"
// end of [SDL_GetTextureAlphaMod]

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
