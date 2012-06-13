(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
sortdef t0p = t@ype and vt0p = viewt@ype
//
(* ****** ****** *)
//
// HX-2012: In $ATSHOME/ccomp/runtime:
// atsbool_true/atsbool_false are mapped to 1/0
// this mapping is fixed and should never be changed!
//
val true_bool
  : bool (true)  = "mac#atsbool_true" // = 1
#define true true_bool // shorthand
val false_bool
  : bool (false) = "mac#atsbool_false" // = 0
#define false false_bool // shorthand
//
(* ****** ****** *)
//
// HX: [false] implies all
//
prfun false_elim {X:prop | false} (): X
//
(* ****** ****** *)

dataprop
INTEQ (int, int) = {x:int} INTEQ (x, x)
prfun inteq_make {x,y:int | x == y} ():<prf> INTEQ (x, y)

dataprop
ADDREQ (addr, addr) = {x:addr} ADDREQ (x, x)
prfun addreq_make {x,y:addr | x == y} ():<prf> ADDREQ (x, y)

dataprop
BOOLEQ (bool, bool) = {x:bool} BOOLEQ (x, x)
prfun booleq_make {x,y:bool | x == y} ():<prf> BOOLEQ (x, y)

(* ****** ****** *)

prfun prop_verify {b:bool} ():<prf> void
prfun prop_verify_and_add {b:bool} ():<prf> [b] void

(* ****** ****** *)

val{a:viewt@ype} sizeof : size_t (sizeof(a))

(* ****** ****** *)

praxi topize {a:t@ype} (x: !INV(a) >> a?): void

(* ****** ****** *)
(*
// HX-2012-05-23: this seems TOO complicated!
(*
** HX-2012-03: handling read-only views and viewtypes
*)
castfn
read_getval // copy out a non-linear value
  {a:t@ype}{s:int}{n:int} (x: !READ (a, s, n)):<> a
// end of [read_getval]

praxi
read_takeout {v:view}
  (pf: !v >> READOUT (v, s)): #[s:int] READ (v, s, 0)
// end of [read_takeout]
praxi
read_addback // HX: there is no need to check
  {v1:view}{v2:view}{s:int} // if v1 and v2 match
  (pf1: !READOUT (v1, s) >> v1, pf2: READ (v2, s, 0)): void
// end of [read0_addback]

praxi
read_split
  {v:view}{s:int}{n:int}
  (pf: !READ (v, s, n) >> READ (v, s, n+1)): READ (v, s, 0)
// end of [read_split]
praxi
read_unsplit // HX: there is no need to check
  {v1:view}{v2:view}{s:int}{n1,n2:int} // if v1 and v2 match
  (pf1: READ (v1, s, n1), pf2: READ (v2, s, n2)): READ (v1, s, n1+n2-1)
// end of [read_unsplit]
*)
(* ****** ****** *)

/*
** HX: the_null_ptr = (void*)0
*/
val the_null_ptr
  : ptr (null) = "mac#atsptr_null" // macro
macdef NULL = the_null_ptr // end of [macdef]

(* ****** ****** *)

praxi
string_param_lemma
  {n:int} (x: string(n)): [n >= 0] void
// end of [string_param_lemma]

(* ****** ****** *)

dataprop SGN (int, int) =
  | SGNzero (0, 0) | {i:neg} SGNneg (i, ~1) | {i:pos} SGNpos (i,  1)
// end of [SGN] // end of [dataprop]

(* ****** ****** *)

typedef
array (a, n) = @[a][n]
viewdef
array_v (a:viewt@ype, l:addr, n:int) = @[a][n] @ l

(* ****** ****** *)
//
datatype // t@ype+: covariant
list0_t0ype_type (a: t@ype+) =
  | list0_cons of (a, list0_t0ype_type a) | list0_nil of ()
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
typedef
List (a:t0p) = [n:int | n >= 0] list (a, n)
typedef listLt
  (a:t0p, n:int) = [n1:nat | n1 < n] list (a, n1)
// end of [listLt]
typedef listLte
  (a:t0p, n:int) = [n1:nat | n1 <= n] list (a, n1)
// end of [listLte]
//
dataviewtype // viewt@ype+: covariant
list_viewt0ype_int_viewtype (a:viewt@ype+, int) =
  | {n:int | n >= 0}
    list_vt_cons (a, n+1) of (a, list_viewt0ype_int_viewtype (a, n))
  | list_vt_nil (a, 0)
// end of [list_viewt0ype_int_viewtype]
stadef list_vt = list_viewt0ype_int_viewtype
viewtypedef
List_vt (a:vt0p) = [n:int | n >= 0] list_vt (a, n)
viewtypedef listLt_vt
  (a:vt0p, n:int) = [n1:nat | n1 < n] list_vt (a, n1)
// end of [listLt_vt]
viewtypedef listLte_vt
  (a:vt0p, n:int) = [n1:nat | n1 <= n] list_vt (a, n1)
// end of [listLte_vt]
//
(* ****** ****** *)
//
dataprop unit_p = unit_p of ()
dataview unit_v = unit_v of ()
//
(* ****** ****** *)
//
datatype
option0_t0ype_type
  (a: t@ype+) = Some0 of (a) | None0 of ()
// end of [datatype]
stadef option0 = option0_t0ype_type
//
datatype // t@ype+: covariant
option_t0ype_bool_type
  (a:t@ype+, bool) = Some (a, true) of a | None (a, false)
// end of [datatype]
stadef option = option_t0ype_bool_type
typedef Option (a:t0p) = [b:bool] option (a, b)
//
dataview
option_prop_bool_prop
  (a:prop+, bool) = Some_p (a, true) of a | None_p (a, false)
// end of [option_prop_bool_prop]
stadef option_p = option_prop_bool_prop
//
dataviewtype // viewt@ype+: covariant
option_viewt0ype_bool_viewtype
  (a:viewt@ype+, bool) = Some_vt (a, true) of a | None_vt (a, false)
// end of [option_viewt0ype_bool_viewtype]
stadef option_vt = option_viewt0ype_bool_viewtype
viewtypedef Option_vt (a:vt0p) = [b:bool] option_vt (a, b)
//
dataview
option_view_bool_view
  (a:view+, bool) = Some_v (a, true) of a | None_v (a, false)
// end of [option_view_bool_view]
stadef option_v = option_view_bool_view
//
(* ****** ****** *)
//
praxi opt_some {a:vt0p} (x: !INV(a) >> opt (a, true)):<prf> void
praxi opt_unsome {a:vt0p} (x: !opt (INV(a), true) >> a):<prf> void
//
praxi opt_none {a:vt0p} (x: !(a?) >> opt (a, false)):<prf> void
praxi opt_unnone {a:vt0p} (x: !opt (INV(a), false) >> a?):<prf> void
//
praxi opt_clear {a:t0p} {b:bool} (x: !opt (a, b) >> a?):<prf> void
//
(* ****** ****** *)

typedef cmpval_1
  (a: vt0p) = (!a, !a) -<fun> int
typedef cmpval_2
  (a: vt0p, vt: viewtype) = (!a, !a, !vt) -<fun> int
stadef cmpval = cmpval_1
stadef cmpval = cmpval_2

fun{a:vt0p}
compval_elt_elt
  {vt:viewtype}
  (x1: !a, x2: !a, cmp: cmpval (a)):<> int
// end of [compval_elt_elt]
fun{a:vt0p}
compval_elt_elt_env
  {vt:viewtype}
  (x1: !a, x2: !a, cmp: cmpval (a, vt), env: !vt):<> int
// end of [compval_elt_elt_env]

(* ****** ****** *)

typedef cmpref_1
  (a: vt0p) = (&a, &a) -<fun> int
typedef cmpref_2
  (a: vt0p, vt: viewtype) = (&a, &a, !vt) -<fun> int
stadef cmpref = cmpref_1
stadef cmpref = cmpref_2

fun{a:vt0p}
compref_elt_elt
  {vt:viewtype}
  (x1: &a, x2: &a, cmp: cmpref (a)):<> int
// end of [compref_elt_elt]
fun{a:vt0p}
compref_elt_elt_env
  {vt:viewtype}
  (x1: &a, x2: &a, cmp: cmpref (a, vt), env: !vt):<> int
// end of [compref_elt_elt_env]

(* ****** ****** *)

absviewtype
argv_int_viewtype (n:int)
stadef argv = argv_int_viewtype

(*
[argv_takeout_strarr] is declared in prelude/SATS/extern.sats
[argv_takeout_parrnull] is declared in prelude/SATS/extern.sats
*)

fun argv_get_at
  {n:int} (argv: !argv (n), i: natLt n): string
overload [] with argv_get_at

(* ****** ****** *)

symintr main

fun main_void
  ((*void*)): int = "mainats"
fun main_argc_argv
  {n:int | n >= 1}
  (argc: int n, argv: !argv n): int = "mainats"
fun main_argc_argv_env
  {n:int | n >= 1}
  (argc: int n, argv: !argv n, env: ptr): int = "mainats"
overload main with main_void
overload main with main_argc_argv
overload main with main_argc_argv_env

(* ****** ****** *)

fun exit
  {a:vt0p} (ecode: int):<> a = "mac#ats_exit"
fun exit_errmsg
  {a:vt0p} (ecode: int, msg: string):<> a = "mac#ats_exit_errmsg"
(*
fun exit_fprintf
  {a:vt0p} {ts:types} (
  ecode: int
, out: FILEref
, fmt: printf_c ts, args: ts
) :<> a = "mac#atspre_exit_fprintf"
// end of [exit_fprintf]
*)

(* ****** ****** *)

fun assert_bool0
  (x: bool):<!exn> void = "atspre_assert"
overload assert with assert_bool0 of 0
fun assert_bool1
  {b:bool} (x: bool (b)):<!exn> [b] void
overload assert with assert_bool1 of 1

fun
assert_errmsg_bool0 (
  x: bool, msg: string
) :<!exn> void = "atspre_assert_errmsg"
overload assert_errmsg with assert_errmsg_bool0 of 0
fun
assert_errmsg_bool1
  {b:bool} (x: bool b, msg: string):<!exn> [b] void
overload assert_errmsg with assert_errmsg_bool1 of 1

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

abstype file_mode (file_mode) = string
typedef file_mode = [fm:file_mode] file_mode (fm)

(* ****** ****** *)

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

abstype FILEref_type = ptr
typedef FILEref = FILEref_type

(* ****** ****** *)

typedef fprint_type (a: t0p) = (FILEref, a) -> void

(* ****** ****** *)

fun{a:vt0p}
fprint_elt (out: FILEref, x: !INV(a)): void
fun{a:vt0p}
print_elt (x: !INV(a)): void // = fprint_elt (stdout_ref, x)
fun{a:vt0p}
prerr_elt (x: !INV(a)): void // = fprint_elt (stderr_ref, x)

(* ****** ****** *)

fun fprint_newline (out: FILEref): void
fun print_newline (): void // = fprint_newline (stdout_ref)
fun prerr_newline (): void // = fprint_newline (stderr_ref)

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_dyn.sats] *)
