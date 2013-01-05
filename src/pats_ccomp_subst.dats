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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: November, 2012
//
(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

implement
funlab_subst
  (sub, flab) = let
//
val name = funlab_get_name (flab)
val level = funlab_get_level (flab)
val hse = funlab_get_type (flab)
val hse2 = hisexp_subst (sub, hse)
val () = println! ("funlab_subst: hse2 = ", hse2)
val qopt = funlab_get_qopt (flab)
val t2mas = funlab_get_tmparg (flab)
val stamp = $STMP.funlab_stamp_make ()
//
in
//
funlab_make (name, level, hse2, qopt, t2mas, stamp)
//
end // end of [funlab_subst]

(* ****** ****** *)

implement
funent_subst
  (env, sub, flab2, fent, sfx) = let
//
val loc = funent_get_loc (fent)
val flab = funent_get_lab (fent)
val level = funent_get_level (fent)
//
val imparg = funent_get_imparg (fent)
val tmparg = funent_get_tmparg (fent)
val tmpret = funent_get_tmpret (fent)
val inss = funent_get_instrlst (fent)
val tmplst = funent_get_tmpvarlst (fent)
//
val tmplst2 = tmpvarlst_subst (sub, tmplst, sfx)
//
(*
val inss2 = instrlst_subst (env, sub, inss, sfx)
*)
//
val inss2 = inss
//
val fent2 =
  funent_make (
  loc, level, flab2, imparg, tmparg, None(), tmpret, inss2, tmplst2
) // end of [val]
//
in
  fent2
end // end of [funent_subst]

(* ****** ****** *)

(* end of [pats_ccomp_subst.dats] *)
