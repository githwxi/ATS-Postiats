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
/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
//
staload
"libats/ML/SATS/string.sats"
staload _ =
"libats/ML/DATS/string.dats"
//
(* ****** ****** *)
//
staload
"libats/SATS/stringbuf.sats"
staload _ =
"libats/DATS/stringbuf.dats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)
//
extern
fun
stringbuf_insert_token
  (sbf: !stringbuf, tok: token): int
//
(* ****** ****** *)

implement
token_strngfy
  (x0) = let
(*
// HX: atext_strngfy
*)
in
//
case+
x0.token_node
of // case+
//
| TOKeol() => "\n"
| TOKeof() => ("")
//
| TOKint(rep) => rep
//
| TOKide(rep) => rep
//
| TOKspchr(c0) =>
  if c0 > 0
    then (
      string_sing($UN.cast{charNZ}(c0))
    ) else ""
  // end of [if]
//
| TOKbslash(c0) =>
  if (c0 > 0 && c0 != '\n')
    then (
      string_sing($UN.cast{charNZ}(c0))
    ) else ("")
  // end of [if]
//
| TOKspace(bs) => bs
//
| TOKsharp(nx) => nx
//
| TOKsquote() => "'"
| TOKdquote(nx) => nx
//
| TOKcode_beg(cbeg) => cbeg
| TOKcode_end(cend) => cend
//
end // end of [token_strngfy]

(* ****** ****** *)

implement
atext_strngfy
  (x0) = let
(*
// HX: atext_strngfy
*)
in
//
case+
x0.atext_node
of // case+
//
| TEXTnil() => ""
//
| TEXTtoken(tok) =>
    token_strngfy(tok)
  // end-of-TEXTtoken
//
//
| TEXTstring(str) => str
| TEXTerrmsg(msg) => msg
//
| TEXTlist(txts) => atextlst_strngfy(txts)
//
| TEXTsquote(txts) => atextlst_strngfy(txts)
| TEXTdquote(_, txts) => atextlst_strngfy(txts)
//
| TEXTextcode _ => "#extcode"
//
| TEXTdefname _ => "#defname"
| TEXTfuncall _ => "#funcall"
//
end // end of [atext_strngfy]

(* ****** ****** *)

local

fun
aux
(
  x0: atext, sbf: !stringbuf
) : void =
(
case+
x0.atext_node
of // case+
//
| TEXTnil() => ()
//
| TEXTtoken(tok) =>
  ignoret(
    stringbuf_insert_token(sbf, tok)
  ) (* TEXTtoken *)
//
//
| TEXTstring(str) =>
  ignoret(
    stringbuf_insert_string(sbf, str)
  ) (* TEXTstring *)
//
| TEXTerrmsg(msg) =>
  ignoret(
    stringbuf_insert_string(sbf, msg)
  ) (* TEXTerrmsg *)
//
| TEXTlist(txts) =>
  {
    val ((*void*)) = auxlst(txts, sbf)
  }
//
| TEXTsquote(txts) =>
  {
    val _(*1*) =
      stringbuf_insert_char(sbf, '\'')
    val ((*void*)) = auxlst(txts, sbf)
    val _(*1*) =
      stringbuf_insert_char(sbf, '\'')
  } (* TEXTsquote *)
| TEXTdquote(tok, txts) =>
  {
    val _(*n*) =
      stringbuf_insert_token(sbf, tok)
    val ((*void*)) = auxlst(txts, sbf)
    val _(*n*) =
      stringbuf_insert_token(sbf, tok)
  } (* TEXTdquote *)
//
| TEXTextcode _ => ()
//
| TEXTdefname _ =>
  {
    val () =
      aux(atext_defname_eval(x0), sbf)
  } (* TEXTdefname *)
| TEXTfuncall _ =>
  {
    val () = aux(atext_funcall_eval(x0), sbf)
  } (* TEXTfuncall *)
//
) (* end of [aux(x0, sbf)] *)

and
auxlst
(
  xs: atextlst, sbf: !stringbuf
) : void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => let
    val () = aux(x, sbf) in auxlst(xs, sbf)
  end // end of [list0_cons]
) (* end of [auxlst(xs, sbf)] *)

in (* in-of-local *)

implement
atextlst_strngfy
  (xs) = let
//
val
bsz = i2sz(1024)
//
val
sbf =
stringbuf_make_nil(bsz)
//
val () = auxlst(xs, sbf)
//
val res = stringbuf_getfree_strptr(sbf)
//
in
  strptr2string(res)
end // end of [atextlst_strngfy]

end // end of [local]

(* ****** ****** *)

implement
stringbuf_insert_token
  (sbf, x0) = let
(*
// HX: stringbuf_insert_token
*)
in
//
case+
x0.token_node
of // case+
//
| TOKeol() =>
  stringbuf_insert_char(sbf, '\n')
| TOKeof() => 0
//
| TOKint(rep) =>
  stringbuf_insert_string(sbf, rep)
//
| TOKide(rep) =>
  stringbuf_insert_string(sbf, rep)
//
| TOKspchr(c0) =>
  if c0 > 0
    then let
      val c0 = $UN.cast{charNZ}(c0)
    in
      stringbuf_insert_char(sbf, c0)
    end else 0
  // end of [if]
//
| TOKbslash(c0) =>
  if (c0 > 0 && c0 != '\n')
    then let
      val c0 = $UN.cast{charNZ}(c0)
    in
      stringbuf_insert_char(sbf, c0)
    end else (0)
  // end of [if]
//
| TOKspace(bs) => stringbuf_insert_string(sbf, bs)
//
| TOKsharp(nx) => stringbuf_insert_string(sbf, nx)
//
| TOKsquote() => stringbuf_insert_string(sbf, "'")
| TOKdquote(nx) => stringbuf_insert_string(sbf, nx)
//
| TOKcode_beg(cbeg) => stringbuf_insert_string(sbf, cbeg)
| TOKcode_end(cend) => stringbuf_insert_string(sbf, cend)
//
end // end of [stringbuf_insert_token]

(* ****** ****** *)

(* end of [atexting_strngfy.dats] *)
