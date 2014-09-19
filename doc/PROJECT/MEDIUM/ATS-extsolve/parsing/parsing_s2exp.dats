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
fun parse_S2Eint (jsonval): s2exp_node
extern
fun parse_S2Eintinf (jsonval): s2exp_node

extern
fun parse_S2Ecst (jsonval): s2exp_node
extern
fun parse_S2Evar (jsonval): s2exp_node
extern
fun parse_S2EVar (jsonval): s2exp_node

(* ****** ****** *)

extern
fun parse_S2Eapp (jsonval): s2exp_node

(* ****** ****** *)

extern
fun parse_S2Emetdec (jsonval): s2exp_node

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
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "S2Eint" => parse_S2Eint (jsv2)
| "S2Eintinf" => parse_S2Eintinf (jsv2)
//
| "S2Ecst" => parse_S2Ecst (jsv2)
| "S2Evar" => parse_S2Evar (jsv2)
| "S2EVar" => parse_S2EVar (jsv2)
//
| "S2Eapp" => parse_S2Eapp (jsv2)
//
| "S2Emetdec" => parse_S2Emetdec (jsv2)
//
| _(*rest*) => let
    val () =
    prerrln! ("warning(ATS): [parse_s2exp]: name = ", name)
  in
    parse_S2Eignored (jsv2)
  end // end of [_]
//
end // end of [parse_s2exp_node]

(* ****** ****** *)

implement
parse_S2Eint
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
//
in
  S2Eint (parse_int (jsvs[0]))
end // end of [parse_S2Eint]

(* ****** ****** *)

implement
parse_S2Eintinf
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
//
in
  S2Eintinf (parse_string (jsvs[0]))
end // end of [parse_S2Eintinf]

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
parse_S2EVar
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2V = parse_s2Var (jsvs[0])
//
in
  S2EVar (s2V)
end // end of [parse_S2EVar]

(* ****** ****** *)

implement
parse_S2Eapp
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2e_fun = parse_s2exp (jsvs[0])
val s2es_arg = parse_list<s2exp> (jsvs[1], parse_s2exp)
//
in
  S2Eapp (s2e_fun, s2es_arg)
end // end of [parse_S2Eapp]

(* ****** ****** *)

implement
parse_S2Emetdec
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2es1 = parse_list<s2exp> (jsvs[0], parse_s2exp)
val s2es2 = parse_list<s2exp> (jsvs[1], parse_s2exp)
//
in
  S2Emetdec (s2es1, s2es2)
end // end of [parse_S2Emetdec]

(* ****** ****** *)

implement
parse_S2Eignored (jsv) = S2Eignored ((*void*))

(* ****** ****** *)

(* end of [parsing_s2exp] *)
