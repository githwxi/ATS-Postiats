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
  
fun parse_s2rt (jsv: jsonval): s2rt
  
(* ****** ****** *)

fun parse_s2cst (jsv: jsonval): s2cst
fun parse_s2var (jsv: jsonval): s2var
fun parse_s2Var (jsv: jsonval): s2Var

(* ****** ****** *)

fun parse_s2exp (jsv: jsonval): s2exp

(* ****** ****** *)

fun parse_s3itm (jsv: jsonval): s3itm
fun parse_s3itmlst (jsv: jsonval): s3itmlst
fun parse_s3itmlstlst (jsv: jsonval): s3itmlstlst

(* ****** ****** *)

fun parse_h3ypo (jsv: jsonval): h3ypo

(* ****** ****** *)

fun parse_c3nstr (jsv: jsonval): c3nstr
fun parse_c3nstropt (jsv: jsonval): c3nstropt

(* ****** ****** *)

(* end of [parsing.sats] *)
