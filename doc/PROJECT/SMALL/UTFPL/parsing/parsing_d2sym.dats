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

implement
parse_d2sym
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "d2sym_name")
//
val sym = parse_symbol (jsv1)
//
in
  d2sym_make (sym)
end // end of [parse_d2sym]

(* ****** ****** *)

(* end of [parsing_d2sym.dats] *)
