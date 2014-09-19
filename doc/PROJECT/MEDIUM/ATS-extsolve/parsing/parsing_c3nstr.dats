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
parse_c3nstr_node (jsonval): c3nstr_node

(* ****** ****** *)

implement
parse_c3nstr
  (jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "c3nstr_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "c3nstr_node") 
val node = parse_c3nstr_node (jsv)
//
in
  c3nstr_make_node (loc, node)
end // end of [parse_c3nstr]

(* ****** ****** *)

implement
parse_c3nstropt
  (jsv0) = (
  parse_option<c3nstr> (jsv0, parse_c3nstr)
) (* end of [parse_c3nstropt] *)

(* ****** ****** *)

extern
fun parse_C3NSTRprop (jsonval): c3nstr_node
extern
fun parse_C3NSTRitmlst (jsonval): c3nstr_node

(* ****** ****** *)

implement
parse_c3nstr_node
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_c3nstr_node: jsv0 = ", jsv0)
*)
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
in
//
case+ lx.0 of
//
| "C3NSTRprop" => parse_C3NSTRprop (lx.1)
| "C3NSTRitmlst" => parse_C3NSTRitmlst (lx.1)
| _(*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
//
end // end of [parse_c3nstr_node]

(* ****** ****** *)

implement
parse_C3NSTRprop
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2e = parse_s2exp (jsvs[0])
//
in
  C3NSTRprop (s2e)
end // end of [parse_C3NSTRprop]

(* ****** ****** *)

implement
parse_C3NSTRitmlst
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s3is = parse_s3itmlst (jsvs[0])
//
in
  C3NSTRitmlst (s3is)
end // end of [parse_C3NSTRitmlst]

(* ****** ****** *)

(* end of [parsing_c3nstr] *)
