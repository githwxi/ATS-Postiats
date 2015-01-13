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
// Start Time: May, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload SYMMAP = "./pats_symmap.sats"
vtypedef symmap(itm:type) = $SYMMAP.symmap(itm)

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)
//
// HX:
// [filenv] is introduced in [pats_staexp2.sats];
// using [minus] to indicate the need for the presence
// of [filenv] (for otherwise GC may reclaim [filenv]
// while the extracted ptr is still in use!
//

viewtypedef s2temap = symmap (s2rtext)
viewtypedef s2itmmap = symmap (s2itm)
viewtypedef d2itmmap = symmap (d2itm)

fun
filenv_make
(
  fil: filename
, m0: s2temap, m1: s2itmmap, m2: d2itmmap, d2cs: d2eclist
) : filenv // end of [filenv_make]

(*
fun filenv_get_name
  (fenv: filenv): filename // in [pats_staexp2.sats]
// end of [filenv_get_name]
*)

fun filenv_get_s2temap (fenv: filenv):
  [l:addr] (s2temap @ l, minus (filenv, s2temap @ l) | ptr l)
// end of [filenv_get_s2temap]

fun filenv_get_s2itmmap (fenv: filenv):
  [l:addr] (s2itmmap @ l, minus (filenv, s2itmmap @ l) | ptr l)
// end of [filenv_get_s2itmmap]

fun filenv_get_d2itmmap (fenv: filenv):
  [l:addr] (d2itmmap @ l, minus (filenv, d2itmmap @ l) | ptr l)
// end of [filenv_get_d2itmmap]

fun filenv_get_d2eclist (fenv: filenv): d2eclist

(* ****** ****** *)
//
fun filenv_getref_d3eclistopt (fenv: filenv): Ptr1
(*
fun filenv_getref_hideclistopt (fenv: filenv): Ptr1
*)
(* ****** ****** *)
//
fun filenv_getref_tmpcstimpmap (fenv: filenv): Ptr1
fun filenv_getref_tmpvardecmap (fenv: filenv): Ptr1
//
(* ****** ****** *)

fun the_s2rtenv_add (id: symbol, s2te: s2rtext): void

fun the_s2rtenv_find (id: symbol): s2rtextopt_vt
fun the_s2rtenv_find_qua (q: $SYN.s0rtq, id: symbol): s2rtextopt_vt

(* ****** ****** *)

absview s2rtenv_push_v

(* ****** ****** *)

fun the_s2rtenv_top_clear ((*void*)): void

(* ****** ****** *)
//
fun the_s2rtenv_pop (pf: s2rtenv_push_v | (*none*)): s2temap
fun the_s2rtenv_pop_free (pf: s2rtenv_push_v | (*none*)): void
fun the_s2rtenv_push_nil (): (s2rtenv_push_v | void)
//
(* ****** ****** *)

fun the_s2rtenv_localjoin
(
  pf1: s2rtenv_push_v, pf2: s2rtenv_push_v | (*none*)
) : void // end of [the_s2rtenv_localjoin]

fun the_s2rtenv_pervasive_joinwth0 (map: s2temap): void
fun the_s2rtenv_pervasive_joinwth1 (map: !s2temap): void

(* ****** ****** *)

fun the_s2expenv_add
  (id: symbol, s2i: s2itm): void
// end of [the_s2expenv_add]
fun the_s2expenv_add_scst (s2c: s2cst): void
fun the_s2expenv_add_svar (s2v: s2var): void
fun the_s2expenv_add_svarlst (s2vs: s2varlst): void
fun the_s2expenv_add_sp2at (sp2t: sp2at): void
fun the_s2expenv_add_datconptr (d2c: d2con): void
fun the_s2expenv_add_datcontyp (d2c: d2con): void

fun the_s2expenv_find (id: symbol): s2itmopt_vt
fun the_s2expenv_find_qua (q: $SYN.s0taq, id: symbol): s2itmopt_vt

fun the_s2expenv_pervasive_find (id: symbol): Option_vt (s2itm)

(* ****** ****** *)
//
absview s2expenv_push_v
//
(* ****** ****** *)

fun the_s2expenv_top_clear ((*void*)): void

(* ****** ****** *)
//
fun the_s2expenv_pop (pf: s2expenv_push_v | (*none*)): s2itmmap
fun the_s2expenv_pop_free (pf: s2expenv_push_v | (*none*)): void
fun the_s2expenv_push_nil (): (s2expenv_push_v | void)
//
(* ****** ****** *)

fun the_s2expenv_localjoin
(
  pf1: s2expenv_push_v, pf2: s2expenv_push_v | (*none*)
) : void // end of [the_s2expenv_localjoin]

