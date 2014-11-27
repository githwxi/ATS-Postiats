(*
** Parsing constraints in JSON format
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 (* no run-time dynloading *)

(* ****** ****** *)

local
//
#include "{$JSONC}/DATS/json.dats"
#include "{$JSONC}/DATS/json_ML.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [parsing_mylib.dats] *)
