/*
** source: gtkwindow.h
*/

/* ****** ****** */

#define atscntrb_GTK_IS_WINDOW(x) GTK_IS_WINDOW(x)

/* ****** ****** */
/*
** There is no floating reference for GtkWindows
*/
#define atscntrb_gtk_window_new(type) \
  g_object_ref_sink(G_OBJECT(gtk_window_new(type)))

/* ****** ****** */

#define atscntrb_gtk_window_get_title gtk_window_get_title
#define atscntrb_gtk_window_set_title gtk_window_set_title

/* ****** ****** */

#define atscntrb_gtk_window_set_default_size gtk_window_set_default_size

/* ****** ****** */

/* end of [gtkwindow.cats] */
