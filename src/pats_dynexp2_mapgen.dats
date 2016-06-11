(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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

staload "./pats_dynexp2.sats"

(* ****** ****** *)

local
//
extern
fun s2cst_app : synent_app (s2cst)
and s2var_app : synent_app (s2var)
and s2Var_app : synent_app (s2Var)
and d2con_app : synent_app (d2con)
//
extern
fun d2cst_app : synent_app (d2cst)
and d2var_app : synent_app (d2var)
and d2sym_app : synent_app (d2sym)
//  
#include "./pats_staexp2_appenv.hats"
#include "./pats_dynexp2_appenv.hats"
//
datavtype
myenv =
MYENV of (
  s2cstset_vt
, s2varset_vt
, s2Varset_vt
, d2conset_vt
, d2cstset_vt
, d2varset_vt
) (* end of [MYENV] *)
//
in
//
implement
s2cst_app
  (s2c, env) = let
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV
  (!p_s2cs, _, _, _, _, _) = env2
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
val+MYENV
  (_, !p_s2vs, _, _, _, _) = env2
val ((*void*)) = !p_s2vs := s2varset_vt_add(!p_s2vs, s2v)
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [s2var_app]

implement
s2Var_app
  (s2V, env) = let
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV
  (_, _, !p_s2Vs, _, _, _) = env2
val ((*void*)) = !p_s2Vs := s2Varset_vt_add(!p_s2Vs, s2V)
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [s2Var_app]

implement
d2con_app
  (d2c, env) = let
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV
  (_, _, _, !p_d2cs, _, _) = env2
val ((*void*)) = !p_d2cs := d2conset_vt_add(!p_d2cs, d2c)
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [d2con_app]

implement
d2cst_app
  (d2c, env) = let
//
val s2e =
  d2cst_get_type(d2c)
val ((*void*)) =
  s2exp_app(s2e, env)
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV
  (_, _, _, _, !p_d2cs, _) = env2
//
val ((*void*)) =
  !p_d2cs := d2cstset_vt_add(!p_d2cs, d2c)
//
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [d2cst_app]

implement
d2var_app
  (d2v, env) = let
//
val env2 =
  $UN.castvwtp1{myenv}(env)
val+MYENV
  (_, _, _, _, _, !p_d2vs) = env2
//
val ((*void*)) =
  !p_d2vs := d2varset_vt_add(!p_d2vs, d2v)
//
prval ((*void*)) = fold@ (env2)
prval ((*void*)) = $UN.castvwtp0{void}(env2)
//
in
  // nothing
end // end of [d2var_app]

implement d2sym_app (d2s, env) = ()

(* ****** ****** *)

implement
d2eclist_mapgen_all
  (d2cls) = let
//
val s2cs = s2cstset_vt_nil ()
val s2vs = s2varset_vt_nil ()
val s2Vs = s2Varset_vt_nil ()
//
val d2cons = d2conset_vt_nil ()
val d2csts = d2cstset_vt_nil ()
val d2vars = d2varset_vt_nil ()
//
val appenv =
$UN.castvwtp0{appenv}(MYENV(s2cs, s2vs, s2Vs, d2cons, d2csts, d2vars))
//
val ((*void*)) = d2eclist_app (d2cls, appenv)
//
val+~MYENV(s2cs, s2vs, s2Vs, d2cons, d2csts, d2vars) = $UN.castvwtp0{myenv}(appenv)
//
in
//
(
  s2cs
, s2vs
, s2Vs
, d2cons
, d2csts
, d2vars
)
//
end // end of [d2eclist_mapgen_all]

end // end of [local]

(* ****** ****** *)

(* end of [pats_dynexp2_mapgen.dats] *)
