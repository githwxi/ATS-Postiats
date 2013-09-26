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
#define true true_bool // shorthand
val true_bool : bool (true)  = "mac#atsbool_true" // = 1
//
#define false false_bool // shorthand
val false_bool : bool (false) = "mac#atsbool_false" // = 0
//
(* ****** ****** *)
//
// HX: [false] implies all
//
prfun false_elim {X:prop | false} (): X
//
(* ****** ****** *)
//
praxi
lemma_subcls_reflexive {c:cls} (): [c <= c] void
praxi
lemma_subcls_transitive
  {c1,c2,c3:cls | c1 <= c2; c2 <= c3} (): [c1 <= c3] void
//
(* ****** ****** *)

dataprop
EQINT (int, int) = {x:int} EQINT (x, x)
//
prfun eqint_make {x,y:int | x == y} (): EQINT (x, y)
//
prfun
eqint_make_gint
  {tk:tk}{x:int} (x: g1int (tk, x)): [y:int] EQINT (x, y)
prfun
eqint_make_guint
  {tk:tk}{x:int} (x: g1uint (tk, x)): [y:int] EQINT (x, y)
//
(* ****** ****** *)

dataprop
EQADDR (addr, addr) = {x:addr} EQADDR (x, x)
//
prfun eqaddr_make {x,y:addr | x == y} (): EQADDR (x, y)
//
prfun eqaddr_make_ptr {x:addr} (x: ptr (x)): [y:addr] EQADDR (x, y)
//
(* ****** ****** *)

dataprop
EQBOOL (bool, bool) = {x:bool} EQBOOL (x, x)
//
prfun eqbool_make {x,y:bool | x == y} (): EQBOOL (x, y)
//
prfun eqbool_make_bool {x:bool} (x: bool (x)): [y:bool] EQBOOL (x, y)
//
(* ****** ****** *)

prfun prop_verify {b:bool | b} ():<prf> void
prfun prop_verify_and_add {b:bool | b} ():<prf> [b] void

(* ****** ****** *)

prfun pridentity {a:vt@ype} (x: !INV(a)): void

(* ****** ****** *)

dataprop
EQTYPE (vt@ype, vt@ype) = {a:vt@ype} EQTYPE (a, a)

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
//
// HX: returning the pf to GC
//
praxi
mfree_gc_v_elim
  {l:addr} (pf: mfree_gc_v l): void
// end of [mfree_gc_v_elim]

(* ****** ****** *)

praxi
mfree_gcngc_v_nullify
  {l:addr} (
  pf1: mfree_gc_v (l), pf1: mfree_ngc_v (l)
) : void // end of [mfree_gcngc_nullify_v]

(* ****** ****** *)

fun cloptr_free
  {a:t@ype} (p: cloptr a):<!wrt> void = "mac#%"
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
//
praxi
vcopyenv_v_decode{v:view} (x: vcopyenv_v (v)): vtakeout0 (v)
castfn
vcopyenv_vt_decode{vt:vt0p} (x: vcopyenv_vt (vt)): vttakeout0 (vt)
//
overload decode with vcopyenv_v_decode
overload decode with vcopyenv_vt_decode
//
(* ****** ****** *)
//
// HX: the_null_ptr = (void*)0
//
val
the_null_ptr : ptr (null) = "mac#atsptr_null"
//
(* ****** ****** *)

praxi
lemma_addr_param {l:addr} (): [l >= null] void

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
// HX-2012-06:
// indication of the failure of
exception AssertExn of () // an assertion
//
(* ****** ****** *)
//
// HX-2012-06:
// indication of something expected
exception NotFoundExn of () // to be found but not
//
(* ****** ****** *)
//
exception GenerallyExn of (string) // for unspecified causes
(*
exception GenerallyExn2 of (string, ptr(*data*)) // for unspecified causes
*)
//
(* ****** ****** *)
//
// HX-2012-07:
// indication of a function argument being
exception IllegalArgExn of (string) // out of its domain
//
(* ****** ****** *)

