(*
** Parsing: ATS -> UTFPL
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
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
fun the_d2varmap_find (stamp): d2varopt_vt
extern
fun the_d2varmap_insert (d2v: d2var): void

(* ****** ****** *)

extern
fun d2var_make_name_stamp (string, stamp): d2var

(* ****** ****** *)

implement
parse_d2var
  (jsv0) = let
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2var_stamp")
//
val-JSONint(int) = jsv2
val stamp = stamp_make (g0i2i(int))
//
val opt = the_d2varmap_find (stamp)
//
in
//
case+ opt of
| ~Some_vt (d2v) => d2v
| ~None_vt ((*void*)) => d2v where
  {
    val-~Some_vt(jsv1) =
      jsonval_get_field (jsv0, "d2var_name")
    val-JSONstring(name) = jsv1
    val d2v = d2var_make_name_stamp (name, stamp)
    val ((*void*)) = the_d2varmap_insert (d2v)
  } (* end of [None_vt] *)
//
end // end of [parse_d2var]

(* ****** ****** *)

(* end of [parsing_d2var.dats] *)
