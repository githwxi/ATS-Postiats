/*
** source: gtkbutton.h
*/

/* ****** ****** */
//
#define atscntrb_gtk_button_new() \
  g_object_ref_sink(G_OBJECT(gtk_button_new()))
//
#define atscntrb_gtk_button_new_with_label(label) \
  g_object_ref_sink(G_OBJECT(gtk_button_new_with_label(label)))
#define atscntrb_gtk_button_new_with_mnemonic(label) \
  g_object_ref_sink(G_OBJECT(gtk_button_new_with_mnemonic(label)))
//
#define atscntrb_gtk_button_new_with_from(stkid) \
  g_object_ref_sink(G_OBJECT(gtk_button_new_from_stock(stkid)))
//
/* ****** ****** */

/* end of [gtkbutton.cats] */
