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

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)
//
implement
atext_make
(
  loc, node
) = $rec{
  atext_loc= loc, atext_node= node
} (* $rec *)
//
(* ****** ****** *)
//
implement
atext_make_nil
(
  loc
) = atext_make(loc, TEXTnil())
//
(* ****** ****** *)
//
implement
atext_make_token
  (tok) = let
  val loc = tok.token_loc
in
  atext_make(loc, TEXTtoken(tok))
end // end of [atext_make_token]
//
(* ****** ****** *)
//
implement
atext_make_list
  (loc, txts) =
  atext_make(loc, TEXTlist(txts))
//
(* ****** ****** *)
//
implement
atext_make_string
  (loc, str) =
  atext_make(loc, TEXTstring(str))
//
implement
atext_make_errmsg
  (loc, msg) =
  atext_make(loc, TEXTerrmsg(msg))
//
(* ****** ****** *)
//
implement
atext_make_squote
  (loc, txts) =
  atext_make(loc, TEXTsquote(txts))
implement
atext_make_dquote
  (loc, tok, txts) =
  atext_make(loc, TEXTdquote(tok, txts))
//
(* ****** ****** *)
//
extern
fun{}
fprint_atext_node_
  : (FILEref, atext_node) -> void
//
(* ****** ****** *)

#ifdef
CODEGEN2
#then
#codegen2
( "fprint"
, atext_node, fprint_atext_node_
)
#else
//
#include
"./atexting_fprint_atext.hats"
//
implement
fprint_val<token> = fprint_token
implement
fprint_val<atext> = fprint_atext
implement
fprint_val<atextlst> = fprint_atextlst
//
implement
fprint_atext(out, x0) =
  fprint_atext_node_<>(out, x0.atext_node)
//
implement
fprint_atextlst
  (out, xs) =
  fprint_list_sep<atext>(out, $UN.cast{List0(atext)}(xs), ", ")
//
#endif // #ifdef

(* ****** ****** *)

(* end of [atexting_atext.dats] *)
