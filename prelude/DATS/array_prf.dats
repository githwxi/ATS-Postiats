(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array_prf.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(*
staload "array_prf.sats" // HX: it is preloaded
*)

(* ****** ****** *)

implement
array_v_split {a}
  (pf_mul, pf_arr) = split (pf_mul, pf_arr) where {
  prfun split
    {l:addr} 
    {n,i:nat | i <= n}
    {ofs:int} .<i>. (
    pf_mul: MUL (i, sizeof a, ofs), pf_arr: array_v (a, l, n)
  ) : @(array_v (a, l, i), array_v (a, l+ofs, n-i)) =
    sif i > 0 then let
      prval @(pf1_elt, pf2_arr) = array_v_uncons (pf_arr)
      // pf1_mul : MUL (i-1, sizeof a, ofs - sizeof a)
      prval pf1_mul = mul_add_const {~1} {i, sizeof a} (pf_mul)
      prval @(pf1_arr_res, pf2_arr_res) = split {n-1,i-1} (pf1_mul, pf2_arr)
    in
      @(array_v_cons (pf1_elt, pf1_arr_res), pf2_arr_res)
    end else let
      prval MULbas () = pf_mul in (array_v_nil {a} {l} (), pf_arr)
    end // end of [sif]
} // end of [array_v_split]

(* ****** ****** *)

implement
array_v_unsplit{a}
  (pf_mul, pf1_arr, pf2_arr) =
  unsplit (pf_mul, pf1_arr, pf2_arr) where {
//
  prval () = lemma_array_params (pf1_arr)
    and () = lemma_array_params (pf2_arr) 
//
  prfun unsplit
    {l:addr}
    {n1,n2:nat}
    {ofs:int} .<n1>. (
    pf_mul: MUL (n1, sizeof a, ofs)
  , pf1_arr: array_v (a, l, n1), pf2_arr: array_v (a, l+ofs, n2)
  ) : array_v (a, l, n1+n2) =
    sif n1 > 0 then let
      prval @(pf11_elt, pf12_arr) = array_v_uncons (pf1_arr)
      // pf1_mul : MUL (n1-1, sizeof a, ofs - sizeof a)
      prval pf1_mul = mul_add_const {~1} {n1, sizeof a} (pf_mul)
      prval pf_arr_res = unsplit (pf1_mul, pf12_arr, pf2_arr)
    in
      array_v_cons (pf11_elt, pf_arr_res)
    end else let
      prval () = array_v_unnil (pf1_arr); prval MULbas () = pf_mul
    in
      pf2_arr
    end // end of [sif]
} // end of [array_v_unsplit]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array_prf.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [array_prf.dats] *)
