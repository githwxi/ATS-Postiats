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
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$GTK}/SATS/gdk.sats"
staload "{$GTK}/SATS/gtk.sats"
staload "{$GLIB}/SATS/glib.sats"
staload "{$GLIB}/SATS/glib-object.sats"
staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

staload "./../SATS/gtkcairoclock.sats"

(* ****** ****** *)

implement{}
gtkcairoclock_title () = stropt_none ()

implement{
} gtkcairoclock_ntimeout_update () = ()

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
  val () = gtkcairoclock_mydraw<> (cr, gint2int(alloc.width), gint2int(alloc.height))
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
extern
fun{} ftimeout (!GtkDrawingArea1): gboolean

(* ****** ****** *)

implement{
} fexpose (darea) = let
  val () = draw_drawingarea (darea) in GFALSE
end // end of [fexpose]

(* ****** ****** *)

implement{
} ftimeout (darea) = let
//
val (
) = gtkcairoclock_ntimeout_update ()
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

#define nullp the_null_ptr

(* ****** ****** *)

implement{}
gtkcairoclock_main
  ((*void*)) = () where
{
//
val win0 =
  gtk_window_new (GTK_WINDOW_TOPLEVEL)
val win0 = win0
val () = assertloc (ptrcast(win0) > 0)
val () = gtk_window_set_default_size (win0, (gint)400, (gint)400)
//
val opt = gtkcairoclock_title ()
val issome = stropt_is_some(opt)
//
val () =
if issome then let
  val title = stropt_unsome (opt)
in
  gtk_window_set_title (win0, gstring(title))
end // end of [if] // end of [val]
//
val darea =
  gtk_drawing_area_new ()
val p_darea = gobjref2ptr (darea)
val () = assertloc (p_darea > 0)
val () = gtk_container_add (win0, darea)
//
val _sid = g_signal_connect
(
  darea, (gsignal)"draw", G_CALLBACK(fexpose), (gpointer)nullp
)
val () = g_object_unref (darea)
//
val _sid = g_signal_connect
(
  win0, (gsignal)"delete-event", G_CALLBACK(gtk_main_quit), (gpointer)nullp
)
val _sid = g_signal_connect
(
  win0, (gsignal)"destroy-event", G_CALLBACK(gtk_widget_destroy), (gpointer)nullp
)
//
val int =
  gtkcairoclock_timeout_interval ()
val _rid = g_timeout_add ((guint)int, (GSourceFunc)ftimeout, (gpointer)p_darea)
//
val () = gtk_widget_show_all (win0)
//
val () = g_object_unref (win0) // HX: refcount of [win0] decreases from 2 to 1
//
val ((*void*)) = gtk_main ((*void*))
//
} // end of [gtkcairoclock_main]

(* ****** ****** *)

(* end of [gtkcairoclock.dats] *)
