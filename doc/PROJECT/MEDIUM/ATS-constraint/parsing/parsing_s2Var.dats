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
fun the_s2Varmap_find (stamp): s2Varopt_vt
extern
fun the_s2Varmap_insert (s2V: s2Var): void

(* ****** ****** *)

local
//
staload FM =
"libats/SATS/funmap_avltree.sats"
staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//
typedef map = $FM.map (stamp, s2Var)
//
var mymap: map = $FM.funmap_nil ()
val the_s2Varmap =
  ref_make_viewptr{map} (view@mymap | addr@mymap)
//
implement
$FM.compare_key_key<stamp> = compare_stamp_stamp
//
in (* in of [local] *)

implement
the_s2Varmap_find
  (k0) = let
//
val (vbox(pf) | p) = ref_get_viewptr (the_s2Varmap)
//
in
  $effmask_ref ($FM.funmap_search_opt (!p, k0))
end // end of [the_s2Varmap_find]

implement
the_s2Varmap_insert
  (s2V0) = let
//
val k0 = s2V0.stamp
val (vbox(pf) | p) = ref_get_viewptr (the_s2Varmap)
val~None_vt ((*void*)) = $effmask_ref ($FM.funmap_insert_opt (!p, k0, s2V0))
//
in
  // nothing
end // end of [the_s2Varmap_find]

end // end of [local]

(* ****** ****** *)

implement
parse_s2Var
  (jsv0) = let
(*
val () =
println! ("parse_s2Var: jsv0 = ", jsv0)
*)
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "s2Var_stamp")
//
val stamp = parse_stamp (jsv1)
//
val opt = the_s2Varmap_find (stamp)
//
in
//
case+ opt of
| ~Some_vt (s2V) => s2V
| ~None_vt ((*void*)) => s2Var_make (stamp)
//
end // end of [parse_s2Var]

(* ****** ****** *)

(* end of [parsing_s2Var.dats] *)
