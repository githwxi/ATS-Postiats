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

fun gtk_window_get_size
(
  win: !GtkWindow1
, width: &gint? >> gint, height: &gint? >> gint
) : void = "mac#%" // endfun

(* ****** ****** *)
//
// HX-2010:
// [width = -1] means unset
// [height = -1] means unset
//
fun gtk_window_set_default_size
  (!GtkWindow1, width: gint, height: gint): void = "mac#%"
// end of [gtk_window_set_default_size]

(* ****** ****** *)

(* end of [gtkwindow.sats] *)
