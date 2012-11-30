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
// Time: December, 2012
//
(* ****** ****** *)
//
// HX: generic arrays (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-30: ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no need for staloading at run-time

(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats" // for handling integer sequences

(* ****** ****** *)

staload "libats/SATS/gfarray.sats"

(* ****** ****** *)

primplmnt
gfarray_v_split
  {a}{l}{xs}{n}{i} (pflen, pfarr) = let
//
prfun
split
  {l:addr}
  {xs:ilist}
  {n:int}
  {i:nat | i <= n} .<i>. (
  pflen: LENGTH (xs, n), pfarr: gfarray_v (a, l, xs)
) : [xs1,xs2:ilist] (
  LENGTH (xs1, i)
, APPEND (xs1, xs2, xs)
, gfarray_v (a, l, xs1)
, gfarray_v (a, l+i*sizeof(a), xs2)
) = let
in
//
sif i > 0 then let
  prval LENGTHcons (pflen) = pflen
  prval gfarray_v_cons (pf1at, pf2arr) = pfarr
  prval (pfres_len, pfres_app, pfres1, pfres2) = split {..}{..}{n-1}{i-1} (pflen, pf2arr)
in
  (LENGTHcons (pfres_len), APPENDcons (pfres_app), gfarray_v_cons (pf1at, pfres1), pfres2)
end else let
  prval INTEQ () = inteq_make {i,0} ()
in
  (LENGTHnil (), APPENDnil (), gfarray_v_nil (), pfarr)
end // end of [sif]
//
end // end of [split]
//
in
  split {l}{xs}{n}{i} (pflen, pfarr)
end // end of [gfarray_v_split]

(* ****** ****** *)

primplmnt
gfarray_v_unsplit
  {a}{l}{xs1,xs2}{n1}
  (pflen, pfarr1, pfarr2) = let
//
prfun
unsplit
  {l:addr}
  {xs1,xs2:ilist}
  {n1:int} .<xs1>. (
  pflen: LENGTH (xs1, n1)
, pfarr1: gfarray_v (a, l, xs1)
, pfarr2: gfarray_v (a, l+n1*sizeof(a), xs2)
) : [xs:ilist] (
  APPEND (xs1, xs2, xs), gfarray_v (a, l, xs)
) = let
in
//
case+ pflen of
| LENGTHcons
    (pflen) => let
    prval gfarray_v_cons (pf1at, pf2arr1) = pfarr1
    prval (pfres_app, pfres_arr) = unsplit (pflen, pf2arr1, pfarr2)
  in
    (APPENDcons (pfres_app), gfarray_v_cons (pf1at, pfres_arr))
  end // end of [LENGTHcons]
| LENGTHnil () => let
    prval gfarray_v_nil () = pfarr1
  in
    (APPENDnil (), pfarr2)
  end // end of [LENGTHnil]
//
end // end of [unsplit]
//
in
  unsplit (pflen, pfarr1, pfarr2)
end // end of [gfarray_v_unsplit]

(* ****** ****** *)

(* end of [gfarray.dats] *)
