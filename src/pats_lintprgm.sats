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
// Time: February 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LOC = "./pats_location.sats"

(* ****** ****** *)

staload "./pats_intinf.sats"

(* ****** ****** *)
//
(*
** HX: only the names are needed
*)
abstype intknd = $extype "intknd"
abstype gmpknd = $extype "gmpknd"
//
(* ****** ****** *)

absvt@ype
myint(a:t@ype) = a // [a] is a kind

(* ****** ****** *)

fun{a:t@ype}
fprint_myint (out: FILEref, x: !myint(a)): void
fun{a:t@ype} print_myint (x: !myint(a)): void
fun{a:t@ype} prerr_myint (x: !myint(a)): void

(* ****** ****** *)

fun{a:t@ype} myint_make_int (x: int):<> myint(a)
fun{a:t@ype} myint_make_intinf (x: intinf): myint(a)

fun{a:t@ype} myint_free (x: myint(a)):<> void
fun{a:t@ype} myint_copy (x: !myint(a)):<> myint(a)

(* ****** ****** *)

fun{a:t@ype}
neg_myint (x: myint(a)):<> myint(a)
fun{a:t@ype}
neg1_myint (x: !myint(a)):<> myint(a)

fun{a:t@ype}
add_myint_int (x: myint(a), i: int):<> myint(a)

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

fun{a:t@ype}
compare_myint_myint (x: !myint(a), y: !myint(a)):<> int

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
absvtype myintvec (a:t@ype, n: int) // initialized
absvtype myintvec0 (a:t@ype, n: int) // uninitialized
absvtype myintvecout (a:t@ype, n: int, l:addr) // SHELL

praxi lemma_myintvec_params
  {a:t@ype}{n:int} (iv: !myintvec (a, n)): [n>=0] void
// end of [lemma_myintvec_params]

(* ****** ****** *)

fun{a:t@ype}
fprint_myintvec {n:int}
  (out: FILEref, iv: !myintvec(a, n), n: int n): void
// end of [fprint_myintvec]
fun{a:t@ype}
print_myintvec {n:int} (iv: !myintvec(a, n), n: int n): void

(* ****** ****** *)

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
prfun
myintvecout0_addback
  {a:t@ype}{n:int}{l:addr} (
  pf: array_v (myint(a)?, n, l)
| iv: !myintvecout (a, n, l) >> myintvec0 (a, n)
) : void // end of [myintvecout0_addback]

(* ****** ****** *)

fun{a:t@ype}
myintvec_get_at
  {n:int} (iv: !myintvec (a, n), i: natLt n):<> myint(a)
overload [] with myintvec_get_at
fun{a:t@ype}
myintvec_set_at
  {n:int} (iv: !myintvec (a, n), i: natLt n, x: myint(a)):<> void
overload [] with myintvec_set_at

fun{a:t@ype}
myintvec_add_int
  {n:int | n > 0} (iv: !myintvec (a, n), i:int): void
// end of [myintvec_add_int]

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
myintvec_make
  {n:nat} (n: int n):<> myintvec (a, n) // initialized with zeros
// end of [myintvec_make]
fun{a:t@ype}
myintvec_free
  {n:int} (iv: myintvec (a, n), n: int n):<> void
// end of [myintvec_free]

(* ****** ****** *)

viewtypedef
myintveclst (a:t@ype, n:int) = List_vt (myintvec (a, n))

fun{a:t@ype}
fprint_myintveclst {n:int}
  (out: FILEref, ivs: !myintveclst (a, n), n: int n): void
// end of [fprint_myintveclst]
fun{a:t@ype}
print_myintveclst
  {n:int} (ivs: !myintveclst (a, n), n: int n): void
// end of [print_myintveclst]

fun{a:t@ype}
myintveclst_free
  {n:int} (ivs: myintveclst (a, n), n: int n):<> void
// end of [myintveclst_free]

(* ****** ****** *)
//
// HX: it is mapped
abstype s3exp // to [s3exp] in pats_constraint3
typedef nat2 = natLt (2)
typedef int2 = intBtwe (~2, 2)

