(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
stadef location = $LOC.location
stadef position = $LOC.position

(* ****** ****** *)

staload
LBF = "pats_lexbuf.sats"
stadef lexbuf = $LBF.lexbuf

(* ****** ****** *)

datatype
token_node =
//
  | T_NONE of () // dummy
//
  | T_AT of () // @
//
  | T_BACKSLASH of () // \
  | T_BANG of () // !
  | T_BAR of () // |
  | T_BQUOTE of () // `
//
  | T_COLON of () // :
  | T_COLONLT of () // :<
(*
  | T_COLONLTGT of () // :<> // HX: impossible
*)
//
  | T_DOLLAR of () // $
//
  | T_DOT of () // .
  | T_DOTDOT of () // ..
  | T_DOTDOTDOT of () // ...
//
  | T_DOTINT of int // .[0-9]+
//
  | T_EQ of () // =
  | T_EQGT of () // =>
  | T_EQLT of () // =<
  | T_EQLTGT of () // =<>
  | T_EQSLASHEQGT of () // =/=>
  | T_EQGTGT of () // =>>
  | T_EQSLASHEQGTGT of () // =/=>>
//
  | T_HASH of () // #
//
  | T_LT of () // < // for opening a tmparg
  | T_GT of () // > // for closing a tmparg
//
  | T_GTLT of () // <>
  | T_DOTLT of () // .<
  | T_GTDOT of () // >.
  | T_DOTLTGTDOT of () // .<>.
//
  | T_MINUSGT of () // ->
  | T_MINUSLT of () // -<
  | T_MINUSLTGT of () // -<>
//
  | T_TILDE of () // ~
//
  | T_ABSTYPE of int // abstype, abst@ype, absprop, absview, absviewtype, absviewt@ype
  | T_AND of () // and
  | T_AS of () // as
  | T_ASSUME of () // assume
  | T_BEGIN of () // begin
  | T_BRKCONT of int // break and continue
  | T_CASE of caskind // case, case-, case+
  | T_CLASSDEC of () // classdec
  | T_DATASORT of () // datasort
  | T_DATATYPE of int // datatype, dataprop, dataview, dataviewtype
  | T_DO of () // do
  | T_DYNLOAD of () // dynload
  | T_ELSE of () // else
  | T_END of () // end
  | T_EXCEPTION of () // exception
  | T_EXTERN of () // extern
  | T_EXTYPE of () // extype
  | T_EXTVAL of () // extval
  | T_FIX of int // fix and fix@
  | T_FIXITY of fxtykind // infix, infixl, infixr, prefix, postfix
  | T_FOR of int // for and for*
  | T_FUN of funkind // fun
  | T_IF of () // if
  | T_IMPLEMENT of () // implement
  | T_IN of () // in
  | T_LAM of int // lam, llam and lam@
  | T_LET of () // let
  | T_LOCAL of () // local
  | T_MACDEF of int // macdef, macrodef
  | T_NONFIX of () // nonfix
  | T_OVERLOAD of () // overload
  | T_OF of () // of
  | T_OP of () // op
  | T_REC of () // rec
  | T_REFAT of () // ref@
  | T_SCASE of () // scase
  | T_SIF of () // sif
  | T_SORTDEF of () // sortdef
  | T_STACST of () // stacst
  | T_STADEF of () // stadef
  | T_STALOAD of () // staload
  | T_STAVAR of () // stavar
  | T_SYMELIM of () // symelim
  | T_SYMINTR of () // symintr
  | T_THEN of () // then
  | T_TKINDEF of () // tkindef // for introducting tkinds
  | T_TRY of () // try
  | T_TYPE of int // type, type+, type-
  | T_TYPEDEF of int // typedef, propdef, viewdef, viewtypedef
  | T_VAL of valkind // val, val+, val-, prval
  | T_VAR of () // var
  | T_WHEN of () // when
  | T_WHERE of () // where
  | T_WHILE of int // while(0) and while*(1)
  | T_WITH of () // with
  | T_WITHTYPE of int // withtype, withprop, withview, withviewtype
//
  | T_ADDRAT of () // addr@
  | T_FOLDAT of () // fold@
  | T_FREEAT of () // free@
  | T_VIEWAT of () // view@
//
  | T_DLRARRSZ of () // $arrsz
  | T_DLRDYNLOAD of () // $dynload
  | T_DLRDELAY of int // $delay and $ldelay
  | T_DLREFFMASK of () // $effmask
  | T_DLREFFMASK_ARG of int // ntm(0), exn(1), ref(2), wrt(3), all(4)
  | T_DLREXTERN of () // $extern
  | T_DLREXTVAL of () // $extval
  | T_DLREXTYPE of () // $extype
  | T_DLREXTYPE_STRUCT of () // $extype_struct
  | T_DLRRAISE of () // $raise
  | T_DLRLST of int // $lst and $lst_t and $lst_vt
  | T_DLRREC of int // $rec and $rec_t and $rec_vt
  | T_DLRTUP of int // $tup and $tup_t and $tup_vt
//
  | T_SRPASSERT of () // #assert
  | T_SRPDEFINE of () // #define
  | T_SRPELIF of () // #elif
  | T_SRPELIFDEF of () // #elifdef
  | T_SRPELIFNDEF of () // #elifndef
  | T_SRPELSE of () // #else
  | T_SRPENDIF of () // #endif
  | T_SRPERROR of () // #error
  | T_SRPIF of () // #if
  | T_SRPIFDEF of () // #ifdef
  | T_SRPIFNDEF of () // #ifndef
  | T_SRPINCLUDE of () // #include
  | T_SRPPRINT of () // #print
  | T_SRPTHEN of () // #then
  | T_SRPUNDEF of () // #undef
//
  | T_SRPFILENAME of () // #FILENAME
  | T_SRPLOCATION of () // #LOCATION
//
  | T_IDENT_alp of string
  | T_IDENT_sym of string
  | T_IDENT_arr of string
  | T_IDENT_tmp of string
  | T_IDENT_dlr of string
  | T_IDENT_srp of string
  | T_IDENT_ext of string
//
  | T_CHAR of char
//
  | T_INTEGER of (
      int(*base*), string(*rep*), uint(*suffix*)
    ) // end of [T_INTEGER]
//
  | T_FLOAT of (int(*base*), string(*rep*), uint(*suffix*))
//
  | T_STRING of string
//
(*
  | T_LABEL of (int(*knd*), string)
*)
//
  | T_LPAREN of () // (
  | T_RPAREN of () // )
  | T_LBRACKET of () // [
  | T_RBRACKET of () // ]
  | T_LBRACE of () // {
  | T_RBRACE of () // }
//
  | T_COMMA of () // ,
  | T_SEMICOLON of () // ;
//
  | T_ATLPAREN of ()  // @(
  | T_QUOTELPAREN of ()  // '(
  | T_ATLBRACKET of ()  // @[
  | T_QUOTELBRACKET of () // '[
  | T_HASHLBRACKET of () // #[
  | T_ATLBRACE of () // @{
  | T_QUOTELBRACE of () // '{
//
  | T_BQUOTELPAREN of () // `( // macro syntax
  | T_COMMALPAREN of ()     // ,( // macro syntax
  | T_PERCENTLPAREN of ()   // %( // macro syntax
//
  | T_EXTCODE of (int(*kind*), string) // external code
//
  | T_COMMENT_line of () // line comment
  | T_COMMENT_block of () // block comment
  | T_COMMENT_rest of () // rest-of-file comment
//
  | T_ERR of () // for errors
//
  | T_EOF of () // end-of-file
// end of [token_node]

typedef token = '{
  token_loc= location, token_node= token_node
} // end of [token]

