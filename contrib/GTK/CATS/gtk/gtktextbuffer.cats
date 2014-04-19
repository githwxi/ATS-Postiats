/*
** source: gtktextbuffer.h
*/

/* ****** ****** */

#define \
atscntrb_gtk_text_buffer_new_null() \
  g_object_ref_sink(G_OBJECT(gtk_text_buffer_new(NULL)))

/* ****** ****** */

#define \
atscntrb_gtk_text_buffer_get_end_iter gtk_text_buffer_get_end_iter
#define \
atscntrb_gtk_text_buffer_get_start_iter gtk_text_buffer_get_start_iter

/* ****** ****** */

#define atscntrb_gtk_text_buffer_insert gtk_text_buffer_insert
#define \
atscntrb_gtk_text_buffer_insertall(tb, itr, txt) gtk_text_buffer_insert(tb, itr, txt, -1)

/* ****** ****** */

#define \
atscntrb_gtk_text_buffer_insert_at_cursor gtk_text_buffer_insert_at_cursor
#define \
atscntrb_gtk_text_buffer_insertall_at_cursor(tb, txt) gtk_text_buffer_insert_at_cursor(tb, txt, -1)

/* ****** ****** */

#define atscntrb_gtk_text_buffer_set_text gtk_text_buffer_set_text
#define \
atscntrb_gtk_text_buffer_setall_text(tb, txt) gtk_text_buffer_set_text(tb, txt, -1)

/* ****** ****** */

#define atscntrb_gtk_text_buffer_get_text gtk_text_buffer_get_text

/* ****** ****** */

#define atscntrb_gtk_text_buffer_get_insert gtk_text_buffer_get_insert

/* ****** ****** */

#define atscntrb_gtk_text_buffer_place_cursor gtk_text_buffer_place_cursor

/* ****** ****** */

/* end of [gtktextbuffer.cats] */
