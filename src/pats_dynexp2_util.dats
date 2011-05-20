(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_dynexp2_util.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
d2con_select_arity
  (d2cs, n) = let
  val nd2cs = list_length (d2cs)
in
  if nd2cs >= 2 then let
    var !p_clo = @lam
      (pf: !unit_v | d2c: d2con): bool =<clo1> d2con_get_arity_full (d2c) = n
    // end of [var]
    prval pfu = unit_v ()
    val d2cs = list_filter_clo {unit_v} (pfu | d2cs, !p_clo)
    prval unit_v () = pfu
  in
    (l2l)d2cs
  end else d2cs // end of [if]
end // end of [d2con_select_arity]

(* ****** ****** *)

(* end of [pats_dynexp2_util.dats] *)
