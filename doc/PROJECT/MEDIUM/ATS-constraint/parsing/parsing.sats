(*
** Parsing constraints in JSON format
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "./../constraint.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

fun parse_int (jsv: jsonval): int
fun parse_string (jsv: jsonval): string

(* ****** ****** *)

fun parse_stamp (jsv: jsonval): stamp
fun parse_symbol (jsv: jsonval): symbol
fun parse_location (jsv: jsonval): loc_t

(* ****** ****** *)

fun{
a:t@ype
} parse_list
  (jsv: jsonval, f: jsonval -> a): List0 (a)
// end of [parse_list]

(* ****** ****** *)

fun{
a:t@ype
} parse_option
  (jsv: jsonval, f: jsonval -> a): Option (a)
// end of [parse_option]

(* ****** ****** *)

fun parse_s2cst (jsv: jsonval): s2cst
fun parse_s2var (jsv: jsonval): s2var

(* ****** ****** *)

fun parse_s2exp (jsv: jsonval): s2exp

(* ****** ****** *)

fun parse_c3nstr (jsv: jsonval): c3nstr

(* ****** ****** *)

(* end of [parsing.sats] *)
