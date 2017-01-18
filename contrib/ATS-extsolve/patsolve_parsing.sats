(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: May, 2015
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"PATSOLVE_PARSING"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
"{$JSONC}/SATS/json_ML.sats"
//
(* ****** ****** *)
//
typedef
jsnvlst = List0(jsonval)
typedef
jsnvopt = Option(jsonval)
vtypedef
jsnvopt_vt = Option_vt(jsonval)
//
(* ****** ****** *)
//
fun
jsonval_get_field
  (jsonval, string): jsnvopt_vt
//
overload [] with jsonval_get_field
//
(* ****** ****** *)

staload "./patsolve_cnstrnt.sats"

(* ****** ****** *)

fun parse_int (jsnv: jsonval): int
fun parse_string (jsnv: jsonval): string

(* ****** ****** *)

fun parse_stamp (jsnv: jsonval): stamp
fun parse_symbol (jsnv: jsonval): symbol
fun parse_location (jsnv: jsonval): loc_t

(* ****** ****** *)

fun parse_label (jsnv: jsonval): label

(* ****** ****** *)
//
fun
parse_tyreckind (jsnv: jsonval): tyreckind
//
(* ****** ****** *)

fun{
a:t@ype
} parse_list
  (jsnv: jsonval, f: jsonval -> a): List0(a)
// end of [parse_list]

(* ****** ****** *)

fun{
a:t@ype
} parse_option
  (jsnv: jsonval, f: jsonval -> a): Option(a)
// end of [parse_option]

(* ****** ****** *)

fun parse_s2rt (jsnv: jsonval): s2rt
fun parse_s2rtlst (jsnv: jsonval): s2rtlst

(* ****** ****** *)

fun parse_s2rtdat(jsnv: jsonval): s2rtdat
fun parse_s2rtdatlst(jsnv: jsonval): s2rtdatlst

(* ****** ****** *)
//
fun the_s2cstmap_insert(s2cst): void
fun the_s2cstmap_search(stamp): s2cstopt_vt
//
fun the_s2cstmap_listize((*void*)): s2cstlst_vt
//
(* ****** ****** *)
//
fun the_s2varmap_insert(s2var): void
fun the_s2varmap_search(stamp): s2varopt_vt
//
(*
fun the_s2varmap_listize((*void*)): s2varlst_vt
*)
//
(* ****** ****** *)
//
fun the_s2Varmap_insert(s2Var): void
fun the_s2Varmap_search(stamp): s2Varopt_vt
//
(* ****** ****** *)

fun the_s2rtdatmap_get((*void*)): s2rtdatlst

(* ****** ****** *)

fun parse_s2cst (jsnv: jsonval): s2cst
fun parse_s2cstlst (jsnv: jsonval): s2cstlst

(* ****** ****** *)

fun parse_s2var (jsnv: jsonval): s2var
fun parse_s2varlst (jsnv: jsonval): s2varlst

(* ****** ****** *)

fun parse_s2Var (jsnv: jsonval): s2Var
fun parse_s2Varlst (jsnv: jsonval): s2Varlst

(* ****** ****** *)

fun parse_s2exp (jsnv: jsonval): s2exp
fun parse_s2explst (jsnv: jsonval): s2explst

(* ****** ****** *)

fun parse_labs2exp (jsnv: jsonval): labs2exp
fun parse_labs2explst (jsnv: jsonval): labs2explst

(* ****** ****** *)

fun parse_s3itm (jsnv: jsonval): s3itm
fun parse_s3itmlst (jsnv: jsonval): s3itmlst
fun parse_s3itmlstlst (jsnv: jsonval): s3itmlstlst

(* ****** ****** *)

fun parse_h3ypo (jsnv: jsonval): h3ypo

(* ****** ****** *)

fun parse_c3nstr (jsnv: jsonval): c3nstr
fun parse_c3nstropt (jsnv: jsonval): c3nstropt

(* ****** ****** *)
//
fun parse_constraints (jsnv: jsonval): c3nstr
//
fun parse_fileref_constraints (filr: FILEref): c3nstr
//
(* ****** ****** *)

(* end of [patsolve_parsing.sats] *)