fun the_s2expenv_pervasive_joinwth0 (map: s2itmmap): void
fun the_s2expenv_pervasive_joinwth1 (map: !s2itmmap): void

(* ****** ****** *)

fun the_maclev_get (): int
fun the_maclev_inc (loc: location): void
fun the_maclev_dec (loc: location): void

(* ****** ****** *)

fun the_macdeflev_get (): int
fun the_macdeflev_inc (): void
fun the_macdeflev_dec (): void

(* ****** ****** *)

fun the_tmplev_get (): int
fun the_tmplev_inc (): void
fun the_tmplev_dec (): void

fun s2var_check_tmplev (loc: location, s2v: s2var): void
fun s2qualstlst_set_tmplev (s2qs: s2qualst, tmplev: int): void

(* ****** ****** *)

absview the_d2varlev_inc_v
//
fun the_d2varlev_get (): int
fun the_d2varlev_inc (): (the_d2varlev_inc_v | void)
fun the_d2varlev_dec (pf: the_d2varlev_inc_v | (*none*)): void
//
fun the_d2varlev_save (): int
fun the_d2varlev_restore (lev0: int): void
//
(* ****** ****** *)
//
fun the_d2expenv_add (id: symbol, d2i: d2itm): void
//
fun the_d2expenv_add_dcon (d2c: d2con): void
fun the_d2expenv_add_dcst (d2c: d2cst): void
fun the_d2expenv_add_dmacdef (d2m: d2mac): void
fun the_d2expenv_add_dmacvar (d2v: d2var): void
fun the_d2expenv_add_dmacvarlst (d2vs: d2varlst): void
fun the_d2expenv_add_dvar (d2v: d2var): void
fun the_d2expenv_add_dvarlst (d2vs: d2varlst): void
fun the_d2expenv_add_dvaropt (d2vopt: d2varopt): void
//
fun the_d2expenv_add_fundeclst (knd: funkind, f2ds: f2undeclst): void
//
(* ****** ****** *)

fun the_d2expenv_find (id: symbol): d2itmopt_vt
fun the_d2expenv_find_qua (q: $SYN.d0ynq, id: symbol): d2itmopt_vt

fun the_d2expenv_current_find (id: symbol): Option_vt (d2itm)
fun the_d2expenv_pervasive_find (id: symbol): Option_vt (d2itm)

(* ****** ****** *)
//
absview d2expenv_push_v
//
(* ****** ****** *)

fun the_d2expenv_top_clear ((*void*)): void

(* ****** ****** *)
//
fun the_d2expenv_pop (pf: d2expenv_push_v | (*none*)): d2itmmap
fun the_d2expenv_pop_free (pf: d2expenv_push_v | (*none*)): void
fun the_d2expenv_push_nil ((*void*)): (d2expenv_push_v | void)
//
(* ****** ****** *)

fun the_d2expenv_localjoin
(
  pf1: d2expenv_push_v, pf2: d2expenv_push_v | (*none*)
) : void // end of [the_d2expenv_localjoin]

fun the_d2expenv_pervasive_joinwth0 (map: d2itmmap): void
fun the_d2expenv_pervasive_joinwth1 (map: !d2itmmap): void

(* ****** ****** *)
//
absview staload_level_push_v
//
fun the_staload_level_get (): int
//
fun the_staload_level_pop
  (pf: staload_level_push_v | (*none*)): void
//
fun the_staload_level_push (): (staload_level_push_v | void)
//
(* ****** ****** *)

fun the_filenvmap_add (fid: symbol, fenv: filenv): void
fun the_filenvmap_find (fid: symbol): Option_vt (filenv)

(* ****** ****** *)
//
absview trans2_env_push_v
//
fun the_trans2_env_pop
  (pf: trans2_env_push_v | (*none*)): void
//
fun the_trans2_env_push (): (trans2_env_push_v | void)
//
fun
the_trans2_env_localjoin
(
  pf1: trans2_env_push_v, pf2: trans2_env_push_v | (*none*)
) : void // end of [trans2_env_localjoin]
//
(* ****** ****** *)
//
absview trans2_env_save_v
//
fun the_trans2_env_save
  ((*none*)): (trans2_env_save_v | void)
fun the_trans2_env_restore
  (pf: trans2_env_save_v | (*none*)) : (s2temap, s2itmmap, d2itmmap)
//
(* ****** ****** *)

fun the_trans2_env_pervasive_joinwth
  (pf: trans2_env_push_v | fil: filename, d2cs: d2eclist): void
// end of [the_trans2_env_pervasive_joinwth1]

(* ****** ****** *)

fun the_trans2_env_initialize ((*void*)): void

(* ****** ****** *)

(* end of [pats_trans2_env.sats] *)
