(* ****** ****** *)
//
// Some code for testing
// the API in ATS for libevent
//
(* ****** ****** *)
//
#define
PATSCONTRIB "\
https://raw.githubusercontent.com/\
githwxi/ATS-Postiats/master/npm-utils/contrib/atscntrb"
//
(* ****** ****** *)
//
#require
"{$PATSCONTRIB}/atscntrb-hx-libevent/SATS/http.sats"
#require
"{$PATSCONTRIB}/atscntrb-hx-libevent/SATS/event.sats"
#require
"{$PATSCONTRIB}/atscntrb-hx-libevent/SATS/buffer.sats"
//
#require "{$PATSCONTRIB}/atscntrb-hx-libevent/CATS/event.cats"
//
(* ****** ****** *)

#staload "{$PATSCONTRIB}/atscntrb-hx-libevent/SATS/event.sats"

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
