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
  {c:cls |
   c <= GtkWindow}
  {l:agz}
(
  win: !gobjref (c, l)
) : [l2:addr]
(
  minus(gobjref(c, l), gstrptr l2) | gstrptr l2
) = "mac#%" // endfun

fun gtk_window_set_title
  (!GtkWindow1, title: gstring): void = "mac#%"
// end of [gtk_window_set_title]

(* ****** ****** *)

fun gtk_window_set_position
  (!GtkWindow1, pos: GtkWindowPosition): void = "mac#%"
// end of [gtk_window_set_position]

(* ****** ****** *)

fun gtk_window_get_size
(
  win: !GtkWindow1
, width: &gint? >> gint, height: &gint? >> gint
) : void = "mac#%" // endfun

(* ****** ****** *)

fun gtk_window_resize
  (!GtkWindow1, width: gint, height: gint): void = "mac#%"
// end of [gtk_window_resize]

(* ****** ****** *)
//
// HX-2010:
// [width = -1] means unset
// [height = -1] means unset
//
fun gtk_window_set_default_size
  (!GtkWindow1, width: gint, height: gint): void = "mac#%"
// end of [gtk_window_set_default_size]

fun gtk_window_get_default_size
  (!GtkWindow1, width: &gint? >> _, height: &gint? >> _): void = "mac#%"
// end of [gtk_window_get_default_size]

(* ****** ****** *)
//
fun gtk_window_get_resizable
  (!GtkWindow1): gboolean = "mac#%"
fun gtk_window_set_resizable
  (!GtkWindow1, resizable: gboolean): void = "mac#%"
//
(* ****** ****** *)

fun gtk_window_set_transient_for
  (window: !GtkWindow1, parent: !GtkWindow1): void = "mac#%"
// end of [gtk_window_set_transient_for]

(* ****** ****** *)

(* end of [gtkwindow.sats] *)
