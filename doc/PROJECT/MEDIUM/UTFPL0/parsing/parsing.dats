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
//
implement
parse_int
  (jsv0) = let
  val-JSONint (lli) = jsv0 in $UN.cast{int}(lli)
end // end of [parse_int]
//
implement
parse_string
  (jsv0) = let val-JSONstring (str) = jsv0 in str end
//
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

implement
parse_label
  (jsv0) = let
//
val-JSONobject (lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
in
//
case+ lx.0 of
| "LABint" => LABint (parse_int(lx.1))
| "LABsym" => LABsym (parse_symbol(lx.1))
| _(*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
//
end // end of [parse_label]

(* ****** ****** *)

implement
parse_funkind
  (jsv0) = let
//
val-JSONstring(knd) = jsv0
//
in
//
case+ knd of
//
| "FK_fn" => FK_fn ()
| "FK_fnx" => FK_fnx ()
| "FK_fun" => FK_fun ()
//
| _ => FK_ignored () // error-handling
//
end // end of [parse_funkind]

(* ****** ****** *)

implement
parse_valkind
  (jsv0) = let
//
val-JSONstring(knd) = jsv0
//
in
//
case+ knd of
//
| "VK_val" => VK_val ()
| "VK_val_pos" => VK_val_pos ()
| "VK_val_neg" => VK_val_neg ()
//
| _ => VK_ignored () // error-handling
//
end // end of [parse_valkind]

(* ****** ****** *)

implement
{a}(*tmp*)
parse_list
  (jsv0, f) = let
//
val-JSONarray(jsvs) = jsv0
//
fun auxlst
(
  jsvs: jsonvalist, f: jsonval -> a
) : List0 (a) =
  case+ jsvs of
  | list_cons
      (jsv, jsvs) =>
      list_cons{a}(f(jsv), auxlst (jsvs, f))
  | list_nil () => list_nil ()
//
in
  auxlst (jsvs, f)
end // end of [parse_list]

(* ****** ****** *)

implement
{a}(*tmp*)
parse_option
  (jsv0, f) = let
//
val-JSONarray (jsvs) = jsv0
//
in
  case+ jsvs of
  | list_nil () => None(*void*)
  | list_cons (jsv, _) => Some{a}(f(jsv))
end // end of [parse_option]

(* ****** ****** *)

(* end of [parsing.dats] *)
