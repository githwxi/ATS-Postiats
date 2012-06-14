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

abstype position
abstype location

fun fprint_position (out: FILEref, x: position): void
fun fprint_location (out: FILEref, x: location): void

(* ****** ****** *)

absviewtype lexbufobj
fun lexbufobj_make_fileref (inp: FILEref): lexbufobj
fun lexbufobj_make_charlst_vt (inp: List_vt (char)): lexbufobj
fun lexbufobj_free (lbf: lexbufobj): void // endfun

(* ****** ****** *)

abstype token
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

abstype d0ecl

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

absviewtype tokbufobj
fun tokbufobj_make_lexbufobj (lbf: lexbufobj): tokbufobj
fun tokbufobj_free (tbf: tokbufobj): void // endfun
fun tokbufobj_unget_token (tbf: !tokbufobj, tok: token): void

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
psynmark_process (
  psm: psynmark, putc: putc_type
) : void // end of [psynmark_process]

fun{} // this one is a generic
psynmarklst_process (
  pos0: lint, psms: &psynmarklst_vt, putc: putc_type
) : void // end of [psynmarklst_process]

viewtypedef
psynmarklstlst_vt = List_vt (psynmarklst_vt)
fun{} // this one is a generic
psynmarklstlst_process (
  pos0: lint, psmss: &psynmarklstlst_vt, putc: putc_type
) : void // end of [psynmarklstlst_process]

(* ****** ****** *)

fun fstring_putc
  (s: string, putc: putc_type): int(*nerr*)
// end of [fstring_putc]

(* ****** ****** *)

fun{}
fileref_psynmarklstlst_process (
  inp: FILEref, psmss: psynmarklstlst_vt, putc: putc_type
) : void // end of [fileref_psynmarklstlst_process]

fun{}
charlst_psynmarklstlst_process (
  inp: List_vt (char), psmss: psynmarklstlst_vt, putc: putc_type
) : void // end of [charlst_psynmarklstlst_process]

(* ****** ****** *)

(* end of [libatsyntax.sats] *)
