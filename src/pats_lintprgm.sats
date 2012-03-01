(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Anairiats - Unleashing the Potential of Types!
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
// Time: February 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_intinf.sats"

(* ****** ****** *)

absviewt@ype
myint(a:t@ype) = a // [a] is a kind

(* ****** ****** *)

fun{a:t@ype} myint_make_int (x: int): myint(a)
fun{a:t@ype} myint_make_intinf (x: intinf): myint(a)

fun{a:t@ype} myint_free (x: myint(a)):<> void
fun{a:t@ype} myint_copy (x: !myint(a)):<> myint(a)

(* ****** ****** *)

fun{a:t@ype}
neg_myint (x: myint(a)):<> myint(a)
overload ~ with neg_myint

fun{a:t@ype}
succ_myint (x: myint(a)):<> myint(a)
fun{a:t@ype}
pred_myint (x: myint(a)):<> myint(a)

fun{a:t@ype}
add01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)
fun{a:t@ype}
sub01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)

fun{a:t@ype}
mul01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)
fun{a:t@ype}
mul10_myint_myint (x: !myint(a), y: myint(a)):<> myint(a)
fun{a:t@ype}
mul11_myint_myint (x: !myint(a), y: !myint(a)):<> myint(a)

fun{a:t@ype}
div01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)
fun{a:t@ype}
div11_myint_myint (x: !myint(a), y: !myint(a)):<> myint(a)
//
// HX: ediv: even division is assumed
//
fun{a:t@ype}
ediv01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)

fun{a:t@ype}
mod01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)
fun{a:t@ype}
mod11_myint_myint (x: !myint(a), y: !myint(a)):<> myint(a)

fun{a:t@ype}
gcd01_myint_myint (x: myint(a), y: !myint(a)):<> myint(a)

(* ****** ****** *)

fun{a:t@ype}
lt_myint_int (x: !myint(a), y: int):<> bool
fun{a:t@ype}
lte_myint_int (x: !myint(a), y: int):<> bool
overload < with lt_myint_int
overload <= with lte_myint_int

fun{a:t@ype}
gt_myint_int (x: !myint(a), y: int):<> bool
fun{a:t@ype}
gte_myint_int (x: !myint(a), y: int):<> bool
overload > with gt_myint_int
overload >= with gte_myint_int

fun{a:t@ype}
eq_myint_int (x: !myint(a), y: int):<> bool
fun{a:t@ype}
neq_myint_int (x: !myint(a), y: int):<> bool
overload = with eq_myint_int
overload != with neq_myint_int

fun{a:t@ype}
compare_myint_int (x: !myint(a), y: int):<> int
overload compare with compare_myint_int

fun{a:t@ype}
lt_myint_myint (x: !myint(a), y: !myint(a)):<> bool
fun{a:t@ype}
lte_myint_myint (x: !myint(a), y: !myint(a)):<> bool
overload < with lt_myint_myint
overload <= with lte_myint_myint

fun{a:t@ype}
gt_myint_myint (x: !myint(a), y: !myint(a)):<> bool
fun{a:t@ype}
gte_myint_myint (x: !myint(a), y: !myint(a)):<> bool
overload > with gt_myint_myint
overload >= with gte_myint_myint

(* ****** ****** *)

fun{a:t@ype}
fprint_myint (out: FILEref, x: !myint(a)): void
fun{a:t@ype} print_myint (x: !myint(a)): void
fun{a:t@ype} prerr_myint (x: !myint(a)): void

(* ****** ****** *)

(*
**
** HX-2012-02:
** [myintvec] is a [myint] array of positive length
** Suppose A: myintvec(n+1) for some n >= 0; then A
** as a linear constraint stands for the following
** inequality:
**
** A[0] + A[1]*x1 + A[2]*x2 + ... + A[n]*xn >= 0
**
*)
absviewtype myintvec (a:t@ype, n: int) // initialized
absviewtype myintvec0 (a:t@ype, n: int) // uninitialized
absviewtype myintvecout (a:t@ype, n: int, l:addr) // SHELL

