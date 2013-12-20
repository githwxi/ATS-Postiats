(*
** For parsing exported constraints
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
staload
"./../constraint.sats"
//
(* ****** ****** *)

staload "./parsing.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)
//
dynload "../dynloadall.dats"
//
dynload "./parsing.sats"
dynload "./parsing.dats"
//
dynload "./parsing_s2rt.dats"
dynload "./parsing_s2cst.dats"
dynload "./parsing_s2var.dats"
dynload "./parsing_s2Var.dats"
dynload "./parsing_s2exp.dats"
//
dynload "./parsing_s3itm.dats"
dynload "./parsing_h3ypo.dats"
dynload "./parsing_c3nstr.dats"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
println! ("Hello from [ATS-constraint/parsing]!")
//
val inp = stdin_ref
//
val D = 1024 // depth
val tkr = json_tokener_new_ex (D)
val () = assertloc (json_tokener2ptr (tkr) > 0)
//
val cs =
  fileref_get_file_string (inp)
//
val jso = let
//
val cs2 = $UN.strptr2string(cs)
val len = g1u2i(string_length(cs2))
//
in
  json_tokener_parse_ex (tkr, cs2, len)
end // end of [val]
//
val ((*void*)) = strptr_free (cs)
val ((*void*)) = json_tokener_free (tkr)
//
val jsv = json_object2val0 (jso)
//
val () =
  fprint! (stdout_ref, "jsv=", jsv)
val () = fprint_newline (stdout_ref)
//
val c3t0 = parse_c3nstr (jsv)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main.dats] *)
