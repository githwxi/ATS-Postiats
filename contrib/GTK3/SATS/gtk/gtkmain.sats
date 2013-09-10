(*
** source: gtkmain.h
*)

(* ****** ****** *)

fun gtk_get_major_version (): guint = "mac#%"
fun gtk_get_minor_version (): guint = "mac#%"
fun gtk_get_micro_version (): guint = "mac#%"

(* ****** ****** *)

fun gtk_get_binary_age (): guint = "mac#%"
fun gtk_get_interface_age (): guint = "mac#%"

(* ****** ****** *)

fun gtk_check_version
(
  required_major: guint, required_minor: guint, required_micro: guint
) : gstring // end of [gtk_check_version]

(* ****** ****** *)

fun gtk_main (): void = "mac#%"
fun gtk_main_level (): guint = "mac#%"

(* ****** ****** *)

(* end of [gtkmain.sats] *)
