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
fun parse_d2exp_node (jsv: jsonval): d2exp_node

(* ****** ****** *)

implement
parse_d2exp
  (jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2exp_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2exp_node") 
val node = parse_d2exp_node (jsv)
//
in
  d2exp_make_node (loc, node)
end // end of [parse_d2exp]

(* ****** ****** *)

extern
fun parse_D2Ecst (jsonval): d2exp_node

extern
fun parse_D2Evar (jsonval): d2exp_node

extern
fun parse_D2Eapplst (jsonval): d2exp_node

extern
fun parse_D2Eifopt (jsonval): d2exp_node

extern
fun parse_D2Elam (jsonval): d2exp_node

extern
fun parse_D2Eerr (jsonval): d2exp_node

(* ****** ****** *)

implement
parse_d2exp_node
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "d2exp_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2exp_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| "D2Ecst" => parse_D2Ecst (jsv2)
| "D2Evar" => parse_D2Evar (jsv2)
(*
| "D2Eifhead" => parse_D2Eifopt (jsv2)
| "D2Eapplst" => parse_D2Eapplst (jsv2)
| "D2Elam_dyn" => parse_D2Elam (jsv2)
*)
//
| _(*rest*) => parse_D2Eerr (jsv2)
//
end // end of [parse_d2exp_node]

(* ****** ****** *)

(* end of [parsing_d2exp.dats] *)
