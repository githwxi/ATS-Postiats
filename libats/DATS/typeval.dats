(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmmhwxiATgmailDOTcom
// Start Time: March, 2015
//
(* ****** ****** *)

staload "libats/SATS/typeval.sats"

(* ****** ****** *)
//
implement
tieq2int<Z()>
  (pf | (*void*)) =
  let prval TIEQZ() = pf in 0 end
//
implement
(t)(*tmp*)
tieq2int<S(t)>
  (pf | (*void*)) =
(
  let prval TIEQS(pf) = pf in
    succ(tieq2int<t>(pf | (*void*))) end
  // end of [tieq2int<S(t)>]
)
//
(* ****** ****** *)
//
implement
ti2eq2int<Z()>
  (pf | (*void*)) =
  let prval TI2EQZ() = pf in 0 end
//
implement
(t)(*tmp*)
ti2eq2int<B0(t)>
  (pf | (*void*)) =
(
  let prval TI2EQB0(pf) = pf in
    2*(ti2eq2int<t>(pf | (*void*))) end
  // end of [ti2eq2int<B0(t)>]
)
//
implement
(t)(*tmp*)
ti2eq2int<B1(t)>
  (pf | (*void*)) =
(
  let prval TI2EQB1(pf) = pf in
    2*(ti2eq2int<t>(pf | (*void*)))+1 end
  // end of [ti2eq2int<B1(t)>]
)
//
(* ****** ****** *)
//
implement
(a)(*tmp*)
sarray_foreach<a><Z()>
  (pf | A, env) = ()
//
implement
(a,t)(*tmp*)
sarray_foreach<a><S(t)>
  (pf | A, env) = let
//
val p0 = addr@A
//
prval TIEQS(pf1) = pf
//
prval pfarr = view@(A)
prval
(
  pfat, pfarr1
) = array_v_uncons(pfarr)
//
val () = sarray_foreach$fwork<a> (!p0, env)
//
val p1 = ptr1_succ<a> (p0)
val (pfarr1 | p1) = viewptr_match(pfarr1 | p1)
val () = sarray_foreach<a><t> (pf1 | !p1, env)
//
prval () = view@A := array_v_cons (pfat, pfarr1)
//
in
  ignoret(0) // HX: for circumventing a tail-call bug!
end // end of [sarray_foreach<a><S(t)>]
//
(* ****** ****** *)
//
implement
(a)(*tmp*)
sarray_foreach2<a><Z()>
  (pf | A0, A1, env) = ()
//
implement
(a,t)(*tmp*)
sarray_foreach2<a><S(t)>
  (pf | A0, A1, env) = let
//
val p0 = addr@A0
val p1 = addr@A1
//
prval TIEQS(pf1) = pf
//
prval pf0arr = view@(A0)
prval
(
  pf0at, pf0arr1
) = array_v_uncons(pf0arr)
//
prval pf1arr = view@(A1)
prval
(
  pf1at, pf1arr1
) = array_v_uncons(pf1arr)
//
val () = sarray_foreach2$fwork<a> (!p0, !p1, env)
//
val p0_1 = ptr1_succ<a> (p0)
val (pf0arr1 | p0_1) = viewptr_match(pf0arr1 | p0_1)
val p1_1 = ptr1_succ<a> (p1)
val (pf1arr1 | p1_1) = viewptr_match(pf1arr1 | p1_1)
//
val () = sarray_foreach2<a><t> (pf1 | !p0_1, !p1_1, env)
//
prval () = view@A0 := array_v_cons (pf0at, pf0arr1)
prval () = view@A1 := array_v_cons (pf1at, pf1arr1)
//
in
  ignoret(0) // HX: for circumventing a tail-call bug!
end // end of [sarray_foreach2<a><S(t)>]
//
(* ****** ****** *)

(* end of [typeval.sats] *)
