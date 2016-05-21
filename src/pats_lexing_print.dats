(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)

staload "./pats_lexing.sats"

(* ****** ****** *)

#define c2i int_of_char

(* ****** ****** *)

implement
fprint_token
  (out, tok) = case+ tok.token_node of
//
  | T_AT () => fprintf (out, "AT()", @())
  | T_BACKSLASH () => fprintf (out, "BACKSLASH()", @())
  | T_BANG () => fprintf (out, "BANG()", @())
  | T_BAR () => fprintf (out, "BAR()", @())
  | T_BQUOTE () => fprintf (out, "BQUOTE()", @())
  | T_COLON () => fprintf (out, "COLON()", @())
  | T_DOLLAR () => fprintf (out, "DOLLAR()", @())
  | T_DOT () => fprintf (out, "DOT()", @())
  | T_EQ () => fprintf (out, "EQ()", @())
  | T_HASH () => fprintf (out, "HASH()", @())
  | T_TILDE () => fprintf (out, "TILDE()", @())
  | T_DOTINT (x) => fprintf (out, "DOTINT(%i)", @(x))
  | T_DOTDOT () => fprintf (out, "DOTDOT()", @())
  | T_DOTDOTDOT () => fprintf (out, "DOTDOTDOT()", @())
  | T_EQGT () => fprintf (out, "EQGT()", @())
  | T_EQLT () => fprintf (out, "EQLT()", @())
  | T_EQLTGT () => fprintf (out, "EQLTGT()", @())
  | T_EQSLASHEQGT () => fprintf (out, "EQSLASHEQGT()", @())
  | T_EQGTGT () => fprintf (out, "EQGTGT()", @())
  | T_EQSLASHEQGTGT () => fprintf (out, "EQSLASHEQGTGT()", @())
//
  | T_LT () => fprintf (out, "LT()", @())
  | T_GT () => fprintf (out, "GT()", @())
  | T_GTLT () => fprintf (out, "GTLT()", @())
//
  | T_DOTLT () => fprintf (out, "DOTLT()", @())
  | T_GTDOT () => fprintf (out, "GTDOT()", @())
//
  | T_DOTLTGTDOT () =>
      fprintf (out, "DOTLTGTDOT()", @())
  | T_MINUSGT () => fprintf (out, "MINUSGT()", @())
  | T_MINUSLT () => fprintf (out, "MINUSLT()", @())
  | T_MINUSLTGT () => fprintf (out, "MINUSLTGT()", @())
  | T_COLONLT () => fprintf (out, "COLONLT()", @())
//
  | T_ABSTYPE (x) =>
      fprintf (out, "ABSTYPE(%i)", @(x))
  | T_AND () => fprintf (out, "AND()", @())
  | T_AS () => fprintf (out, "AS()", @())
  | T_ASSUME () => fprintf (out, "ASSUME()", @())
  | T_BEGIN () => fprintf (out, "BEGIN()", @())
  | T_CASE (x) => fprintf (out, "CASE(...)", @())
  | T_CLASSDEC () => fprintf (out, "CLASSDEC()", @())
  | T_DATASORT () => fprintf (out, "DATASORT()", @())
  | T_DATATYPE (x) => fprintf (out, "DATATYPE(%i)", @(x))
  | T_DO () => fprintf (out, "DO()", @())
  | T_DYNLOAD () => fprintf (out, "DYNLOAD()", @())
  | T_ELSE () => fprintf (out, "ELSE()", @())
  | T_END () => fprintf (out, "END()", @())
  | T_EXCEPTION () => fprintf (out, "EXCEPTION()", @())
  | T_EXTERN () => fprintf (out, "EXTERN()", @())
  | T_EXTYPE () => fprintf (out, "EXTYPE()", @())
  | T_EXTVAR () => fprintf (out, "EXTVAR()", @())
