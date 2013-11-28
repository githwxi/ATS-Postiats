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

fun parse_stamp (jsv: jsonval): stamp
fun parse_symbol (jsv: jsonval): symbol
fun parse_location: jsonval -> location

(* ****** ****** *)

fun{
a:t@ype
} parse_list
  (jsv: jsonval, f: jsonval -> a): List0_vt (a)
// end of[parse_list]

(* ****** ****** *)

fun parse_d2cst (jsv: jsonval): d2cst
fun parse_d2var (jsv: jsonval): d2var

(* ****** ****** *)

fun parse_p2at (jsv: jsonval): p2at

(* ****** ****** *)

fun parse_d2exp (jsv: jsonval): d2exp

(* ****** ****** *)

fun parse_d2ecl (jsv: jsonval): d2ecl
fun parse_d2eclist (jsv: jsonval): d2eclist

(* ****** ****** *)

(* end of [parsing.sats] *)
