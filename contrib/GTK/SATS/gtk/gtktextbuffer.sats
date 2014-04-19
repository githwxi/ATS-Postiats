(*
** source: gtktextbuffer.h
*)

(* ****** ****** *)

fun
gtk_text_buffer_new_null
(
// HX: argumentless function
) : gobjref0(GtkTextBuffer) = "mac#%"

(* ****** ****** *)
//
fun
gtk_text_buffer_get_end_iter
  (tbuf: !GtkTextBuffer1, iter: &GtkTextIter? >> _): void = "mac#"
fun
gtk_text_buffer_get_start_iter
  (tbuf: !GtkTextBuffer1, iter: &GtkTextIter? >> _): void = "mac#"
//
(* ****** ****** *)
//
fun
gtk_text_buffer_insert
  {n,n2:int | n >= n2; n2 >= 0}
(
  tbuf: !GtkTextBuffer1
, iter: &GtkTextIter >> _
, text: arrayref(gchar, n), len: int(n2)
) : void = "mac#%" // end of [gtk_text_buffer_insert]
fun
gtk_text_buffer_insertall
(
  tbuf: !GtkTextBuffer1, iter: &GtkTextIter >> _, text: gstring
) : void = "mac#%" // end of [gtk_text_buffer_insertall]
//
(* ****** ****** *)
//
fun
gtk_text_buffer_insert_at_cursor
  {n,n2:int | n >= n2; n2 >= 0}
(
  tbuf: !GtkTextBuffer1
, text: arrayref(gchar, n), len: int(n2)
) : void = "mac#%" // end-of-fun
fun
gtk_text_buffer_insertall_at_cursor
  (tbuf: !GtkTextBuffer1, text: gstring) : void = "mac#%"
//
(* ****** ****** *)
//
fun
gtk_text_buffer_set_text
  {n,n2:int | n >= n2; n2 >= 0}
(
  tbuf: !GtkTextBuffer1
, text: arrayref(gchar, n), len: int(n2)
) : void = "mac#%" // end of [gtk_text_buffer_set_text]
fun
gtk_text_buffer_setall_text
  (tbuf: !GtkTextBuffer1, text: gstring) : void = "mac#%"
//
(* ****** ****** *)

fun
gtk_text_buffer_get_text
(
  tbuf: !GtkTextBuffer1
, iter_beg: &GtkTextIter >> _, iter_end: &GtkTextIter >> _
, hidden_chars: gboolean
) : gstrptr1 = "mac#%" // end of [gtk_text_buffer_get_text]

(* ****** ****** *)

fun
gtk_text_buffer_get_insert
  {l:agz}
(
  tbuf: !GtkTextBuffer(l)
) : [l2:addr]
(
  minus (GtkTextBuffer(l), GtkTextMark(l2)) | GtkTextMark(l2)
) = "mac#%" // end of [gtk_text_buffer_get_insert]

(* ****** ****** *)
//
fun
gtk_text_buffer_place_cursor
  (tbuf: !GtkTextBuffer1, iter: &RD(GtkTextIter)): void = "mac#%"
//
(* ****** ****** *)

(* end of [gtktextbuffer.sats] *)