praxi lemma_myintvec_params
  {a:t@ype}{n:int} (iv: !myintvec (a, n)): [n>=0] void
// end of [lemma_myintvec_params]

castfn
myintvec_takeout
  {a:t@ype}{n:int} (
  iv: !myintvec (a, n) >> myintvecout (a, n, l)
) :<> #[l:addr] (array_v (myint(a), n, l) | ptr l)
castfn
myintvec0_takeout
  {a:t@ype}{n:int} (
  iv: !myintvec0 (a, n) >> myintvecout (a, n, l)
) :<> #[l:addr] (array_v (myint(a)?, n, l) | ptr l)
prfun
myintvecout_addback
  {a:t@ype}{n:int}{l:addr} (
  pf: array_v (myint(a), n, l)
| iv: !myintvecout (a, n, l) >> myintvec (a, n)
) : void // end of [myintvecout_addback]

fun{a:t@ype}
myintvec_get_at
  {n:int} (iv: !myintvec (a, n), i: natLt n):<> myint(a)
overload [] with myintvec_get_at

fun{a:t@ype}
myintvec_compare_at
  {n:int} (iv: !myintvec (a, n), i: natLt n, x: int): int
// end of [myintvec_compare_at]

(* ****** ****** *)

fun{a:t@ype}
myintvec0_make
  {n:nat} (n: int n):<> myintvec0 (a, n)
// end of [myintvec0_make]
fun myintvec0_free
  {a:t@ype}{n:int} (iv: myintvec0 (a, n), n: int n):<> void
// end of [myintvec0_free]

fun{a:t@ype}
myintvec_free
  {n:int} (iv: myintvec (a, n), n: int n):<> void
// end of [myintvec_free]

fun{a:t@ype}
fprint_myintvec {n:int}
  (out: FILEref, iv: !myintvec(a, n), n: int n): void
// end of [fprint_myintvec]
fun{a:t@ype}
print_myintvec {n:int} (iv: !myintvec(a, n), n: int n): void

(* ****** ****** *)

viewtypedef
myintveclst (a:t@ype, n:int) = List_vt (myintvec (a, n))

fun{a:t@ype}
myintveclst_free
  {n:int} (ivs: myintveclst (a, n), n: int n):<> void
// end of [myintveclst_free]

fun{a:t@ype}
fprint_myintveclst {n:int}
  (out: FILEref, ivs: !myintveclst (a, n), n: int n): void
// end of [fprint_myintveclst]
fun{a:t@ype}
print_myintveclst
  {n:int} (ivs: !myintveclst (a, n), n: int n): void
// end of [print_myintveclst]

(* ****** ****** *)

dataviewtype
icnstr (a:t@ype, int) =
  | {n:int}
    // knd: gte/lt: 2/~2; eq/neq: 1/~1
    ICvec (a, n) of (int(*knd*), myintvec (a, n))
  | {n:int}
    // knd:conj/disj: 0/1
    ICveclst (a, n) of (int(*knd*), icnstrlst (a, n))
// end of [icnstr]

where icnstrlst
  (a:t@ype, n:int) = List_vt (icnstr(a, n))
// end of [icnstrlst]

(* ****** ****** *)

fun{a:t@ype}
icnstr_free {n:int} (ic: icnstr (a, n), n: int n): void
fun{a:t@ype}
icnstrlst_free {n:int} (ics: icnstrlst (a, n), n: int n): void

(* ****** ****** *)

fun{a:t@ype}
fprint_icnstr {n:int}
  (out: FILEref, ic: !icnstr(a, n), n: int n): void
fun{a:t@ype}
print_icnstr {n:int} (ic: !icnstr(a, n), n: int n): void

fun{a:t@ype}
fprint_icnstrlst
  {n:int}{s:int} (
  out: FILEref, ics: !list_vt (icnstr(a, n), s), n: int n
) : void // end of [fprint_icnstrlst]
fun{a:t@ype}
print_icnstrlst {n:int}{s:int}
  (ics: !list_vt (icnstr(a, n), s), n: int n): void

