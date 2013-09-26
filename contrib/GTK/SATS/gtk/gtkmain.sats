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
  (major: guint, minor: guint, micro: guint) : gstring
// end of [gtk_check_version]

(* ****** ****** *)

fun gtk_main (): void = "mac#%"
fun gtk_main_level (): guint = "mac#%"

(* ****** ****** *)

fun gtk_main_iteration (): gboolean = "mac#%"
fun gtk_main_iteration_do (blocking: gboolean): gboolean = "mac#%"

(* ****** ****** *)

fun gtk_main_quit (): void = "mac#%"

(* ****** ****** *)

(* end of [gtkmain.sats] *)
