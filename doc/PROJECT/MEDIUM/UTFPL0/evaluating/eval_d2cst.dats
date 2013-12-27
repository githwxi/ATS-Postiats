(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../utfpl.sats"
staload
"./../utfpleval.sats"
//
staload "./eval.sats"
//
(* ****** ****** *)

implement
eval_d2cst
  (env, d2c) = let
  val opt = the_d2cstmap_find (d2c)
in
  case+ opt of
  | ~Some_vt (def) => def | ~None_vt () => VALcst (d2c)
end // end of [eval_d2cst]

(* ****** ****** *)

local
//
staload FM =
"libats/SATS/funmap_avltree.sats"
staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//
typedef map = $FM.map (d2cst, value)
//
var mymap: map = $FM.funmap_nil ()
val the_d2cstmap =
  ref_make_viewptr{map}(view@mymap | addr@mymap)
//
implement
$FM.compare_key_key<d2cst> = compare_d2cst_d2cst
//
in (* in of [local] *)

implement
the_d2cstmap_add
  (d2c, def) = let
//
val (vbox(pf) | p) =
  ref_get_viewptr (the_d2cstmap)
//
val opt =
$effmask_ref ($FM.funmap_insert_opt (!p, d2c, def))
//
in
//
case+ opt of | ~Some_vt _ => () | ~None_vt () => ()
//
end // end of [the_d2cstmap_add]

(* ****** ****** *)

implement
the_d2cstmap_find
  (d2c) = let
//
val (vbox(pf) | p) =
  ref_get_viewptr (the_d2cstmap)
//
in
  $effmask_ref ($FM.funmap_search_opt (!p, d2c))
end // end of [the_d2cstmap_find]

end // end of [local]

(* ****** ****** *)

(* end of [eval_d2cst.dats] *)