(* ****** ****** *)

typedef
tnode = token_node

val ABSTYPE : tnode
val ABST0YPE : tnode
val ABSPROP : tnode
val ABSVIEW : tnode
val ABSVIEWTYPE : tnode
val ABSVIEWT0YPE : tnode

val ADDR : tnode
val ADDRAT : tnode

val BREAK : tnode
val CONTINUE : tnode

val CASE : tnode
val CASE_pos : tnode
val CASE_neg : tnode

val DATATYPE : tnode
val DATAPROP : tnode
val DATAVIEW : tnode
val DATAVIEWTYPE : tnode

val FUN : tnode
val PRFUN : tnode
val PRAXI : tnode
val CASTFN : tnode
val FN : tnode
val FNSTAR : tnode
val PRFN : tnode

val FOLD : tnode
val FOLDAT : tnode

val FIX : tnode
val FIXAT : tnode

val FOR : tnode
val FORSTAR : tnode

val FREE : tnode
val FREEAT : tnode

val INFIX : tnode
val INFIXL : tnode
val INFIXR : tnode
val PREFIX : tnode
val POSTFIX : tnode

val LAM : tnode
val LAMAT : tnode
val LLAM : tnode
val LLAMAT : tnode

val MACDEF  : tnode
val MACRODEF : tnode

