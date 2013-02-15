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
sortdef t0p = t@ype and vt0p = vt@ype
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

prfun prop_verify {b:bool | b} ():<prf> void
prfun prop_verify_and_add {b:bool | b} ():<prf> [b] void

(* ****** ****** *)

prfun pridentity {a:vt@ype} (x: !INV(a)): void

(* ****** ****** *)

castfn
viewptr_match
  {a:vt0p}{l1,l2:addr | l1==l2}
  (pf: INV(a) @ l1 | p: ptr l2):<> [l:addr | l==l1] (a @ l | ptr l)
// end of [viewptr_match]

(* ****** ****** *)

val{a:vt@ype} sizeof : size_t (sizeof(a))

(* ****** ****** *)

praxi topize {a:t@ype} (x: !INV(a) >> a?): void

(* ****** ****** *)

castfn dataget {a:vt@ype} (x: !INV(a) >> a): a?!

(* ****** ****** *)

praxi free_gcngc_v_nullify
  {l:addr} (pf1: free_gc_v (l), pf1: free_ngc_v (l)): void
// en dof [free_gcngc_nullify_v]

(* ****** ****** *)

fun cloptr_free
  {a:t@ype} (p: cloptr a):<!wrt> void = "atspre_cloptr_free"
// end of [cloptr_free]

