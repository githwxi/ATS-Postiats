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
//
staload
"./../SATS/atexting.sats"
//
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
tokbuf_get1_token
  (buf: &tokbuf >> _): token
//
implement
tokbuf_get1_token
  (buf) = let
//
val
tok = tokbuf_get_token(buf)
//
in
//
case+
tok.token_node
of // case+
//
(*
| TOKspace _ => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get1_token(buf)
  end // end of [TOKspace]
*)
//
| TOKbslash(i)
  when int2char0(i) = '\n' => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get1_token(buf)
  end // end of [TOKbslash\n]
//
| _(* rest-of-token *) => tok
//
end // end of [tokbuf_get1_token]
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
val
tok = tokbuf_get_token(buf)
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
| TOKeol((*void*)) => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get2_token(buf)
  end // end of [TOKeol]
//
| TOKbslash(i)
  when int2char0(i) = '\n' => let
    val () =
    tokbuf_incby_1(buf)
  in 
    tokbuf_get2_token(buf)
  end // end of [TOKbslash\n]
//
| _(* rest-of-token *) => tok
//
end // end of [tokbuf_get2_token]
//
(* ****** ****** *)
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
parsing_squote
  (tok0: token, buf: &tokbuf >> _) : atext
//
extern
fun
parsing_dquote
  (tok0: token, buf: &tokbuf >> _) : atext
//
extern
fun
parsing_extcode
  (tok0: token, buf: &tokbuf >> _) : atext
//
(* ****** ****** *)
//
extern
fun
parsing_funcall
(
  tok0: token, tok1: token, buf: &tokbuf >> _
) : atext // end-of-function
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
parsing_atext1seq_rparen
  (buf: &tokbuf >> _, rparen: &tokenopt? >> _): atextlst
//
(* ****** ****** *)

local

fun
parsing_atext
(
  tok0: token, buf: &tokbuf >> _
) : atext = (
//
case+
tok0.token_node
of // case+
//
| TOKsquote _ => parsing_squote(tok0, buf)
| TOKdquote _ => parsing_dquote(tok0, buf)
//
| TOKsharp _ when
  token_is_nsharp(tok0) => parsing_sharp(tok0, buf)
//
| TOKcode_beg _ when
  token_is_atlnbeg(tok0) => parsing_extcode(tok0, buf)
//
| _ (*rest-of-token*) => atext_make_token(tok0)
//
) (* end of [parsing_atext] *)

in (* in-of-local *)

implement
parsing_atext0
  (buf) = let
//
val
tok0 =
tokbuf_get_token(buf)
//
val () = tokbuf_incby_1(buf)
//
in
  parsing_atext(tok0, buf)
end // end of [parsing_atext0]

implement
parsing_atext1
  (buf) = let
//
val
tok0 =
tokbuf_get2_token(buf)
//
val () = tokbuf_incby_1(buf)
//
in
  parsing_atext(tok0, buf)
end // end of [parsing_atext1]

end // end of [local]

(* ****** ****** *)

implement
parsing_atext_top
  (buf) = let
//
val
tok0 =
tokbuf_get_token(buf)
//
val () = tokbuf_incby_1(buf)
//
in
//
case+
tok0.token_node
of // case+
//
| TOKsharp _ when
  token_is_nsharp(tok0) => parsing_sharp(tok0, buf)
//
| TOKcode_beg _ when
  token_is_atlnbeg(tok0) => parsing_extcode(tok0, buf)
//
| _ (*rest-of-token*) => atext_make_token(tok0)
//
end (* end of [parsing_atext_top] *)

(* ****** ****** *)

implement
parsing_sharp
  (tok0, buf) = let
//
macdef
incby1(buf) =
  tokbuf_incby_1(,(buf))
//
val x0 = tokbuf_get2_token(buf)
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
val x0 = tokbuf_get1_token(buf)
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
    val xs = parsing_atext1seq_rparen(buf, rparen)
    val loc1 = tok1.token_loc
    val loc2 =
    (
//
      case+ rparen of
//
      | Some(tok) => tok.token_loc
//
      | None((*err*)) => loc2 where
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
          val loc2 = aux(loc1, xs)
          val loc2_end = location_rightmost(loc2)
          val ((*void*)) =
          the_parerrlst_insert2(loc2_end, PARERR_FUNARG(x0.token_loc))
          // end of [val]
        } (* end of [None] *)
