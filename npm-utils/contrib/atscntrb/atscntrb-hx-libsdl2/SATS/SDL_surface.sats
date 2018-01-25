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
SDL_Surface_ptr2ptr
  {l:addr}(!SDL_Surface_ptr(l)):<> ptr(l)
//
overload ptrcast with SDL_Surface_ptr2ptr
//
(* ****** ****** *)

fun SDL_CreateRGBSurface
(
  flags: Uint32
, width: int, height: int, depth: int
, Rmask: Uint32, Gmask: Uint32, Bmask: Uint32, Amask: Uint32
) : SDL_Surface_ptr0 = "mac#%" // end-of-fun

(* ****** ****** *)

fun SDL_CreateRGBSurfaceFrom
(
  pixes: ptr // not-freed by [FreeSurface]
, width: int, height: int, depth: int, pitch: int
, Rmask: Uint32, Gmask: Uint32, Bmask: Uint32, Amask: Uint32
) : SDL_Surface_ptr0 = "mac#%" // end-of-fun

(* ****** ****** *)

fun SDL_FreeSurface (SDL_Surface_ptr0): void = "mac#%"

(* ****** ****** *)
//
fun SDL_LoadBMP
  (path: string): SDL_Surface_ptr0 = "mac#%"
fun SDL_SaveBMP
  (!SDL_Surface_ptr1, path: string): int = "mac#%"
//
(* ****** ****** *)

fun SDL_SetSurfaceColorMod
(
  !SDL_Surface_ptr1, r: Uint8, g: Uint8, b: Uint8
) : int = "mac#%" // end of [SDL_SetSurfaceColorMod]

fun SDL_GetSurfaceColorMod
(
  !SDL_Surface_ptr1, r: &Uint8? >> _, g: &Uint8? >> _, b: &Uint8? >> _
) : int = "mac#%" // end of [SDL_GetSurfaceColorMod]

(* ****** ****** *)
//
fun SDL_UpperBlit
(
  src: !SDL_Surface_ptr1, srcrect: cPtr0(SDL_Rect)
, dst: !SDL_Surface_ptr1, dstrect: cPtr0(SDL_Rect)
) : int = "mac#%" // end of [SDL_UpperBlit]
fun SDL_UpperBlit2
(
  src: !SDL_Surface_ptr1, srcrect: cPtr0(SDL_Rect)
, dst: !SDL_Surface_ptr1, dstrect: &SDL_Rect? >> _
) : int = "mac#%" // end of [SDL_UpperBlit2]
//
macdef
SDL_BlitSurface (src, srcrect, dst, dstrect) =
  SDL_UpperBlit (,(src), ,(srcrect), ,(dst), ,(dstrect))
//
(* ****** ****** *)

(* end of [SDL_surface.sats] *)
