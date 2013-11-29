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
//
implement
parse_d2eclist
  (jsv0) = (
  parse_list<d2ecl> (jsv0, parse_d2ecl)
) (* end of [parse_d2eclist] *)
//
(* ****** ****** *)

extern
fun parse_f2undec (jsonval): f2undec
extern
fun parse_v2aldec (jsonval): v2aldec

(* ****** ****** *)

extern
fun parse_D2Cfundecs (jsonval): d2ecl_node

extern
fun parse_D2Cvaldecs (jsonval): d2ecl_node

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
| "D2Cfundecs" => parse_D2Cfundecs (jsv2)
| "D2Cvaldecs" => parse_D2Cvaldecs (jsv2)
| _(*not-yet-processed*) => parse_D2Cerr (jsv2)
//
end // end of [parse_d2ecl_node]

(* ****** ****** *)

implement
parse_f2undec
  (jsv0) = let
//
val-~Some_vt(loc) = 
  jsonval_get_field (jsv0, "f2undec_loc")
val-~Some_vt(d2v) =
  jsonval_get_field (jsv0, "f2undec_var")
val-~Some_vt(def) = 
  jsonval_get_field (jsv0, "f2undec_def")
//
val loc =
  parse_location (loc)
val d2v = parse_d2var (d2v)
val def = parse_d2exp (def)
//
in
  f2undec_make (loc, d2v, def)
end // end of [parse_f2undec]

(* ****** ****** *)

implement
parse_v2aldec
  (jsv0) = let
//
val-~Some_vt(loc) = 
  jsonval_get_field (jsv0, "v2aldec_loc")
val-~Some_vt(p2t) =
  jsonval_get_field (jsv0, "v2aldec_pat")
val-~Some_vt(def) = 
  jsonval_get_field (jsv0, "v2aldec_def")
//
val loc =
  parse_location (loc)
val p2t = parse_p2at (p2t)
val def = parse_d2exp (def)
//
in
  v2aldec_make (loc, p2t, def)
end // end of [parse_v2aldec]

(* ****** ****** *)

implement
parse_D2Cfundecs
  (jsv0) = let
//
val-JSONarray(A, n) = jsv0
val () = assertloc (n >= 3)
val knd = parse_funkind (A[0])
val f2ds = parse_list<f2undec> (A[2], parse_f2undec)
//
in
  D2Cfundecs (knd, f2ds)
end // end of [parse_D2Cfundecs]

(* ****** ****** *)

implement
parse_D2Cvaldecs
  (jsv0) = let
//
val-JSONarray(A, n) = jsv0
val () = assertloc (n >= 2)
val knd = parse_valkind (A[0])
val v2ds = parse_list<v2aldec> (A[1], parse_v2aldec)
//
in
  D2Cvaldecs (knd, v2ds)
end // end of [parse_D2Cvaldecs]

(* ****** ****** *)

implement
parse_D2Cerr (jsv0) = D2Cerr ((*void*))

(* ****** ****** *)

(* end of [parsing_d2ecl.dats] *)