praxi __vfree_exn (x: exn):<> void // for freeing nullary exception-con

(* ****** ****** *)
//
datatype unit = unit of ()
dataprop unit_p = unit_p of ()
dataview unit_v = unit_v of ()
prfun unit_v_elim (pf: unit_v): void
//
(* ****** ****** *)
//
typedef
array (a, n) = @[a][n]
viewdef
array_v
  (a:vt@ype, l:addr, n:int) = @[a][n] @ l
//
absvtype
arrayptr_vt0ype_addr_int_vtype
  (a:vt0ype+, l:addr, n:int(*size*)) = ptr (l)
stadef
arrayptr = arrayptr_vt0ype_addr_int_vtype
vtypedef
arrayptr
  (a:vt0p, n:int) = [l:addr] arrayptr (a, l, n)
//
abstype
arrayref_vt0ype_int_type
  (a:vt@ype(*elt*), n:int(*size*)) = ptr
stadef arrayref = arrayref_vt0ype_int_type
//
abstype
arrszref_vt0ype_type (a: vt@ype) = ptr
stadef arrszref = arrszref_vt0ype_type
//
(* ****** ****** *)
//
datatype // t@ype+: covariant
list_t0ype_int_type (a:t@ype+, int) =
  | {n:int | n >= 0}
    list_cons (a, n+1) of (a, list_t0ype_int_type (a, n))
  | list_nil (a, 0) of ()
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
(* ****** ****** *)
//
datavtype // vt@ype+: covariant
list_vt0ype_int_vtype (a:vt@ype+, int) =
  | {n:int | n >= 0}
    list_vt_cons (a, n+1) of (a, list_vt0ype_int_vtype (a, n))
  | list_vt_nil (a, 0) of ()
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
//
absvt@ype
arrayopt (a:vt0p, n:int, b:bool) = array (a, n)
//
praxi
arrayopt_some
  {a:vt0p}{n:int} (A: &array (a, n) >> arrayopt (a, n, true)): void
praxi
arrayopt_none
  {a:vt0p}{n:int} (A: &array (a?, n) >> arrayopt (a, n, false)): void
praxi
arrayopt_unsome
  {a:vt0p}{n:int} (A: &arrayopt (a, n, true) >> array (a, n)): void
praxi
arrayopt_unnone
  {a:vt0p}{n:int} (A: &arrayopt (a, n, false) >> array (a?, n)): void
//
(* ****** ****** *)

absvtype
argv_int_vtype (n:int) = ptr
stadef argv = argv_int_vtype

(*
[argv_takeout_strarr] is declared in prelude/SATS/extern.sats
[argv_takeout_parrnull] is declared in prelude/SATS/extern.sats
*)

(* ****** ****** *)

praxi
lemma_argv_param {n:int} (argv: !argv(n)): [n >= 0] void
// end of [praxi]

(* ****** ****** *)

fun argv_get_at{n:int}
  (argv: !argv (n), i: natLt n):<> string = "mac#%"
fun argv_set_at{n:int}
  (argv: !argv (n), i: natLt n, x: string):<!wrt> void = "mac#%"
//
overload [] with argv_get_at
overload [] with argv_set_at
//
(* ****** ****** *)
//
symintr main0
//
fun main_void_0
  ((*void*)): void = "ext#mainats_void_0"
fun main_argc_argv_0
  {n:int | n >= 1}
  (argc: int n, argv: !argv(n)): void = "ext#mainats_argc_argv_0"
overload main0 with main_void_0
overload main0 with main_argc_argv_0
//
(* ****** ****** *)
//
symintr main
//
fun main_void_int
  ((*void*)): int = "ext#mainats_void_int"
fun main_argc_argv_int
  {n:int | n >= 1}
  (argc: int n, argv: !argv(n)): int = "ext#mainats_argc_argv_int"
fun main_argc_argv_envp_int
  {n:int | n >= 1}
  (argc: int n, argv: !argv n, envp: ptr): int = "ext#mainats_argc_argv_envp_int"
