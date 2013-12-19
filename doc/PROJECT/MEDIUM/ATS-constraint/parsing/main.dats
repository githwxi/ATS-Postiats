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
dynload "./parsing_s2cst.dats"
dynload "./parsing_s2var.dats"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
println! ("Hello from [ATS-constraint/parsing]!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main.dats] *)
