(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: April, 2017 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload "./myatscc.sats"

(* ****** ****** *)
//
dynload "./myatscc_loc_t.dats"
dynload "./myatscc_lexer.dats"
dynload "./myatscc_parser.dats"
//
(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println! ("Hello from [myatscc]!")
//
val toks =
  string_tokenize(MYATSCCDEF)
//
val toks = tokenlst_tokenize(toks)
//
val exps = tokenlst2myexpseq(toks)
//
val exps = g0ofg1_list(exps)
//
val ((*void*)) = exps.foreach()(lam(exp) => println!(exp, ":", exp.myexp_loc))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [myatscc_main.dats] *)
