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
//
// HX:
// for integer sequences
//
staload
"libats/SATS/ilist_prf.sats"
//
(* ****** ****** *)

staload "libats/SATS/gfarray.sats"

(* ****** ****** *)

primplmnt
gfarray_v_sing (pfat) = gfarray_v_cons (pfat, gfarray_v_nil ())

primplmnt
gfarray_v_unsing (pfarr) = let
  prval gfarray_v_cons (pfat, gfarray_v_nil ()) = pfarr in pfat
end // end of [gfarray_v_unsing]

(* ****** ****** *)

(*
prfun
gfarray_v_split
  {a:vt0p}
  {l:addr}
  {xs:ilist}
  {n:int}
  {i:nat | i <= n} (
  pflen: LENGTH (xs, n)
, pfarr: gfarray_v (a, l, xs)
) : [
  xs1,xs2:ilist
] (
  LENGTH (xs1, i)
, APPEND (xs1, xs2, xs)
, gfarray_v (a, l, xs1)
, gfarray_v (a, l+i*sizeof(a), xs2)
) // end of [gfarray_v_split]
*)
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
  prval EQINT () = eqint_make {i,0} ()
in
  (LENGTHnil (), APPENDnil (), gfarray_v_nil (), pfarr)
end // end of [sif]
//
end // end of [split]
//
val [
  xs1:ilist,xs2:ilist
] (
  pf1len, pfapp, pf1arr, pf2arr
) = split {l}{xs}{n}{i} (pflen, pfarr)
prval pf2len = length_istot {xs2} ()
prval pflen2 = lemma_append_length (pfapp, pf1len, pf2len)
prval () = length_isfun (pflen, pflen2)
//
in
  (pf1len, pf2len, pfapp, pf1arr, pf2arr)
end // end of [gfarray_v_split]

(* ****** ****** *)

(*
prfun
gfarray_v_unsplit
  {a:vt0p}
  {l:addr}
  {xs1,xs2:ilist}
  {n1:int} (
  pflen: LENGTH (xs1, n1)
, pfarr1: gfarray_v (a, l, xs1)
, pfarr2: gfarray_v (a, l+n1*sizeof(a), xs2)
) : [xs:ilist] (
  APPEND (xs1, xs2, xs), gfarray_v (a, l, xs)
) // end of [gfarray_v_unsplit]
*)
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

(*
prfun
gfarray_v_extend
  {a:vt0p}
  {l:addr}
  {xs:ilist}{x:int}{xsx:ilist}
  {n:nat} (
  pflen: LENGTH (xs, n)
, pfsnoc: SNOC (xs, x, xsx)
, pfat: stamped_vt (a, x) @ l+n*sizeof(a)
, pfarr: gfarray_v (a, l, xs)
) : gfarray_v (a, l, xsx)
// end of [gfarray_v_extend]
*)
primplmnt
gfarray_v_extend
  {a}{l}{xs}{x}{xsx}{n} (
  pflen, pfsnoc, pfat, pfarr
) = let
//
stadef xs1 = xs
stadef xs2 = ilist_sing (x)
//
prval pfapp =
  lemma (pfsnoc) where {
  extern praxi lemma : SNOC (xs, x, xsx) -<prf> APPEND (xs1, xs2, xsx)
} // end of [prval]
//
prval pf1arr = pfarr
prval pf2arr = gfarray_v_sing (pfat)
//
prval (pfapp2, pfarr) =
  gfarray_v_unsplit {a}{l}{xs1,xs2}{n} (pflen, pf1arr, pf2arr)
// end of [prval]
//
prval ILISTEQ () = append_isfun (pfapp, pfapp2)
//
in
  pfarr
end // end of [gfarray_v_extend]

(* ****** ****** *)

(*
prfun
gfarray_v_unextend
  {a:vt0p}
  {l:addr}
  {xs:ilist}
  {n:int | n > 0} (
  pflen: LENGTH (xs, n)
, pfarr: gfarray_v (a, l, xs)
) : [xsf:ilist;x:int] ( // xsf: the front
  SNOC (xsf, x, xs), stamped_vt (a, x) @ l+(n-1)*sizeof(a), gfarray_v (a, l, xsf)
) // end of [gfarray_v_unextend]
*)
primplmnt
gfarray_v_unextend
  {a}{l}{xs}{n} (pflen, pfarr) = let
//
prval [
  xs1:ilist,xs2:ilist
] (
  pf1len, pf2len, pfapp, pf1arr, pf2arr
) = gfarray_v_split {a}{l}{xs}{n}{n-1} (pflen, pfarr)
//
prval LENGTHcons (LENGTHnil()) = pf2len
prval pf2at = gfarray_v_unsing (pf2arr)
//
prval pfsnoc =
  lemma (pfapp) where { extern praxi lemma :
    {xs:ilist}{x:int}{xsx:ilist} APPEND (xs, ilist_sing(x), xsx) -<prf> SNOC (xs, x, xsx)
  // end of [extern]
} // end of [prval]
//
in
  (pfsnoc, pf2at, pf1arr)
end // end of [gfarray_v_unextend]

(* ****** ****** *)

local

staload UN = "prelude/SATS/unsafe.sats"

in (* in-of-local *)
//
implement
{a}(*tmp*)
gfarray_get_at
  {l}{x0}{xs}{i0}
  (pf1, pf2 | gp0, i0) =
  $UN.ptr0_get_at<stamped_t(a, x0)>(gp0, i0)
//
implement
{a}(*tmp*)
gfarray_set_at
  {l}{x0}{xs1}{xs2}{i0}
  (pf1, pf2 | gp0, i0, x0) = let
//
prval () =
  pf2 := $UN.castview0(pf2)
//
in
  $UN.ptr0_set_at<stamped_t(a, x0)>(gp0, i0, x0)
end // end of [gfarray_set_at]
//
end // end of [local]

(* ****** ****** *)

(* end of [gfarray.dats] *)
