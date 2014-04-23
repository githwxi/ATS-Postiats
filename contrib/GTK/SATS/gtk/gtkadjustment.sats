(*
** source: gtkadjustment.h
*)

(* ****** ****** *)

fun gtk_adjustment_new
(
  value: gdouble
, lower: gdouble
, upper: gdouble
, step_increment: gdouble
, page_increment: gdouble
, page_size: gdouble
) : gobjref0(GtkAdjustment)

(* ****** ****** *)

fun gtk_adjustment_get_value
  (adj: !GtkAdjustment1): gdouble = "mac#%"
fun gtk_adjustment_set_value
  (adj: !GtkAdjustment1, value: gdouble): void = "mac#%"

(* ****** ****** *)

fun gtk_adjustment_get_lower
  (adj: !GtkAdjustment1): gdouble = "mac#%"
fun gtk_adjustment_set_lower
  (adj: !GtkAdjustment1, lower: gdouble): void = "mac#%"

(* ****** ****** *)

fun gtk_adjustment_get_upper
  (adj: !GtkAdjustment1): gdouble = "mac#%"
fun gtk_adjustment_set_upper
  (adj: !GtkAdjustment1, upper: gdouble): void = "mac#%"

(* ****** ****** *)

fun gtk_adjustment_changed (!GtkAdjustment1): void = "mac#%"
fun gtk_adjustment_value_changed (!GtkAdjustment1): void = "mac#%"
  
(* ****** ****** *)

(* end of [gtkadjustment.sats] *)
