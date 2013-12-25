(*
** Parsing: ATS/JSON -> UTFPL
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
fun
parse_p2at_node (jsv: jsonval): p2at_node

(* ****** ****** *)

extern
fun parse_labp2at (jsv: jsonval): labp2at

(* ****** ****** *)

implement
parse_p2at
  (jsv0) = let
//
(*
val () =
println! ("parse_p2at: jsv0 = ", jsv0)
*)
//
val-~Some_vt(jsv) =
  jsonval_get_field (jsv0, "p2at_loc") 
val loc = parse_location (jsv)
val-~Some_vt(jsv) =
  jsonval_get_field (jsv0, "p2at_node") 
val node = parse_p2at_node (jsv)
//
in
  p2at_make_node (loc, node)
end // end of [parse_p2at]

(* ****** ****** *)
//
implement
parse_p2atlst
  (jsv0) = (
  parse_list<p2at> (jsv0, parse_p2at)
) (* end of [parse_p2atlst] *)
//
(* ****** ****** *)

extern
fun parse_P2Tany (jsonval): p2at_node
extern
fun parse_P2Tvar (jsonval): p2at_node

extern
fun parse_P2Tempty (jsonval): p2at_node

extern
fun parse_P2Trec (jsonval): p2at_node

extern
fun parse_P2Tann (jsonval): p2at_node

extern
fun parse_P2Tignored (jsonval): p2at_node

(* ****** ****** *)

extern
fun parse_LABP2ATnorm (jsonval): labp2at
extern
fun parse_LABP2ATomit (jsonval): labp2at

(* ****** ****** *)

implement
parse_p2at_node
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "p2at_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "p2at_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| "P2Tany" => parse_P2Tany (jsv2)
| "P2Tvar" => parse_P2Tvar (jsv2)
//
| "P2Tempty" => parse_P2Tempty (jsv2)
//
| "P2Trec" => parse_P2Trec (jsv2)
//
| "P2Tann" => parse_P2Tann (jsv2)
//
| _(*yet-to-be-processed*) => parse_P2Tignored (jsv2)
//
end // end of [parse_p2at_node]

(* ****** ****** *)

implement
parse_labp2at
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "labp2at_name")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "labp2at_arglst")
//
val-JSONstring(name) = jsv1
//
in
//
case+ name of
//
| "LABP2ATnorm" => parse_LABP2ATnorm (jsv2)
| "LABP2ATomit" => parse_LABP2ATomit (jsv2)
//
| _(*deadcode*) =>
    let val () = assertloc(false) in exit(1) end
//
end // end of [parse_labp2at]

(* ****** ****** *)

implement
parse_P2Tany
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
//
in
  P2Tany ()
end // end of [parse_P2Tany]

(* ****** ****** *)

implement
parse_P2Tvar
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
val () = assertloc (length(jsvs) >= 1)
val d2v = parse_d2var (jsvs[0])
//
in
  P2Tvar (d2v)
end // end of [parse_P2Tvar]

(* ****** ****** *)

implement
parse_P2Tempty
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
//
in
  P2Tempty ()
end // end of [parse_P2Tempty]

(* ****** ****** *)

implement
parse_P2Trec
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
val () = assertloc (length(jsvs) >= 3)
val lp2ts =
  parse_list<labp2at> (jsvs[2], parse_labp2at)
//
in
  P2Trec (lp2ts)
end // end of [parse_P2Trec]

(* ****** ****** *)

implement
parse_P2Tann
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
val () = assertloc (length(jsvs) >= 2)
val p2t = parse_p2at (jsvs[0])
//
in
  P2Tpat (p2t)
end // end of [parse_P2Tann]

(* ****** ****** *)

implement
parse_P2Tignored (jsv) = P2Tignored ((*void*))

(* ****** ****** *)

implement
parse_LABP2ATnorm
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
val () = assertloc (length(jsvs) >= 2)
val lab = parse_label (jsvs[0])
//
in
  LABP2ATnorm (lab, parse_p2at (jsvs[1]))
end // end of [parse_LABP2ATnorm]

(* ****** ****** *)

implement
parse_LABP2ATomit
  (jsv2) = let
//
val-JSONarray(jsvs) = jsv2
val () = assertloc (length(jsvs) >= 1)
//
in
  LABP2ATomit (parse_location (jsvs[0]))
end // end of [parse_LABP2ATomit]

(* ****** ****** *)

(* end of [parsing_p2at.dats] *)
