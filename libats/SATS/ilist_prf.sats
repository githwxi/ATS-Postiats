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
// Authoremail: hwxiATcsDOTbuDOTedu
// Time: October, 2010
//
(* ****** ****** *)
//
// HX: reasoning about integer sequences
//
(* ****** ****** *)
//
// HX-2012-11-26: ported to ATS/Postiats
//
(* ****** ****** *)

datasort ilist =
  | ilist_nil of () | ilist_cons of (int, ilist)
// end of [ilist]

(* ****** ****** *)

stadef ilist_sing (x:int) = ilist_cons (x, ilist_nil)

(* ****** ****** *)

dataprop ILISTEQ
  (ilist, ilist) = {xs:ilist} ILISTEQ (xs, xs) of ()
// end of [ILISTEQ]

(* ****** ****** *)
//
prfun
ILISTEQ_refl{xs:ilist}(): ILISTEQ(xs, xs)
//
prfun
ILISTEQ_symm
  {xs,ys:ilist}(ILISTEQ(xs, ys)): ILISTEQ(ys, xs)
//
prfun
ILISTEQ_tran
  {xs,ys,zs:ilist}
  (ILISTEQ(xs, ys), ILISTEQ(ys, zs)): ILISTEQ(xs, zs)
//
(* ****** ****** *)

dataprop
ILISTEQ2 (
  ilist, ilist
) =
  | ILISTEQ2nil
    (
      ilist_nil, ilist_nil
    ) of ((*void*))
  | {x:int}
    {xs1,xs2:ilist}
    ILISTEQ2cons
    (
      ilist_cons (x, xs1)
    , ilist_cons (x, xs2)
    ) of (
      ILISTEQ2 (xs1, xs2)
    ) // end of [ILISTEQ2cons]
// end of [ILISTEQ2]

(* ****** ****** *)

prfun
ILISTEQ2_elim
  {xs1,xs2:ilist}
  (pf: ILISTEQ2(xs1, xs2)): ILISTEQ (xs1, xs2)
// end of [ILISTEQ2_elim]

(* ****** ****** *)

dataprop
ISCONS (ilist) =
  {x:int}{xs:ilist} ISCONS (ilist_cons (x, xs))
// end of [ISCONS]

dataprop
ISEMP (ilist, bool) =
  | ISEMPnil (ilist_nil, true)
  | {x:int} {xs:ilist} ISEMPcons (ilist_cons (x, xs), false)
// end of [ISEMP]

(* ****** ****** *)

dataprop
LENGTH (ilist, int) =
  | LENGTHnil(ilist_nil, 0) of ()
  | {x:int}{xs:ilist}{n:nat}
    LENGTHcons(ilist_cons (x, xs), n+1) of LENGTH (xs, n)
// end of [LENGTH]

prfun length_istot {xs:ilist} (): [n:nat] LENGTH (xs, n)
prfun length_isfun {xs:ilist} {n1,n2:int}
  (pf1: LENGTH (xs, n1), pf2: LENGTH (xs, n2)): [n1==n2] void
// end of [length_isfun]

prfun length_isnat
  {xs:ilist} {n:int} (pf: LENGTH (xs, n)): [n>=0] void
// end of [length_isnat]

(* ****** ****** *)

dataprop
SNOC (ilist, int, ilist) =
  | {x:int} SNOCnil (ilist_nil, x, ilist_sing (x)) of ()
  | {x0:int} {xs1:ilist} {x:int} {xs2:ilist}
    SNOCcons (ilist_cons (x0, xs1), x, ilist_cons (x0, xs2)) of SNOC (xs1, x, xs2)
// end of [SNOC]

(* ****** ****** *)

prfun
snoc_istot{xs:ilist}{x:int} (): [xsx:ilist] SNOC (xs, x, xsx)
prfun
snoc_isfun{xs:ilist}{x:int}
  {xsx1,xsx2:ilist} (pf1: SNOC (xs, x, xsx1), pf2: SNOC (xs, x, xsx2)): ILISTEQ (xsx1, xsx2)
