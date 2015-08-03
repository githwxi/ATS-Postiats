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
// Author:
// Hongwei Xi
// Authoremail:
// gmhwxiATgmailDOTcom
// Start Time: December, 2014
//
(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"
staload "./pats_constraint3.sats"

(* ****** ****** *)

(*
#include "./pats_staexp2_appenv.hats"
*)

(* ****** ****** *)
//
extern
fun s3itm_app : synent_app (s3itm)
extern
fun s3itmlst_app : synent_app (s3itmlst)
extern
fun s3itmlstlst_app : synent_app (s3itmlstlst)
//
extern
fun h3ypo_app : synent_app (h3ypo)
//
extern
fun c3nstr_app : synent_app (c3nstr)
//
(* ****** ****** *)

implement
s3itm_app
  (s3i, env) = let
in
//
case+ s3i of
//
| S3ITMsvar(s2v) => s2var_app (s2v, env)
| S3ITMhypo(h3p) => h3ypo_app (h3p, env)
//
| S3ITMsVar(s2V) => s2Var_app (s2V, env)
//
| S3ITMcnstr(c3t) => c3nstr_app (c3t, env)
//
| S3ITMcnstr_ref(c3tr) => let
    val ref = c3tr.c3nstroptref_ref
  in
    case+ !ref of
    | None() => ()
    | Some(c3t) => c3nstr_app (c3t, env)
  end // end of [S3ITMcnstr_ref]
//
| S3ITMdisj(s3iss) => s3itmlstlst_app (s3iss, env)
//
| S3ITMsolassert(s2e) => s2exp_app (s2e, env)
//
end // end of [s3itm_app]

(* ****** ****** *)
//
implement
s3itmlst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    s3itm_app(x, env); s3itmlst_app(xs, env)
  ) (* end of [list_cons] *)
//
end (* end of [s3itmlst_app] *)
//
implement
s3itmlstlst_app
  (xss, env) = let
in
//
case+ xss of
| list_nil () => ()
| list_cons (xs, xss) =>
  (
    s3itmlst_app(xs, env); s3itmlstlst_app(xss, env)
  ) (* end of [list_cons] *)
//
end (* end of [s3itmlstlst_app] *)
//
(* ****** ****** *)

implement
h3ypo_app
  (h3p0, env) = let
in
//
case+
h3p0.h3ypo_node of
//
| H3YPOprop (s2e) => s2exp_app (s2e, env)
| H3YPObind (s2v1, s2e2) =>
  (
    s2var_app (s2v1, env); s2exp_app (s2e2, env)
  )
| H3YPOeqeq (s2e1, s2e2) =>
  (
    s2exp_app (s2e1, env); s2exp_app (s2e2, env)
  )
//
end // end of [h3ypo_app]

(* ****** ****** *)

implement
c3nstr_app
  (c3t0, env) = let
(*
val () =
println! ("c3nstr_app: c3t0 = ", c3t0)
*)
in
//
case+
c3t0.c3nstr_node of
//
| C3NSTRprop(s2e) => s2exp_app (s2e, env)
| C3NSTRitmlst(s3is) => s3itmlst_app (s3is, env)
| C3NSTRsolverify(s2e) => s2exp_app (s2e, env)
//
end // end of [c3nstr_app]

(* ****** ****** *)

(* end of [pats_constraint3_appenv.hats] *)
