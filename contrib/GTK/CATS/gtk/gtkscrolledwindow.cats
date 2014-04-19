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

/* end of [gtkscrolledwindow.cats] */
