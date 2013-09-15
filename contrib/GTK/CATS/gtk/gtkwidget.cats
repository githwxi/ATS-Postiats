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

#define atscntrb_gtk_widget_show_now gtk_widget_show_now
#define atscntrb_gtk_widget_show_all gtk_widget_show_all

/* ****** ****** */

#define atscntrb_gtk_widget_destroy gtk_widget_destroy
#define atscntrb_gtk_widget_destroy0 gtk_widget_destroy

/* ****** ****** */
//
// HX: it gets the GDK window from a Drawable
//
#define atscntrb_gtk_widget_get_window gtk_widget_get_window
//
/* ****** ****** */

#define atscntrb_gtk_widget_get_allocated_width gtk_widget_get_allocated_width
#define atscntrb_gtk_widget_get_allocated_height gtk_widget_get_allocated_height

/* ****** ****** */

#define atscntrb_gtk_widget_get_allocation gtk_widget_get_allocation
#define atscntrb_gtk_widget_set_allocation gtk_widget_set_allocation

/* ****** ****** */

/*
//
// HX: this is only available in GTK2; it is a poor idea anyways
//
ATSinline()
atstype_ptr
atscntrb_gtk_widget_getref_allocation
  (atstype_ptr widget) { return &(GTK_WIDGET(widget))->allocation ; }
// end of [atscntrb_gtk_widget_getref_allocation]
*/

/* ****** ****** */

#define atscntrb_gtk_widget_queue_draw_area gtk_widget_queue_draw_area

/* ****** ****** */

/* end of [gtkwidget.cats] */
