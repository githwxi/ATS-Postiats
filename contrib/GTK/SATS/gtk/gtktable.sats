(*
** source: gtktable.h
*)

(* ****** ****** *)

fun gtk_table_new
(
  nrow: guint, ncol: guint, homo: gboolean
) : gobjref0(GtkTable) = "mac#%" // endfun

(* ****** ****** *)

fun gtk_table_attach_defaults
(
  !GtkTable1, !GtkWidget1, left: guint, right: guint, top: guint, bot: guint
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [gtktable.sats] *)
