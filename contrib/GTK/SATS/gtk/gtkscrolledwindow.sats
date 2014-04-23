(*
** source: gtkscrolledwindow.h
*)

(* ****** ****** *)

fun
gtk_scrolled_window_new_null
(
// HX: argumentless function
) : gobjref0(GtkScrolledWindow) = "mac#%"

(* ****** ****** *)

fun
gtk_scrolled_window_new
(
  hadj: !GtkAdjustment0
, vadj: !GtkAdjustment0
) : gobjref0(GtkScrolledWindow) = "mac#%"

(* ****** ****** *)
//
fun
gtk_scrolled_window_get_hadjustment
  {l:agz} (sw: !GtkScrolledWindow(l)): [l2:agez]
(
  minus (GtkScrolledWindow(l), GtkAdjustment(l2)) | GtkAdjustment(l2)
) = "mac#%" // end of [gtk_scrolled_window_get_hadjustment]
fun
gtk_scrolled_window_get_vadjustment
  {l:agz} (sw: !GtkScrolledWindow(l)): [l2:agez]
(
  minus (GtkScrolledWindow(l), GtkAdjustment(l2)) | GtkAdjustment(l2)
) = "mac#%" // end of [gtk_scrolled_window_get_vadjustment]
//
(* ****** ****** *)
//
fun
gtk_scrolled_window_set_hadjustment
  (sw: !GtkScrolledWindow1, adj: !GtkAdjustment0): void = "mac#%"
fun
gtk_scrolled_window_set_vadjustment
  (sw: !GtkScrolledWindow1, adj: !GtkAdjustment0): void = "mac#%"
//
(* ****** ****** *)

(* end of [gtkscrolledwindow.sats] *)
