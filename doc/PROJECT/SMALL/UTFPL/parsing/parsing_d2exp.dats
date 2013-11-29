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
//
implement
parse_d2explst
  (jsv0) = (
  parse_list<d2exp> (jsv0, parse_d2exp)
) (* end of [parse_d2explst] *)
//
(* ****** ****** *)

extern
fun parse_D2Ecst (jsonval): d2exp_node

extern
fun parse_D2Evar (jsonval): d2exp_node

extern
fun parse_D2Eapplst (jsonval): d2exp_node

extern
fun parse_D2Eifhead (jsonval): d2exp_node

extern
fun parse_D2Elam_dyn (jsonval): d2exp_node

extern
fun parse_D2Eann_seff (jsonval): d2exp_node

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
| "D2Eifhead" => parse_D2Eifhead (jsv2)
| "D2Eapplst" => parse_D2Eapplst (jsv2)
*)
| "D2Elam_dyn" => parse_D2Elam_dyn (jsv2)
//
| "D2Eann_seff" => parse_D2Eann_seff (jsv2)
//
| _(*rest*) => parse_D2Eerr (jsv2)
//
end // end of [parse_d2exp_node]

(* ****** ****** *)

implement
parse_D2Ecst
  (jsv0) = let
//
val-JSONarray(A, n) = jsv0
val () = assertloc (n >= 1)
val d2c = parse_d2cst (A[0])
//
in
  D2Ecst (d2c)
end // end of [parse_D2Ecst]

(* ****** ****** *)

implement
parse_D2Evar
  (jsv0) = let
//
val-JSONarray(A, n) = jsv0
val () = assertloc (n >= 1)
val d2v = parse_d2var (A[0])
//
in
  D2Evar (d2v)
end // end of [parse_D2Evar]

(* ****** ****** *)

implement
parse_D2Elam_dyn
  (jsv0) = let
//
val-JSONarray(A, n) = jsv0
val () = assertloc (n >= 4)
val p2ts = parse_p2atlst (A[2])
val d2e_body = parse_d2exp (A[3])
//
in
  D2Elam (p2ts, d2e_body)
end // end of [parse_D2Elam_dyn]

(* ****** ****** *)

implement
parse_D2Eann_seff
  (jsv0) = let
//
val-JSONarray(A, n) = jsv0
val () = assertloc (n >= 2)
val d2e = parse_d2exp (A[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Elam_dyn]

(* ****** ****** *)

implement
parse_D2Eerr (jsv) = D2Eerr ((*void*))

(* ****** ****** *)

(* end of [parsing_d2exp.dats] *)
