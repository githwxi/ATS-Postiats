(*
** source: gtkbox.h
*)

(* ****** ****** *)

fun gtk_box_new
  (GtkOrientation, spacing: gint): gobjref0(GtkBox) = "mac#%"
// end of [gtk_box_new]

(* ****** ****** *)

fun gtk_box_pack_start
(
  box: !GtkBox1, child: !GtkWidget1
, expand: gboolean, fill: gboolean, padding: guint
) : void = "mac#%" // endfun

(* ****** ****** *)

fun gtk_box_pack_end
(
  box: !GtkBox1, child: !GtkWidget1
, expand: gboolean, fill: gboolean, padding: guint
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [gtkbox.sats] *)
