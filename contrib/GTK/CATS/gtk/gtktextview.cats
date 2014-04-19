/*
** source: gtktextview.h
*/

/* ****** ****** */
//
#define atscntrb_gtk_text_view_new() \
  g_object_ref_sink(G_OBJECT(gtk_text_view_new()))
//
#define atscntrb_gtk_text_view_new_with_buffer(tb) \
  g_object_ref_sink(G_OBJECT(gtk_text_view_new_with_buffer(tb)))
//
/* ****** ****** */

#define atscntrb_gtk_text_view_get_buffer gtk_text_view_get_buffer
#define atscntrb_gtk_text_view_set_buffer gtk_text_view_set_buffer

/* ****** ****** */

#define atscntrb_gtk_text_view_get_wrap_mode gtk_text_view_get_wrap_mode
#define atscntrb_gtk_text_view_set_wrap_mode gtk_text_view_set_wrap_mode

/* ****** ****** */

#define atscntrb_gtk_text_view_get_editable gtk_text_view_get_editable
#define atscntrb_gtk_text_view_set_editable gtk_text_view_set_editable

/* ****** ****** */

#define \
atscntrb_gtk_text_view_get_cursor_visible gtk_text_view_get_cursor_visible
#define \
atscntrb_gtk_text_view_set_cursor_visible gtk_text_view_set_cursor_visible

/* ****** ****** */

#define \
atscntrb_gtk_text_view_scroll_to_mark gtk_text_view_scroll_to_mark

/* ****** ****** */

#define \
atscntrb_gtk_text_view_scroll_to_iter gtk_text_view_scroll_to_iter

/* ****** ****** */

#define \
atscntrb_gtk_text_view_move_mark_onscreen gtk_text_view_move_mark_onscreen

/* ****** ****** */

#define \
atscntrb_gtk_text_view_place_cursor_onscreen gtk_text_view_place_cursor_onscreen

/* ****** ****** */

/* end of [gtktextview.cats] */
