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
fun SDL_Delay (ms: Uint32): void = "mac#%"
*)
fun SDL_Delay_Uint32 (ms: Uint32): void = "mac#%"
fun SDL_Delay_intGtez (ms: intGte(0)): void = "mac#%"
//
overload SDL_Delay with SDL_Delay_Uint32
overload SDL_Delay with SDL_Delay_intGtez
//
(* ****** ****** *)

(* end of [SDL_timer.sats] *)
