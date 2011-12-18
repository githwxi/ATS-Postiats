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
// Start Time: December, 2011
//
(* ****** ****** *)

staload "prelude/DATS/list.dats"
staload "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef hnflst = s2hnflst_of_s2explst
macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

extern
fun s2zexp_make_s2cst (s2c: s2cst): s2zexp
implement s2zexp_make_s2cst (s2c) = S2ZEcst s2c

local

absviewtype env
extern fun env_make_nil (): env
extern fun env_pop (env: &env): void
extern fun env_push (env: &env, s2vs: s2varlst): void
extern fun env_free (env: env): void

in // in of [local]

local
assume env = List_vt (s2varlst)
in // in of [local]
implement env_make_nil () = list_vt_nil ()
implement
env_pop (env) =
  case+ env of
  | ~list_vt_cons (_, xss) => env := xss
  | _ => ()
// end of [env_pop]
implement
env_push (env, s2vs) = env := list_vt_cons (s2vs, env)
implement
env_free (env) = list_vt_free (env)
end // end of [local]

(* ****** ****** *)

local

fun aux_s2hnf (
  env: &env, s2f0: s2hnf
) : s2zexp = let
(*
  val () = (
    print "s2zexp_make_s2exp: aux_s2hnf: s2f0 = "; print_s2hnf s2f0; print_newline ()
  ) // end of [val]
*)
  val s2e0 = (unhnf)s2f0
in
  case+ s2e0.s2exp_node of
//
  | S2Ecst s2c => let
      val isabs = s2cst_get_isabs (s2c)
    in
      case+ isabs of
      | Some (opt) => (case+ opt of
        | Some (s2f) => aux_s2hnf (env, s2f)
        | None () => s2zexp_make_s2cst (s2c)
        ) // end of [Some]
      | None () => s2zexp_make_s2cst (s2c)
    end // end of [S2Ecst]
//
  | S2Edatconptr _ => S2ZEptr ()
  | S2Edatcontyp _ => S2ZEptr ()
  | S2Eextype (name, _(*arg*)) => S2ZEextype (name)
  | S2Efun _ => S2ZEptr ()
//
  | S2Eapp (s2e_fun, s2es_arg) =>
      aux_s2exp_app (env, s2e0.s2exp_srt, (hnf)s2e_fun, s2es_arg)
    // end of [S2Eapp]
//
  | S2Etop (knd, s2e) => aux_s2exp (env, s2e)
//
  | S2Eexi (
      s2vs, _(*s2ps*), s2e
    ) => let
      val () = env_push (env, s2vs)
      val s2ze = aux_s2exp (env, s2e)
      val () = env_pop (env)
    in
      s2ze
    end // end of [S2Eexi]
  | S2Euni (
      s2vs, _(*s2ps*), s2e
    ) => let
      val () = env_push (env, s2vs)
      val s2ze = aux_s2exp (env, s2e)
      val () = env_pop (env)
    in
      s2ze
    end // end of [S2Eexi]
//
  | _ => S2ZEany ()
end // end of [aux_s2hnf]

and aux_s2exp (
  env: &env, s2e: s2exp
) : s2zexp =
  aux_s2hnf (env, s2exp_hnfize (s2e))
// end of [aux_s2exp]

and aux_s2exp_app (
  env: &env
, s2t: s2rt
, s2f_fun: s2hnf, s2es_arg: s2explst
) : s2zexp = let
  val s2e_fun = (unhnf)s2f_fun
in
  case+ s2e_fun.s2exp_node of
  | S2Ecst s2c => let
      val isabs = s2cst_get_isabs (s2c)
    in
      case+ isabs of
      | Some (opt) => let
          val s2e = s2exp_app_srt (s2t, s2e_fun, s2es_arg) in aux_s2exp (env, s2e)
        end // end of [Some (Some _)]
      | _ => s2zexp_make_s2cst (s2c) // HX: can be incorrect for certain constructors
    end (* end of [S2Ecst] *)
  | _ => S2ZEany () (* HX: ??? *)
end // end of [aux_s2exp_app]

in // in of [local]

implement
s2zexp_make_s2exp
  (s2e0) = let
  var env = env_make_nil ()
  val s2ze = aux_s2exp (env, s2e0)
  val () = env_free (env)
in
  s2ze
end // end of [s2zexp_make_s2exp]

end // end of [local]

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_szexp.dats] *)