//
    ) (* end of [val] *)
//
    val loc = tok0.token_loc + loc2
//
  in
    atext_make
      (loc, TEXTfuncall(tok0, tok1, xs))
    // atext_make
  end // end of [LPAREN]
//
| _(*non-LPAREN*) => let
    val loc =
      tok0.token_loc+tok1.token_loc
    // end of [val]
  in
    atext_make(loc, TEXTdefname(tok0, tok1))
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
    val x0 = parsing_atext1(buf)
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
parsing_atext1seq_rparen
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
    val x0 = parsing_atext1(buf)
    val xs = parsing_commatextseq(buf)
    val () = (rparen := parsing_rparen(buf))
  } (* end of [non-empty] *)
//
end // end of [parsing_atextseq_rparen]

(* ****** ****** *)

implement
parsing_squote
  (tok0, buf) = let
//
fun
loop
(
  buf: &tokbuf >> _
, txts: List0_vt(atext)
) : atext = let
//
val tok1 = tokbuf_get_token(buf)
//
in
//
case+
tok1.token_node
of // case+
//
| TOKsquote() => let
    val () =
      tokbuf_incby_1(buf)
    val loc =
      tok0.token_loc + tok1.token_loc
    // end of [val]
    val txts =
      list0_of_list_vt(list_vt_reverse(txts))
    // end of [val]
  in
    atext_make(loc, TEXTsquote(txts))
  end // TOKsquote
//
| TOKeof((*void*)) => let
    val () =
      tokbuf_incby_1(buf)
    val loc =
      tok0.token_loc + tok1.token_loc
    // end of [val]
    val txts =
      list0_of_list_vt(list_vt_reverse(txts))
    // end of [val]
    val () =
    the_parerrlst_insert2
      (tok1.token_loc, PARERR_SQUOTE(tok0.token_loc))
    // end of [val]
  in
    atext_make(loc, TEXTsquote(txts))
  end // end of [TOKeof]
//
| TOKdquote _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKdquote]
//
| _ (*non-TOKsquote*) =>
  let
    val txt = parsing_atext0(buf)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [non-TOKsquote]
//
end // end of [loop]
//
in
  loop(buf, nil_vt)
end // end of [parsing_squote]

(* ****** ****** *)

local

fun
dquote_eq
(
  x: token, y: token
) : bool = let
//
val-TOKdquote(xs) = x.token_node
val-TOKdquote(ys) = y.token_node
//
in
  if xs = ys then true else false
end // end of [dquote_eq]

in (* in-of-local *)

implement
parsing_dquote
  (tok0, buf) = let
//
fun
loop
(
  buf: &tokbuf >> _
, txts: List0_vt(atext)
) : atext = let
//
val tok1 = tokbuf_get_token(buf)
//
in
//
case+
tok1.token_node
of // case+
| TOKdquote _ when
  dquote_eq(tok0, tok1) =>
  let
    val () =
      tokbuf_incby_1(buf)
    val loc =
      tok0.token_loc + tok1.token_loc
    // end of [val]
    val txts =
      list0_of_list_vt(list_vt_reverse(txts))
    // end of [val]
  in
    atext_make(loc, TEXTdquote(tok0, txts))
  end // TOKdquote_eq
//
| TOKeof((*void*)) => let
    val () =
      tokbuf_incby_1(buf)
    val loc =
      tok0.token_loc + tok1.token_loc
    // end of [val]
    val txts =
      list0_of_list_vt(list_vt_reverse(txts))
    // end of [val]
    val () =
    the_parerrlst_insert2
      (tok1.token_loc, PARERR_DQUOTE(tok0.token_loc))
    // end of [val]
  in
    atext_make(loc, TEXTdquote(tok0, txts))
  end // end of [TOKeof]
//
| TOKsquote _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKsquote]
//
| TOKdquote _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKdquote]
//
| _ (*non-TOKdquote_eq*) =>
  let
    val txt = parsing_atext0(buf)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [non-TOKdquote_eq]
//
end // end of [loop]
//
in
  loop(buf, list_vt_nil())
end // end of [parsing_dquote]

end // end of [local]

(* ****** ****** *)

implement
parsing_extcode
  (tok0, buf) = let
