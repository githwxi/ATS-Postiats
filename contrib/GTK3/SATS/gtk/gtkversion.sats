(*
** source: gtkversion.h
*)

(* ****** ****** *)

macdef GTK_MAJOR_VERSION = $extval (int, "GTK_MAJOR_VERSION")
macdef GTK_MINOR_VERSION = $extval (int, "GTK_MINOR_VERSION")
macdef GTK_MICRO_VERSION = $extval (int, "GTK_MICRO_VERSION")

(* ****** ****** *)

macdef GTK_BINARY_AGE = $extval (int, "GTK_BINARY_AGE")
macdef GTK_INTERFACE_AGE = $extval (int, "GTK_INTERFACE_AGE")

(* ****** ****** *)

fun GTK_CHECK_VERSION (major:int, minor:int, micro: int): bool = "mac#%"

(* ****** ****** *)

(* end of [gtkversion.sats] *)
