(*
** source: gtkwindow.h
*)

(* ****** ****** *)

fun GTK_IS_WINDOW
  {c:cls | c <= GObject}
  (x: !gobjref1 (c)) : bool (c <= GtkWindow) = "mac#%"
// end of [GTK_IS_WINDOW]

(* ****** ****** *)
//
// HX-2011-10:
// the ref-count of the created window is 2!
//
fun gtk_window_new
  (GtkWindowType): gobjref0(GtkWindow) = "mac#%"
fun gtk_window_new1
  (GtkWindowType): gobjref1(GtkWindow) = "mac#%"
//
(* ****** ****** *)

fun gtk_window_get_title
  {l1:agz}
(
  window: !GtkWindow(l1)
) : [l2:addr]
(
  minus (GtkWindow(l1), gstrptr l2) | gstrptr l2
) = "mac#%" // endfun

fun gtk_window_set_title
  (!GtkWindow1, title: gstring): void = "mac#%"
// end of [gtk_window_set_title]

(* ****** ****** *)

(* end of [gtkwindow.sats] *)
