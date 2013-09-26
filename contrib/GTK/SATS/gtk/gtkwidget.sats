(*
** source: gtkwidget.h
*)

(* ****** ****** *)

typedef
GtkAllocation =
$extype_struct"GtkAllocation" of
{
  x= gint, y= gint, width= gint, height= gint
} (* end of [GtkAllocation] *)

(* ****** ****** *)

fun gtk_widget_show (!GtkWidget1): void = "mac#%"
fun gtk_widget_show_unref (x: GtkWidget1): void = "mac#%"

(* ****** ****** *)

fun gtk_widget_show_now (!GtkWidget1): void = "mac#%"
fun gtk_widget_show_all (!GtkWidget1): void = "mac#%"

(* ****** ****** *)

fun gtk_widget_destroy (!GtkWidget0): void = "mac#%"
fun gtk_widget_destroy0 (x: GtkWidget0): void = "mac#%"

(* ****** ****** *)
//
// HX-2010-04-18:
// it gets GDK window!
// this is probably safe enough :)
//
fun
gtk_widget_get_window
  {c:cls |
   c <= GtkWidget}
  {l:agz} (
  widget: !gobjref (c, l)
) : [l2:addr] (
  minus (gobjref (c, l), gobjref (GdkWindow, l2)) | gobjref (GdkWindow, l2)
) = "mac#%" // endfun
  
(* ****** ****** *)
//
fun
gtk_widget_get_allocated_width (!GtkWidget1): int = "mac#%"
fun
gtk_widget_get_allocated_height (!GtkWidget1): int = "mac#%"
//
(* ****** ****** *)

fun
gtk_widget_get_allocation
(
  !GtkWidget1, alloc: &GtkAllocation? >> GtkAllocation
) : void = "mac#%" // endfun

fun
gtk_widget_set_allocation
  (widget: !GtkWidget1, alloc: &GtkAllocation): void = "mac#%"
// end of [gtk_widget_set_allocation]

(* ****** ****** *)

(*
//
// HX: this is only available in GTK2; it is a poor idea anyways
//
fun
gtk_widget_getref_allocation
  {c:cls |
   c <= GtkWidget}
  {l:agz} (
  widget: !gobjref (c, l)
) : [l2:addr] (
  GtkAllocation @ l2
, minus (gobjref (c, l), GtkAllocation @ l2) | ptr l2
) = "mac#%" // endfun
*)

(* ****** ****** *)

fun
gtk_widget_queue_draw_area
(
  widget: !GtkWidget1, x: gint, y: gint, width: gint, height: gint
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [gtkwidget.sats] *)
