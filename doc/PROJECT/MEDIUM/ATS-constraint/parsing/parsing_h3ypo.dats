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
parse_h3ypo_node (jsonval): h3ypo_node

(* ****** ****** *)

implement
parse_h3ypo
  (jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "h3ypo_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "h3ypo_node") 
val node = parse_h3ypo_node (jsv)
//
in
  h3ypo_make_node (loc, node)
end // end of [parse_h3ypo]

(* ****** ****** *)

extern
fun parse_H3YPOprop (jsonval): h3ypo_node
extern
fun parse_H3YPObind (jsonval): h3ypo_node
extern
fun parse_H3YPOeqeq (jsonval): h3ypo_node

(* ****** ****** *)

extern
fun parse_H3YPOignored (jsonval): h3ypo_node

(* ****** ****** *)

implement
parse_h3ypo_node
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_h3ypo_node: jsv0 = ", jsv0)
*)
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "h3ypo_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "h3ypo_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| "H3YPOprop" => parse_H3YPOprop (jsv2)
| "H3YPObind" => parse_H3YPObind (jsv2)
| "H3YPOeqeq" => parse_H3YPOeqeq (jsv2)
//
| _(*deadcode*) => parse_H3YPOignored (jsv2)
//
end // end of [parse_h3ypo_node]

(* ****** ****** *)

implement
parse_H3YPOprop
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2e = parse_s2exp (jsvs[0])
//
in
  H3YPOprop (s2e)
end // end of [parse_H3YPOprop]

(* ****** ****** *)

implement
parse_H3YPObind
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2v = parse_s2var (jsvs[0])
val s2e = parse_s2exp (jsvs[1])
//
in
  H3YPObind (s2v, s2e)
end // end of [parse_H3YPObind]

(* ****** ****** *)

implement
parse_H3YPOeqeq
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2e1 = parse_s2exp (jsvs[0])
val s2e2 = parse_s2exp (jsvs[1])
//
in
  H3YPOeqeq (s2e1, s2e2)
end // end of [parse_H3YPOeqeq]

(* ****** ****** *)
//
implement
parse_H3YPOignored (jsv0) =
  let val () = assertloc (false) in exit(1) end
//
(* ****** ****** *)

(* end of [parsing_h3ypo.dats] *)
