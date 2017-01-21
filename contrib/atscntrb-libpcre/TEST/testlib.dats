(* ****** ****** *)
//
#define
ATS_PACKNAME "testlib"
//
#define
ATS_DYNLOADFLAG 0 // no dynloading at run-time
//
(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

local
//
#include "./../DATS/pcre.dats"
#include "./../DATS/pcre_ML.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [testlib.dats] *)
