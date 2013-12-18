//
// Some library code for testing
//
(* ****** ****** *)

#define ATS_PACKNAME "mylib"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
  
local
//
#include "prelude/DATS/filebas.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]
  
(* ****** ****** *)

local
//
#include "{$HIREDIS}/DATS/hiredis_ML.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [mylib.dats] *)
