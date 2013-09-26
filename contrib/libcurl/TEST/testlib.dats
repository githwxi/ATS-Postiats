//
// Some library code for testing
//
(* ****** ****** *)

#define ATS_PACKNAME "testlib"

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading at run-time

(* ****** ****** *)

staload "./../SATS/curl.sats"

(* ****** ****** *)

(* end of [testlib.dats] *)
