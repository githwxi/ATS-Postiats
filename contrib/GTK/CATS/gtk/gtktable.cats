/*
** source: gtktable.h
*/

/* ****** ****** */
//
#define atscntrb_gtk_table_new(nrow, ncol, homo) \
  g_object_ref_sink(G_OBJECT(gtk_table_new(nrow, ncol, homo)))
//
/* ****** ****** */

#define atscntrb_gtk_table_attach_defaults gtk_table_attach_defaults

/* ****** ****** */

/* end of [gtktable.cats] */
