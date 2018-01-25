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

#ifndef SDL2_MYBASIS
#define SDL2_MYBASIS

(* ****** ****** *)

(*
#print "Hello from [mybasis]!\n"
*)

(* ****** ****** *)

typedef Sint8 = int8
typedef Sint16 = int16
typedef Sint32 = int32
typedef Sint64 = int64

(* ****** ****** *)

typedef Uint8 = uint8
typedef Uint16 = uint16
typedef Uint32 = uint32
typedef Uint64 = uint64

(* ****** ****** *)

symintr Uint8
castfn Uint8_of_int(int):<> Uint8
castfn Uint8_of_uint(uint):<> Uint8
overload Uint8 with Uint8_of_int
overload Uint8 with Uint8_of_uint

(* ****** ****** *)

symintr Uint32
castfn Uint32_of_int(int):<> Uint32
castfn Uint32_of_uint(uint):<> Uint32
overload Uint32 with Uint32_of_int
overload Uint32 with Uint32_of_uint

(* ****** ****** *)

typedef
SDL_version =
$extype_struct
"SDL_version_struct" of
{
  major= Uint8, minor=Uint8, patch= Uint8
} (* end of [SDL_version] *)

(* ****** ****** *)
//
typedef
SDL_Point =
$extype_struct "SDL_Point" of { x= int, y= int }
//
typedef
SDL_Rect =
$extype_struct "SDL_Rect" of { x=int, y= int, w= int, h= int }
//
(* ****** ****** *)
//
absvtype
SDL_RWops_ptr(l:addr) = ptr(l) // SDL_RWops* or null
vtypedef
SDL_RWops_ptr0 = [l:addr] SDL_RWops_ptr(l)
vtypedef
SDL_RWops_ptr1 = [l:addr | l > null] SDL_RWops_ptr(l)
//
(* ****** ****** *)

abst@ype
SDL_EventType =
$extype"SDL_EventType"

(* ****** ****** *)

typedef SDL_Event =
$extype_struct"SDL_Event" of
{
//
  type= SDL_EventType
//
, SDL_Event_rest= undefined_t0ype
} // end of [SDL_Event]

(* ****** ****** *)
//
absvtype
SDL_Window_ptr(l:addr) = ptr(l) // SDL_Window* or null
vtypedef
SDL_Window_ptr0 = [l:addr] SDL_Window_ptr(l)
vtypedef
SDL_Window_ptr1 = [l:addr | l > null] SDL_Window_ptr(l)
//
(* ****** ****** *)
//
absvtype
SDL_Surface_ptr(l:addr) = ptr(l) // SDL_Surface* or null
vtypedef
SDL_Surface_ptr0 = [l:addr] SDL_Surface_ptr(l)
vtypedef
SDL_Surface_ptr1 = [l:addr | l > null] SDL_Surface_ptr(l)
//
(* ****** ****** *)
//
absvtype
SDL_Texture_ptr(l:addr) = ptr(l) // SDL_Texture* or null
vtypedef
SDL_Texture_ptr0 = [l:addr] SDL_Texture_ptr(l)
vtypedef
SDL_Texture_ptr1 = [l:addr | l > null] SDL_Texture_ptr(l)
//
absvtype
SDL_Renderer_ptr(l:addr) = ptr(l) // SDL_Renderer* or null
vtypedef
SDL_Renderer_ptr0 = [l:addr] SDL_Renderer_ptr(l)
vtypedef
SDL_Renderer_ptr1 = [l:addr | l > null] SDL_Renderer_ptr(l)
//
(* ****** ****** *)

abst@ype
SDL_RendererInfo =
$extype_struct "SDL_RendererInfo" of
{
  name= string
, flags= Uint32
, num_texture_formats= Uint32
, texture_formats= @[Uint32][16]
, max_texture_width= int 
, max_texture_height= int
} (* end of [SDL_RendererInfo] *)

(* ****** ****** *)

#endif // end of [ifndef]

(* ****** ****** *)

(* end of [mybasis.sats] *)
