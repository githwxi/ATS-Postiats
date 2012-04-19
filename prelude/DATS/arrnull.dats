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

implement{a}
arrnull_size (pf | p) = let
  prval () = lemma_arrnull_v_params (pf)
  fun loop
    {i,j:nat} .<i>. (
    pf: !arrnull_v (a, l, i) | p: ptr l, j: size_t j
  ) :<> size_t (i+j) = let
    val x = $UN.ptr_get<ptr> (p)
  in
    if x > null then let
      val () = __assert () where {
        extern praxi __assert (): [i > 0] void
      } // end of [val]
      prval arrnull_v_cons (pf1, pf2) = pf
      val n = loop (pf2 | p+sizeof<a>, j+1)
      prval () = pf := arrnull_v_cons (pf1, pf2)
    in
      n
    end else j
  end (* end of [loop] *)
in
  loop (pf | p, 0)
end // end of [arrnull_size]

(* ****** ****** *)

(* end of [arrnull.dats] *)
