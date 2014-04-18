(*
** source: gtktextbuffer.h
*)

(* ****** ****** *)

fun
gtk_text_buffer_new_null
(
// HX: argumentless function
): gobjref0(GtkTextBuffer) = "mac#%"

(* ****** ****** *)

fun
gtk_text_buffer_insert
  {n,n2:int | n >= n2}
(
  tbuf: !GtkTextBuffer1
, iter: &GtkTextIter >> _
, text: arrayref(gchar, n), len: int(n2)
) : void = "mac#%" // end of [gtk_text_buffer_insert]

fun
gtk_text_buffer_insertall
(
  tbuf: !GtkTextBuffer1, iter: &GtkTextIter >> _, text: gstring
) : void = "mac#%" // end of [gtk_text_buffer_insert_all]

(* ****** ****** *)

(* end of [gtktextbuffer.sats] *)
