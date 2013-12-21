(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./utfpl.sats"
staload "./utfpl_eval.sats"

(* ****** ****** *)

staload "./parsing/parsing.sats"
staload "./evaluating/eval.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

implement
utfpl_eval_fileref
  (inp) = let
//
val dp = 1024 // depth
val tkr = json_tokener_new_ex (dp)
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
(*
val () =
  fprint! (stdout_ref, "jsv=", jsv)
val () = fprint_newline (stdout_ref)
*)
//
val d2cs = parse_d2eclist (jsv)
//
(*
val () =
  fprint! (stdout_ref, "d2cs=\n", d2cs)
val () = fprint_newline (stdout_ref)
*)
//
val env = eval0_d2eclist (d2cs)
//
in
  // nothing
end // end of [utfpl_eval_fileref]

(* ****** ****** *)

(* end of [utfpl_eval.dats] *)
