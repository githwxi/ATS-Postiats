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

staload "./atexting.sats"

(* ****** ****** *)
//
extern
fun{}
fprint_token_node
  : (FILEref, tnode) -> void
//
(* ****** ****** *)

#ifdef
CODEGEN2
#then
#codegen2
( "fprint"
, token_node, fprint_token_node
)
#else
//
#include
"./atexting_token_fprint.hats"
//
implement
fprint_val<token> = fprint_token
//
implement{}
fprint_token_node$TOKfuncall$arg2
  (out, arg0) = let
  val-TOKfuncall(_, arg2) = arg0
in
  fprint_list_sep<token>(out, arg2, ", ")
end // end of [fprint_token_node$TOKfuncall$arg2]
//
implement
fprint_token(out, x0) =
  fprint_token_node<>(out, x0.token_node)
//
implement
fprint_tokenlst
  (out, xs) = fprint_list_sep<token>(out, xs, ", ")
//
#endif // #ifdef

(* ****** ****** *)

(* end of [atexting_token.dats] *)
