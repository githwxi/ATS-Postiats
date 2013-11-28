(*
** Implementing UTFPL
** with closure-based evaluation
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
"./../utfpl.sats"
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
dynload "./parsing_d2cst.dats"
dynload "./parsing_d2var.dats"
dynload "./parsing_p2at.dats"
dynload "./parsing_d2exp.dats"
dynload "./parsing_d2ecl.dats"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
println! ("Hello from [parsing]!")
//
val inp = stdin_ref
//
val cs = fileref_get_file_string (inp)
val jso =
  json_tokener_parse ($UN.strptr2string(cs))
val jsv = json_object2val0 (jso)
val ((*void*)) = strptr_free (cs)
//
val () =
  fprint! (stdout_ref, "jsv=", jsv)
val () = fprint_newline (stdout_ref)
//
val d2cs = parse_d2eclist (jsv)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main.dats] *)
