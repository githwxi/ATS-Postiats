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
fun parse_d2exparg (jsv: jsonval): d2exparg

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
//
implement
parse_d2explst
  (jsv0) = (
  parse_list<d2exp> (jsv0, parse_d2exp)
) (* end of [parse_d2explst] *)
//
implement
parse_d2expopt
  (jsv0) = (
  parse_option<d2exp> (jsv0, parse_d2exp)
) (* end of [parse_d2expopt] *)
//
(* ****** ****** *)

extern
fun parse_D2Ecst (jsonval): d2exp_node
extern
fun parse_D2Evar (jsonval): d2exp_node

extern
fun parse_D2Ei0nt (jsonval): d2exp_node
extern
fun parse_D2Ef0loat (jsonval): d2exp_node
extern
fun parse_D2Es0tring (jsonval): d2exp_node

extern
fun parse_D2Esym (jsonval): d2exp_node

extern
fun parse_D2Elet (jsonval): d2exp_node

extern
fun parse_D2Eapplst (jsonval): d2exp_node

extern
fun parse_D2Eifhead (jsonval): d2exp_node

extern
fun parse_D2Elam_dyn (jsonval): d2exp_node

extern
fun parse_D2Eann_seff (jsonval): d2exp_node
extern
fun parse_D2Eann_type (jsonval): d2exp_node
extern
fun parse_D2Eann_funclo (jsonval): d2exp_node

extern
fun parse_D2Eignored (jsonval): d2exp_node

(* ****** ****** *)

extern
fun parse_D2EXPARGsta (jsonval): d2exparg
extern
fun parse_D2EXPARGdyn (jsonval): d2exparg

(* ****** ****** *)

implement
parse_d2exp_node
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_d2exp_node: jsv0 = ", jsv0)
*)
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
//
| "D2Ei0nt" => parse_D2Ei0nt (jsv2)
| "D2Ef0loat" => parse_D2Ef0loat (jsv2)
| "D2Es0tring" => parse_D2Es0tring (jsv2)
//
| "D2Esym" => parse_D2Esym (jsv2)
//
| "D2Elet" => parse_D2Elet (jsv2)
//
| "D2Eapplst" => parse_D2Eapplst (jsv2)
//
| "D2Eifhead" => parse_D2Eifhead (jsv2)
//
| "D2Elam_dyn" => parse_D2Elam_dyn (jsv2)
//
| "D2Eann_seff" => parse_D2Eann_seff (jsv2)
| "D2Eann_type" => parse_D2Eann_type (jsv2)
| "D2Eann_funclo" => parse_D2Eann_funclo (jsv2)
//
| _(*rest*) => parse_D2Eignored (jsv2)
//
end // end of [parse_d2exp_node]

(* ****** ****** *)

implement
parse_D2Ecst
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2c = parse_d2cst (jsvs[0])
//
in
  D2Ecst (d2c)
end // end of [parse_D2Ecst]

(* ****** ****** *)

implement
parse_D2Evar
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2v = parse_d2var (jsvs[0])
//
in
  D2Evar (d2v)
end // end of [parse_D2Evar]

(* ****** ****** *)

implement
parse_D2Ei0nt
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Ei0nt (rep)
end // end of [parse_D2Ei0nt]

(* ****** ****** *)

implement
parse_D2Ef0loat
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Ef0loat (rep)
end // end of [parse_D2Ef0loat]

(* ****** ****** *)

implement
parse_D2Es0tring
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Es0tring (rep)
end // end of [parse_D2Es0tring]

(* ****** ****** *)

implement
parse_D2Esym
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2s = parse_d2sym (jsvs[0])
//
in
  D2Esym (d2s)
end // end of [parse_D2Esym]

(* ****** ****** *)

implement
parse_D2Elet
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2cs = parse_d2eclist (jsvs[0])
val d2e_body = parse_d2exp (jsvs[1])
//
in
  D2Elet (d2cs, d2e_body)
end // end of [parse_D2Elet]

(* ****** ****** *)

implement
parse_D2Eapplst
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e_fun = parse_d2exp (jsvs[0])
val d2as_arg = parse_list<d2exparg> (jsvs[1], parse_d2exparg)
//
in
  D2Eapplst (d2e_fun, d2as_arg)
end // end of [parse_D2Eapplst]

(* ****** ****** *)

implement
parse_D2Eifhead
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
//
val _test = parse_d2exp (jsvs[1])
val _then = parse_d2exp (jsvs[2])
val _else = parse_d2expopt (jsvs[3])
//
in
  D2Eifopt (_test, _then, _else)
end // end of [parse_D2Eifhead]

(* ****** ****** *)

implement
parse_D2Elam_dyn
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
val p2ts = parse_p2atlst (jsvs[2])
val d2e_body = parse_d2exp (jsvs[3])
//
in
  D2Elam (p2ts, d2e_body)
end // end of [parse_D2Elam_dyn]

(* ****** ****** *)

implement
parse_D2Eann_seff
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_seff]

(* ****** ****** *)

implement
parse_D2Eann_type
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_type]

(* ****** ****** *)

implement
parse_D2Eann_funclo
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_funclo]

(* ****** ****** *)

implement
parse_D2Eignored (jsv) = D2Eignored ((*void*))

(* ****** ****** *)

implement
parse_d2exparg
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "d2exparg_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2exparg_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| "D2EXPARGsta" => parse_D2EXPARGsta (jsv2)
| "D2EXPARGdyn" => parse_D2EXPARGdyn (jsv2)
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [parse_d2exparg]

(* ****** ****** *)

implement
parse_D2EXPARGsta
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
//
in
  D2EXPARGsta ((*void*))
end // end of [parse_D2EXPARGsta]

implement
parse_D2EXPARGdyn
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_D2EXPARGdyn: jsv0 = ", jsv0)
*)
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
//
val npf = parse_int (jsvs[0])
val loc = parse_location (jsvs[1])
val d2es = parse_d2explst (jsvs[2])
//
in
  D2EXPARGdyn (npf, loc, d2es)
end // end of [parse_D2EXPARGsta]

(* ****** ****** *)

(* end of [parsing_d2exp.dats] *)
