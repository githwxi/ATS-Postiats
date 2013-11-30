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

fun parse_int (jsv: jsonval): int
fun parse_string (jsv: jsonval): string

(* ****** ****** *)

fun parse_stamp (jsv: jsonval): stamp
fun parse_symbol (jsv: jsonval): symbol
fun parse_location (jsv: jsonval): loc_t

(* ****** ****** *)

fun parse_funkind: jsonval -> funkind
fun parse_valkind: jsonval -> valkind

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

fun parse_d2cst (jsv: jsonval): d2cst
fun parse_d2var (jsv: jsonval): d2var
fun parse_d2sym (jsv: jsonval): d2sym

(* ****** ****** *)

fun parse_p2at (jsv: jsonval): p2at
fun parse_p2atlst (jsv: jsonval): p2atlst

(* ****** ****** *)

fun parse_d2exp (jsv: jsonval): d2exp
fun parse_d2explst (jsv: jsonval): d2explst
fun parse_d2expopt (jsv: jsonval): d2expopt

(* ****** ****** *)

fun parse_d2ecl (jsv: jsonval): d2ecl
fun parse_d2eclist (jsv: jsonval): d2eclist

(* ****** ****** *)

(* end of [parsing.sats] *)
