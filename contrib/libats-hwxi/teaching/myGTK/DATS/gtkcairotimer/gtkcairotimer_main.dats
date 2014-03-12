(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
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
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$GTK}/SATS/gdk.sats"
staload "{$GTK}/SATS/gtk.sats"
staload "{$GLIB}/SATS/glib.sats"
staload "{$GLIB}/SATS/glib-object.sats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)
//
staload "./../../SATS/gtkcairotimer.sats"
//
(* ****** ****** *)
//
implement{}
gtkcairotimer_title () = stropt_none()
//
implement{}
gtkcairotimer_timeout_update () = ((*void*))
//
(* ****** ****** *)

staload "./ControlPanel.dats"

(* ****** ****** *)

implement{}
gtkcairotimer_main
  ((*void*)) = () where
{
//
val win0 =
  gtk_window_new (GTK_WINDOW_TOPLEVEL)
//
val win0 = win0 // HX: fix the master type
//
val () = assertloc (ptrcast(win0) > 0)
val () = gtk_window_set_default_size (win0, (gint)400, (gint)400)
//
val opt = gtkcairotimer_title ()
val issome = stropt_is_some(opt)
val () =
if issome then let
  val title = stropt_unsome (opt)
in
  gtk_window_set_title (win0, gstring(title))
end // end of [if] // end of [val]
//
val CP = ControlPanel_make ()
val () = gtk_container_add (win0, CP)
val () = g_object_unref (CP)
//
val () = gtk_widget_show_all (win0)
//
val () = g_object_unref (win0) // HX: refcount of [win0] decreases from 2 to 1
//
val ((*void*)) = gtk_main ((*void*))
//
} (* end of [gtkcairotimer_main] *)

(* ****** ****** *)

(* end of [gtkcairotimer_main.dats] *)
