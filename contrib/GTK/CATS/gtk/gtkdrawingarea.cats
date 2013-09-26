/*
** source: gtkdrawingarea.h
*/

/* ****** ****** */
/*
** There is a floating reference for GtkDrawingAreas
*/
#define atscntrb_gtk_drawing_area_new() \
  g_object_ref_sink(G_OBJECT(gtk_drawing_area_new()))

/* ****** ****** */

/* end of [gtkdrawingarea.cats] */
