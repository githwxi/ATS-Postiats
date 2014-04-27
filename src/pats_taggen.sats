(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: July, 2013
//
(* ****** ****** *)

staload
SYN = "./pats_syntax.sats"
typedef d0eclist = $SYN.d0eclist

(* ****** ****** *)

abstype tagent_type
typedef tagent = tagent_type

(* ****** ****** *)

vtypedef tagentlst_vt = List_vt (tagent)

(* ****** ****** *)

fun taggen_proc (d0cs: d0eclist): tagentlst_vt

(* ****** ****** *)
//
fun fprint_entlst
  (out: FILEref, given: string, xs: tagentlst_vt): void
//
(* ****** ****** *)

(* end of [pats_taggen.sats] *)
