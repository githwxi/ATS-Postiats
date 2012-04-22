(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

fun atscode_banner
  (): atext = atext_strcst ("\
(***********************************************************************)\
(*                                                                     *)\
(*                         Applied Type System                         *)\
(*                                                                     *)\
(***********************************************************************)\
") // end of [atscode_banner]

fun atscode_copyright_LGPL
  (): atext = atext_strcst ("\
(*\
** ATS/Postiats - Unleashing the Potential of Types!\
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.\
** All rights reserved\
**\
** ATS is free software;  you can  redistribute it and/or modify it under\
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the\
** Free Software Foundation; either version 2.1, or (at your option)  any\
** later version.\
**\
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY\
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or\
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License\
** for more details.\
**\
** You  should  have  received  a  copy of the GNU General Public License\
** along  with  ATS;  see the  file COPYING.  If not, please write to the\
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA\
** 02110-1301, USA.\
*)\
") // end of [atsode_copyright_LGPL)

(* ****** ****** *)

fun atscode_author (x: string): atext = atext_strcst (x)
fun atscode_authoremail (x: string): atext = atext_strcst (x)

(* ****** ****** *)

fun atscode_start_time (x: string): atext = atext_strcst (x)

(* ****** ****** *)

fun atscode_separator
  (): atext = atext_strcst ("(* ****** ****** *)")
// end of [atscode_separator]

(* ****** ****** *)

fun atscode_eof (x: string): atext = atext_strcst (x)

(* ****** ****** *)

(* end of [postiatsatxt_txt.hats] *)
