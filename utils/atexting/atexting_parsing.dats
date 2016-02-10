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
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/list0.sats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)

overload + with location_combine

(* ****** ****** *)
//
fun
token_is_spchr
  (tok: token, c: char): bool =
(
//
case+
tok.token_node of
| TOKspchr(i) => (int2char0(i) = c) | _ => false
//
) (* token_is_COMMA *)
//
fun
token_is_COMMA
  (tok: token): bool = token_is_spchr(tok, ',')
//
fun
token_is_SEMICOLON
  (tok: token): bool = token_is_spchr(tok, ';')
//
fun
token_is_RPAREN
  (tok: token): bool = token_is_spchr(tok, ')')
fun
token_is_LPAREN
  (tok: token): bool = token_is_spchr(tok, '\(')
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
//
| TOKspace _ => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get2_token(buf)
  end // end of [TOKspace]
//
| TOKbslash(i)
  when int2char0(i) = '\n' => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get2_token(buf)
  end // end of [TOKspace]
//
| _(* rest-of-token *) => tok
//
end // end of [tokbuf_get2_token]
//
(* ****** ****** *)
//
extern
fun
parsing_atext(buf: &tokbuf >> _): atext
//
extern
fun
parsing_sharp
(
  tok0: token, buf: &tokbuf >> _
) : atext // end-of-function
//
extern
fun
parsing_funcall
(
  tok0: token, tok1: token, buf: &tokbuf >> _
) : atext // end-of-function
//
(* ****** ****** *)
//
extern
fun
parsing_rparen(buf: &tokbuf >> _): tokenopt
//
extern
fun
parsing_commatextseq(buf: &tokbuf >> _): atextlst
//
extern
fun
parsing_atextseq_rparen
  (buf: &tokbuf >> _, rparen: &tokenopt? >> _): atextlst
//
(* ****** ****** *)

implement
parsing_sharp
  (tok0, buf) = let
//
macdef
incby1(buf) =
  tokbuf_incby_1(,(buf))
//
val
x0 = tokbuf_get2_token(buf)
//
in
//
case+
x0.token_node
of // case+
//
| TOKide _ => let
    val () = incby1(buf)
  in
    parsing_funcall(tok0, x0, buf)
  end // end of [TOKide]
//
| _(*non-ident*) =>
  (
    atext_make(tok0.token_loc, TEXTtoken(tok0))
  ) (* non-ident *)
//
end // end of [parsing_sharp]

(* ****** ****** *)

implement
parsing_funcall
  (tok0, tok1, buf) = let
//
macdef
incby1(buf) =
  tokbuf_incby_1(,(buf))
//
val
x0 = tokbuf_get2_token(buf)
//
in
//
case+
x0.token_node
of // case+
| _ when
    token_is_LPAREN(x0) => let
    val () = incby1(buf)
    var rparen: tokenopt
    val xs = parsing_atextseq_rparen(buf, rparen)
    val loc = tok1.token_loc
    val loc =
    (
//
      case+ rparen of
//
      | Some(tok) => tok.token_loc
//
      | None((*err*)) => aux(loc, xs) where
        {
          fun
          aux
          (
            loc: loc_t, xs: atextlst
          ) : loc_t =
          (
            case+ xs of
            | list0_nil() => loc
            | list0_cons(x, xs) => aux2(x, xs)
          )
          and
          aux2
          (
            x: atext, xs: atextlst
          ) : loc_t =
          (
            case+ xs of
            | list0_nil() => x.atext_loc
            | list0_cons(x, xs) => aux2(x, xs)
          )
        } (* end of [None] *)
//
    ) (* end of [val] *)
//
    val loc = tok0.token_loc + loc
//
  in
    atext_make(loc, TEXTfuncall(tok1, xs))
  end // end of [LPAREN]
//
| _(*non-LPAREN*) => let
    val xs = list0_nil()
    val loc = tok1.token_loc
    val loc = tok0.token_loc + loc
  in
    atext_make(loc, TEXTfuncall(tok1, xs))
  end // end of [non-LPAREN]
//
end // end of [parsing_funcall]

(* ****** ****** *)

implement
parsing_rparen
  (buf) = let
//
macdef
incby1(buf) =
  tokbuf_incby_1(,(buf))
//
val tok = tokbuf_get2_token(buf)
//
in
//
case+
tok.token_node
of // case+
| _ when
    token_is_RPAREN(tok) =>
    let val () = incby1(buf) in Some(tok) end
| _ (*non-RPAREN*) => None((*void*))
//
end // end of [parsing_rparen]

(* ****** ****** *)

implement
parsing_commatextseq
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
end // end of [parsing_commatextseq]

(* ****** ****** *)

implement
parsing_atextseq_rparen
  (buf, rparen) = let
//
macdef
incby1(buf) =
  tokbuf_incby_1(,(buf))
//
val tok = tokbuf_get2_token(buf)
//
in
//
case+
tok.token_node
of // case+
| _ when
    token_is_RPAREN(tok) => let
    val () = incby1(buf)
  in
    rparen := Some(tok); list0_nil()
  end // end of [RPAREN]
| _ (*non-RPAREN*) =>
    list0_cons(x0, xs) where
  {
    val x0 = parsing_atext(buf)
    val xs = parsing_commatextseq(buf)
    val () = (rparen := parsing_rparen(buf))
  } (* end of [non-empty] *)
//
end // end of [parsing_atextseq_rparen]

(* ****** ****** *)

(* end of [atexting_parsing.dats] *)