(* ****** ****** *)
(*
// HX-2012-05-23: this seems TOO complicated!
(*
** HX-2012-03: handling read-only views and vtypes
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

castfn
unstamp_t0ype
  {a:t@ype}{x:int} (x: stamped_t0ype (INV(a), x)):<> a
// end of [unstamp_t0ype]
castfn
unstamp_vt0ype
  {a:vt@ype}{x:int} (x: stamped_vt0ype (INV(a), x)):<> a
// end of [unstamp_vt0ype]

castfn
stamped_t2vt
  {a:t@ype}{x:int}
  (x: stamped_t0ype (INV(a), x)):<> stamped_vt0ype (a, x)
// end of [stamped_t2vt]
castfn
stamped_vt2t
  {a:t@ype}{x:int}
  (x: &stamped_vt0ype (INV(a), x)):<> stamped_t0ype (a, x)
// end of [stamped_vt2t]

(* ****** ****** *)

/*
** HX: the_null_ptr = (void*)0
*/
val the_null_ptr
  : ptr (null) = "mac#atsptr_null" // macro
macdef NULL = the_null_ptr // end of [macdef]

(* ****** ****** *)

praxi
lemma_string_param
  {n:int} (x: string(n)): [n >= 0] void
// end of [lemma_string_param]
praxi
lemma_stropt_param
  {n:int} (x: stropt(n)): [n >= ~1] void
// end of [lemma_stropt_param]

(* ****** ****** *)

dataprop SGN (int, int) =
  | SGNzero (0, 0) | {i:neg} SGNneg (i, ~1) | {i:pos} SGNpos (i,  1)
// end of [SGN] // end of [dataprop]

(* ****** ****** *)
//
// HX-2012-06: indication of something
exception NotFoundExn of () // expected to be found but not found
//
(* ****** ****** *)
//
// HX-2012-07: indication of a function argument taking
exception IllegalArgExn of (string) // some value out of its domain
//
(* ****** ****** *)
//
// HX-2012-07: indication of something (e.g. a template instance)
exception NotImplementedExn of (string) // that is not yet implemented
//
(* ****** ****** *)

typedef
array (a, n) = @[a][n]
viewdef
array_v (a:vt@ype, l:addr, n:int) = @[a][n] @ l

(* ****** ****** *)
//
datatype // t@ype+: covariant
list_t0ype_int_type (a:t@ype+, int) =
  | list_nil (a, 0) of ()
  | {n:int | n >= 0}
    list_cons (a, n+1) of (a, list_t0ype_int_type (a, n))
// end of [datatype]
stadef list = list_t0ype_int_type
typedef
List (a:t0p) = [n:int] list (a, n)
typedef
List0 (a:t0p) = [n:int | n >= 0] list (a, n)
typedef
List1 (a:t0p) = [n:int | n >= 1] list (a, n)
typedef listLt
  (a:t0p, n:int) = [k:nat | k < n] list (a, k)
typedef listLte
  (a:t0p, n:int) = [k:nat | k <= n] list (a, k)
typedef listGt
  (a:t0p, n:int) = [k:int | k > n] list (a, k)
typedef listGte
  (a:t0p, n:int) = [k:int | k >= n] list (a, k)
typedef listBtw
  (a:t0p, m:int, n:int) = [k:int | m <= k; k < n] list (a, k)
typedef listBtwe
  (a:t0p, m:int, n:int) = [k:int | m <= k; k <= n] list (a, k)
//
datavtype // vt@ype+: covariant
list_vt0ype_int_vtype (a:vt@ype+, int) =
  | list_vt_nil (a, 0) of ()
  | {n:int | n >= 0}
    list_vt_cons (a, n+1) of (a, list_vt0ype_int_vtype (a, n))
// end of [list_vt0ype_int_vtype]
stadef list_vt = list_vt0ype_int_vtype
vtypedef
List_vt (a:vt0p) = [n:int] list_vt (a, n)
vtypedef
List0_vt (a:vt0p) = [n:int | n >= 0] list_vt (a, n)
vtypedef
List1_vt (a:vt0p) = [n:int | n >= 1] list_vt (a, n)
vtypedef listLt_vt
  (a:vt0p, n:int) = [k:nat | k < n] list_vt (a, k)
vtypedef listLte_vt
  (a:vt0p, n:int) = [k:nat | k <= n] list_vt (a, k)
vtypedef listGt_vt
  (a:vt0p, n:int) = [k:int | k > n] list_vt (a, k)
vtypedef listGte_vt
  (a:vt0p, n:int) = [k:int | k >= n] list_vt (a, k)
vtypedef listBtw_vt
  (a:vt0p, m:int, n:int) = [k:int | m <= k; k < n] list_vt (a, k)
vtypedef listBtwe_vt
  (a:vt0p, m:int, n:int) = [k:int | m <= k; k <= n] list_vt (a, k)
//
(* ****** ****** *)
//
dataprop unit_p = unit_p of ()
dataview unit_v = unit_v of ()
prfun unit_v_elim (pf: unit_v): void
//
(* ****** ****** *)
//
datatype // t@ype+: covariant
option_t0ype_bool_type
  (a:t@ype+, bool) = Some (a, true) of (a) | None (a, false)
// end of [datatype]
stadef option = option_t0ype_bool_type
typedef Option (a:t0p) = [b:bool] option (a, b)
//
dataview
option_prop_bool_prop
  (a:prop+, bool) = Some_p (a, true) of (a) | None_p (a, false)
// end of [option_prop_bool_prop]
stadef option_p = option_prop_bool_prop
//
datavtype // vt@ype+: covariant
option_vt0ype_bool_vtype
  (a:vt@ype+, bool) = Some_vt (a, true) of (a) | None_vt (a, false)
// end of [option_vt0ype_bool_vtype]
stadef option_vt = option_vt0ype_bool_vtype
vtypedef Option_vt (a:vt0p) = [b:bool] option_vt (a, b)
//
dataview
option_view_bool_view
  (a:view+, bool) = Some_v (a, true) of (a) | None_v (a, false)
// end of [option_view_bool_view]
stadef option_v = option_view_bool_view
//
(* ****** ****** *)
//
praxi opt_some
  {a:vt0p} (x: !INV(a) >> opt (a, true)):<prf> void
praxi opt_unsome
  {a:vt0p} (x: !opt (INV(a), true) >> a):<prf> void
//
praxi opt_none
  {a:vt0p} (x: !(a?) >> opt (a, false)):<prf> void
praxi opt_unnone
  {a:vt0p} (x: !opt (INV(a), false) >> a?):<prf> void
//
praxi opt_clear
  {a:t0p} {b:bool} (x: !opt (INV(a), b) >> a?):<prf> void
//
(* ****** ****** *)

absvtype
argv_int_vtype (n:int) = ptr
stadef argv = argv_int_vtype

(*
[argv_takeout_strarr] is declared in prelude/SATS/extern.sats
[argv_takeout_parrnull] is declared in prelude/SATS/extern.sats
*)

fun
argv_get_at {n:int}
  (argv: !argv (n), i: natLt n):<> string = "mac#atspre_argv_get_at"
overload [] with argv_get_at

(* ****** ****** *)

symintr main

fun main_void
  ((*void*)): int = "ext#mainats_void"
fun main_argc_argv
  {n:int | n >= 1}
  (argc: int n, argv: !argv n): int = "ext#mainats_argc_argv"
fun main_argc_argv_envp
  {n:int | n >= 1}
  (argc: int n, argv: !argv n, envp: ptr): int = "ext#mainats_argc_argv_envp"
overload main with main_void
overload main with main_argc_argv
overload main with main_argc_argv_envp

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
  (x: bool):<!exn> void = "atspre_assert_bool"
overload assert with assert_bool0 of 0
fun assert_errmsg_bool0 (
  x: bool, msg: string
) :<!exn> void = "atspre_assert_errmsg_bool"
overload assert_errmsg with assert_errmsg_bool0 of 0

fun assert_bool1
  {b:bool} (
  x: bool (b)
) :<!exn> [b] void = "atspre_assert_bool"
overload assert with assert_bool1 of 1
fun assert_errmsg_bool1
  {b:bool} (
  x: bool b, msg: string
) :<!exn> [b] void = "atspre_assert_errmsg_bool"
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
typedef fmode = file_mode // HX-2013-01: shorthand

(* ****** ****** *)

dataprop
file_mode_lte
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
typedef fprint_vtype (a: vt0p) = (FILEref, !a) -> void

(* ****** ****** *)

fun fprint_newline
  (out: FILEref): void = "mac#atspre_fprint_newline"
fun print_newline (): void = "mac#atspre_print_newline"
fun prerr_newline (): void = "mac#atspre_prerr_newline"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_dyn.sats] *)
