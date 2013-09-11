(*
**
** A simple GTK example
** one button in a window
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Start Time: April, 2010
**
*)
(*
**
** Ported to ATS2
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: September, 2013
**
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "{$GLIB}/SATS/glib.sats"

(* ****** ****** *)

staload "./../SATS/gdk.sats"
staload "./../SATS/gtk.sats"
staload "{$GLIB}/SATS/glib-object.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

fun
fcallback
(
  widget: !GtkWidget1, data: string
) : void =
(
  println! ("Hello again: ", data, " was pressed")
) // end of [fcallback]

fun fdelete_event
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : gboolean = let
  val () = println! ("This is from [fdelete_event]!")
in
  GFALSE // deletion to be performed
end // end of [fdelete_event]

fun fdestroy
(
  widget: GtkWidget1
) : void = let
//
val () =
println! ("This is from [fdestroy]!")
val () = gtk_widget_destroy0 (widget)
//
in
  gtk_main_quit ()
end (* end of [fdestroy] *)

(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

implement
main0 (argc, argv) = () where
{
//
var argc: int = argc
var argv: charptrptr = $UN.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
val window =
  gtk_window_new (GTK_WINDOW_TOPLEVEL)
val () = assertloc (ptrcast(window) > 0)
val () = gtk_window_set_title (window, gstring("Hello Buttons!"))
val _sid = g_signal_connect
(
  window, (gsignal)"destroy", (G_CALLBACK)fdestroy, (gpointer)nullp
) // end of [val]
val _sid = g_signal_connect
(
  window, (gsignal)"delete_event", (G_CALLBACK)fdelete_event, (gpointer)nullp
) // end of [val]
//
val () = gtk_container_set_border_width (window, (guint)10)
//
val table =
gtk_table_new ((guint)2, (guint)2, GTRUE)
val () = assertloc (ptrcast(table) > 0)
val () = gtk_container_add (window, table)
//
val button = gtk_button_new_with_label (gstring("Button 1"))
val () = assertloc (ptrcast(button) > 0)
val _ = g_signal_connect
(
  button, (gsignal)"clicked", G_CALLBACK(fcallback), $UN.cast{gpointer}"button 1"
)
val () = gtk_table_attach_defaults (table, button, (guint)0, (guint)1, (guint)0, (guint)1)
val () = gtk_widget_show_unref (button)
//
val button = gtk_button_new_with_label (gstring("Button 2"))
val () = assertloc (ptrcast(button) > 0)
val _ = g_signal_connect
(
  button, (gsignal)"clicked", G_CALLBACK(fcallback), $UN.cast{gpointer}"button 2"
)
val () = gtk_table_attach_defaults (table, button, (guint)1, (guint)2, (guint)0, (guint)1)
val () = gtk_widget_show_unref (button)
//
val button = gtk_button_new_with_mnemonic (gstring("_Q_u_i_t"))
val () = assertloc (ptrcast(button) > 0)
val _ = g_signal_connect_swapped (button, (gsignal)"clicked", G_CALLBACK(fdestroy), window)
val () = gtk_table_attach_defaults (table, button, (guint)0U, (guint)2U, (guint)1U, (guint)2U)
val () = gtk_widget_show_unref (button)
//
val () = gtk_widget_show_unref (table)
val () = gtk_widget_show_unref (window) // ref-count becomes 1!
//
val () = gtk_main ()
//
} // end of [main0]

(* ****** ****** *)

(* end of [test03.dats] *)
