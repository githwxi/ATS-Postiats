/*
** source: gtkviewport.h
*/

/* ****** ****** */

#define \
atscntrb_gtk_viewport_new(hadj, vadj) \
  g_object_ref_sink(G_OBJECT(gtk_viewport_new(hadj, vadj)))
#define \
atscntrb_gtk_viewport_new_null(/*void*/) \
  g_object_ref_sink(G_OBJECT(gtk_viewport_new(NULL, NULL)))

/* ****** ****** */

/* end of [gtkviewport.cats] */
