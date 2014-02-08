(* ****** ****** *)
//
// API in ATS for SDL2_image
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

%{#
//
#include "SDL2/CATS/SDL_image.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.SDL2IMG" // package name
#define ATS_EXTERN_PREFIX "atscntrb_SDL2IMG_" // prefix for external names"

(* ****** ****** *)

staload "./SDL.sats"

(* ****** ****** *)

fun SDL_IMAGE_VERSION (ver: &SDL_version? >> _): void = "mac#%"

(* ****** ****** *)
//
fun
IMG_Linked_Version ((*void*)): [l:addr]
(
  SDL_version @ l, SDL_version @ l -<lin,prf> void | ptr(l)
) = "mac#%" // end of [IMG_Linked_Version]
//
(* ****** ****** *)
//
typedef IMG_InitFlags = int
//
macdef
IMG_INIT_JPG = $extval (IMG_InitFlags, "IMG_INIT_JPG")
macdef
IMG_INIT_PNG = $extval (IMG_InitFlags, "IMG_INIT_PNG")
macdef
IMG_INIT_TIF = $extval (IMG_InitFlags, "IMG_INIT_TIF")
macdef
IMG_INIT_WEBP = $extval (IMG_InitFlags, "IMG_INIT_WEBP")
//
(* ****** ****** *)

fun IMG_Init (flags: int): int = "mac#%"

(* ****** ****** *)

fun IMG_Load (path: NSH(string)): SDL_Surface_ptr0 = "mac#%"

(* ****** ****** *)

fun IMG_SavePNG
  (surface: !SDL_Surface_ptr1, path: NSH(string)): int = "mac#%"
// end of [IMG_SavePNG]

(* ****** ****** *)

(* end of [SDL_image.sats] *)
