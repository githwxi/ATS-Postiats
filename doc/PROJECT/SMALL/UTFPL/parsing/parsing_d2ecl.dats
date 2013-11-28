(*
** Parsing: ATS -> UTFPL
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
staload "./../utfpl.sats"
//
(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload "./parsing.dats"

(* ****** ****** *)

extern
fun parse_d2ecl_node (jsv: jsonval): d2ecl_node

(* ****** ****** *)

implement
parse_d2ecl
  (jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2ecl_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2ecl_node") 
val node = parse_d2ecl_node (jsv)
//
in
  d2ecl_make_node (loc, node)
end // end of [parse_d2ecl]

(* ****** ****** *)

extern
fun parse_D2Cerr (jsonval): d2ecl_node

(* ****** ****** *)

implement
parse_d2ecl_node
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "d2ecl_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2ecl_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| _(*rest*) => parse_D2Cerr (jsv2)
//
end // end of [parse_d2ecl_node]

(* ****** ****** *)

(* end of [parsing_d2ecl.dats] *)
