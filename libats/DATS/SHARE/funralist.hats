(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in (* in of [local] *)

implement{a}
funralist_listize
  {n} (xs) = let
//
viewtypedef tenv = $Q.qstruct (a)
//
implement
funralist_foreach$fwork<a><tenv> (x, env) = $Q.qstruct_insert<a> (env, x)
//
var env: $Q.qstruct
val () = $Q.qstruct_initize {a} (env)
val () = $effmask_all (funralist_foreach_env (xs, env))
val res = $Q.qstruct_takeout_list (env)
val () = $Q.qstruct_uninitize {a} (env)
//
in
  $UN.castvwtp0{list_vt(a,n)}(res)
end // end of [funralist_listize]

end // end of [local]

(* ****** ****** *)

(* end of [funralist.hats] *)
