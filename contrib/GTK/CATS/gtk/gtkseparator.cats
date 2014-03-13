/*
** source: gtkseparator.h
*/

/* ****** ****** */
/*
** There is a floating reference for GtkSeparators
*/
#define atscntrb_gtk_separator_new(orient) \
  g_object_ref_sink(G_OBJECT(gtk_separator_new(orient)))

/* ****** ****** */

/* end of [gtkseparator.cats] */
