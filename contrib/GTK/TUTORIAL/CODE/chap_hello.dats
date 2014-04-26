(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: April, 2014
**
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)
//
staload
"{$GLIB}/SATS/glib.sats"
//
staload
"{$GLIB}/SATS/glib-object.sats"
//
staload "{$GTK}/SATS/gtk.sats"
//
(* ****** ****** *)

%{^
typedef char **charpp ;
%} ;
abstype charpp = $extype"charpp"

(* ****** ****** *)

extern
fun window_create (): GtkWindow1
extern
fun button_create (): GtkButton1
extern
fun window_add_button (!GtkWindow1, !GtkButton1): void
extern
fun button_handle_clicked (!GtkButton1): void
extern
fun window_handle_destroy (!GtkWindow1): void
extern
fun window_handle_delete_event (!GtkWindow1): void

(* ****** ****** *)

fun
mymain
(
) : GtkWindow1 = let
//
val window = window_create ()
val button = button_create ()
//
val () = window_add_button (window, button)
//
val () = button_handle_clicked (button)
val () = window_handle_destroy (window)
val () = window_handle_delete_event (window)
//
val () = gtk_widget_show (window)
val () = gtk_widget_show_unref (button)
//
in
  window
end // end of [mymain]

(* ****** ****** *)

implement
window_create () = let
//
val widget =
  gtk_window_new (GTK_WINDOW_TOPLEVEL)
val ((*void*)) = assertloc (ptrcast(widget) > 0)
val ((*void*)) =
  gtk_window_set_title (widget, (gstring)"Hello, world!")
//
in
  widget
end // end of [window_create]

(* ****** ****** *)

implement
button_create () = let
//
val widget =
  gtk_button_new_with_label ((gstring)"Hello, world!")
//
val ((*void*)) = assertloc (ptrcast(widget) > 0)
//
in
  widget
end // end of [button_create]

(* ****** ****** *)

implement
window_add_button
  (window, button) = let
//
val () =
gtk_container_set_border_width (window, (guint)10)
//
in
//
gtk_container_add (window, button)
//
end (* end of [window_add_button] *)

(* ****** ****** *)

implement
button_handle_clicked
  (button) = () where
{
//
fun f (): void = println! ("Hello, world!")
//
val id =
g_signal_connect
(
  button, (gsignal)"clicked", G_CALLBACK(f), (gpointer)NULL
) (* end of [val] *)
//
} (* end of [button_handle_clicked] *)

(* ****** ****** *)

implement
window_handle_destroy
  (window) = () where
{
//
val id =
g_signal_connect
(
  window, (gsignal)"destroy", G_CALLBACK(gtk_main_quit), (gpointer)NULL
) (* end of [val] *)
//
} (* end of [window_handle_destroy] *)

(* ****** ****** *)

implement
window_handle_delete_event
  (window) = () where
{
//
fun f (x: GtkWindow1): gboolean =
  let val () = gtk_widget_destroy0 (x) in GTRUE end
//
val id =
g_signal_connect
(
  window, (gsignal)"delete-event", G_CALLBACK(f), (gpointer)NULL
) (* end of [val] *)
//
} (* end of [window_handle_delete_event] *)

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var argc: int = argc
var argv: charpp = $UN.castvwtp1{charpp}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
val window = mymain ()
//
val ((*void*)) = gtk_main ()
//
val ((*void*)) = gtk_widget_destroy0 (window) // a type-error if omitted
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [chap_hello.dats] *)
