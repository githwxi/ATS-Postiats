(*
** source: gtktextview.h
*)

(* ****** ****** *)

fun
gtk_text_view_new
(
// HX: argumentless function
): gobjref0(GtkTextView) = "mac#%"

(* ****** ****** *)

fun
gtk_text_view_new_with_buffer
(
  tb: !GtkTextBuffer1
) : gobjref0(GtkTextView) = "mac#%"

(* ****** ****** *)

fun
gtk_text_view_set_buffer
  (tv: !GtkTextView1, tb: !GtkTextBuffer0): void = "mac#%"
fun
gtk_text_view_get_buffer
  {l:agz} (tv: !GtkTextView(l)): [l2:addr]
(
  minus (GtkTextView(l), GtkTextBuffer(l2)) | GtkTextBuffer(l2)
) = "mac#%" // end of [gtk_text_view_get_buffer]

(* ****** ****** *)
//
fun
gtk_text_view_get_wrap_mode
  (tv: !GtkTextView1): GtkWrapMode = "mac#%"
fun
gtk_text_view_set_wrap_mode
  (tv: !GtkTextView1, mode: GtkWrapMode): void = "mac#%"
//
(* ****** ****** *)
//
fun
gtk_text_view_get_editable
  (tv: !GtkTextView1): gboolean = "mac#%"
fun
gtk_text_view_set_editable
  (tv: !GtkTextView1, editable: gboolean): void = "mac#%"
//
(* ****** ****** *)
//
fun
gtk_text_view_get_cursor_visible
  (tv: !GtkTextView1): gboolean = "mac#%"
fun
gtk_text_view_set_cursor_visible
  (tv: !GtkTextView1, visible: gboolean): void = "mac#%"
//
(* ****** ****** *)

fun
gtk_text_view_scroll_to_mark
(
  tv: !GtkTextView1
, mark: !GtkTextMark1
, within_margin: gdouble
, use_align: gboolean, xalign: gdouble, yalign: gdouble
) : void = "mac#%" // end-of-fun

(* ****** ****** *)

fun
gtk_text_view_scroll_to_iter
(
  tv: !GtkTextView1
, iter: &GtkTextIter
, within_margin: gdouble
, use_align: gboolean, xalign: gdouble, yalign: gdouble
) : gboolean = "mac#%" // end-of-fun

(* ****** ****** *)
//
fun
gtk_text_view_move_mark_onscreen (tv: !GtkTextView1): gboolean = "mac#%"
//
(* ****** ****** *)
//
fun
gtk_text_view_place_cursor_onscreen (tv: !GtkTextView1): gboolean = "mac#%"
//
(* ****** ****** *)

(* end of [gtktextview.sats] *)
