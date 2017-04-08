(*
  A constraint solver for ATS2
  
  Constraints are read in through JSON and then fed to an SMT
  solver in order to check for their validity.
*)

(* ****** ****** *)

//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

staload "solver.sats"

(* ****** ****** *)

implement main0 () =
{
//
val inp = stdin_ref
//
val constraints =
  fileref_get_file_string (inp)
//
val D = 1024 // depth
val tkr = json_tokener_new_ex (D)
val () = assertloc (json_tokener2ptr (tkr) > 0)
//
val json = let
  val cs2 = $UN.strptr2string (constraints)
  val len = g1u2i (string_length (cs2))
in
  json_tokener_parse_ex (tkr, cs2, len)
end
//
val ((**)) = strptr_free (constraints)
val ((**)) = json_tokener_free (tkr)
//
val constraints = json_object2val0 (json)
//
val valid = constraint_solve (constraints)
}