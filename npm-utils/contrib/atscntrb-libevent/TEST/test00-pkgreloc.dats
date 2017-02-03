//
// Some code for testing
// the API in ATS for libevent
//
(* ****** ****** *)
//
#define
PATSCONTRIB "\
https://raw.githubusercontent.com/\
githwxi/ATS-Postiats-contrib/master/contrib"
//
(*
//
// HX-2014-05-14: this is a backup:
//
#define
PATSCONTRIB "http://www.ats-lang.org/LIBRARY/contrib"
*)
//
(* ****** ****** *)
//
require "{$PATSCONTRIB}/libevent/SATS/event.sats"
require "{$PATSCONTRIB}/libevent/SATS/buffer.sats"
require "{$PATSCONTRIB}/libevent/SATS/http.sats"
//
require "{$PATSCONTRIB}/libevent/CATS/event.cats"
//
(* ****** ****** *)

staload "{$PATSCONTRIB}/libevent/SATS/event.sats"

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

(* end of [test00-pkgreloc.dats] *)
