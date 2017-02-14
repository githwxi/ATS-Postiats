(*
** For writing ATS code
** that translates into JavaScript
*)

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
** API in ATS for HTML5/WebGL
*)
(* ****** ****** *)
(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: November, 2014
*)
(* ****** ****** *)

#define
ATS_STALOADFLAG 0 // no staloading at run-time
#define
ATS_EXTERN_PREFIX "ats2js_HTML5_" // prefix for external names

(* ****** ****** *)
//
abstype canvas_type
typedef canvas = canvas_type
//
abstype canvasgl_type
typedef canvasgl = canvasgl_type
//
(* ****** ****** *)
//
fun
canvas_getById (id: string): canvas = "mac#%"
fun
canvasgl_getById (id: string): canvasgl = "mac#%"
//
(* ****** ****** *)

(* end of [WebGL.sats] *)
