(*
//
// HX-2013-09:
// For maximal portability
//
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0 // no dynloading
//
(* ****** ****** *)

local
#include "prelude/DATS/filebas.dats"
in(**)end

(* ****** ****** *)

local
#include "libc/DATS/stdio.dats"
in(**)end

(* ****** ****** *)

local
#include "libats/ML/DATS/filebas.dats"
in(**)end

(* ****** ****** *)

(* end of [myatslib.dats] *)