(*
** for testing weboxy
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

local
//
#include
"{$LIBATSHWXI}/weboxy/DATS/weboxy.dats"
//
in (* in-of-local *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [myweboxy.dats] *)
