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

staload LEX = "pats_lexing.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

implement
s2exp_c0har (x) = let
  val- $LEX.T_CHAR (c) = x.token_node
in '{
  s2exp_srt= s2rt_char, s2exp_node= S2Echar (c)
} end // end of [s2exp_c0har]

implement
s2exp_app_srt (s2t, _fun, _arg) = '{
  s2exp_srt= s2t, s2exp_node= S2Eapp (_fun, _arg)
}

implement
s2exp_cst (s2c) = let
  val s2t = s2cst_get_srt (s2c)
in '{
  s2exp_srt= s2t, s2exp_node= S2Ecst (s2c)
} end // end of [s2exp_cst]

implement
s2exp_var (s2v) = let
  val s2t = s2var_get_srt (s2v)
in '{
  s2exp_srt= s2t, s2exp_node= S2Evar (s2v)
} end // end of [s2exp_var]

implement
s2exp_err (s2t) = '{
  s2exp_srt= s2t, s2exp_node= S2Eerr ()
}

(* ****** ****** *)

(* end of [pats_staexp2.dats] *)