//
fun
loop
(
  buf: &tokbuf >> _
, txts: List0_vt(atext)
) : atext = let
//
val tok1 = tokbuf_get_token(buf)
//
in
//
case+
tok1.token_node
of // case+
//
| TOKcode_end _ when
  token_is_atlnbeg(tok1) => let
    val () =
      tokbuf_incby_1(buf)
    val loc =
      tok0.token_loc + tok1.token_loc
    // end of [val]
    val txts =
      list0_of_list_vt(list_vt_reverse(txts))
    // end of [val]
  in
    atext_make(loc, TEXTextcode(tok0, txts, tok1))
  end // TOKcode_end
//
| TOKeof((*void*)) => let
    val () =
      tokbuf_incby_1(buf)
    val loc =
      tok0.token_loc + tok1.token_loc
    // end of [val]
    val txts =
      list0_of_list_vt(list_vt_reverse(txts))
    // end of [val]
    val () =
    the_parerrlst_insert2
      (tok1.token_loc, PARERR_EXTCODE(tok0.token_loc))
    // end of [val]
  in
    atext_make(loc, TEXTextcode(tok0, txts, tok1))
  end // end of [TOKeof]
//
| TOKsharp _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKsharp]
//
| TOKsquote _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKsquote]
//
| TOKdquote _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKdquote]
//
| TOKcode_beg _ => let
    val () =
      tokbuf_incby_1(buf)
    // end of [val]
    val txt = atext_make_token(tok1)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [TOKcode_beg]
//
| _ (*non-TOKcode_end*) =>
  let
    val txt = parsing_atext0(buf)
    val txts = cons_vt(txt, txts) in loop(buf, txts)
  end // end of [non-TOKcode_end]
//
end // end of [loop]
//
in
  loop(buf, list_vt_nil())
end // end of [parsing_extcode]

(* ****** ****** *)

implement
parsing_toplevel
  (buf) = let
//
vtypedef
res_vt = List0_vt(atext)
//
fun
loop
(
  buf: &tokbuf >> _, txts: res_vt
) : atextlst = let
//
val
txt =
parsing_atext_top(buf)
//
in
//
case+
txt.atext_node
of // case+
//
| TEXTtoken(tok)
  when token_is_eof(tok) =>
  list0_of_list_vt(list_vt_reverse(txts))
//
| _(*non-TEXTtoken_eof*) => let
    val txts = list_vt_cons(txt, txts) in loop(buf, txts)
  end // end of [non-TEXTtoken_eof]
//
end // end of [loop]
//
val () = the_parerrlst_clear()
//
val txts = loop(buf, list_vt_nil((*txts*)))
//
val nerr = the_parerrlst_length()
val ((*void*)) =
if nerr >= 2
then fprintln!(stderr_ref, "There are some parsing errors:")
else (
  if nerr >= 1
  then fprintln!(stderr_ref, "There exists a parsing error:")
) (* end of [if] *)
//
val _(*nerr*) = the_parerrlst_print_free()
//
in
  txts
end // end of [parsing_toplevel]

(* ****** ****** *)

implement
parsing_from_fileref
  (infil) = txtlst where
{
//
var buf: tokbuf
//
val ((*void*)) =
tokbuf_initize_fileref(buf, infil)
//
val txtlst = parsing_toplevel(buf)
//
val ((*void*)) = tokbuf_uninitize(buf)
//
} (* end of [parsing_from_fileref] *)

(* ****** ****** *)

implement
parsing_from_stdin
  ((*void*)) = txtlst where
{
//
val () =
  the_filename_push(filename_stdin)
//
val txtlst = parsing_from_fileref(stdin_ref)
//
val _(*fname*) = the_filename_pop()
//
} (* end of [parsing_from_stdin] *)

(* ****** ****** *)

implement
parsing_from_filename
  (path) = let
//
val opt =
  fileref_open_opt(path, file_mode_r)
//
in
//
case+ opt of
| ~None_vt() =>
    list0_nil()
| ~Some_vt(infil) =>
    txtlst where
  {
    val fname =
      filename_make(path)
    val ((*void*)) =
      the_filename_push(fname)
    val txtlst =
      parsing_from_fileref(infil)
    val _(*fname*) = the_filename_pop()
    val ((*void*)) = fileref_close(infil)
  } (* end of [Some_vt] *)
//
end // end of [parsing_from_filename]

(* ****** ****** *)

(* end of [atexting_parsing.dats] *)
