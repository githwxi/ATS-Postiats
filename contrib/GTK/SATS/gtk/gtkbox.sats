(*
** source: gtkbox.h
*)

(* ****** ****** *)

fun gtk_box_new
(
  orient: GtkOrientation, spacing: gint
) : gobjref0(GtkBox) = "mac#%" // endfun

(* ****** ****** *)
//
// HX-2014-04-23-checked:
// The refcount of a gobject is increased
// by one after it is added into a gtkbox.
//
(* ****** ****** *)

fun gtk_box_pack_start
(
  box: !GtkBox1, child: !GtkWidget1
, expand: gboolean, fill: gboolean, padding: guint
) : void = "mac#%" // end of [gtk_box_pack_start]

(* ****** ****** *)

fun gtk_box_pack_end
(
  box: !GtkBox1, child: !GtkWidget1
, expand: gboolean, fill: gboolean, padding: guint
) : void = "mac#%" // end of [gtk_box_pack_end]

(* ****** ****** *)

(* end of [gtkbox.sats] *)
