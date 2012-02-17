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
#print "Loading [arith_prf.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(*
staload "arith_prf.sats" // HX: preloaded
*)

(* ****** ****** *)

implement
lemma_exp2_params (pf) = let
  prfun aux
    {n:int}
    {p:int}
    .<max(n,0)>. (
    pf: EXP2 (n, p)
  ) : [n>=0;p>=1] void = case+ pf of
    | EXP2ind (pf1) => aux (pf1) | EXP2bas () => ()
  // end of [aux]
in
  aux (pf)
end // end of [lemma_exp2_params]  

(* ****** ****** *)

implement
exp2_istot {n}
  () = istot {n} () where {
  prfun istot
    {n:nat} .<n>. (): [p:nat] EXP2 (n, p) =
    sif n > 0 then EXP2ind (istot {n-1} ()) else EXP2bas ()
} // end of [exp2_istot]

(* ****** ****** *)

implement
exp2_isfun
  (pf1, pf2) =
  isfun (pf1, pf2) where {
  prfun isfun
    {n:nat} {p1,p2:int} .<n>. (
    pf1: EXP2 (n, p1), pf2: EXP2 (n, p2)
  ) : [p1==p2] void =
    case+ pf1 of
    | EXP2ind pf1 => let
        prval EXP2ind pf2 = pf2 in isfun (pf1, pf2)
      end // end of [EXP2ind]
    | EXP2bas () => let
        prval EXP2bas () = pf2 in (* nothing *)
      end // end of [EXP2bas]
  // end of [isfun]
} // end of [exp2_isfun]

(* ****** ****** *)

implement
exp2_ismono
  (pf1, pf2) =
  aux (pf1, pf2) where {
  prfun aux
    {n1:nat;n2:int | n1 <= n2}
    {p1,p2:int} .<n2>. (
    pf1: EXP2 (n1, p1), pf2: EXP2 (n2, p2)
  ) : [p1 <= p2] void =
    case+ pf2 of
    | EXP2ind (pf2) => (case+ pf1 of
      | EXP2ind (pf1) => aux (pf1, pf2) | EXP2bas () => aux (pf1, pf2)
      ) // end of [EXP2ind]
    | EXP2bas () => let prval EXP2bas () = pf1 in () end
  // end of [aux]
} // end of [exp2_ismono]

implement
exp2_mul
  (pf1, pf2, pf3) = let
  prfun aux
    {n1,n2:nat} {p1,p2:nat} {p:int} .<n2>. (
    pf1: EXP2 (n1, p1), pf2: EXP2 (n2, p2), pf3: MUL (p1, p2, p)
  ) : [p>=0] EXP2 (n1+n2, p) = case+ pf2 of
    | EXP2ind {n21} {p21} (pf21) => let // n2 = n21+1; p2 = p21 + p21
        prval pf31 = mul_istot {p1,p21} ()
        prval pf32 = mul_distribute (pf31, pf31)
        prval () = mul_isfun (pf3, pf32)
        prval pf1_res = aux (pf1, pf21, pf31)
      in
        EXP2ind pf1_res
      end // end of [EXP2ind]
    | EXP2bas () => let prval () = mul_elim (pf3) in pf1 end
  // end of [aux]
in
  aux (pf1, pf2, pf3)
end // end of [exp2_mul]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [arith_prf.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [arith_prf.sats] *)
