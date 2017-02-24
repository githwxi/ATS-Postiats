//
// Some library code for testing
//
(* ****** ****** *)

#define ATS_PACKNAME "testlib"

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

local
//
#include "./../DATS/json.dats"
#include "./../DATS/json_ML.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [testlib.dats] *)
