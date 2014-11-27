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

implement
parse_h3ypo_node
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_h3ypo_node: jsv0 = ", jsv0)
*)
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
in
//
case+ lx.0 of
//
| "H3YPOprop" => parse_H3YPOprop (lx.1)
| "H3YPObind" => parse_H3YPObind (lx.1)
| "H3YPOeqeq" => parse_H3YPOeqeq (lx.1)
//
| _(*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
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

(* end of [parsing_h3ypo.dats] *)