(* ****** ****** *)
(*
** ~1/0/1: CONTRADICTION/UNDECIDED/TAUTOLOGY
*)
fun{a:t@ype}
myintvec_inspect
  {n:pos} (knd: int, vec: !myintvec (a, n), n: int n): int
// end of [myintvec_inspect]

fun{a:t@ype}
myintvec_inspect_eq
  {n:pos} (vec: !myintvec (a, n), n: int n): int
// end of [myintvec_inspect_eqe]
fun{a:t@ype}
myintvec_inspect_gte
  {n:pos} (vec: !myintvec (a, n), n: int n): int
// end of [myintvec_inspect_gte]

fun{a:t@ype}
myintveclst_inspect_gte
  {n:pos} (ivs: &myintveclst (a, n), n: int n): int
// end of [myintveclst_inspect_gte]

(* ****** ****** *)
//
// HX-2012-02:
// the function computes gcd (iv[1], ..., iv[n])
// please note that iv[0] is skipped
//
fun{a:t@ype}
myintvec_cffgcd
  {n:pos} (iv: !myintvec (a, n), n: int n): myint(a)
// end of [myintvec_cffgcd]

fun{a:t@ype}
myintvec_normalize // knd=2/1:gte/eq
  {n:pos} (knd: int, vec: !myintvec (a, n), n: int n): int(*~1/0*)
// end of [myintvec_normalize]

(* ****** ****** *)
//
// HX: return a copy of [vec]
//
fun{a:t@ype}
myintvec_copy {n:int}
  (vec: !myintvec (a, n), n: int n):<> myintvec (a, n)
// end of [myintvec_copy]
//
// HX: return a copy of [cff*vec]
//
fun{a:t@ype}
myintvec_copy_cff {n:int} (
  cff: !myint(a), vec: !myintvec (a, n), n: int n
) :<> myintvec (a, n) // end of [myintvec_copy_cff]

(* ****** ****** *)
//
// vec1 := vec2
//
fun{a:t@ype}
myintvec_assign {n:int} (
  iv1: !myintvec (a, n), iv2: !myintvec (a, n), n: int n
) :<> void // end of [myintvec_assign]

(* ****** ****** *)
//
// vec1 := -vec1
//
fun{a:t@ype}
myintvec_negate {n:int}
  (vec: !myintvec (a, n), n: int n):<> void
// end of [myintvec_negate]

(* ****** ****** *)

fun{a:t@ype}
myintvec_scale {n:int}
  (cff: !myint (a), vec: !myintvec (a, n), n: int n):<> void
// end of [myintvec_scale]

(* ****** ****** *)
//
// vec1 := vec1 + vec2
//
fun{a:t@ype}
myintvec_addby {n:int} (
  vec1: !myintvec (a, n), vec2: !myintvec (a, n), n: int n
) :<> void // end of [myintvec_addby]
//
// vec1 := vec1 - vec2
//
fun{a:t@ype}
myintvec_subby {n:int} (
  vec1: !myintvec (a, n), vec2: !myintvec (a, n), n: int n
) :<> void // end of [myintvec_subby]
//
// vec1 := vec1 + cff * vec2
//
fun{a:t@ype}
myintvec_addby_cff {n:int} (
  vec1: !myintvec (a, n), cff: !myint(a), vec2: !myintvec (a, n), n: int n
) :<> void // end of [myintvec_addby_cff]

(* ****** ****** *)
//
// HX: 0/~1: unsolved constraints/contradiction reached
//
fun{a:t@ype}
icnstrlst_solve {n:pos}
  (ics: &icnstrlst (a, n), n: int n): int
// end of [icnstrlst_solve]

local
//
typedef intknd = int
//
in
fun icnstrlst_int_solve {n:pos}
  (ics: &icnstrlst (intknd, n), n: int n): int
end // end of [local]

local
//
typedef intknd = intinf
//
in
fun icnstrlst_intinf_solve {n:pos}
  (ics: &icnstrlst (intknd, n), n: int n): int
end // end of [local]

(* ****** ****** *)

(* end of [pats_lintprgm_solver.sats] *)
