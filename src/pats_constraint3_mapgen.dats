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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: December, 2014
//
(* ****** ****** *)
//
staload
ATSPRE =
  "./pats_atspre.dats"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

local
//
#include
"./pats_staexp2_appenv.hats"
#include
"./pats_constraint3_appenv.hats"
//
datavtype myenv =
  | MYENV of (s2cstset_vt, s2varset_vt)
//
in
//
implement
s2cst_app
  (s2c, env) = let
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV (!p_s2cs, _) = env2
val ((*void*)) = !p_s2cs := s2cstset_vt_add(!p_s2cs, s2c)
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [s2cst_app]

implement
s2var_app
  (s2v, env) = let
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV (_, !p_s2vs) = env2
val ((*void*)) = !p_s2vs := s2varset_vt_add(!p_s2vs, s2v)
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [s2var_app]

implement d2con_app (s2v, env) = ()

(* ****** ****** *)

implement
c3nstr_mapgen_scst_svar
  (c3t) = let
//
  val s2cs = s2cstset_vt_nil ()
  val s2vs = s2varset_vt_nil ()
  val appenv = $UN.castvwtp0{appenv}(MYENV(s2cs, s2vs))
  val ((*void*)) = c3nstr_app (c3t, appenv)
  val+~MYENV (s2cs, s2vs) = $UN.castvwtp0{myenv}(appenv)
//
in
  (s2cs, s2vs)
end // end of [c3nstr_mapgen_scst_svar]

end // end of [local]

(* ****** ****** *)

(* end of [pats_constraint3_mapgen.dats] *)
