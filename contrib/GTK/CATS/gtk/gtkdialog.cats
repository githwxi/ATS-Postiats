/*
** source: gtkdialog.h
*/

/* ****** ****** */

#define atscntrb_gtk_dialog_new() \
  g_object_ref_sink(G_OBJECT(gtk_dialog_new()))

/* ****** ****** */

#define \
atscntrb_gtk_dialog_add_buttons gtk_dialog_add_buttons

/* ****** ****** */

#define atscntrb_gtk_dialog_run gtk_dialog_run
#define atscntrb_gtk_dialog_response gtk_dialog_response

/* ****** ****** */

/* end of [gtkdialog.cats] */
