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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "./../utfpl.sats"
//
(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload "./parsing.sats"

(* ****** ****** *)

extern
fun jsonval_get_field
  (jsv: jsonval, name: string): Option_vt (jsonval)

(* ****** ****** *)

implement
jsonval_get_field
  (jsv0, name) = let
in
//
case+ jsv0 of
| JSONobject
    (lxs) => let
  in
    list_assoc_opt<string,jsonval> (lxs, name)
  end // end of [JSONobject]
| _ (*nonobj*) => None_vt ()
//
end // end of [jsonval_get_field]

(* ****** ****** *)

implement
parse_stamp (jsv0) = let
  val-JSONint(lli) = jsv0 in stamp_make ($UN.cast{int}(lli))
end // end of [parse_stamp]

(* ****** ****** *)

implement
parse_symbol (jsv0) = let
  val-JSONstring(name) = jsv0 in symbol_make (name)
end // end of [parse_symbol]

(* ****** ****** *)

implement
parse_location (jsv0) = let
  val-JSONstring(strloc) = jsv0 in location_make (strloc)
end // end of [parse_location]

(* ****** ****** *)

(* end of [parsing.dats] *)
