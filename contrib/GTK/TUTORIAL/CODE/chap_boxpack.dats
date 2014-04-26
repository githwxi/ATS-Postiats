(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: April, 2014
**
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
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
fun window_handle_destroy (!GtkWindow1): void
extern
fun window_handle_delete_event (!GtkWindow1): void

(* ****** ****** *)

local

val row0 = $list{string}("1", "2", "3")
val row0 = g0ofg1 (row0)
val row1 = $list{string}("4", "5", "6")
val row1 = g0ofg1 (row1)
val row2 = $list{string}("7", "8", "9")
val row2 = g0ofg1 (row2)
val row3 = g0ofg1_list ($list{string}("0"))

fun
button_create
(
  msg: SHR(string)
) : GtkButton1 = let
//
val res =
gtk_button_new_with_label ((gstring)msg)
//
fun f
(
  button: !GtkButton1, udata: gpointer
) : void = println! ($UN.cast{string}(udata))
//
val ((*void*)) = assertloc (ptrcast (res) > 0)
//
val id =
g_signal_connect
(
  res, (gsignal)"clicked", G_CALLBACK(f), $UN.cast{gpointer}(msg)
) (* end of [val] *)
//
in
  res
end // end of [button_create]

fun row_create
(
  xs: list0(string)
) : GtkBox1 = let
//
fun loop
(
  box: !GtkBox1, xs: list0(string)
) : void =
  case+ xs of
  | nil0 () => ()
  | cons0 (x, xs) => let
      val btn = button_create (x)
      val () = gtk_box_pack_start (box, btn, GTRUE, GTRUE, (guint)0)
      val () = gtk_widget_show_unref (btn)
    in
      loop (box, xs)
    end // end of [cons0]
//
val hbox =
gtk_box_new
(
  GTK_ORIENTATION_HORIZONTAL, (gint)0
) (* end of [val] *)
val () = assertloc (ptrcast(hbox) > 0)
//
val () = loop (hbox, xs)
//
in
  hbox
end // end of [row_create]

in (* in-of-local *)

fun
thePanel_create (): GtkBox1 = let
//
val vbox =
gtk_box_new
(
  GTK_ORIENTATION_VERTICAL, (gint)0
) (* end of [val] *)
val () = assertloc (ptrcast(vbox) > 0)
//
val row0 = row_create (row0)
val () = gtk_box_pack_start (vbox, row0, GTRUE, GTRUE, (guint)0)
val () = gtk_widget_show_unref (row0)
//
val row1 = row_create (row1)
val () = gtk_box_pack_start (vbox, row1, GTRUE, GTRUE, (guint)0)
val () = gtk_widget_show_unref (row1)
//
val row2 = row_create (row2)
val () = gtk_box_pack_start (vbox, row2, GTRUE, GTRUE, (guint)0)
val () = gtk_widget_show_unref (row2)
//
val row3 = row_create (row3)
val () = gtk_box_pack_start (vbox, row3, GTRUE, GTRUE, (guint)0)
val () = gtk_widget_show_unref (row3)
//
in
  vbox
end // end of [thePanel_create]

end // end of [local]

(* ****** ****** *)

fun
mymain
(
) : GtkWindow1 = let
//
val window = window_create ()
//
val thePanel = thePanel_create ()
//
val () = gtk_container_add (window, thePanel)
val () = gtk_container_set_border_width (window, (guint)10)
val () = gtk_widget_show_unref (thePanel)
//
val () = window_handle_destroy (window)
val () = window_handle_delete_event (window)
//
val () = gtk_widget_show (window)
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
  gtk_window_set_default_size (widget, (gint)400, (gint)240)
val ((*void*)) =
  gtk_window_set_title (widget, (gstring)"Panel-of-Digits")
//
in
  widget
end // end of [window_create]

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

(* end of [chap_boxpack.dats] *)
