//
// Some library code for testing
//
(* ****** ****** *)

#define ATS_PACKNAME "testlib"

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading at run-time

(* ****** ****** *)

staload "libcurl/SATS/curl.sats"

(* ****** ****** *)

(* end of [testlib.dats] *)