// end of [snoc_isfun]

(*
// HX-2012-12-13: proven
*)
prfun
lemma_snoc_length
  {xs:ilist}{x:int}{xsx:ilist}{n:int}
  (pf1: SNOC (xs, x, xsx), pf2: LENGTH (xs, n)): LENGTH (xsx, n+1)
// end of [lemma_snoc_length]

(* ****** ****** *)

dataprop
APPEND (ilist, ilist, ilist) =
  | {ys:ilist} APPENDnil (ilist_nil, ys, ys) of ()
  | {x:int} {xs:ilist} {ys:ilist} {zs:ilist}
    APPENDcons (ilist_cons (x, xs), ys, ilist_cons (x, zs)) of APPEND (xs, ys, zs)
// end of [APPEND]

(* ****** ****** *)
//
prfun
append_istot
  {xs,ys:ilist}(): [zs:ilist] APPEND(xs, ys, zs)
prfun
append_isfun
  {xs,ys:ilist}{zs1,zs2:ilist}
  (pf1: APPEND(xs, ys, zs1), pf2: APPEND(xs, ys, zs2)): ILISTEQ(zs1, zs2)
//
(* ****** ****** *)
(*
// HX-2012-12-13: proven
*)
prfun
append_unit_left
  {xs:ilist}(): APPEND (ilist_nil, xs, xs)
prfun
append_unit_right
  {xs:ilist}(): APPEND (xs, ilist_nil, xs)

(* ****** ****** *)

(*
// HX-2012-12-17: proven
*)
prfun
append_sing
{x:int}{xs:ilist}
(
// argumentless
) : APPEND (ilist_sing(x), xs, ilist_cons (x, xs))
// end of [append_sing]

(* ****** ****** *)

(*
// HX-2012-12-13: proven
*)
prfun
lemma_append_length
  {xs1,xs2:ilist}
  {xs:ilist}
  {n1,n2:int} (
  pf: APPEND (xs1, xs2, xs)
, pf1len: LENGTH (xs1, n1), pf2len: LENGTH (xs2, n2)
) : LENGTH (xs, n1+n2) // end of [lemma_append_length]

(* ****** ****** *)

(*
// HX-2012-12-13: proven
*)
prfun
lemma_append_snoc
  {xs1:ilist}
  {x:int}
  {xs2:ilist}
  {xs1x:ilist}
  {res:ilist}
(
  pf1: APPEND(xs1, ilist_cons(x, xs2), res), pf2: SNOC (xs1, x, xs1x)
) : APPEND (xs1x, xs2, res) // end-of-prfun

