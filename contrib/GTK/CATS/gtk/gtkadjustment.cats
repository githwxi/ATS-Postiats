/*
** source: gtkadjustment.h
*/

/* ****** ****** */
/*
** There is a floating reference for GtkAdjustments
*/
#define \
atscntrb_gtk_adjustment_new(value, lower, upper, sincr, pincr, psize) \
g_object_ref_sink(G_OBJECT(gtk_adjustment_new(value, lower, upper, sincr, pincr, psize)))

/* ****** ****** */

#define atscntrb_gtk_adjustment_get_value gtk_adjustment_get_value
#define atscntrb_gtk_adjustment_set_value gtk_adjustment_set_value

/* ****** ****** */

#define atscntrb_gtk_adjustment_get_lower gtk_adjustment_get_lower
#define atscntrb_gtk_adjustment_set_lower gtk_adjustment_set_lower

/* ****** ****** */

#define atscntrb_gtk_adjustment_get_upper gtk_adjustment_get_upper
#define atscntrb_gtk_adjustment_set_upper gtk_adjustment_set_upper

/* ****** ****** */

#define \
atscntrb_gtk_adjustment_get_step_increment gtk_adjustment_get_step_increment
#define \
atscntrb_gtk_adjustment_set_step_increment gtk_adjustment_set_step_increment

/* ****** ****** */

#define \
atscntrb_gtk_adjustment_get_page_increment gtk_adjustment_get_page_increment
#define \
atscntrb_gtk_adjustment_set_page_increment gtk_adjustment_set_page_increment

/* ****** ****** */

#define atscntrb_gtk_adjustment_get_page_size gtk_adjustment_get_page_size
#define atscntrb_gtk_adjustment_set_page_size gtk_adjustment_set_page_size

/* ****** ****** */

#define atscntrb_gtk_adjustment_configure gtk_adjustment_configure

/* ****** ****** */

#define atscntrb_gtk_adjustment_clamp_page gtk_adjustment_clamp_page

/* ****** ****** */

#define atscntrb_gtk_adjustment_changed gtk_adjustment_changed
#define atscntrb_gtk_adjustment_value_changed gtk_adjustment_value_changed

/* ****** ****** */

/* end of [gtkadjustment.cats] */
