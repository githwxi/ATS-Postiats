//
// Some code for testing
// the API in ATS for libevent
//
(* ****** ****** *)

staload "./../SATS/event.sats"

(* ****** ****** *)

val () =
{
//
val vstring = event_get_version ()
val () = println! ("The libevent version is ", vstring)
val vnumber = event_get_version_number ()
val () = print! ("The libevent version number is ")
val () = $extfcall (void, "printf", "0x%x\n", vnumber)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
