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
// Start Time: April, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

sortdef vtp = viewtype

(* ****** ****** *)

dataview
arrnull_v (
  a:viewtype+, addr(*l*), int(*n*)
) = // for arrays with a sentinel at the end
  | {l:addr}
    arrnull_v_nil (a, l, 0) of (ptr null @ l)
  | {n:int}{l:addr}
    arrnull_v_cons (a, l, n+1) of (a @ l, arrnull_v (a, l+sizeof(a), n))
// end of [arrnull_v]

(* ****** ****** *)

prfun
lemma_arrnull_v_params{a:vtp}
  {l:addr}{n:int} (pf: !arrnull_v (INV(a), l, n)): [n >= 0] void
// end of [lemma_arrnull_v_params]

(* ****** ****** *)

fun{a:vtp} ptr_of_elt (x: !INV(a)): [l:agz] ptr l

(* ****** ****** *)

fun{
a:vtp
} arrnull_size
  {n:int}{l:addr}
  (pf: !arrnull_v (INV(a), l, n) | p: ptr l):<> size_t (n)
// end of [arrnull_size]

(* ****** ****** *)

(* end of [arrnull.sats] *)
