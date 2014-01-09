(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
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
// HX-2013-09:
// A simple GTK/cairo-package
// for implementing something like slide presentation
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)
//
fun{
} gtkcairoslide_main (): void
//
fun{
} gtkcairoslide_title (): stropt
fun{
} gtkcairoslide_timeout_update (): void
fun{
} gtkcairoslide_timeout_interval (): uint
//
fun{
} gtkcairoslide_myshow
  (cr: !cairo_ref1, width: int, height: int): void
//
(* ****** ****** *)

(* end of [gtkcairoslide.sats] *)
