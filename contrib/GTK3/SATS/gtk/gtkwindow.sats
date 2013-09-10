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
fun gtk_window_new (GtkWindowType): GtkWindow0 = "mac#%"
fun gtk_window_new1 (GtkWindowType): GtkWindow1 = "mac#%"
//
(* ****** ****** *)

(* end of [gtkwindow.sats] *)
