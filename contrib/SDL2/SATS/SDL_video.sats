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
// HX: [SDL_Surface_ref] is reference counted
//
absvtype SDL_Window_ptr (l:addr) // SDL_Window* or null
vtypedef SDL_Window_ptr0 = [l:addr] SDL_Window_ptr (l)
vtypedef SDL_Window_ptr1 = [l:addr | l > null] SDL_Window_ptr (l)
//
(* ****** ****** *)

fun SDL_CreateWindow
(
  title: NSH(string), x: int, y: int, w: int, h: int, flags: Uint32
) : SDL_Window_ptr0 = "mac#%" // end of [SDL_CreateWindow]

(* ****** ****** *)

(* end of [SDL_video.sats] *)
