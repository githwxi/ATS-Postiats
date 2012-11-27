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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
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

#define ATS_STALOADFLAG 0 // no need for staloading at run-time

(* ****** ****** *)

datasort ilist =
  | ilist_nil of () | ilist_cons of (int, ilist)
// end of [ilist]

(* ****** ****** *)

stadef ilist_sing (x:int): ilist = ilist_cons (x, ilist_nil)

(* ****** ****** *)

dataprop
ilisteq (
  ilist, ilist
) =
  | ilisteq_nil (
      ilist_nil, ilist_nil
    ) of ()
  | {x:int} {xs1,xs2:ilist}
    ilisteq_cons (
      ilist_cons (x, xs1), ilist_cons (x, xs2)
    ) of (
      ilisteq (xs1, xs2)
    ) // end of [ilisteq_cons]
// end of [ilisteq]

(* ****** ****** *)

dataprop ILISTEQ
  (ilist, ilist) = {xs:ilist} ILISTEQ (xs, xs) of ()
// end of [ILISTEQ]

prfun ilisteq_elim
  {xs1,xs2:ilist} (pf: ilisteq (xs1, xs2)): ILISTEQ (xs1, xs2)
// end of [ilisteq_elim]

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
  | LENGTHnil (ilist_nil, 0) of ()
  | {x:int} {xs:ilist} {n:nat}
    LENGTHcons (ilist_cons (x, xs), n+1) of LENGTH (xs, n)
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

prfun snoc_istot {xs:ilist} {x:int} (): [xsx:ilist] SNOC (xs, x, xsx)
prfun snoc_isfun {xs:ilist} {x:int}
  {xsx1,xsx2:ilist} (pf1: SNOC (xs, x, xsx1), pf2: SNOC (xs, x, xsx2)): ILISTEQ (xsx1, xsx2)
// end of [snoc_isfun]

prfun lemma_snoc_length
  {xs:ilist} {x:int} {xsx:ilist} {n:nat}
  (pf1: SNOC (xs, x, xsx), pf2: LENGTH (xs, n)): LENGTH (xsx, n+1)
// end of [lemma_snoc_length]

(* ****** ****** *)

dataprop
APPEND (ilist, ilist, ilist) =
  | {ys:ilist} APPENDnil (ilist_nil, ys, ys) of ()
  | {x:int} {xs:ilist} {ys:ilist} {zs:ilist}
    APPENDcons (ilist_cons (x, xs), ys, ilist_cons (x, zs)) of APPEND (xs, ys, zs)
// end of [APPEND]

prfun append_istot
  {xs,ys:ilist} (): [zs:ilist] APPEND (xs, ys, zs)
prfun append_isfun {xs,ys:ilist} {zs1,zs2:ilist}
  (pf1: APPEND (xs, ys, zs1), pf2: APPEND (xs, ys, zs2)): ILISTEQ (zs1, zs2)
// end of [append_isfun]

(* ****** ****** *)

prfun append_unit1
  {xs:ilist} (): APPEND (ilist_nil, xs, xs)
prfun append_unit2
  {xs:ilist} (): APPEND (xs, ilist_nil, xs)

prfun append_sing
  {x:int}{xs:ilist}
  (): APPEND (ilist_sing(x), xs, ilist_cons (x, xs))
// end of [append_sing]

(* ****** ****** *)

prfun
lemma_append_length
  {xs1,xs2:ilist}
  {xs:ilist}
  {n1,n2:int} (
  pf: APPEND (xs1, xs2, xs), pf1len: LENGTH (xs1, n1), pf2len: LENGTH (xs2, n2)
) : LENGTH (xs, n1+n2) // end of [lemma_append_length]

prfun
lemma_append_snoc
  {xs1:ilist}
  {x:int}
  {xs2:ilist}
  {xs1x:ilist}
  {xs:ilist} (
  pf1: APPEND (xs1, ilist_cons (x, xs2), xs)
, pf2: SNOC (xs1, x, xs1x)
) : APPEND (xs1x, xs2, xs) // end of [lemma_append_snoc]

(* ****** ****** *)

dataprop
REVAPP (ilist, ilist, ilist) =
  | {ys:ilist} REVAPPnil (ilist_nil, ys, ys) of ()
  | {x:int} {xs:ilist} {ys:ilist} {zs:ilist}
    REVAPPcons (ilist_cons (x, xs), ys, zs) of REVAPP (xs, ilist_cons (x, ys), zs)
// end of [REVAPP]

(* ****** ****** *)

dataprop
NTH (x0:int, ilist, int) =
  | {xs:ilist} NTHbas (x0, ilist_cons (x0, xs), 0)
  | {x:int} {xs:ilist} {n:nat}
    NTHind (x0, ilist_cons (x, xs), n+1) of NTH (x0, xs, n)
// end of [NTH]
//
// HX: reverse NTH
//
dataprop
RNTH (x0:int, ilist, int) =
  | {xs:ilist} {n:nat}
    RNTHbas (x0, ilist_cons (x0, xs), n) of LENGTH (xs, n)
  | {x:int} {xs:ilist} {n:nat}
    RNTHind (x0, ilist_cons (x, xs), n) of RNTH (x0, xs, n)
// end of [RNTH]

(* ****** ****** *)

prfun lemma_nth_rnth
  {x:int} {xs:ilist}
  {n:int} {i:nat | i < n}
  (pf1: NTH (x, xs, i), pf2: LENGTH (xs, n)): RNTH (x, xs, n-1-i)
// end of [lemma_nth_rnth]

prfun lemma_rnth_nth
  {x:int} {xs:ilist}
  {n:int} {i:nat | i < n}
  (pf1: RNTH (x, xs, i), pf2: LENGTH (xs, n)): NTH (x, xs, n-1-i)
// end of [lemma_rnth_nth]

(* ****** ****** *)

dataprop
INSERT (
  x0:int, ilist, int, ilist
) = // INSERT (x0, xs, i, ys): insert x0 in xs at i = ys
  | {xs:ilist}
    INSERTbas (
      x0, xs, 0, ilist_cons (x0, xs)
    ) of () // end of [INSERTbas]
  | {x:int} {xs:ilist} {i:nat} {ys:ilist}
    INSERTind (
      x0, ilist_cons (x, xs), i+1, ilist_cons (x, ys)
    ) of INSERT (x0, xs, i, ys) // end of [INSERTind]
// end of [INSERT]

prfun lemma_insert_length
  {x0:int} {xs:ilist} {i:int} {ys:ilist} {n:nat}
  (pf1: INSERT (x0, xs, i, ys), pf2: LENGTH (xs, n)): LENGTH (ys, n+1)
// end of [lemma_insert_length]

prfun lemma_nth_insert
  {x:int} {xs:ilist} {n:nat}
  (pf: NTH (x, xs, n)): [ys:ilist] INSERT (x, ys, n, xs)
// end of [lemma_nth_insert]

(* ****** ****** *)

(* end of [ilist_prf.sats] *)
