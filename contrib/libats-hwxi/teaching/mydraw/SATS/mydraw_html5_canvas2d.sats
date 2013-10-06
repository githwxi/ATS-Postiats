(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2013-10:
// A drawing interface based on html5-canvas-2d
// which itself is based on cairo
//
(* ****** ****** *)

(*
** Author: Will Blair
** Authoremail: wdblairATgmailDOTcom
*)
(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.libats-hwxi.teaching.mydraw"

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_libatshwxi_" // prefix for external names

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

absvtype canvas2d_vtype (l:addr) = ptr (l)

(* ****** ****** *)

vtypedef canvas2d (l:addr) = canvas2d_vtype (l)
vtypedef canvas2d0 = [l:agez] canvas2d (l)
vtypedef canvas2d1 = [l:addr | l > null] canvas2d (l)

(* ****** ****** *)
//
fun{
} mydraw_get0_canvas2d (
) : [l:agz] vttakeout0 (canvas2d (l))
//
fun{} mydraw_get1_canvas2d (): canvas2d1
//
(* ****** ****** *)

fun
canvas2d_make (id: string): canvas2d0 = "mac#%"
fun
canvas2d_free (canvas: canvas2d0): void = "mac#%"

(* ****** ****** *)

fun
canvas2d_clearRect
(
  !canvas2d1
, x: double, y: double, wd: double, ht: double
) : void = "mac#%" // endfun

(* ****** ****** *)

fun
canvas2d_beginPath (!canvas2d1): void = "mac#%"
fun
canvas2d_closePath (!canvas2d1): void = "mac#%"

(* ****** ****** *)
//
fun canvas2d_moveTo
  (!canvas2d1, x: double, y: double): void = "mac#%"
//
fun canvas2d_lineTo
  (!canvas2d1, x: double, y: double): void = "mac#%"
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
) : void = "mac#%"

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
, anticlockwise : bool
) : void = "mac#%"

(* ****** ****** *)

fun canvas2d_fill (!canvas2d1): void = "mac#%"
fun canvas2d_stroke (!canvas2d1): void = "mac#%"

(* ****** ****** *)

fun
canvas2d_translate
  (!canvas2d1, x: double, y: double): void = "mac#%"
fun
canvas2d_scale (!canvas2d1, sx: double, sy: double): void = "mac#%"
fun
canvas2d_rotate (!canvas2d1, angle: double): void = "mac#%"

(* ****** ****** *)
//
absview canvas2d_save_v (l:addr)
//
fun
canvas2d_save{l:agz}
  (canvas: !canvas2d l): (canvas2d_save_v l | void) = "mac#%"
fun
canvas2d_restore{l:agz}
  (pf: canvas2d_save_v l | canvas: canvas2d l): void = "mac#%"
//
(* ****** ****** *)

(* end of [mydraw_html5_canvas2d.sats] *)
