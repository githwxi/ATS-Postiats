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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

implement
d2exp_funclo_of_d2exp
  (d2e0, fc0) =
  case+ d2e0.d2exp_node of
  | D2Eann_funclo (d2e, fc) => (fc0 := fc; d2e)
  | _ => d2e0
// end of [d2exp_funclo_of_d2exp]

(* ****** ****** *)

implement
d2exp_s2eff_of_d2exp
  (d2e0, s2fe0) =
  case+ d2e0.d2exp_node of
  | D2Elam_dyn _ => d2e0
  | D2Elaminit_dyn _ => d2e0
  | D2Elam_sta _ => d2e0
  | D2Eann_seff
      (d2e, s2fe) => let
      val () = s2fe0 := s2fe in d2e
    end // end of [D2Eann_seff]
  | _ => let
      val () = s2fe0 := S2EFFall () in d2e0
    end // end of [_]
// end of [d2exp_s2eff_of_d2exp]

(* ****** ****** *)

(* end of [pats_trans3_util.dats] *)
