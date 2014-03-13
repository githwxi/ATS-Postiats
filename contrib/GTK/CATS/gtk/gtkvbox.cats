/*
** source: gtkvbox.h
*/

/* ****** ****** */
//
// HX: deprecated in GTK3
//
#define atscntrb_gtk_vbox_new(homo, spacing) \
  g_object_ref_sink(G_OBJECT(gtk_vbox_new(homo, spacing)))
//
/* ****** ****** */

/* end of [gtkvbox.cats] */
