/*
** source: gtkscrolledwindow.h
*/

/* ****** ****** */

#define \
atscntrb_gtk_scrolled_window_new(hadj, vadj) \
  g_object_ref_sink(G_OBJECT(gtk_scrolled_window_new(hadj, vadj)))
#define \
atscntrb_gtk_scrolled_window_new_null(/*void*/) \
  g_object_ref_sink(G_OBJECT(gtk_scrolled_window_new(NULL, NULL)))

/* ****** ****** */

#define \
atscntrb_gtk_scrolled_window_get_hadjustment gtk_scrolled_window_get_hadjustment
#define \
atscntrb_gtk_scrolled_window_get_vadjustment gtk_scrolled_window_get_vadjustment

/* ****** ****** */

#define \
atscntrb_gtk_scrolled_window_set_hadjustment gtk_scrolled_window_set_hadjustment
#define \
atscntrb_gtk_scrolled_window_set_vadjustment gtk_scrolled_window_set_vadjustment

/* ****** ****** */

/* end of [gtkscrolledwindow.cats] */
