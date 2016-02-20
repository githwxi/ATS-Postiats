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
//
#include
"share\
/atspre_staload.hats"
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"utils/atexting/SATS/atexting.sats"
//
(* ****** ****** *)
//
extern fun
string_pats2xhtmlize_bground
  (stadyn: int, code: string): string =
  "ext#libatsynmark_string_pats2xhtmlize_bground"
//
extern fun
string_pats2xhtmlize_embedded
  (stadyn: int, code: string): string =
  "ext#libatsynmark_string_pats2xhtmlize_embedded"
//
(* ****** ****** *)

local

fun
__ats2xhtml__
(
  stadyn: int, xs: atextlst
) : string = let
//
val-
cons0(x0, _) = xs
//
val code = atext_strngfy(x0)
(*
val ((*void*)) =
  fprintln! (stdout_ref, "code =\n", code)
*)
val xhtml =
  string_pats2xhtmlize_embedded(stadyn, code)
//
in
  xhtml
end // end of [__ats2xhtml__]

in (* in-of-local *)
//
val () =
the_atextdef_insert_fstring
  ("sats2xhtml", lam(xs) => __ats2xhtml__(0, xs))
//
val () =
the_atextdef_insert_fstring
  ("dats2xhtml", lam(xs) => __ats2xhtml__(1, xs))
//
end // end of [local]

(* ****** ****** *)

(* end of [atexting_textdef_xhtml.dats] *)
