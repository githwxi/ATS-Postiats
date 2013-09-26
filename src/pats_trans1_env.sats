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
FIX = "./pats_fixity.sats"
typedef fxty = $FIX.fxty

(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload "./pats_syntax.sats"
staload "./pats_symmap.sats"
staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)

fun the_e1xpenv_add (k: symbol, x: e1xp): void
fun the_e1xpenv_addperv (k: symbol, x: e1xp): void
fun the_e1xpenv_find (k: symbol): Option_vt (e1xp)

(* ****** ******* *)
//
absview e1xpenv_push_v
//
fun the_e1xpenv_pop
  (pf: e1xpenv_push_v | (*none*)): symmap (e1xp)
fun the_e1xpenv_push_nil (): (e1xpenv_push_v | void)
//
(* ****** ******* *)

fun the_EXTERN_PREFIX_get (): Stropt
fun the_EXTERN_PREFIX_set (prfx: string): void
fun the_EXTERN_PREFIX_set_none (): void

(* ****** ******* *)

fun the_fxtyenv_add (key: symbol, itm: fxty): void
fun the_fxtyenv_find (key: symbol): Option_vt (fxty)

absview fxtyenv_push_v
fun the_fxtyenv_pop
  (pf: fxtyenv_push_v | (*none*)): symmap (fxty)
fun the_fxtyenv_push_nil (): (fxtyenv_push_v | void)

fun the_fxtyenv_pervasive_joinwth (map: symmap (fxty)): void

(* ****** ******* *)

fun fprint_the_fxtyenv (out: FILEref): void // mostly for debugging

(* ****** ****** *)

absview
trans1_level_v // for avoiding negative levels
fun the_trans1_level_get (): int
fun the_trans1_level_dec (pf: trans1_level_v | (*none*)): void
fun the_trans1_level_inc (): (trans1_level_v | void)

(* ****** ****** *)

absview trans1_env_push_v

fun the_trans1_env_pop
  (pf: trans1_env_push_v | (*none*)): void
fun the_trans1_env_push (): (trans1_env_push_v | void)

(*
** HX: for handling <local ... in ... end>
*)
fun the_trans1_env_localjoin (
  pf1: trans1_env_push_v, pf2: trans1_env_push_v | (*none*)
) : void // end of [trans1_env_localjoin]

(* ****** ******* *)

absview trans1_env_save_v
fun the_trans1_env_save ((*none*)): (trans1_env_save_v | void)
fun the_trans1_env_restore (pf: trans1_env_save_v | (*none*)): void

(* ****** ****** *)

fun staload_file_search (fil: filename): Option_vt@(int(*ldflg*), d1eclist)
fun staload_file_insert (fil: filename, loadflag: int, d1cs: d1eclist): void

(* ****** ******* *)

fun the_trans1_env_initialize (): void

(* ****** ******* *)

(* end of [pats_trans1_env.sats] *)
