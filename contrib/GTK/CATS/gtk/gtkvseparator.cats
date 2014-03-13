/*
** source: gtkvseparator.h
*/

/* ****** ****** */
/*
** There is a floating reference for GtkVSeparators
*/
#define atscntrb_gtk_vseparator_new() \
  g_object_ref_sink(G_OBJECT(gtk_vseparator_new()))

/* ****** ****** */

/* end of [gtkvseparator.cats] */
