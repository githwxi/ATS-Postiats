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

extern
fun
parse_s2exp_node (jsonval): s2exp_node

(* ****** ****** *)

implement
parse_s2exp
  (jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "s2exp_srt") 
val s2t = parse_s2rt (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "s2exp_node") 
val node = parse_s2exp_node (jsv)
//
in
  s2exp_make_node (s2t, node)
end // end of [parse_s2exp]

(* ****** ****** *)

extern
fun parse_S2Ecst (jsonval): s2exp_node
extern
fun parse_S2Evar (jsonval): s2exp_node

(* ****** ****** *)

extern
fun parse_S2Eignored (jsonval): s2exp_node

(* ****** ****** *)

implement
parse_s2exp_node
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_s2exp_node: jsv0 = ", jsv0)
*)
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "s2exp_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "s2exp_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| "S2Ecst" => parse_S2Ecst (jsv2)
| "S2Evar" => parse_S2Evar (jsv2)
//
| _(*rest*) => parse_S2Eignored (jsv2)
//
end // end of [parse_s2exp_node]

(* ****** ****** *)

implement
parse_S2Ecst
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2c = parse_s2cst (jsvs[0])
//
in
  S2Ecst (s2c)
end // end of [parse_S2Ecst]

(* ****** ****** *)

implement
parse_S2Evar
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2v = parse_s2var (jsvs[0])
//
in
  S2Evar (s2v)
end // end of [parse_S2Evar]

(* ****** ****** *)

implement
parse_S2Eignored (jsv) = S2Eignored ((*void*))

(* ****** ****** *)

(* end of [parsing_s2exp] *)
