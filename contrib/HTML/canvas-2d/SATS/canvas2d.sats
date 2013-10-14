(*
** API in ATS for HTML5/canvas-2d
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
ATS_PACKNAME "ATSCNTRB.HTML5"

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
//
castfn
canvas2d2ptr{l:addr} (can: !canvas2d(l)):<> ptr(l)
overload ptrcast with canvas2d2ptr
//
(* ****** ****** *)
//
fun
canvas2d_make (id: string): canvas2d0 = "ext#%"
//
fun canvas2d_free (can: canvas2d0): void = "ext#%"
//
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
canvas2d_scale
  (!canvas2d1, sx: double, sy: double): void = "ext#%"
fun
canvas2d_rotate
  (!canvas2d1, angle: double(*radian*)): void = "ext#%"
fun
canvas2d_translate
  (can: !canvas2d1, x: double, y: double): void = "ext#%"
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
//
symintr canvas2d_set_lineWidth
fun canvas2d_set_lineWidth_int (!canvas2d1, int): void = "ext#%"
fun canvas2d_set_lineWidth_double (!canvas2d1, double): void = "ext#%"
overload canvas2d_set_lineWidth with canvas2d_set_lineWidth_int
overload canvas2d_set_lineWidth with canvas2d_set_lineWidth_double
//
(* ****** ****** *)

fun canvas2d_set_font_string (!canvas2d1, font: string): void = "ext#%"
fun canvas2d_set_textAlign_string (!canvas2d1, value: string): void = "ext#%"
fun canvas2d_set_textBaseline_string (!canvas2d1, value: string): void = "ext#%"

(* ****** ****** *)

fun canvas2d_set_fillStyle_string (!canvas2d1, style: string): void = "ext#%"
fun canvas2d_set_strokeStyle_string (!canvas2d1, style: string): void = "ext#%"

(* ****** ****** *)
//
fun canvas2d_set_shadowColor (!canvas2d1, color: string): void = "ext#%"
//
symintr canvas2d_set_shadowBlur
fun canvas2d_set_shadowBlur_int (!canvas2d1, int): void = "ext#%"
fun canvas2d_set_shadowBlur_double (!canvas2d1, double): void = "ext#%"
overload canvas2d_set_shadowBlur with canvas2d_set_shadowBlur_int
overload canvas2d_set_shadowBlur with canvas2d_set_shadowBlur_double
//
symintr canvas2d_set_shadowOffsetX
symintr canvas2d_set_shadowOffsetY
fun canvas2d_set_shadowOffsetX_int (!canvas2d1, int): void = "ext#%"
fun canvas2d_set_shadowOffsetX_double (!canvas2d1, double): void = "ext#%"
fun canvas2d_set_shadowOffsetY_int (!canvas2d1, int): void = "ext#%"
fun canvas2d_set_shadowOffsetY_double (!canvas2d1, double): void = "ext#%"
overload canvas2d_set_shadowOffsetX with canvas2d_set_shadowOffsetX_int
overload canvas2d_set_shadowOffsetX with canvas2d_set_shadowOffsetX_double
overload canvas2d_set_shadowOffsetY with canvas2d_set_shadowOffsetY_int
overload canvas2d_set_shadowOffsetY with canvas2d_set_shadowOffsetY_double
//
(* ****** ****** *)

absvtype gradient_vtype = ptr
vtypedef gradient = gradient_vtype

fun canvas2d_createLinearGradient
(
  !canvas2d1
, x0: double, y0: double, x1: double, y1: double
) : gradient = "ext#%" // end-of-fun

fun canvas2d_gradient_free (gradient): void = "ext#%"

fun canvas2d_gradient_addColorStop
  (!gradient, stop: double, color: string): void = "ext#%"

fun canvas2d_set_fillStyle_gradient (!canvas2d1, style: !gradient): void = "ext#%"
fun canvas2d_set_strokeStyle_gradient (!canvas2d1, style: !gradient): void = "ext#%"

(* ****** ****** *)

(* end of [canvas2d.sats] *)
