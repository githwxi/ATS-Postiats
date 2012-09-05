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
// Start Time: July, 2012
//
(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

implement
s2exp_tyer_deep
  (loc0, s2e0) = s2exp_tyer (loc0, 1(*flag*), s2e0)
// end of [s2exp_tyer_deep]

implement
s2exp_tyer_shallow
  (loc0, s2e0) = s2exp_tyer (loc0, 0(*flag*), s2e0)
// end of [s2exp_tyer_shallow]

(* ****** ****** *)

extern
fun s2hnf_tyer
  (loc: location, flag: int, s2f0: s2hnf): hisexp
// end of [s2hnf_tyer]

(* ****** ****** *)

implement
s2exp_tyer
  (loc0, flag, s2e0) = let
  val s2f0 = s2exp2hnf (s2e0) in s2hnf_tyer (loc0, flag, s2f0)
end // end of [s2hnf_tyer]

(* ****** ****** *)

implement
s2hnf_tyer
  (loc0, flag, s2f0) = let
  val s2e0 = s2hnf2exp (s2f0)
in
//
case+ s2e0.s2exp_node of
| _ => hisexp_err (loc0, s2e0)
//
end // end of [s2hnf_tyer]

(* ****** ****** *)

(* end of [pats_typerase_staexp.dats] *)
