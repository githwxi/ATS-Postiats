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

#define ATS_DYNLOADFLAG 0

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
staload "./DrawingPanel.dats"

(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)
//
extern
fun{
} on_destroy
  (widget: !GtkWidget1, event: &GdkEvent, _: gpointer): void
extern
fun{
} on_delete_event
  (widget: !GtkWidget1, event: &GdkEvent, _: gpointer): gboolean
//
(* ****** ****** *)
//
implement{
} on_destroy (widget, event, _) = ((*void*))
implement{
} on_delete_event (widget, event, _) = (gtk_main_quit (); GTRUE)
//
(* ****** ****** *)

staload
TOPWIN = "./the_topwin.dats"

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
val p_win0 = ptrcast(win0)
val () = assertloc (p_win0 > 0)
//
val () = $TOPWIN.set (p_win0)
val () = gtk_window_set_default_size (win0, (gint)600, (gint)400)
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
val hbox1 =
gtk_box_new
(
  GTK_ORIENTATION_HORIZONTAL(*orient*), (gint)0(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (hbox1) > 0)
//
val CP = ControlPanel_make ()
val () =
gtk_box_pack_start
(
  hbox1, CP, GFALSE, GFALSE, (guint)2
) (* end of [val] *)
val () = g_object_unref (CP)
//
val VS =
gtk_separator_new (GTK_ORIENTATION_VERTICAL)
val () = assertloc (ptrcast (VS) > 0)
val () =
gtk_box_pack_start
(
  hbox1, VS, GFALSE, GFALSE, (guint)2
) (* end of [val] *)
val () = g_object_unref (VS)
//
val DP = DrawingPanel_make ()
val () =
gtk_box_pack_start
(
  hbox1, DP, GTRUE (*expand*), GTRUE (*fill*), (guint)2
) (* end of [val] *)
val () = g_object_unref (DP)
//
val () = gtk_container_add (win0, hbox1)
val () = g_object_unref (hbox1)
//
val _sid = g_signal_connect
(
  win0, (gsignal)"destroy", G_CALLBACK(on_destroy), (gpointer)NULL
)
val _sid = g_signal_connect
(
  win0, (gsignal)"delete-event", G_CALLBACK(on_delete_event), (gpointer)NULL
)
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