//
  | T_FIX (x) => fprintf (out, "FIX(%i)", @(x))
  | T_FIXITY (x) => fprintf (out, "FIXITY(...)", @())
  | T_FOR () => fprintf (out, "FOR()", @())
  | T_FORSTAR () => fprintf (out, "FORSTAR()", @())
  | T_FUN (x) => fprintf (out, "FUN(...)", @())
//
  | T_IF () => fprintf (out, "IF()", @())
  | T_IFCASE () => fprintf (out, "IFCASE()", @())
//
  | T_IMPLEMENT (k) => fprintf (out, "IMPLEMENT(%i)", @(k))
  | T_IMPORT () => fprintf (out, "IMPORT()", @())
  | T_IN () => fprintf (out, "IN()", @())
  | T_LAM (x) => fprintf (out, "LAM(%i)", @(x))
  | T_LET () => fprintf (out, "LET()", @())
  | T_LOCAL () => fprintf (out, "LOCAL()", @())
  | T_MACDEF (x) => fprintf (out, "MACDEF(%i)", @(x))
  | T_NONFIX () => fprintf (out, "NONFIX()", @())
  | T_OVERLOAD () => fprintf (out, "OVERLOAD()", @())
  | T_OF () => fprintf (out, "OF()", @())
  | T_OP () => fprintf (out, "OP()", @())
  | T_REC () => fprintf (out, "REC()", @())
(*
  | T_REFAT () => fprintf (out, "REFAT()", @())
*)
  | T_SIF () => fprintf (out, "SIF()", @())
  | T_SCASE () => fprintf (out, "SCASE()", @())
  | T_SORTDEF () => fprintf (out, "SORTDEF()", @())
  | T_STACST () => fprintf (out, "STACST()", @())
  | T_STADEF () => fprintf (out, "STADEF()", @())
  | T_STALOAD () => fprintf (out, "STALOAD()", @())
  | T_STATIC () => fprintf (out, "STATIC()", @())
(*
  | T_STAVAR () => fprintf (out, "STAVAR()", @())
*)
  | T_SYMELIM () => fprintf (out, "SYMELIM()", @())
  | T_SYMINTR () => fprintf (out, "SYMINTR()", @())
  | T_THEN () => fprintf (out, "THEN()", @())
  | T_TKINDEF () =>  fprintf (out, "TKINDEF()", @())
  | T_TRY () => fprintf (out, "TRY()", @())
  | T_TYPE (x) => fprintf (out, "TYPE(%i)", @(x))
  | T_TYPEDEF (x) => fprintf (out, "TYPEDEF(%i)", @(x))
  | T_VAL (x) => fprintf (out, "VAL(...)", @())
  | T_VAR (x) => fprintf (out, "VAR(%i)", @(x))
  | T_WHEN () => fprintf (out, "WHEN()", @())
  | T_WHERE () => fprintf (out, "WHERE()", @())
  | T_WHILE () => fprintf (out, "WHILE()", @())
  | T_WHILESTAR () => fprintf (out, "WHILESTAR()", @())
  | T_WITH () => fprintf (out, "WITH()", @())
  | T_WITHTYPE (x) => fprintf (out, "WITHTYPE(%i)", @(x))
//
  | T_ADDRAT () => fprintf (out, "ADDRAT()", @()) // addr@
  | T_FOLDAT () => fprintf (out, "FOLDAT()", @()) // fold@
  | T_FREEAT () => fprintf (out, "FREEAT()", @()) // free@
  | T_VIEWAT () => fprintf (out, "VIEWAT()", @()) // view@
//
  | T_DLRDELAY (x) => fprintf (out, "DLRDELAY(%i)", @(x))
//
  | T_DLRARRPSZ () => fprintf (out, "DLRARRPSZ()", @())
//
  | T_DLRD2CTYPE () => fprintf (out, "DLRD2CTYPE()", @())
