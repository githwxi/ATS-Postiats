//
// Some code for testing
// the API in ATS for libev
//
(* ****** ****** *)

staload "./../SATS/ev.sats"

(* ****** ****** *)

val () =
{
//
val major = ev_version_major ()
val minor = ev_version_minor ()
//
val () = println! ("ev_version_major() = ", major)
val () = println! ("ev_version_minor() = ", minor)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
