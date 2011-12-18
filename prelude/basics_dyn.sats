(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)
//
// HX: In $ATSHOME/ccomp/runtime:
// atsbool_true/atsbool_false are mapped to 1/0, respectively
//
val true  : bool (true)  = "mac#atsbool_true" // macro
and false : bool (false) = "mac#atsbool_false" // macro
//
(* ****** ****** *)

praxi
string_param_lemma
  {n:int} (x: string(n)): [n >= 0] void
// end of [string_param_lemma]

(* ****** ****** *)

datasort file_mode =
  | file_mode_r (* read *)
  | file_mode_w (* write *)
  | file_mode_rw (* read and write *)
// end of [file_mode]

stadef r() = file_mode_r ()
stadef w() = file_mode_w ()
stadef rw() = file_mode_rw ()

(* ****** ****** *)

abstype
file_mode (file_mode) = string

dataprop file_mode_lte
  (file_mode, file_mode) =
  | {m:file_mode} file_mode_lte_refl (m, m)
  | {m1,m2,m3:file_mode}
    file_mode_lte_tran (m1, m3) of
      (file_mode_lte (m1, m2), file_mode_lte (m2, m3))
  | {m:file_mode} file_mode_lte_rw_r (rw(), r()) of ()
  | {m:file_mode} file_mode_lte_rw_w (rw(), w()) of ()
// end of [file_mode_lte]

prval file_mode_lte_r_r
  : file_mode_lte (r(), r()) // implemented in [filebas_prf.dats]
prval file_mode_lte_w_w
  : file_mode_lte (w(), w()) // implemented in [filebas_prf.dats]
prval file_mode_lte_rw_rw
  : file_mode_lte (rw(), rw()) // implemented in [filebas_prf.dats]
(*
prval file_mode_lte_rw_r
  : file_mode_lte (rw(), r()) // implemented in [filebas_prf.dats]
prval file_mode_lte_rw_w
  : file_mode_lte (rw(), w()) // implemented in [filebas_prf.dats]
*)
(* ****** ****** *)
//
datatype // t@ype+: covariant
list0_t0ype_type (a: t@ype+) =
  | list0_cons (a) of (a, list0_t0ype_type a)
  | list0_nil (a) of ()
// end of [list0_t0ype_type]
stadef list0 = list0_t0ype_type
//
datatype // t@ype+: covariant
list_t0ype_int_type (a:t@ype+, int) =
  | {n:int | n >= 0}
    list_cons (a, n+1) of (a, list_t0ype_int_type (a, n))
  | list_nil (a, 0)
// end of [datatype]
stadef list = list_t0ype_int_type
typedef List (a:t@ype) = [n:int | n >= 0] list (a, n)
//
dataviewtype // viewt@ype+: covariant
list_viewt0ype_int_viewtype (a:viewt@ype+, int) =
  | {n:int | n >= 0}
    list_vt_cons (a, n+1) of (a, list_viewt0ype_int_viewtype (a, n))
  | list_vt_nil (a, 0)
// end of [list_viewt0ype_int_viewtype]
stadef list_vt = list_viewt0ype_int_viewtype
viewtypedef List_vt (a:viewt@ype) = [n:int | n >= 0] list_vt (a, n)
//
(* ****** ****** *)
//
dataprop unit_p = unit_p of ()
dataview unit_v = unit_v of ()
//
(* ****** ****** *)
//
datatype
option0_t0ype_type (a: t@ype+) =
  | option0_some (a) of (a) | option0_none (a) of ()
// end of [datatype]
stadef option0 = option0_t0ype_type
//
datatype // t@ype+: covariant
option_t0ype_bool_type (a:t@ype+, bool) =
  | None (a, false) | Some (a, true) of a
// end of [datatype]
stadef option = option_t0ype_bool_type
typedef Option (a:t@ype) = [b:bool] option (a, b)
//
dataview
option_view_bool_view
  (a:view+, bool) = Some_v (a, true) of a | None_v (a, false)
// end of [option_view_bool_view]
stadef option_v = option_view_bool_view
//
dataviewtype // viewt@ype+: covariant
option_viewt0ype_bool_viewtype (a:viewt@ype+, bool) =
  | None_vt (a, false) | Some_vt (a, true) of a
// end of [option_viewt0ype_bool_viewtype]
stadef option_vt = option_viewt0ype_bool_viewtype
viewtypedef Option_vt (a:viewt@ype) = [b:bool] option_vt (a, b)
//
(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_dyn.sats] *)
