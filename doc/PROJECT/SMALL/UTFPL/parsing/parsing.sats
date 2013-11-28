(*
** Parsing: ATS -> UTFPL
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

fun parse_d2cst (jsv: jsonval): d2cst
fun parse_d2var (jsv: jsonval): d2var

(* ****** ****** *)

fun parse_p2at (jsv: jsonval): p2at

(* ****** ****** *)

fun parse_d2exp (jsv: jsonval): d2exp

(* ****** ****** *)

fun parse_d2ecl (jsv: jsonval): d2ecl

(* ****** ****** *)

(* end of [parsing.sats] *)
