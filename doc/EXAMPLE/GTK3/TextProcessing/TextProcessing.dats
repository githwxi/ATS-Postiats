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
//
// This is meant to be used in
// an implementation of the Enigma machine
//
(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "{$GLIB}/SATS/glib.sats"

(* ****** ****** *)

staload "{$GTK}/SATS/gdk.sats"
staload "{$GTK}/SATS/gtk.sats"
staload "{$GLIB}/SATS/glib-object.sats"

(* ****** ****** *)

#define NULL the_null_ptr
staload "./TextProcessing_toplevel.dats"

(* ****** ****** *)

fun
fdestroy
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

fun
fdelete_event
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
//
fun
on_key_press_event
(
  wdgt: !GtkWidget1
, event: &GdkEvent, udate: gpointer
) : gboolean =
  let val () = $KEYPRESSED.inc () in GFALSE end
//
(* ****** ****** *)

extern
fun TextProcessing (string): Strptr1

(* ****** ****** *)

implement
TextProcessing
  (str) = let
//
val [n:int] str = g1ofg0 (str)
//
local
//
implement
string_tabulate$fopr<>
  (i) = $UN.cast{charNZ}(c2) where
{
  val c = str[$UN.cast{sizeLt(n)}(i)]
  var c2: char = c
  val () = if islower(c) then c2 := toupper(c)  
  val () = if isupper(c) then c2 := tolower(c)  
}
//
in
val str2 = string_tabulate<> (length(str))
end // end of [local]
//
prval ((*void*)) = lemma_strnptr_param (str2)
//
in
  strnptr2strptr(str2)
end // end of [TextProcessing]

(* ****** ****** *)

fun
ftimeout
  (): gboolean = let
//
val tb = $TEXTBUF.get ()
val tb = $UN.castvwtp0{GtkTextBuffer1}(tb)
//
var iter_beg : GtkTextIter
var iter_end : GtkTextIter
val () = gtk_text_buffer_get_start_iter(tb, iter_beg)
val () = gtk_text_buffer_get_end_iter(tb, iter_end)
//
val content =
  gtk_text_buffer_get_text (tb, iter_beg, iter_end, GTRUE)
val content2 = TextProcessing ($UN.castvwtp1{string}(content))
val () = gstrptr_free (content)
//
prval () = $UN.cast2void (tb)
//
val tb2 = $TEXTBUF2.get ()
val tb2 = $UN.castvwtp0{GtkTextBuffer1}(tb2)
val () = gtk_text_buffer_setall_text (tb2, $UN.castvwtp1{gstring}(content2))
val () = $KEYPRESSED.reset ()
//
prval () = $UN.cast2void (tb2)
//
val () = strptr_free (content2)
//
in
  GTRUE
end (* end of [ftimeout] *)

(* ****** ****** *)
//
fun
ftimeout2 (): gboolean =
  if $KEYPRESSED.get () > 0 then ftimeout () else (GTRUE)
//
(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)

dynload "./TextProcessing_toplevel.dats"

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
val p_window = ptrcast(window)
val () = assertloc (p_window > 0)
val () = $TOPWIN.set (p_window)
val () = gtk_window_set_title (window, gstring("TextProcessing"))
val _sid = g_signal_connect
(
  window, (gsignal)"destroy", (G_CALLBACK)fdestroy, (gpointer)NULL
) // end of [val]
val _sid = g_signal_connect
(
  window, (gsignal)"delete_event", (G_CALLBACK)fdelete_event, (gpointer)NULL
) // end of [val]
//
val () =
gtk_window_set_position (window, GTK_WIN_POS_CENTER)
val () = gtk_window_set_resizable (window, GTRUE)
val () = gtk_container_set_border_width (window, (guint)10)
//
val hbox =
gtk_box_new (GTK_ORIENTATION_HORIZONTAL, (gint)0)
val () = assertloc (ptrcast(hbox) > 0)
val () = gtk_container_add (window, hbox)
//
val swin =
gtk_scrolled_window_new_null ((*void*))
val () = assertloc (ptrcast(swin) > 0)
val () = gtk_widget_set_size_request (swin, (gint)320, (gint)400)
val () = gtk_box_pack_start (hbox, swin, GTRUE, GTRUE, (guint)4)
//
val swin2 =
gtk_scrolled_window_new_null ((*void*))
val () = assertloc (ptrcast(swin2) > 0)
val () = gtk_widget_set_size_request (swin2, (gint)320, (gint)400)
val () = gtk_box_pack_start (hbox, swin2, GTRUE, GTRUE, (guint)4)
//
val tv = gtk_text_view_new ()
val p_tv = ptrcast(tv)
val () = assertloc (p_tv > 0)
//
val (fpf | tb) = gtk_text_view_get_buffer (tv)
val () = $TEXTBUF.set (ptrcast(tb))
prval () = minus_addback (fpf, tb | tv)
//
val () = gtk_container_add (swin, tv)
val () = gtk_text_view_set_editable (tv, GTRUE)
val () = gtk_text_view_set_wrap_mode (tv, GTK_WRAP_WORD)
val () = gtk_widget_show_unref (tv)
//
val tv2 = gtk_text_view_new ()
val p_tv2 = ptrcast(tv2)
val () = assertloc (p_tv2 > 0)
//
val (fpf | tb2) = gtk_text_view_get_buffer (tv2)
val () = $TEXTBUF2.set (ptrcast(tb2))
prval () = minus_addback (fpf, tb2 | tv2)
//
val () = gtk_container_add (swin2, tv2)
val () = gtk_text_view_set_editable (tv2, GFALSE)
val () = gtk_text_view_set_cursor_visible (tv2, GFALSE)
val () = gtk_text_view_set_wrap_mode (tv2, GTK_WRAP_WORD)
val () = gtk_widget_show_unref (tv2)
//
val _sid = g_signal_connect
(
  window, (gsignal)"key-press-event", G_CALLBACK(on_key_press_event), (gpointer)NULL
)
//
val () = gtk_widget_show_unref (swin)
val () = gtk_widget_show_unref (swin2)
val () = gtk_widget_show_unref (hbox)
val () = gtk_widget_show_unref (window) // ref-count becomes 1!
//
val int = 100U
val _rid = g_timeout_add ((guint)int, (GSourceFunc)ftimeout2, (gpointer)NULL)
//
val () = gtk_main ((*void*))
//
} // end of [main0]

(* ****** ****** *)

(* end of [TextProcessing.dats] *)