//
  | T_DLREFFMASK () => fprintf (out, "DLREFFMASK()", @())
  | T_DLREFFMASK_ARG (x) => fprintf (out, "DLREFFMASK(%i)", @(x))
//
  | T_DLREXTERN () => fprintf (out, "DLREXTERN()", @())
  | T_DLREXTKIND () => fprintf (out, "DLREXTKIND()", @())
  | T_DLREXTYPE () => fprintf (out, "DLREXTYPE()", @())
  | T_DLREXTYPE_STRUCT () => fprintf (out, "DLREXTYPE_STRUCT()", @())
//
  | T_DLREXTVAL () => fprintf (out, "DLREXTVAL()", @())
  | T_DLREXTFCALL () => fprintf (out, "DLREXTFCALL()", @())
  | T_DLREXTMCALL () => fprintf (out, "DLREXTMCALL()", @())
//
  | T_DLRLITERAL () => fprintf (out, "DLRLITERAL()", @())
//
  | T_DLRMYFILENAME () => fprintf (out, "DLRMYFILENAME()", @())
  | T_DLRMYLOCATION () => fprintf (out, "DLRMYLOCATION()", @())
  | T_DLRMYFUNCTION () => fprintf (out, "DLRMYFUNCTION()", @())
//
  | T_DLRLST (x) => fprintf (out, "DLRLST(%i)", @(x))
  | T_DLRREC (x) => fprintf (out, "DLRREC(%i)", @(x))
  | T_DLRTUP (x) => fprintf (out, "DLRTUP(%i)", @(x))
//
  | T_DLRBREAK () => fprintf (out, "DLRBREAK()", @())
  | T_DLRCONTINUE () => fprintf (out, "DLRCONTINUE()", @())
//
  | T_DLRRAISE () => fprintf (out, "DLRRAISE()", @())
//
  | T_DLRSHOWTYPE () => fprintf (out, "DLRSHOWTYPE()", @())
//
  | T_DLRVCOPYENV (x) => fprintf (out, "DLRVCOPYENV(%i)", @(x))
//
  | T_DLRTEMPENVER () => fprintf (out, "DLRTEMPENVER()", @())
//
  | T_DLRSOLASSERT () => fprintf (out, "DLRSOLASSERT()", @())
  | T_DLRSOLVERIFY () => fprintf (out, "DLRSOLVERIFY()", @())
//
  | T_SRPIF () => fprintf (out, "SRPIF()", @())
  | T_SRPIFDEF () => fprintf (out, "SRPIFDEF()", @())
  | T_SRPIFNDEF () => fprintf (out, "SRPIFNDEF()", @())
  | T_SRPTHEN () => fprintf (out, "SRPTHEN()", @())
  | T_SRPELSE () => fprintf (out, "SRPELSE()", @())
  | T_SRPELIF () => fprintf (out, "SRPELIF()", @())
  | T_SRPELIFDEF () => fprintf (out, "SRPELIFDEF()", @())
  | T_SRPELIFNDEF () => fprintf (out, "SRPELIFNDEF()", @())
  | T_SRPENDIF () => fprintf (out, "SRPENDIF()", @())
//
  | T_SRPERROR () => fprintf (out, "SRPERROR()", @())
  | T_SRPPRERR () => fprintf (out, "SRPPRERR()", @())
  | T_SRPPRINT () => fprintf (out, "SRPPRINT()", @())
//
  | T_SRPASSERT () => fprintf (out, "SRPASSERT()", @())
//
  | T_SRPUNDEF () => fprintf (out, "SRPUNDEF()", @())
  | T_SRPDEFINE () => fprintf (out, "SRPDEFINE()", @())
//
  | T_SRPINCLUDE () => fprintf (out, "SRPINCLUDE()", @())
  | T_SRPREQUIRE () => fprintf (out, "SRPREQUIRE()", @())
