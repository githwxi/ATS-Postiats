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
** API in ATS for HTML5/canvas-2d
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
(*
//
#define
ATS_STALOADFLAG 0
//
*)
//
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2js_HTML5_"
//
(* ****** ****** *)
//
abstype canvas_type
typedef canvas = canvas_type
//
abstype canvas2d_type
typedef canvas2d = canvas2d_type
//
(* ****** ****** *)
//
fun
canvas_getById(id: string): canvas = "mac#%"
fun
canvas2d_getById(id: string): canvas2d = "mac#%"
//
(* ****** ****** *)

fun
canvas2d_clearRect
(
  canvas2d
, x: int, y: int, wd: int, ht: int
) : void = "mac#%" // endfun

overload
.clearRect with canvas2d_clearRect

(* ****** ****** *)
//
fun
canvas2d_beginPath
  (cnvs: canvas2d): void = "mac#%"
fun
canvas2d_closePath
  (cnvs: canvas2d): void = "mac#%"
//
overload
.beginPath with canvas2d_beginPath
overload
.closePath with canvas2d_closePath
//
(* ****** ****** *)
//
fun
canvas2d_moveTo
  (canvas2d, x: double, y: double): void = "mac#%"
//
fun
canvas2d_lineTo
  (canvas2d, x: double, y: double): void = "mac#%"
//
overload .moveTo with canvas2d_moveTo
overload .lineTo with canvas2d_lineTo
//
(* ****** ****** *)

fun
canvas2d_rect
(
  canvas2d
, xul: double, yul: double
, width: double, height: double
) : void = "mac#%" // endfun

overload .rect with canvas2d_rect

(* ****** ****** *)

fun
canvas2d_arc
(
  canvas2d
, xc: double, yc: double, rad: double
, angle_beg: double, angle_end: double, ccw: bool
) : void = "mac#%" // endfun

overload .arc with canvas2d_arc

(* ****** ****** *)
//
fun
canvas2d_fill (canvas2d): void = "mac#%"
fun
canvas2d_stroke (canvas2d): void = "mac#%"
//
overload .fill with canvas2d_fill
overload .stroke with canvas2d_stroke
//
(* ****** ****** *)
//
fun
canvas2d_fillRect
(
  canvas2d
, xul: double, yul: double, width: double, height: double
) : void = "mac#%"
fun
canvas2d_strokeRect
(
  canvas2d
, xul: double, yul: double, width: double, height: double
) : void = "mac#%"
//
overload .fillRect with canvas2d_fillRect
overload .strokeRect with canvas2d_strokeRect
//
(* ****** ****** *)
//
fun
canvas2d_fillText
  (canvas2d, text: string, x: double, y: double): void = "mac#%"
fun
canvas2d_fillText2
  (canvas2d, text: string, x: double, y: double, maxWidth: double): void = "mac#%"
//
overload .fillText with canvas2d_fillText
overload .fillText2 with canvas2d_fillText2
//
(* ****** ****** *)
//
fun
canvas2d_scale
  (canvas2d, sx: double, sy: double): void = "mac#%"
fun
canvas2d_rotate
  (canvas2d, angle: double(*radian*)): void = "mac#%"
fun
canvas2d_translate
  (can: canvas2d, x: double, y: double): void = "mac#%"
//
overload .scale with canvas2d_scale
overload .rotate with canvas2d_rotate
overload .translate with canvas2d_translate
//
(* ****** ****** *)
//
absview canvas2d_save_v
//
(* ****** ****** *)
//
fun
canvas2d_save
  (canvas: canvas2d): (canvas2d_save_v | void) = "mac#%"
fun
canvas2d_restore
  (pf: canvas2d_save_v | canvas: canvas2d): void = "mac#%"
//
overload .save with canvas2d_save
overload .restore with canvas2d_restore
//
(* ****** ****** *)
//
fun canvas2d_get_lineWidth (canvas2d): double = "mac#%"
fun canvas2d_set_lineWidth_int (canvas2d, int): void = "mac#%"
fun canvas2d_set_lineWidth_double (canvas2d, double): void = "mac#%"
//
overload .lineWidth with canvas2d_get_lineWidth
overload .lineWidth with canvas2d_set_lineWidth_int
overload .lineWidth with canvas2d_set_lineWidth_double
//
(* ****** ****** *)
//
fun
canvas2d_set_font_string (canvas2d, font: string): void = "mac#%"
fun
canvas2d_set_textAlign_string (canvas2d, value: string): void = "mac#%"
fun
canvas2d_set_textBaseline_string (canvas2d, value: string): void = "mac#%"
//
overload .font with canvas2d_set_font_string
overload .textAlign with canvas2d_set_textAlign_string
overload .textBaseline with canvas2d_set_textBaseline_string
//
(* ****** ****** *)
//
fun
canvas2d_set_fillStyle_string (canvas2d, style: string): void = "mac#%"
fun
canvas2d_set_strokeStyle_string (canvas2d, style: string): void = "mac#%"
//
overload .fillStyle with canvas2d_set_fillStyle_string
overload .strokeStyle with canvas2d_set_strokeStyle_string
//
(* ****** ****** *)
//
fun
canvas2d_set_shadowColor_string
  (canvas2d, color: string): void = "mac#%"
//
overload .shadowColor with canvas2d_set_shadowColor_string
//
(* ****** ****** *)
//
fun
canvas2d_set_shadowBlur_int
  (canvas2d, blur: int): void = "mac#%"
fun
canvas2d_set_shadowBlur_double
  (canvas2d, blur: double): void = "mac#%"
//
overload .shadowBlur with canvas2d_set_shadowBlur_int
overload .shadowBlur with canvas2d_set_shadowBlur_double
//
(* ****** ****** *)
//
fun
canvas2d_set_shadowOffsetX_int (canvas2d, int): void = "mac#%"
fun
canvas2d_set_shadowOffsetX_double (canvas2d, double): void = "mac#%"
//
overload .shadowOffsetX with canvas2d_set_shadowOffsetX_int
overload .shadowOffsetX with canvas2d_set_shadowOffsetX_double
//
(* ****** ****** *)
//
fun
canvas2d_set_shadowOffsetY_int (canvas2d, int): void = "mac#%"
fun
canvas2d_set_shadowOffsetY_double (canvas2d, double): void = "mac#%"
//
overload .shadowOffsetY with canvas2d_set_shadowOffsetY_int
overload .shadowOffsetY with canvas2d_set_shadowOffsetY_double
//
(* ****** ****** *)
//
abstype gradient_type
typedef gradient = gradient_type
//
(* ****** ****** *)
//
fun
canvas2d_createLinearGradient
(
  canvas2d
, x0: double, y0: double, x1: double, y1: double
) : gradient = "mac#%" // end-of-fun
//
overload .createLinearGradient with canvas2d_createLinearGradient
//
(* ****** ****** *)
//
fun
canvas2d_gradient_addColorStop
  (gradient, stop: double, color: string): void = "mac#%"
//
overload .addColorStop with canvas2d_gradient_addColorStop
//
(* ****** ****** *)
//
fun
canvas2d_set_fillStyle_gradient (canvas2d, style: gradient): void = "mac#%"
fun
canvas2d_set_strokeStyle_gradient (canvas2d, style: gradient): void = "mac#%"
//
overload .fillStyle_gradient with canvas2d_set_fillStyle_gradient
overload .strokeStyle_gradient with canvas2d_set_strokeStyle_gradient
//
(* ****** ****** *)

(* end of [canvas2d.sats] *)
