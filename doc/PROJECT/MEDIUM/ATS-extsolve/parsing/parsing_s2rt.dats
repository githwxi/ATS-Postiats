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
//
staload "./../constraint.sats"
//
(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload "./parsing.dats"

(* ****** ****** *)

implement
parse_s2rt
  (jsv0) = let
//
val-JSONstring(name) = jsv0
//
in
//
case+ name of
//
| "int" => S2RTint ()
| "addr" => S2RTaddr ()
| "bool" => S2RTbool ()
//
| "s2rt_fun" => S2RTfun ()
| "s2rt_tup" => S2RTtup ()
| "s2rt_err" => S2RTerr ()
//
| _(*rest*) => S2RTignored ()
//
end // end of [parse_s2rt]

(* ****** ****** *)

(* end of [parsing_s2rt] *)
