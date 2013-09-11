/*
** source: gtkwidget.h
*/

/* ****** ****** */

#define atscntrb_gtk_widget_show gtk_widget_show

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atscntrb_gtk_widget_show_unref
  (GtkWidget *widget)
{
  gtk_widget_show (widget) ; g_object_unref (widget) ; return ;
} // end of [atscntrb_gtk_widget_show_unref]

/* ****** ****** */

#define atscntrb_gtk_widget_destroy gtk_widget_destroy
#define atscntrb_gtk_widget_destroy0 gtk_widget_destroy

/* ****** ****** */

/* end of [gtkwidget.cats] */
