(* ****** ****** *)
//
// HX-2013-11
//
// Implementing a variant of
// the problem of Dining Philosophers
//
(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
  
#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)

local
//
#include "libats/DATS/athread.dats"
#include "libats/DATS/athread_posix.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [DiningPhil2_mylib.dats] *)
