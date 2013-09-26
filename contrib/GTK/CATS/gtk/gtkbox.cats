/*
** source: gtkbox.h
*/

/* ****** ****** */
/*
** There is a floating reference for GtkBoxes
*/
#define atscntrb_gtk_box_new(orient, spacing) \
  g_object_ref_sink(G_OBJECT(gtk_box_new(orient, spacing)))

/* ****** ****** */

#define atscntrb_gtk_box_pack_start gtk_box_pack_start
#define atscntrb_gtk_box_pack_end gtk_box_pack_end

/* ****** ****** */

/* end of [gtkbox.cats] */
