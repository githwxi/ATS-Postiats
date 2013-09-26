(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)

typedef charlst = List (char)
viewtypedef charlst_vt = List_vt (char)

(* ****** ****** *)

staload ERR = "src/pats_error.sats"

(* ****** ****** *)

staload SYM = "src/pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload LOC = "src/pats_location.sats"
typedef position = $LOC.position
typedef location = $LOC.location

(* ****** ****** *)

fun fprint_position (out: FILEref, x: position): void
fun fprint_location (out: FILEref, x: location): void

(* ****** ****** *)

staload FIL = "src/pats_filename.sats"
(*
// HX-2012-12:
// this is needed for [#include] and [staload]
*)
fun libatsynmark_filename_set_current (name: string): void

(* ****** ****** *)

absviewtype lexbufobj
fun lexbufobj_make_string (inp: string): lexbufobj
fun lexbufobj_make_fileref (inp: FILEref): lexbufobj
fun lexbufobj_make_charlst_vt (inp: charlst_vt): lexbufobj
fun lexbufobj_free (lbf: lexbufobj): void // endfun

(* ****** ****** *)

staload
LEX = "src/pats_lexing.sats"
typedef token = $LEX.token
typedef tokenlst = List (token)
viewtypedef tokenlst_vt = List_vt (token)

(* ****** ****** *)

fun token_get_loc (x: token): location

fun fprint_token (out: FILEref, x: token): void

(* ****** ****** *)

fun token_is_eof (x: token): bool
fun token_is_comment (x: token): bool
fun token_is_extcode (x: token): bool
fun token_is_keyword (x: token): bool

fun token_is_char (x: token): bool
fun token_is_integer (x: token): bool
fun token_is_float (x: token): bool
fun token_is_string (x: token): bool

(* ****** ****** *)

fun lexbufobj_get_tokenlst (lbf: !lexbufobj): tokenlst_vt

(* ****** ****** *)

absviewtype tokbufobj
fun tokbufobj_make_lexbufobj (lbf: lexbufobj): tokbufobj
fun tokbufobj_free (tbf: tokbufobj): void // endfun
fun tokbufobj_unget_token (tbf: !tokbufobj, tok: token): void

(* ****** ****** *)

staload
SYN = "src/pats_syntax.sats"
typedef p0at = $SYN.p0at
typedef d0ecl = $SYN.d0ecl

(* ****** ****** *)

fun test_symbol_p0at (sym: symbol, p0t: p0at): bool
fun test_symbol_d0ecl (sym: symbol, d0c: d0ecl): bool

(* ****** ****** *)

datatype
d0eclrep =
  | D0ECLREPsing of (d0ecl, charlst)
  | D0ECLREPinclude of (d0ecl, charlst, d0eclreplst)
  | D0ECLREPguadecl of (guad0eclrep)

and guad0eclrep =
  | GUAD0ECLREPone of (d0eclreplst)
  | GUAD0ECLREPtwo of (d0eclreplst, d0eclreplst)
  | GUAD0ECLREPcons of (d0eclreplst, guad0eclrep)

where d0eclreplst = List (d0eclrep)

(* ****** ****** *)

fun charlst_declitemize
  (stadyn: int, inp: charlst_vt): d0eclreplst
// end of [charlst_declitemize]

(* ****** ****** *)
//
// HX: global references
abstype globalref // for sta/dyn-constants
//
(* ****** ****** *)

datatype
synmark =
//
  | SMnone of ()
//
  | SMcomment of () // comment
  | SMkeyword of () // keyword
  | SMextcode of () // external code
//
  | SMstaexp of () // static expression
  | SMprfexp of () // proof expression
  | SMdynexp of () // dynamic expression
  | SMneuexp of () // neutral expression
//
  | SMstalab of () // static labels
  | SMdynlab of () // dynamic labels
//
  | SMdynstr of () // dynamic strings
//
  | SMscst_def of (globalref)
  | SMscst_use of (globalref)
//
  | SMscon_dec of (globalref)
  | SMscon_use of (globalref)
  | SMscon_assume of (globalref)
//
  | SMdcst_dec of (globalref)
  | SMdcst_use of (globalref)
  | SMdcst_implement of (globalref)
//
// end of [synmark]