//
  | T_SRPPRAGMA () => fprintf (out, "SRPPRAGMA()", @())
  | T_SRPCODEGEN2 () => fprintf (out, "SRPCODEGEN2()", @())
  | T_SRPCODEGEN3 () => fprintf (out, "SRPCODEGEN3()", @())
//
  | T_IDENT_alp (x) => fprintf (out, "IDENT_alp(%s)", @(x))
  | T_IDENT_sym (x) => fprintf (out, "IDENT_sym(%s)", @(x))
  | T_IDENT_arr (x) => fprintf (out, "IDENT_arr(%s)", @(x))
  | T_IDENT_tmp (x) => fprintf (out, "IDENT_tmp(%s)", @(x))
  | T_IDENT_dlr (x) => fprintf (out, "IDENT_dlr(%s)", @(x))
  | T_IDENT_srp (x) => fprintf (out, "IDENT_srp(%s)", @(x))
  | T_IDENT_ext (x) => fprintf (out, "IDENT_ext(%s)", @(x))
//
  | T_INT (base, rep, sfx) =>
      fprintf (out, "INT(%i; %s)", @(base, rep))
  | T_CHAR (x) => fprintf (out, "CHAR(%c)", @(x))
  | T_FLOAT (base, rep, sfx) =>
      fprintf (out, "FLOAT(%i; %s)", @(base, rep))
//
  | T_CDATA _ => fprintf (out, "CDATA(...)", @())
  | T_STRING (x) => fprintf (out, "STRING(%s)", @(x))
//
(*
  | T_LABEL (knd, x) => fprintf (out, "LABEL(%i; %s)", @(knd, x))
*)
//
  | T_COMMA () => fprintf (out, "COMMA()", @())
  | T_SEMICOLON () => fprintf (out, "SEMICOLON()", @())
//
  | T_LPAREN () => fprintf (out, "LPAREN()", @())
  | T_RPAREN () => fprintf (out, "RPAREN()", @())
  | T_LBRACKET () => fprintf (out, "LBRACKET()", @())
  | T_RBRACKET () => fprintf (out, "RBRACKET()", @())
  | T_LBRACE () => fprintf (out, "LBRACE()", @())
  | T_RBRACE () => fprintf (out, "RBRACE()", @())
//
  | T_ATLPAREN () => fprintf (out, "ATLPAREN()", @())
  | T_QUOTELPAREN () => fprintf (out, "QUOTELPAREN()", @())
  | T_ATLBRACKET () => fprintf (out, "ATLBRACKET()", @())
  | T_QUOTELBRACKET () => fprintf (out, "QUOTELBRACKET()", @())
  | T_HASHLBRACKET () => fprintf (out, "HASHLBRACKET()", @())
  | T_ATLBRACE () => fprintf (out, "ATLBRACE()", @())
  | T_QUOTELBRACE () => fprintf (out, "QUOTELBRACE()", @())
//
  | T_BQUOTELPAREN () => fprintf (out, "BQUOTELPAREN()", @())
  | T_COMMALPAREN () => fprintf (out, "COMMALPAREN()", @())
  | T_PERCENTLPAREN () => fprintf (out, "PERCENTLPAREN()", @())
//
  | T_EXTCODE (knd, x) => fprintf (out, "EXTCODE(%i, %s)", @(knd, x))
//
  | T_COMMENT_line () => fprintf (out, "COMMENT_line()", @())
  | T_COMMENT_block () => fprintf (out, "COMMENT_block()", @())
  | T_COMMENT_rest () => fprintf (out, "COMMENT_rest()", @())
//
  | T_ERR () => fprintf (out, "ERR()", @())
  | T_EOF () => fprintf (out, "EOF()", @())
//
  | T_NONE () => fprintf (out, "NONE()", @())
(*
  | _ => fprintf (out, "TOKEN()", @())
*)
//
(* end of [fprint_token] *)

implement print_token (tok) = fprint_token (stdout_ref, tok)

(* ****** ****** *)

(* end of [pats_lexing_print.dats] *)
