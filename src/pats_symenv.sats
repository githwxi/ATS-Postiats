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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload
SYMMAP = "./pats_symmap.sats"
vtypedef symmap (itm:type) = $SYMMAP.symmap (itm)

(* ****** ****** *)

absvt@ype
symenv_vt0ype (itm:type)
stadef symenv = symenv_vt0ype

(* ****** ****** *)

fun symenv_make_nil
  {itm:type} (): [l:addr] (symenv (itm) @ l | ptr l)
// end of [symenv]

(* ****** ****** *)

fun symenv_search
  {itm:type} // HX: search all
  (env: &symenv itm, k: symbol):<> Option_vt (itm)
// end of [symenv_search]

fun symenv_insert
  {itm:type} // HX: insert first
  (env: &symenv itm, k: symbol, i: itm):<> void
// end of [symenv_insert]

(* ****** ****** *)

fun symenv_pop{itm:type}
  (env: &symenv itm):<> symmap (itm)
fun symenv_pop_free{itm:type}(env: &symenv itm):<> void

fun symenv_push {itm:type}
  (env: &symenv itm, map: symmap (itm)):<> void
fun symenv_push_nil{itm:type}(env: &symenv itm):<> void

(* ****** ****** *)

fun symenv_top_clear{itm:type}(env: &symenv itm):<> void

(* ****** ****** *)
//
// HX: saving the current env
//
fun symenv_savecur
  {itm:type} (env: &symenv itm):<> void
// end of [symenv_savecur]

//
// HX: restoring the last saved env
//
fun symenv_restore
  {itm:type} (env: &symenv itm):<> symmap (itm)
// end of [symenv_restore]

(* ****** ****** *)
//
// HX: handling: local ... in ... end
//
fun symenv_localjoin
  {itm:type} (env: &symenv itm):<> void
// end of [symenv_localjoin]

(* ****** ****** *)

fun
symenv_pervasive_search
  {itm:type}(env: &symenv itm, k: symbol):<> Option_vt (itm)
// end of [symenv_pervasive_search]

fun
symenv_pervasive_insert
  {itm:type} (env: &symenv itm, k: symbol, i: itm):<> void
// end of [symenv_pervasive_insert]

(* ****** ****** *)

fun
symenv_pervasive_joinwth0
  {itm:type} (env: &symenv itm, map:  symmap itm):<> void
// end of [symenv_pervasive_joinwth0]
fun
symenv_pervasive_joinwth1
  {itm:type} (env: &symenv itm, map: !symmap itm):<> void
// end of [symenv_pervasive_joinwth1]

(* ****** ****** *)

fun
fprint_symenv_map
  {itm:type} (
  out: FILEref, env: &symenv itm, f: (FILEref, itm) -> void
) : void // end of [fprint_symenv_map]

(* ****** ****** *)

(* end of [pats_symenv.sats] *)
