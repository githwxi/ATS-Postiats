(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/list0.sats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)
//
fun
token_is_COMMA
  (tok: token): bool =
(
//
case+
tok.token_node of
| TOKspchr(i) => (int2char0(i) = ',') | _ => false
//
) (* token_is_COMMA *)
//
fun
token_is_RPAREN
  (tok: token): bool =
(
//
case+
tok.token_node of
| TOKspchr(i) => (int2char0(i) = ')') | _ => false
//
) (* token_is_LPAREN *)
fun
token_is_LPAREN
  (tok: token): bool =
(
//
case+
tok.token_node of
| TOKspchr(i) => (int2char0(i) = '\(') | _ => false
//
) (* token_is_LPAREN *)
//
fun
token_is_SEMICOLON
  (tok: token): bool =
(
//
case+
tok.token_node of
| TOKspchr(i) => (int2char0(i) = ';') | _ => false
//
) (* token_is_COMMA *)
//
(* ****** ****** *)
//
extern
fun
tokbuf_get2_token
  (buf: &tokbuf >> _): token
//
implement
tokbuf_get2_token
  (buf) = let
//
val tok =
  tokbuf_get_token(buf)
//
in
//
case+
tok.token_node
of // case+
| TOKspace _ => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get2_token(buf)
  end // end of [TOKspace]
| TOKbslash(i)
  when int2char0(i) = '\n' => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get2_token(buf)
  end // end of [TOKspace]
| _(* rest-of-token *) => tok
//
end // end of [tokbuf_get2_token]
//
(* ****** ****** *)
//
datatype parenv =
  | PARENV_SQUOTE of ()
  | PARENV_DQUOTE of (int)
  | PARENV_FUNARG of ()
  | PARENV_EXTCODE of ()
//
(* ****** ****** *)
//
extern
fun
parsing_atext(buf: &tokbuf >> _): atext
//
extern
fun
parsing_funarg(buf: &tokbuf >> _): atextlst
//
(* ****** ****** *)
//
extern
fun
parsing_atextseq_comma(buf: &tokbuf >> _): atextlst
//
(* ****** ****** *)

implement
parsing_atextseq_comma
  (buf) = let
//
macdef
incby1(buf) =
  tokbuf_incby_1(,(buf))
//
vtypedef res = List0_vt(atext)
//
fun
loop
(
  buf: &tokbuf >> _, xs: res
) : res = let
//
val tok = tokbuf_get2_token(buf)
//
in
//
case+ tok of
| _ when
    token_is_COMMA(tok) => let
    val () = incby1(buf)
    val x0 = parsing_atext(buf)
  in
    loop(buf, list_vt_cons(x0, xs))
  end // end of [_ when ...]
| _ (*non-COMMA*) => (xs)
//
end // end of [loop]
//
val xs = loop(buf, list_vt_nil())
//
in
  list0_of_list_vt(list_vt_reverse(xs))
end // end of [parsing_atextseq_comma]

(* ****** ****** *)

(* end of [atexting_parsing.dats] *)
