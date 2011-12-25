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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)


(* ****** ****** *)

local

absviewtype env
extern fun env_make_nil (): env
extern fun env_pop (env: &env): void
extern fun env_push (env: &env, s2vs: s2varlst): void
extern fun env_free (env: env): void
extern fun env_find (env: &env, s2v: s2var): bool
//
in // in of [local]
//
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
implement
env_find (env, x0) = list_exists_cloptr<s2var> (
  $UN.castvwtp1 {s2varlst} (env), lam x =<0> eq_s2var_s2var (x0, x)
) // end of [env_find]
end // end of [local]

(* ****** ****** *)

local
in // in of [local]
end // end of [local]

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_skexp.dats] *)
