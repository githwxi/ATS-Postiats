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
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)

local

fun
is_escaped
  (c0: int): bool = let
  val c0 = int2char0(c0)
in
//
case+ c0 of
| 'n' => true
| 't' => true
| 'f' => true
| 'b' => true
| 'v' => true
| '0' => true
| '\\' => true
| '\n' => true
| _(*rest-of-char*) => false
//
end // end of [is_escaped]

in (* in-of-local *)

implement
token_topeval
  (out, x0) = let
(*
// HX: token_topeval
*)
in
//
case+
x0.token_node
of // case+
//
| TOKide(ide) => fprint(out, ide)
| TOKint(rep) => fprint(out, rep)
//
| TOKspace(cs) => fprint(out, cs)
| TOKsharp(cs) => fprint(out, cs)
//
| TOKsquote() => fprint(out, "'")
| TOKdquote(cs) => fprint(out, cs)
//
| TOKspchr(c) =>
    fprint_char(out, int2char0(c))
  // TOKspchr
| TOKbslash(c) => let
    val isesp = is_escaped(c)
    val ((*void*)) =
    if isesp
      then fprint_char(out, '\\')
    // end of [val]
  in
    fprint_char(out, int2char0(c))
  end // TOKbslash
//
| TOKcode_beg _ => fprint(out, "%{")
| TOKcode_end _ => fprint(out, "%}")
//
| TOKeol((*void*)) => fprint_newline(out)
//
| TOKeof((*void*)) => ((*end-of-file*))
//
end // end of [token_topeval]

end // end of [local]

(* ****** ****** *)
//
implement
tokenlst_topeval
  (out, xs) =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  (
    token_topeval(out, x); tokenlst_topeval(out, xs)
  ) (* end of [list0_cons] *)
)
//
(* ****** ****** *)
  
implement
atext_topeval
  (out, x0) = let
(*
// HX: atext_topeval
*)
in
//
case+
x0.atext_node
of // case+
//
| TEXTtoken(tok) =>
  {
    val () = token_topeval(out, tok)
  } (* end of [TEXTtoken] *)
//
| TEXTsquote(xs) =>
  {
    val () = fprint(out, "'")
    val () = atextlst_topeval(out, xs)
    val () = fprint(out, "'")
  }
//
| TEXTdquote(tok, xs) =>
  {
    val () = token_topeval(out, tok)
    val () = atextlst_topeval(out, xs)
    val () = token_topeval(out, tok)
  }
//
| TEXTextcode
    (tok_beg, toklst, tok_end) =>
  {
    val () = token_topeval(out, tok_beg)
    val () = atextlst_topeval(out, toklst)
    val () = token_topeval(out, tok_end)
  }
//
| TEXTdefname(tok, name) =>
  {
    val () = token_topeval(out, tok)
    val () = token_topeval(out, name)
  }
//
| TEXTfuncall(tok0, tok1, arglst) =>
  {
    val () = token_topeval(out, tok0)
    val () = token_topeval(out, tok1)
    val () = fprint(out, "(")
    val () = atextlst_topeval(out, arglst)
    val () = fprint(out, ")")
  } (* end of [TEXTfuncall] *)

//
end // end of [atext_topeval]
  
(* ****** ****** *)
//
implement
atextlst_topeval
  (out, xs) =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  (
    atext_topeval(out, x); atextlst_topeval(out, xs)
  ) (* end of [list0_cons] *)
)
//
(* ****** ****** *)

(* end of [atexting_topeval.dats] *)
