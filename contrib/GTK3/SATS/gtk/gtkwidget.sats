(*
** source: gtkwidget.h
*)

(* ****** ****** *)

fun gtk_widget_show
  {c:cls | c <= GtkWidget} (!gobjref0 (c)): void = "mac#%"
// end of [gtk_widget_show]

(* ****** ****** *)

fun gtk_widget_destroy
  {c:cls | c <= GtkWidget} (!gobjref0 (c)): void = "mac#%"
// end of [gtk_widget_destroy]
fun gtk_widget_destroy0
  {c:cls | c <= GtkWidget} (x: gobjref0 (c)): void = "mac#%"
// end of [gtk_widget_destroy0]

(* ****** ****** *)

(* end of [gtkwidget.sats] *)
