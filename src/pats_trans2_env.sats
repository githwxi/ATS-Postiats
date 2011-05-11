(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
staload SYMMAP = "pats_symmap.sats"
stadef symmap = $SYMMAP.symmap
staload SYN = "pats_syntax.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)
//
// HX:
// [filenv] is introduced in [pats_staexp2.sats];
// using [minus] to indicate the need for the presence
// of [filenv] (for otherwise GC may reclaim [filenv]
// while the extracted ptr is still in use!
//
viewtypedef s2temap = symmap (s2rtext)
fun filenv_get_s2temap (fenv: filenv):
  [l:addr] (s2temap @ l, minus (filenv, s2temap @ l) | ptr l)
// end of [filenv_get_s2temap]

(* ****** ****** *)

fun the_s2rtenv_add (id: symbol, s2te: s2rtext): void

fun the_s2rtenv_find (id: symbol): s2rtextopt_vt
fun the_s2rtenv_find_qua (q: $SYN.s0rtq, id: symbol): s2rtextopt_vt

absview s2rtenv_push_v
fun the_s2rtenv_pop (pf: s2rtenv_push_v | (*none*)): s2temap
fun the_s2rtenv_push_nil (): (s2rtenv_push_v | void)

fun the_s2rtenv_localjoin
  (pf1: s2rtenv_push_v, pf2: s2rtenv_push_v | (*none*)): void
// end of [the_s2rtenv_localjoin]

fun the_s2rtenv_pervasive_joinwth (map: s2temap): void

(* ****** ****** *)

viewtypedef s2itmmap = symmap (s2itm)
fun filenv_get_s2itmmap (fenv: filenv):
  [l:addr] (s2itmmap @ l, minus (filenv, s2itmmap @ l) | ptr l)
// end of [filenv_get_s2itmmap]

fun the_s2expenv_add
  (id: symbol, s2i: s2itm): void
// end of [the_s2expenv_add]
fun the_s2expenv_add_scst (s2c: s2cst): void
fun the_s2expenv_add_svar (s2v: s2var): void
fun the_s2expenv_add_svarlst (s2vs: s2varlst): void
fun the_s2expenv_add_datconptr (d2c: d2con): void
fun the_s2expenv_add_datcontyp (d2c: d2con): void

fun the_s2expenv_find (id: symbol): s2itmopt_vt
fun the_s2expenv_find_qua (q: $SYN.s0taq, id: symbol): s2itmopt_vt

absview s2expenv_push_v
fun the_s2expenv_pop (pf: s2expenv_push_v | (*none*)): s2itmmap
fun the_s2expenv_pop_free (pf: s2expenv_push_v | (*none*)): void
fun the_s2expenv_push_nil (): (s2expenv_push_v | void)

fun the_s2expenv_localjoin
  (pf1: s2expenv_push_v, pf2: s2expenv_push_v | (*none*)): void
// end of [the_s2expenv_localjoin]

(* ****** ****** *)

fun the_maclev_get (): int
fun the_maclev_inc (): void
fun the_maclev_dec (): void

(* ****** ****** *)

fun the_tmplev_get (): int
fun the_tmplev_inc (): void
fun the_tmplev_dec (): void

fun s2var_check_tmplev (loc: location, s2v: s2var): void

(* ****** ****** *)

viewtypedef d2itmmap = symmap (d2itm)
fun filenv_get_d2itmmap (fenv: filenv):
  [l:addr] (d2itmmap @ l, minus (filenv, d2itmmap @ l) | ptr l)
// end of [filenv_get_d2itmmap]

(* ****** ****** *)

absview trans2_env_push_v
fun the_trans2_env_pop (pf: trans2_env_push_v | (*none*)): void
fun the_trans2_env_push_nil (): (trans2_env_push_v | void)

fun the_trans2_env_localjoin
  (pf1: trans2_env_push_v, pf2: trans2_env_push_v | (*none*)): void
// end of [trans2_env_localjoin]

absview trans2_env_save_v
fun the_trans2_env_save ((*none*)): (trans2_env_save_v | void)
fun the_trans2_env_restore (pf: trans2_env_save_v | (*none*)): void

(* ****** ****** *)

fun the_trans2_env_initialize (): void

(* ****** ****** *)

(* end of [pats_trans2_env.sats] *)
