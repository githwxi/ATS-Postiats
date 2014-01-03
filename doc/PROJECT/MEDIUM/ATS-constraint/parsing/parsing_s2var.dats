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
fun the_s2varmap_find (stamp): s2varopt_vt
extern
fun the_s2varmap_insert (s2v: s2var): void

(* ****** ****** *)

local
//
staload FM =
"libats/SATS/funmap_avltree.sats"
staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//
typedef map = $FM.map (stamp, s2var)
//
var mymap: map = $FM.funmap_nil ()
val the_s2varmap =
  ref_make_viewptr{map} (view@mymap | addr@mymap)
//
implement
$FM.compare_key_key<stamp> = compare_stamp_stamp
//
in (* in of [local] *)

implement
the_s2varmap_find
  (k0) = let
//
val (vbox(pf) | p) = ref_get_viewptr (the_s2varmap)
//
in
  $effmask_ref ($FM.funmap_search_opt (!p, k0))
end // end of [the_s2varmap_find]

implement
the_s2varmap_insert
  (s2v0) = let
//
val k0 = s2v0.stamp
val (vbox(pf) | p) = ref_get_viewptr (the_s2varmap)
val~None_vt ((*void*)) = $effmask_ref ($FM.funmap_insert_opt (!p, k0, s2v0))
//
in
  // nothing
end // end of [the_s2varmap_find]

end // end of [local]

(* ****** ****** *)

implement
parse_s2var
  (jsv0) = let
(*
val () =
println! ("parse_s2var: jsv0 = ", jsv0)
*)
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "s2var_stamp")
//
val stamp = parse_stamp (jsv2)
//
val opt = the_s2varmap_find (stamp)
//
in
//
case+ opt of
| ~Some_vt (s2v) => s2v
| ~None_vt ((*void*)) => s2v where
  {
    val-~Some_vt(jsv1) =
      jsonval_get_field (jsv0, "s2var_name")
    val sym = parse_symbol (jsv1)
    val s2v = s2var_make (sym, stamp)
    val ((*void*)) = the_s2varmap_insert (s2v)
  } (* end of [None_vt] *)
//
end // end of [parse_s2var]

(* ****** ****** *)

(* end of [parsing_s2var.dats] *)
