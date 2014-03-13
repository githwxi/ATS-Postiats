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

#define NULL the_null_ptr

(* ****** ****** *)

fun{}
draw_drawingarea
(
  darea: !GtkDrawingArea1
) : void = let
//
val (
  fpf_win | win
) = gtk_widget_get_window (darea)
//
val isnot = g_object_isnot_null (win)
//
in
//
if isnot then let
  val cr = gdk_cairo_create (win)
  prval () = minus_addback (fpf_win, win | darea)
  var alloc: GtkAllocation?
  val () = gtk_widget_get_allocation (darea, alloc)
  val () = gtkcairotimer_mydraw<> (cr, gint2int(alloc.width), gint2int(alloc.height))
  val () = cairo_destroy (cr)
in
  // nothing
end else let
  prval () = minus_addback (fpf_win, win | darea)
in
  // nothing
end (* end of [if] *)
//
end // end of [draw_drawingarea]

(* ****** ****** *)

extern
fun{} fexpose (!GtkDrawingArea1): gboolean

(* ****** ****** *)

implement{
} fexpose (darea) = let
  val () = draw_drawingarea (darea) in GFALSE
end // end of [fexpose]

(* ****** ****** *)

extern
fun{} ftimeout (!GtkDrawingArea1): gboolean
implement{
} ftimeout (darea) = let
//
val (
) = gtkcairotimer_timeout_update ()
//
val (fpf_win | win) = gtk_widget_get_window (darea)
//
val isnot = g_object_isnot_null (win) 
//
prval () = minus_addback (fpf_win, win | darea)
//
in
//
if isnot then let
  var alloc: GtkAllocation
  val () = gtk_widget_get_allocation (darea, alloc)
  val () = gtk_widget_queue_draw_area (darea, (gint)0, (gint)0, alloc.width, alloc.height)
in
  GTRUE // HX: [ftimeout] continues
end else
  GFALSE // HX: [ftimeout] is unregistered
// end of [if]
//
end // end of [ftimeout]

(* ****** ****** *)

extern
fun{}
DrawingPanel_make (): gobjref1(GtkBox)

(* ****** ****** *)

implement{
} DrawingPanel_make () = let
//
val vbox0 =
gtk_box_new
(
  GTK_ORIENTATION_VERTICAL(*orient*), (gint)10(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (vbox0) > 0)
//
val hbox1 =
gtk_box_new
(
  GTK_ORIENTATION_HORIZONTAL(*orient*), (gint)0(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (hbox1) > 0)
val () =
gtk_box_pack_start (vbox0, hbox1, GFALSE, GFALSE, (guint)0)
val () = g_object_unref (hbox1)
//
val darea2 =
gtk_drawing_area_new ((*void*))
val p_darea2 = ptrcast (darea2)
val () = assertloc (p_darea2 > 0)
val () =
gtk_box_pack_start (vbox0, darea2, GTRUE(*expand*), GTRUE(*fill*), (guint)0)
val _sid = g_signal_connect
(
  darea2, (gsignal)"draw", G_CALLBACK(fexpose), (gpointer)NULL
)
val int = gtkcairotimer_timeout_interval ()
val _rid = g_timeout_add ((guint)int, (GSourceFunc)ftimeout, (gpointer)p_darea2)
val () = g_object_unref (darea2)
//
val hbox3 =
gtk_box_new
(
  GTK_ORIENTATION_HORIZONTAL(*orient*), (gint)0(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (hbox3) > 0)
val () =
gtk_box_pack_start (vbox0, hbox3, GFALSE, GFALSE, (guint)0)
val () = g_object_unref (hbox3)
//
in
  vbox0
end // end of [DrawingPanel_make]

(* ****** ****** *)

(* end of [DrawingPanel.dats] *)
