(*
** source: gtkbutton.h
*)

(* ****** ****** *)
//
fun gtk_button_new
  ((*void*)): gobjref0(GtkButton) = "mac#%"
//
fun gtk_button_new_with_label
  (label: gstring): gobjref0(GtkButton) = "mac#%"
//
fun gtk_button_new_with_mnemonic
  (label: gstring): gobjref0(GtkButton) = "mac#%"
//
fun gtk_button_new_from_stock
  (stockid: gstring): gobjref0(GtkButton) = "mac#%"
//
(* ****** ****** *)
//
// HX-2010-04-26: the label string belongs to the widget!
// HX-2010-05-07: the label string can be NULL (if it is not set)
//
fun
gtk_button_get_label
  {l:agz} (button: !GtkButton (l))
: [l2:addr] (
  minus (GtkButton (l), gstrptr (l2)) | gstrptr (l2)
) = "mac#%" // endfun

(* ****** ****** *)

fun
gtk_button_set_label
  (button: !GtkButton1, label: gstrptr0): void = "mac#%"
// end of [gtk_button_set_label]

(* ****** ****** *)

(* end of [gtkbutton.sats] *)
