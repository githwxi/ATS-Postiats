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
dynload "./atexting_mylib.dats"
//
dynload "./atexting_fname.dats"
dynload "./atexting_posloc.dats"
//
dynload "./atexting_token.dats"
dynload "./atexting_atext.dats"
//
dynload "./atexting_parerr.dats"
//
dynload "./atexting_lexbuf.dats"
dynload "./atexting_lexing.dats"
//
dynload "./atexting_tokbuf.dats"
//
dynload "./atexting_global.dats"
//
(* ****** ****** *)

dynload "./atexting_parsing.dats"

(* ****** ****** *)

dynload "./atexting_topeval.dats"

(* ****** ****** *)

dynload "./atexting_stringify.dats"

(* ****** ****** *)

dynload "./atexting_mytest.dats"

(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println!("Hello from [atexting]!")
//
(*
val () = the_nsharp_set(2)
*)
//
(*
val () = test_tokenizing_fileref(inp)
*)
//
(*
val () = test_atextizing_fileref(inp)
*)
//
val out = stdout_ref
val txts = parsing_from_stdin((*void*))
//
val ((*void*)) = atextlst_topeval(out, txts)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [atexting_main.sats] *)