fun fprint_synmark (out: FILEref, sm: synmark): void

(* ****** ****** *)

datatype
psynmark = PSM of
  (lint, synmark, int(*knd*)) // knd: 0/1: beg/end
// end of [psynmark]
typedef psynmarklst = List (psynmark)
viewtypedef psynmarklst_vt = List_vt (psynmark)

fun fprint_psynmark (out: FILEref, psm: psynmark): void

(* ****** ****** *)

(*
** HX-2012-06:
** synmark info for tokens
*)
fun listize_token2psynmark
  (toks: !tokenlst_vt): psynmarklst_vt
// end of [listize_token2psynmark]

(* ****** ****** *)

(*
** HX-2012-06:
** splitting psm list into two:
** beg-psm list and end-psm list
*)
fun psynmarklst_split (xs: psynmarklst_vt)
  : @(psynmarklst_vt(*beg*), psynmarklst_vt(*end*))
// end of [psynmarklst_split]

(* ****** ****** *)

(*
** HX-2012-06:
** synmark info for various syntatic entities
*)
fun tokbufobj_get_psynmarklst
  (stadyn: int, tbf: !tokbufobj): psynmarklst_vt
// end of [tokbufobj_get_psynmarklst]

(* ****** ****** *)

typedef
putc_type = (char) -<cloref1> int

fun{} // a specific template
psynmark_process
  (psm: psynmark, putc: putc_type): void
// end of [psynmark_process]

fun
psynmark_process_xhtml_bground
  (psm: psynmark, putc: putc_type): void
// end of [psynmark_process_xhtml_bground]

fun
psynmark_process_xhtml_embedded
  (psm: psynmark, putc: putc_type): void
// end of [psynmark_process_xhtml_embedded]

(* ****** ****** *)

fun{} // this one is a generic
psynmarklst_process
(
  pos0: lint, psms: &psynmarklst_vt, putc: putc_type
) : void // end of [psynmarklst_process]

(* ****** ****** *)

viewtypedef
psynmarklstlst_vt = List_vt (psynmarklst_vt)

fun{} // this one is a generic
psynmarklstlst_process
(
  pos0: lint, psmss: &psynmarklstlst_vt, putc: putc_type
) : void // end of [psynmarklstlst_process]

(* ****** ****** *)

fun fhtml_putc (c: char, putc: putc_type): int(*nerr*)
fun fstring_putc (s: string, putc: putc_type): int(*nerr*)

(* ****** ****** *)

fun{}
string_psynmarklstlst_process
(
  inp: string, psmss: psynmarklstlst_vt, putc: putc_type
) : void // end of [string_psynmarklstlst_process]

fun{}
fileref_psynmarklstlst_process
(
  inp: FILEref, psmss: psynmarklstlst_vt, putc: putc_type
) : void // end of [fileref_psynmarklstlst_process]

fun{}
charlst_psynmarklstlst_process
(
  inp: charlst_vt, psmss: psynmarklstlst_vt, putc: putc_type
) : void // end of [charlst_psynmarklstlst_process]

(* ****** ****** *)

fun
lexbufobj_level1_psynmarkize
  (stadyn: int, lbf: lexbufobj): psynmarklstlst_vt
// end of [lexbufobj_level1_psynmarkize]

(* ****** ****** *)

fun{}
string_pats2xhtmlize (stadyn: int, code: string): strptr1
// end of [string_pats2xhtmlize]
fun{}
charlst_pats2xhtmlize (stadyn: int, code: charlst): strptr1
// end of [charlst_pats2xhtmlize]

(* ****** ****** *)

fun string_pats2xhtmlize_bground
  (stadyn: int, code: string): strptr1
fun charlst_pats2xhtmlize_bground
  (stadyn: int, code: charlst): strptr1

fun string_pats2xhtmlize_embedded
  (stadyn: int, code: string): strptr1
fun charlst_pats2xhtmlize_embedded
  (stadyn: int, code: charlst): strptr1

(* ****** ****** *)
//
// HX: it is for building ATSLIB documentation
//
fun d0eclreplst_find_synop
  (xs: d0eclreplst, sym: symbol): List_vt (charlst)
//
(* ****** ****** *)

(* end of [libatsynmark.sats] *)