overload main with main_void_int
overload main with main_argc_argv_int
overload main with main_argc_argv_envp_int
//
(* ****** ****** *)

fun exit
  (ecode: int):<!exn> {a:t0p}(a) = "mac#%"
fun exit_errmsg
  (ecode: int, msg: string):<!exn> {a:t0p}(a) = "mac#%"
(*
fun exit_fprintf{ts:types}
(
  ecode: int, out: FILEref, fmt: printf_c ts, args: ts
) :<!exn> {a:vt0p}(a) = "mac#%" // end of [exit_fprintf]
*)

(* ****** ****** *)
//
fun exit_void
  (ecode: int):<!exn> void = "mac#%"
fun exit_errmsg_void
  (ecode: int, msg: string):<!exn> void = "mac#%"
//
(* ****** ****** *)

fun assert_bool0
  (x: bool):<!exn> void = "mac#%"
fun assert_bool1
  {b:bool} (x: bool (b)):<!exn> [b] void = "mac#%"
//
overload assert with assert_bool0 of 0
overload assert with assert_bool1 of 10
//
(* ****** ****** *)

fun{}
assertexn_bool0 (x: bool):<!exn> void
fun{}
assertexn_bool1 {b:bool} (x: bool (b)):<!exn> [b] void
//
symintr assertexn
overload assertexn with assertexn_bool0 of 0
overload assertexn with assertexn_bool1 of 10
//
(* ****** ****** *)

fun assert_errmsg_bool0
  (x: bool, msg: string):<!exn> void = "mac#%"
fun assert_errmsg_bool1
  {b:bool} (x: bool b, msg: string):<!exn> [b] void = "mac#%"
//
symintr assert_errmsg
overload assert_errmsg with assert_errmsg_bool0 of 0
overload assert_errmsg with assert_errmsg_bool1 of 10
//
(* ****** ****** *)

fun assert_errmsg2_bool0
  (x: bool, msg1: string, msg2: string):<!exn> void = "mac#%"
fun assert_errmsg2_bool1{b:bool}
  (x: bool b, msg1: string, msg2: string):<!exn> [b] void = "mac#%"
//
symintr assert_errmsg2
overload assert_errmsg2 with assert_errmsg2_bool0 of 0
overload assert_errmsg2 with assert_errmsg2_bool1 of 10
//
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
typedef
file_mode = [fm:file_mode] file_mode (fm)

(* ****** ****** *)

sortdef fmode = file_mode
typedef fmode (fm:fmode) = file_mode (fm)
typedef fmode = file_mode

(* ****** ****** *)

dataprop
file_mode_lte
  (fmode, fmode) =
  | {m:fmode} file_mode_lte_refl (m, m)
  | {m1,m2,m3:fmode}
    file_mode_lte_tran (m1, m3) of
      (file_mode_lte (m1, m2), file_mode_lte (m2, m3))
  | {m:fmode} file_mode_lte_rw_r (rw(), r()) of ()
  | {m:fmode} file_mode_lte_rw_w (rw(), w()) of ()
// end of [file_mode_lte]

(* ****** ****** *)
//
prval file_mode_lte_r_r
  : file_mode_lte (r(), r()) // impled in [filebas_prf.dats]
prval file_mode_lte_w_w
  : file_mode_lte (w(), w()) // impled in [filebas_prf.dats]
prval file_mode_lte_rw_rw
  : file_mode_lte (rw(), rw()) // impled in [filebas_prf.dats]
//
(* ****** ****** *)

abstype FILEref_type = ptr
typedef FILEref = FILEref_type

(* ****** ****** *)

typedef fprint_type (a: t0p) = (FILEref, a) -> void
typedef fprint_vtype (a: vt0p) = (FILEref, !a) -> void

(* ****** ****** *)

fun print_newline (): void = "mac#%"
fun prerr_newline (): void = "mac#%"
fun fprint_newline (out: FILEref): void = "mac#%"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_dyn.sats] *)