val REF : tnode
val REFAT : tnode

val TKINDEF : tnode

val TYPE : tnode
val TYPE_pos : tnode
val TYPE_neg : tnode
val T0YPE : tnode
val T0YPE_pos : tnode
val T0YPE_neg : tnode
val PROP : tnode
val PROP_pos : tnode
val PROP_neg : tnode
val VIEW : tnode
val VIEWAT : tnode
val VIEW_pos : tnode
val VIEW_neg : tnode
val VIEWTYPE : tnode
val VIEWTYPE_pos : tnode
val VIEWTYPE_neg : tnode
val VIEWT0YPE : tnode
val VIEWT0YPE_pos : tnode
val VIEWT0YPE_neg : tnode

val TYPEDEF : tnode
val PROPDEF : tnode
val VIEWDEF : tnode
val VIEWTYPEDEF : tnode

val VAL : tnode
val VAL_pos : tnode
val VAL_neg : tnode
val PRVAL  : tnode

val WHILE : tnode
val WHILESTAR : tnode

val WITHTYPE : tnode
val WITHPROP : tnode
val WITHVIEW : tnode
val WITHVIEWTYPE : tnode

(* ****** ****** *)

val DLRDELAY : tnode
val DLRLDELAY : tnode

val DLREFFMASK : tnode
val DLREFFMASK_NTM : tnode
val DLREFFMASK_EXN : tnode
val DLREFFMASK_REF : tnode
val DLREFFMASK_WRT : tnode
val DLREFFMASK_ALL : tnode

val DLRLST : tnode
val DLRLST_T : tnode
val DLRLST_VT : tnode
val DLRREC : tnode
val DLRREC_T : tnode
val DLRREC_VT : tnode
val DLRTUP : tnode
val DLRTUP_T : tnode
val DLRTUP_VT : tnode

(* ****** ****** *)

val DOT : tnode // = T_DOT
val PERCENT : tnode // = IDENT_sym ("%")
val QMARK : tnode // = IDENT_sym ("?")

val ZERO : tnode // = T_INTEGER_dec ("0")

(* ****** ****** *)

fun fprint_token : fprint_type (token)
overload fprint with fprint_token
fun print_token (tok: token): void
overload print with print_token
fun prerr_token (tok: token): void
overload prerr with prerr_token

(* ****** ****** *)

fun token_make
  (loc: location, node: tnode): token
// end of [token_make]

(* ****** ****** *)

fun tnode_is_comment (node: tnode): bool

(* ****** ****** *)
//
// HX-2011-03-11:
// see if a name refers to a special token;
// if the return is not T_NONE, then it does
//
fun tnode_search (x: string): tnode

(* ****** ****** *)

datatype
lexerr_node =
  | LE_CHAR_oct of ()
  | LE_CHAR_hex of ()
  | LE_CHAR_unclose of ()
  | LE_QUOTE_dangling of ()
//
  | LE_STRING_unclose of ()
  | LE_STRING_char_oct of ()
  | LE_STRING_char_hex of ()
//
  | LE_COMMENT_block_unclose of ()
//
  | LE_EXTCODE_unclose of ()
//
  | LE_FEXPONENT_empty of ()
//
  | LE_UNSUPPORTED of char
// end of [lexerr_node]
typedef lexerr = '{
  lexerr_loc= location, lexerr_node= lexerr_node
} // end of [lexerr]

fun lexerr_make (
  loc: location, node: lexerr_node
) : lexerr // end of [lexerr_make]

fun the_lexerrlst_clear (): void

fun the_lexerrlst_add (x: lexerr): void

(* ****** ****** *)

fun fprint_lexerr
  (out: FILEref, err: lexerr): void
// end of [fprint_lexerr]

fun fprint_the_lexerrlst (out: FILEref): void

(* ****** ****** *)

fun lexing_next_token (buf: &lexbuf): token
fun lexing_next_token_ncmnt (buf: &lexbuf): token

(* ****** ****** *)

(* end of [pats_lexing.sats] *)
