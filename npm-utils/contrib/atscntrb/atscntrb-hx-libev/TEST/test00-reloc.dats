(* ****** ****** *)
//
// HX-2017-02-04:
// This is no longer in use
// The code is kept for historic reasons
//
(* ****** ****** *)
//
// Some code for testing
// the API in ATS for libev
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
PATSCONTRIB
"http://www.ats-lang.org/LIBRARY/contrib"
*)
//
(* ****** ****** *)
//
#require "{$PATSCONTRIB}/libev/SATS/ev.sats"
#require "{$PATSCONTRIB}/libev/DATS/ev.dats"
#require "{$PATSCONTRIB}/libev/CATS/ev.cats"
//
(* ****** ****** *)

#staload "{$PATSCONTRIB}/libev/SATS/ev.sats"

(* ****** ****** *)

val () =
{
//
val
major = ev_version_major()
val
minor = ev_version_minor()
//
val () = println!("ev_version_major() = ", major)
val () = println!("ev_version_minor() = ", minor)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00-reloc.dats] *)