(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma_append_assoc
  {xs1,xs2,xs3:ilist}
  {xs12,xs23:ilist}
  {xs12_3,xs1_23:ilist}
(
  pf12: APPEND (xs1, xs2, xs12), pf23: APPEND (xs2, xs3, xs23)
, pf12_3: APPEND (xs12, xs3, xs12_3), pf1_23: APPEND (xs1, xs23, xs1_23)
) : ILISTEQ (xs12_3, xs1_23) // end of [lemma_append_assoc]

(* ****** ****** *)

dataprop
REVAPP(ilist, ilist, ilist) =
  | {ys:ilist}
    REVAPPnil (ilist_nil, ys, ys) of ()
  | {x:int}{xs:ilist}{ys:ilist}{zs:ilist}
    REVAPPcons (ilist_cons (x, xs), ys, zs) of REVAPP (xs, ilist_cons (x, ys), zs)
// end of [REVAPP]

propdef REVERSE (xs: ilist, ys: ilist) = REVAPP (xs, ilist_nil, ys)

(* ****** ****** *)
//
prfun
revapp_istot
  {xs,ys:ilist} (): [zs:ilist] REVAPP (xs, ys, zs)
//
prfun
revapp_isfun
  {xs,ys:ilist}{zs1,zs2:ilist}
  (pf1: REVAPP (xs, ys, zs1), pf2: REVAPP (xs, ys, zs2)): ILISTEQ (zs1, zs2)
//
(* ****** ****** *)

prfun
lemma_revapp_length
  {xs,ys,zs:ilist}{m,n:int} (
  pf: REVAPP (xs, ys, zs), pf1len: LENGTH (xs, m), pf2len: LENGTH (ys, n)
) : LENGTH (zs, m+n) // end of [lemma_revapp_length]

(* ****** ****** *)
//
prfun
reverse_istot
  {xs:ilist}(): [ys:ilist] REVERSE(xs, ys)
//
prfun
reverse_isfun
  {xs:ilist}{ys1,ys2:ilist}
  (REVERSE(xs, ys1), REVERSE(xs, ys2)): ILISTEQ(ys1, ys2)
//
(* ****** ****** *)
//
prfun
lemma_reverse_length
  {xs,ys:ilist}{n:int}(REVERSE(xs, ys), LENGTH(xs, n)): LENGTH(ys, n)
//
(* ****** ****** *)

dataprop
NTH (x0:int, ilist, int) =
  | {xs:ilist}
    NTHbas (x0, ilist_cons (x0, xs), 0)
  | {x1:int}{xs:ilist}{n:nat}
    NTHind (x0, ilist_cons (x1, xs), n+1) of NTH (x0, xs, n)
// end of [NTH]
//
// HX: reverse NTH
//
dataprop
RNTH (x0:int, ilist, int) =
  | {xs:ilist}{n:nat}
    RNTHbas (x0, ilist_cons (x0, xs), n) of LENGTH (xs, n)
  | {x1:int}{xs:ilist}{n:nat}
    RNTHind (x0, ilist_cons (x1, xs), n) of RNTH (x0, xs, n)
// end of [RNTH]

(* ****** ****** *)

prfun
lemma_nth_param
  {x0:int}
  {xs:ilist}{i:int}
(
  pf: NTH(x0, xs, i)
) : [y:int;ys:ilist | i >= 0] ILISTEQ(xs, ilist_cons(y, ys))

prfun
lemma_rnth_param
  {x0:int}
  {xs:ilist}{i:int}
(
  pf: RNTH(x0, xs, i)
) : [y:int;ys:ilist | i >= 0] ILISTEQ(xs, ilist_cons(y, ys))

(* ****** ****** *)

prfun
lemma_nth_rnth
  {x:int}{xs:ilist}
  {n:int}{i:int | i < n}
  (pf1: NTH (x, xs, i), pf2: LENGTH (xs, n)): RNTH (x, xs, n-1-i)
// end of [lemma_nth_rnth]

prfun
lemma_rnth_nth
  {x:int}{xs:ilist}
  {n:int}{i:int | i < n}
  (pf1: RNTH (x, xs, i), pf2: LENGTH (xs, n)): NTH (x, xs, n-1-i)
// end of [lemma_rnth_nth]

(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma_nth_ilisteq
  {xs1,xs2:ilist}{n:int}
(
  pf1len: LENGTH (xs1, n), pf2len: LENGTH (xs2, n)
, fpf: {x:int}{i:int | i < n} NTH (x, xs1, i) -> NTH (x, xs2, i)
) : ILISTEQ (xs1, xs2) // end of [lemma_nth_ilisteq]

(* ****** ****** *)
//
(*
// HX-2015-08-24: proven
*)
//
prfun
lemma_length_nth
  {xs:ilist}
  {n:int}{i:nat | i < n}
  (pflen: LENGTH(xs, n)): [x:int] NTH(x, xs, i)
//
(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma1_revapp_nth
  {xs,ys,zs:ilist}
  {n:int}{x:int}{i:int} (
  REVAPP (xs, ys, zs), LENGTH (xs, n), NTH (x, ys, i)
) : NTH (x, zs, n+i) // end of [lemma1_revapp_nth]

(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma2_revapp_nth
  {xs,ys,zs:ilist}
  {n:int}{x:int}{i:int} (
  REVAPP (xs, ys, zs), LENGTH (xs, n), NTH (x, xs, i)
) : NTH (x, zs, n-1-i) // end of [lemma2_revapp_nth]

(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma_reverse_nth
  {xs,ys:ilist}
  {n:int}{x:int}{i:int}
(
  pf: REVERSE(xs, ys), pf2: LENGTH(xs, n), pf3: NTH(x, xs, i)
) : NTH (x, ys, n-1-i) // end of [lemma_reverse_nth]
    
(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma_reverse_symm{xs,ys:ilist}(REVERSE(xs, ys)): REVERSE(ys, xs)
// end of [lemma_reverse_symm]

(* ****** ****** *)

dataprop
INSERT (
  xi:int, ilist, int, ilist
) = // INSERT (xi, xs, i, ys): insert xi in xs at i = ys
  | {xs:ilist}
    INSERTbas (
      xi, xs, 0, ilist_cons (xi, xs)
    ) of () // end of [INSERTbas]
  | {x:int}{xs:ilist}{i:nat}{ys:ilist}
    INSERTind (
      xi, ilist_cons (x, xs), i+1, ilist_cons (x, ys)
    ) of INSERT (xi, xs, i, ys) // end of [INSERTind]
// end of [INSERT]

(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun lemma_insert_length
  {xi:int}{xs:ilist}{i:int}{ys:ilist}{n:int}
  (pf1: INSERT (xi, xs, i, ys), pf2: LENGTH (xs, n)): LENGTH (ys, n+1)
// end of [lemma_insert_length]

(* ****** ****** *)

(*
// HX-2012-12-14: proven
*)
prfun
lemma_insert_nth_at
  {xi:int}{xs:ilist}{i:int}{ys:ilist}
  (pf: INSERT (xi, xs, i, ys)): NTH (xi, ys, i)
// end of [lemma_insert_nth_eq]

(*
// HX-2012-12-14: proven
*)
prfun
lemma_insert_nth_lt
  {xi:int}{xs:ilist}{i:int}{ys:ilist}{x:int}{j:int | j < i}
  (pf1: INSERT (xi, xs, i, ys), pf2: NTH (x, xs, j)): NTH (x, ys, j)
// end of [lemma_insert_nth_lt]

(*
// HX-2012-12-14: proven
*)
prfun
lemma_insert_nth_gte
  {xi:int}{xs:ilist}{i:int}{ys:ilist}{x:int}{j:int | j >= i}
  (pf1: INSERT (xi, xs, i, ys), pf2: NTH (x, xs, j)): NTH (x, ys, j+1)
// end of [lemma_insert_nth_lt]

(* ****** ****** *)
(*
// HX-2012-12-14: proven
*)
prfun
lemma_nth_insert
  {x:int}{xs:ilist}{n:int}
  (pf: NTH (x, xs, n)): [ys:ilist] INSERT (x, ys, n, xs)
// end of [lemma_nth_insert]

(* ****** ****** *)
//
// UPDATE (
//   yi, xs, i, ys
// ): ys[i]=yi; xs[k]=ys[k] if k != i
//
dataprop
UPDATE (
  yi: int, ilist, int, ilist
) = // UPDATE
  | {x0:int}{xs:ilist}
    UPDATEbas (
      yi, ilist_cons (x0, xs), 0, ilist_cons (yi, xs)
    ) of () // end of [UPDATEbas]
  | {x:int}{xs:ilist}{i:nat}{ys:ilist}
    UPDATEind (
      yi, ilist_cons (x, xs), i+1, ilist_cons (x, ys)
    ) of UPDATE (yi, xs, i, ys) // end of [UPDATEind]
// end of [UPDATE]

(* ****** ****** *)
//
// INTERCHANGE (xs, i, j, ys) means:
// ys[i]=xs[j]; ys[j]=xs[i]; ys[k]=xs[k] for k != i or j
//
absprop
INTERCHANGE
(
  xs:ilist, i:int, j:int, ys:ilist
) (* INTERCHANGE *)

(* ****** ****** *)

prfun
lemma_interchange_inv
  {xs:ilist}{i,j:int}{ys:ilist}
  (pf: INTERCHANGE (xs, i, j, ys)): INTERCHANGE (xs, j, i, ys)
// end of [lemma_interchange_inv]

prfun
lemma_interchange_symm
  {xs:ilist}{i,j:int}{ys:ilist}
  (pf: INTERCHANGE (xs, i, j, ys)): INTERCHANGE (ys, i, j, xs)
// end of [lemma_interchange_symm]

(* ****** ****** *)
//
// PERMUTE (xs, ys):
// [ys] is a permutation of [xs]
//
absprop
PERMUTE
(
  xs1:ilist, xs2:ilist
) (* PERMUTE *)
//
prfun
permute_refl {xs:ilist} (): PERMUTE (xs, xs)
prfun
permute_symm
  {xs1,xs2:ilist} (pf: PERMUTE (xs1, xs2)): PERMUTE (xs2, xs1)
prfun
permute_trans {xs1,xs2,xs3:ilist}
  (pf1: PERMUTE (xs1, xs2), pf2: PERMUTE (xs2, xs3)): PERMUTE (xs1, xs3)
//
(* ****** ****** *)

prfun
lemma_permute_length
  {xs1,xs2:ilist}{n:int}
  (pf1: PERMUTE (xs1, xs2), pf2: LENGTH (xs1, n)): LENGTH (xs2, n)
// end of [lemma_permute_length]

(* ****** ****** *)

prfun
lemma_permute_insert
  {x:int} {xs:ilist} {ys:ilist}
  (pf: PERMUTE (ilist_cons (x, xs), ys)): [ys1:ilist;i:nat] INSERT (x, ys1, i, ys)
// end of [lemma_permute_insert]

(* ****** ****** *)

prfun
lemma_interchange_permute
  {xs:ilist}{i,j:int}{ys:ilist}
  (pf: INTERCHANGE (xs, i, j, ys)): PERMUTE (xs, ys)
// end of [lemma_interchange_permute]

(* ****** ****** *)
//
absprop LTB
  (x: int, xs: ilist) // [x] is a strict lower bound for [xs]
// end of [LTB]
//
prfun
ltb_istot {xs:ilist} (): [x:int] LTB(x, xs)
//
prfun ltb_nil {x:int} (): LTB(x, ilist_nil)
//
prfun
ltb_cons
  {x0:int}
  {x:int | x0 < x}
  {xs:ilist}
  (pf: LTB(x0, xs)): LTB(x0, ilist_cons(x, xs))
// end of [ltb_cons]
//
prfun
ltb_cons_elim
  {x0:int}
  {x:int}
  {xs:ilist}
  (pf: LTB(x0, ilist_cons(x, xs))): [x0 < x] LTB(x0, xs)
// end of [ltb_cons_elim]
//
prfun ltb_dec
  {x1:int}{x2:int | x2 <= x1}{xs:ilist} (pf: LTB(x1, xs)): LTB(x2, xs)
// end of [ltb_dec]
//
(* ****** ****** *)
//
absprop LTEB
  (x: int, xs: ilist) // [x] is a lower bound for [xs]
// end of [LTEB]
//
prfun
lteb_istot {xs:ilist} (): [x:int] LTEB(x, xs)
//
prfun lteb_nil {x:int} (): LTEB(x, ilist_nil)
//
prfun lteb_cons
  {x0:int}
  {x:int | x0 <= x}
  {xs:ilist}
  (pf: LTEB(x0, xs)): LTEB(x0, ilist_cons(x, xs))
// end of [lteb_cons]
//
prfun
lteb_cons_elim
  {x0:int}
  {x:int}
  {xs:ilist}
  (pf: LTEB(x0, ilist_cons(x, xs))): [x0 <= x] LTEB(x0, xs)
// end of [lteb_cons_elim]
//
prfun lteb_dec
  {x1:int}{x2:int | x2 <= x1}{xs:ilist}(pf: LTEB(x1, xs)): LTEB(x2, xs)
// end of [lteb_dec]
//
(* ****** ****** *)

dataprop
ISORD (ilist) =
  | ISORDnil(ilist_nil) of ()
  | {x:int} {xs:ilist}
    ISORDcons(ilist_cons(x, xs)) of (ISORD(xs), LTEB(x, xs))
// end of [ISORD]

(* ****** ****** *)

prfun
lemma_ltb_permute{x:int}
  {xs1,xs2:ilist}
  (pf1: LTB(x, xs1), pf2: PERMUTE(xs1, xs2)): LTB(x, xs2)
// end of [lemma_ltb_permute]

prfun
lemma_lteb_permute{x:int}
  {xs1,xs2:ilist}
  (pf1: LTEB(x, xs1), pf2: PERMUTE(xs1, xs2)): LTEB(x, xs2)
// end of [lemma_lteb_permute]

(* ****** ****** *)
//
// SORT (xs, ys):
// [ys] is a sorted version of [xs]
//
absprop
SORT (xs:ilist, ys:ilist)
//
prfun
sort_elim {xs,ys:ilist}
  (pf: SORT (xs, ys)): @(ISORD ys, PERMUTE (xs, ys))
prfun
sort_make {xs,ys:ilist}
  (pf1: ISORD ys, pf2: PERMUTE (xs, ys)): SORT (xs, ys)
//
(* ****** ****** *)
//
// HX-2016-02-09:
// static functions
// for external solvers (such as Z3)
//
(* ****** ****** *)
//
stacst
ilist_head : (ilist) -> int
stacst
ilist_tail : (ilist) -> ilist
//
stacst
ilist_take : (ilist, int) -> ilist
stacst
ilist_drop : (ilist, int) -> ilist
//
(* ****** ****** *)
//
stacst
ilist_get_at : (ilist, int) -> int
stacst
ilist_set_at : (ilist, int, int) -> ilist
//
(* ****** ****** *)
//
stacst
ilist_length : (ilist) -> int
//
praxi
lemma_length_f2p
{xs:ilist}
(
// argumentless
) : LENGTH(xs, ilist_length(xs))
//
praxi
lemma_length_p2b
{xs:ilist}{n:int}
(
  pf: LENGTH(xs, n)
) : [ilist_length(xs) == n] unit_p
//
(* ****** ****** *)
//
stacst
ilist_append : (ilist, ilist) -> ilist
//
praxi
lemma_append_f2p
{xs,ys:ilist}
(
// argumentless
) : APPEND(xs,ys,ilist_append(xs, ys))
//
praxi
lemma_append_p2b
  {xs,ys,zs:ilist}
(
  pf: APPEND(xs, ys, zs)
) : [ilist_append(xs, ys) == zs] unit_p
//
(* ****** ****** *)

prfun
lemma_append_length_eq
{xs,ys:ilist}
(
// argumentless
) :
[
  ilist_length(ilist_append(xs,ys))
==
  ilist_length(xs)+ilist_length(ys)
] void // end of [lemma_append_length_eq]

(* ****** ****** *)
//
stacst
ilist_revapp : (ilist, ilist) -> ilist
//
stacst ilist_reverse : (ilist) -> ilist
//
(* ****** ****** *)
//
prfun
lemma_revapp_append_eq
{xs,ys:ilist}
(
// argumentless
) :
ILISTEQ
(
  ilist_revapp(xs, ys)
, ilist_append(ilist_reverse(xs), ys)
) (* ILISTEQ *) // lemma_revapp_append_eq
//
prfun
lemma_reverse_reverse_eq
{xs:ilist}
(
// argumentless
) : ILISTEQ(xs, ilist_reverse(ilist_reverse(xs)))
//
(* ****** ****** *)
//
stacst
ilist_snoc : (ilist, int) -> ilist
//
(* ****** ****** *)
//
stacst
ilist_isord : (ilist) -> bool
//
stacst ilist_sort : (ilist) -> ilist
//
(* ****** ****** *)

(* end of [ilist_prf.sats] *)
