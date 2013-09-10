/*
** source: gtkwindow.h
*/

/* ****** ****** */

#define atscntrb_gtk3_GTK_IS_WINDOW(x) GTK_IS_WINDOW(x)

/* ****** ****** */
/*
** There is no floating reference for GtkWindows
*/
ATSinline()
atstype_ptr
atscntrb_gtk3_gtk_window_new
(
  GtkWindowType type
) {
  GtkWidget *widget ;
  widget = gtk_window_new (type) ;
  g_object_ref_sink(G_OBJECT(widget)) ;
/*
** the ref-count of the created window is 2!
*/
  return widget ;
} // end of [atscntrb_gtk3_gtk_window_new]

/* ****** ****** */

/* end of [gtkwindow.cats] */
