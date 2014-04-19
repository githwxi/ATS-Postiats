(*
**
** A simple GTK example
** involving textview and textbuffer
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: April 18, 2014
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

fun fdestroy
(
  widget: GtkWidget1
) : void = let
//
(*
val () =
println! ("This is from [fdestroy]!")
*)
val () = gtk_widget_destroy0 (widget)
//
in
  gtk_main_quit ()
end (* end of [fdestroy] *)

(* ****** ****** *)

fun fdelete_event
(
  widget: !GtkWidget1
, event: &GdkEvent, udata: gpointer
) : gboolean = let
(*
  val () = println! ("This is from [fdelete_event]!")
*)
in
  GFALSE // deletion to be performed
end // end of [fdelete_event]

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
val () = gtk_window_set_title (window, gstring("Hello, MyTextView!"))
val _sid = g_signal_connect
(
  window, (gsignal)"destroy", (G_CALLBACK)fdestroy, (gpointer)nullp
) // end of [val]
val _sid = g_signal_connect
(
  window, (gsignal)"delete_event", (G_CALLBACK)fdelete_event, (gpointer)nullp
) // end of [val]
//
val () =
gtk_window_set_position (window, GTK_WIN_POS_CENTER)
val () = gtk_window_set_resizable (window, GTRUE)
val () = gtk_container_set_border_width (window, (guint)10)
//
val win2 =
gtk_scrolled_window_new_null ((*void*))
val () = assertloc (ptrcast(win2) > 0)
val () =
gtk_widget_set_size_request (win2, (gint)640, (gint)400)
val () = gtk_container_add (window, win2)
//
val tv = gtk_text_view_new ()
val () = assertloc (ptrcast(tv) > 0)
val () = gtk_container_add (win2, tv)
val () = gtk_text_view_set_wrap_mode (tv, GTK_WRAP_WORD)
val () = gtk_widget_show_unref (tv)
//
val () = gtk_widget_show_unref (win2) // ref-count becomes 1!
val () = gtk_widget_show_unref (window) // ref-count becomes 1!
//
val () = gtk_main ((*void*))
//
} // end of [main0]

(* ****** ****** *)

(* end of [test_textview.dats] *)
