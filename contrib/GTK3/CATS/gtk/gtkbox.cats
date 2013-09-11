/*
** source: gtkbox.h
*/

/* ****** ****** */

#define atscntrb_gtk3_gtk_box_new(orient, spacing) \
  g_object_ref_sink(G_OBJECT(gtk_box_new(orient, spacing)))

/* ****** ****** */

#define atscntrb_gtk3_gtk_box_pack_start gtk_box_pack_start
#define atscmtrb_gtk3_gtk_box_pack_end gtk_box_pack_end

/* ****** ****** */

/* end of [gtkbox.cats] */
