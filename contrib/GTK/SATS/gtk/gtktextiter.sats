(*
** source: gtktextiter.h
*)

(* ****** ****** *)
//
fun
gtk_text_iter_is_start
  (iter: &GtkTextIter): gboolean = "mac#%"
//
fun gtk_text_iter_is_end
  (iter: &GtkTextIter): gboolean = "mac#%"
//
(* ****** ****** *)
//
fun gtk_text_iter_get_line (iter: &GtkTextIter): gint = "mac#%"
fun gtk_text_iter_get_line_offset (iter: &GtkTextIter): gint = "mac#%"
//
(* ****** ****** *)
//
fun gtk_text_iter_forward_char (iter: &GtkTextIter): void = "mac#%"
fun gtk_text_iter_forward_chars (iter: &GtkTextIter, n: gint): void = "mac#%"
//
fun gtk_text_iter_backward_char (iter: &GtkTextIter): void = "mac#%"
fun gtk_text_iter_backward_chars (iter: &GtkTextIter, n: gint): void = "mac#%"
//
(* ****** ****** *)
//
fun gtk_text_iter_forward_line (iter: &GtkTextIter): void = "mac#%"
fun gtk_text_iter_forward_lines (iter: &GtkTextIter, n: gint): void = "mac#%"
//
fun gtk_text_iter_backward_line (iter: &GtkTextIter): void = "mac#%"
fun gtk_text_iter_backward_lines (iter: &GtkTextIter, n: gint): void = "mac#%"
//
(* ****** ****** *)

(* end of [gtktextiter.sats] *)
