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
extern
fun
string_pats2xhtmlize_bground
  (stadyn: int, code: string): string =
  "ext#libatsynmark_string_pats2xhtmlize_bground"
//
extern
fun
string_pats2xhtmlize_embedded
  (stadyn: int, code: string): string =
  "ext#libatsynmark_string_pats2xhtmlize_embedded"
//
(* ****** ****** *)

local

fun
__patsyntax__
(
  loc: loc_t, _: atextlst
) : atext =
atext_make_string
( loc
, "\
<style type=\"text/css\">
  .patsyntax {color:#808080;background-color:#E0E0E0;}
  .patsyntax span.keyword {color:#000000;font-weight:bold;}
  .patsyntax span.comment {color:#787878;font-style:italic;}
  .patsyntax span.extcode {color:#A52A2A;}
  .patsyntax span.neuexp  {color:#800080;}
  .patsyntax span.staexp  {color:#0000F0;}
  .patsyntax span.prfexp  {color:#603030;}
  .patsyntax span.dynexp  {color:#F00000;}
  .patsyntax span.stalab  {color:#0000F0;font-style:italic}
  .patsyntax span.dynlab  {color:#F00000;font-style:italic}
  .patsyntax span.dynstr  {color:#008000;font-style:normal}
  .patsyntax span.stacstdec  {text-decoration:none;}
  .patsyntax span.stacstuse  {color:#0000CF;text-decoration:underline;}
  .patsyntax span.dyncstdec  {text-decoration:none;}
  .patsyntax span.dyncstuse  {color:#B80000;text-decoration:underline;}
  .patsyntax span.dyncst_implement  {color:#B80000;text-decoration:underline;}
</style>
") (* end of [_patsyntax__] *)

in (* in-of-local *)
//
val () =
the_atextmap_insert
(
  "patsyntax"
, TEXTDEFfun(
    lam(loc, xs) => __patsyntax__(loc, xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)
//
end // end of [local]

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
//
(*
val ((*void*)) =
  fprintln! (stdout_ref, "code =\n", code)
*)
//
val xhtml =
  string_pats2xhtmlize_bground(stadyn, code)
//
in
  xhtml
end // end of [__ats2xhtml__]

in (* in-of-local *)
//
fun
sats2xhtml
(
  loc: loc_t, xs: atextlst
) : atext =
(
  atext_make_string(loc, __ats2xhtml__(0, xs))
)
//
fun
dats2xhtml
(
  loc: loc_t, xs: atextlst
) : atext =
(
  atext_make_string(loc, __ats2xhtml__(1, xs))
)
//
val () =
the_atextmap_insert
( "sats2xhtml"
, TEXTDEFfun(lam(loc, xs) => sats2xhtml(loc, xs))
) (* the_atextmap_insert *)
//
val () =
the_atextmap_insert
( "dats2xhtml"
, TEXTDEFfun(lam(loc, xs) => dats2xhtml(loc, xs))
) (* the_atextmap_insert *)
//
end // end of [local]

(* ****** ****** *)

(* end of [atexting_textdef_xhtml.dats] *)