dataviewtype
icnstr (a:t@ype, int) =
  | {n:int}
    // knd: gte/lt: 2/~2; eq/neq: 1/~1
    ICvec (a, n) of (int2(*knd*), myintvec (a, n))
  | {n:int}
    // knd:conj/disj: 0/1
    ICveclst (a, n) of (nat2(*knd*), icnstrlst (a, n))
  | {n:int} ICerr (a, n) of ($LOC.location, s3exp)
// end of [icnstr]

where icnstrlst
  (a:t@ype, n:int) = List_vt (icnstr(a, n))
// end of [icnstrlst]

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

fun{a:t@ype}
icnstr_copy {n:int}
  (ic: !icnstr (a, n), n: int n): icnstr (a, n)
// end of [icnstr_copy]
fun{a:t@ype}
icnstrlst_copy {n:int}{s:int}
  (ics: !list_vt (icnstr (a, n), s), n: int n): icnstrlst (a, n)
// end of [icnstrlst_copy]

fun{a:t@ype}
icnstr_negate {n:int}
  (ic: icnstr (a, n)): icnstr (a, n)
// end of [icnstr_negate]
fun{a:t@ype}
icnstrlst_negate {n:int}
  (ics: icnstrlst (a, n)): icnstrlst (a, n)
// end of [icnstrlst_negate]

(* ****** ****** *)

fun{a:t@ype}
icnstr_free {n:int} (ic: icnstr (a, n), n: int n): void
fun{a:t@ype}
icnstrlst_free {n:int} (ics: icnstrlst (a, n), n: int n): void

(* ****** ****** *)

typedef Ans2 = [i:int | ~1 <= i; i <= 0] int (i)
typedef Ans3 = [i:int | ~1 <= i; i <= 1] int (i)

(* ****** ****** *)

(*
** ~1/0/1: CONTRADICTION/UNDECIDED/TAUTOLOGY
*)
fun{a:t@ype}
myintvec_inspect
  {n:pos} (
  knd: int, vec: !myintvec (a, n), n: int n
) : Ans3 // end of [myintvec_inspect]

fun{a:t@ype}
myintvec_inspect_lt
  {n:pos} (vec: !myintvec (a, n), n: int n): Ans3
// end of [myintvec_inspect_lt]
fun{a:t@ype}
myintvec_inspect_gte
  {n:pos} (vec: !myintvec (a, n), n: int n): Ans3
// end of [myintvec_inspect_gte]
fun{a:t@ype}
myintvec_inspect_eq
  {n:pos} (vec: !myintvec (a, n), n: int n): Ans3
// end of [myintvec_inspect_eq]
fun{a:t@ype}
myintvec_inspect_neq
  {n:pos} (vec: !myintvec (a, n), n: int n): Ans3
// end of [myintvec_inspect_neq]

fun{a:t@ype}
myintveclst_inspect_gte
  {n:pos} (ivs: &myintveclst (a, n), n: int n): Ans2
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
myintvec_normalize_gte
  {n:pos} (vec: !myintvec (a, n), n: int n): void
// end of [myintvec_normalize_gte]

fun{a:t@ype}
myintveclst_normalize_gte
  {n:pos} (ivs: &myintveclst (a, n), n: int n): void
// end of [myintveclst_normalize_gte]

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

typedef
index (n:int) = intBtw (1, n)
abstype indexset (n:int)

fun indexset_nil {n:int} ():<> indexset (n)
fun indexset_is_member
  {n:int} (xs: indexset n, x: index n):<> bool
fun indexset_add
  {n:pos} (xs: indexset n, x: index n):<> indexset n
// end of [indexset_add]

(*
//
// HX: 0/~1: unsolved constraints/contradiction reached
//
*)
fun{a:t@ype}
icnstrlst_solve {n:pos} (
  iset(*hint*): indexset (n), ics: &icnstrlst (a, n), n: int n
) : Ans2 // end of [icnstrlst_solve]

(* ****** ****** *)

(* end of [pats_lintprgm.sats] *)
