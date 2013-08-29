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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: January, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
hidexp_ccomp_ret_case
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDEcase
  (knd, hdes, hicls) = hde0.hidexp_node
//
val pmvs = hidexplst_ccomp (env, res, hdes)
val fail =
(
case+ knd of
| CK_case_pos () => PTCKNTnone ()
| CK_case () => PTCKNTcaseof_fail (loc0)
| CK_case_neg () => PTCKNTcaseof_fail (loc0)
) : patckont // end of [val]
//
val lvl0 = the_d2varlev_get ()
val ibranchlst = hiclaulst_ccomp
(
  env, lvl0, pmvs, hicls, tmpret, fail
) (* end of [val] *)
val ins = instr_caseof (loc0, ibranchlst)
val () = instrseq_add (res, ins)
//
in
  // nothing
end // end of [hidexp_ccomp_ret_case]

(* ****** ****** *)

(* end of [pats_ccomp_caseof.dats] *)
