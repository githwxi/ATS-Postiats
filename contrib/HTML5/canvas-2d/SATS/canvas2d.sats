(*
** API in ATS for HTML/canvas-2d
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
** Author: Will Blair
** Authoremail: wdblairATgmailDOTcom
** Start Time: October, 2013
*)
(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: October, 2013
*)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.HTML"

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_html5_" // prefix for external names

(* ****** ****** *)

absvtype
canvas2d_vtype (l:addr) = ptr (l)

(* ****** ****** *)
//
vtypedef
canvas2d (l:addr) = canvas2d_vtype (l)
//
vtypedef canvas2d0 = [l:agez] canvas2d (l)
vtypedef canvas2d1 = [l:addr | l > null] canvas2d (l)
//
(* ****** ****** *)

castfn
canvas2d2ptr {l:addr} (!canvas2d (l)):<> ptr (l)
overload ptrcast with canvas2d2ptr

(* ****** ****** *)
//
fun{
} get0_canvas2d (
) : [l:agz] vttakeout0 (canvas2d (l))
//
fun{} get1_canvas2d (): canvas2d1
//
(* ****** ****** *)

fun
canvas2d_make (id: string): canvas2d0 = "ext#%"
fun
canvas2d_free (canvas: canvas2d0): void = "ext#%"

(* ****** ****** *)

fun
canvas2d_clearRect
(
  !canvas2d1
, x: double, y: double, wd: double, ht: double
) : void = "ext#%" // endfun

(* ****** ****** *)

fun
canvas2d_beginPath (!canvas2d1): void = "ext#%"
fun
canvas2d_closePath (!canvas2d1): void = "ext#%"

(* ****** ****** *)
//
fun canvas2d_moveTo
  (!canvas2d1, x: double, y: double): void = "ext#%"
//
fun canvas2d_lineTo
  (!canvas2d1, x: double, y: double): void = "ext#%"
//
(* ****** ****** *)

fun
canvas2d_rect
(
  !canvas2d1
, xul: double
, yul: double
, width: double
, height: double
) : void = "ext#%"

(* ****** ****** *)

fun
canvas2d_arc
(
  !canvas2d1
, xc: double
, yc: double
, rad: double
, angle_beg: double
, angle_end: double
, counterclockwise: bool
) : void = "ext#%"

(* ****** ****** *)

fun canvas2d_fill (!canvas2d1): void = "ext#%"
fun canvas2d_stroke (!canvas2d1): void = "ext#%"

(* ****** ****** *)

fun
canvas2d_fillRect
(
  !canvas2d1
, xul: double, yul: double, width: double, height: double
) : void = "ext#%"
fun
canvas2d_strokeRect
(
  !canvas2d1
, xul: double, yul: double, width: double, height: double
) : void = "ext#%"

(* ****** ****** *)

fun
canvas2d_fillText
  (!canvas2d1, text: string, x: double, y: double): void = "ext#%"
fun
canvas2d_fillText2
  (!canvas2d1, text: string, x: double, y: double, maxWidth: double): void = "ext#%"

(* ****** ****** *)
//
fun
canvas2d_translate
  (!canvas2d1, x: double, y: double): void = "ext#%"
fun
canvas2d_scale
  (!canvas2d1, sx: double, sy: double): void = "ext#%"
fun
canvas2d_rotate
  (!canvas2d1, angle: double(*radian*)): void = "ext#%"
//
(* ****** ****** *)
//
absview canvas2d_save_v (l:addr)
//
fun
canvas2d_save{l:agz}
  (canvas: !canvas2d l): (canvas2d_save_v l | void) = "ext#%"
fun
canvas2d_restore{l:agz}
  (pf: canvas2d_save_v l | canvas: !canvas2d l): void = "ext#%"
//
(* ****** ****** *)

fun canvas2d_set_font_string (!canvas2d1, font: string): void = "ext#%"
fun canvas2d_set_textAlign_string (!canvas2d1, value: string): void = "ext#%"
fun canvas2d_set_textBaseline_string (!canvas2d1, value: string): void = "ext#%"

(* ****** ****** *)

fun canvas2d_set_fillStyle_string (!canvas2d1, style: string): void = "ext#%"
fun canvas2d_set_strokeStyle_string (!canvas2d1, style: string): void = "ext#%"

(* ****** ****** *)

fun canvas2d_set_size_int
  (!canvas2d1, width: int(*px*), height: int(*px*)): void = "ext#%"
// end of [canvas2d_set_size_int]

(* ****** ****** *)

(* end of [canvas2d.sats] *)
