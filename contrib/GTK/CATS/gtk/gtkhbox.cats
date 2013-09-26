/*
** source: gtkhbox.h
*/

/* ****** ****** */
//
// HX: deprecated in GTK3
//
#define atscntrb_gtk_hbox_new(homo, spacing) \
  g_object_ref_sink(G_OBJECT(gtk_hbox_new(homo, spacing)))
//
/* ****** ****** */

/* end of [gtkhbox.cats] */
