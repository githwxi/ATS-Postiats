//
// Some library code for testing
//
(* ****** ****** *)

#define ATS_PACKNAME "testlib"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/hiredis.sats"
staload "./../SATS/hiredis_ML.sats"

(* ****** ****** *)

local
//
#include "./../DATS/hiredis_ML.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [testlib.dats] *)
