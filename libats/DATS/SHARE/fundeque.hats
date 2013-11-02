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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement{a}
fundeque_get_atbeg_opt (xs) =
(
if fundeque_is_cons (xs) then 
  Some_vt{a}(fundeque_get_atbeg<a> (xs))
else None_vt{a}((*void*))
) // end of [fundeque_get_atbeg_opt]

implement{a}
fundeque_get_atend_opt (xs) =
(
if fundeque_is_cons (xs) then 
  Some_vt{a}(fundeque_get_atend<a> (xs))
else None_vt{a}((*void*))
) // end of [fundeque_get_atend_opt]

(* ****** ****** *)

implement{a}
fundeque_takeout_atbeg_opt (xs) =
(
if fundeque_is_cons (xs) then 
  Some_vt{a}(fundeque_uncons<a> (xs))
else None_vt{a}((*void*))
) // end of [fundeque_get_atbeg_opt]

implement{a}
fundeque_takeout_atend_opt (xs) =
(
if fundeque_is_cons (xs) then 
  Some_vt{a}(fundeque_unsnoc<a> (xs))
else None_vt{a}((*void*))
) // end of [fundeque_get_atend_opt]

(* ****** ****** *)

implement{a}
fprint_fundeque (out, xs) = let
//
typedef tenv = int
//
implement
fundeque_foreach$fwork<a><tenv>
  (x, env) = let
//
val () =
if env > 0 then
  fprint_fundeque$sep (out)
// end of [val]
val () = fprint_val<a> (out, x)
val () = env := env + 1
//
in
  // nothing
end // end of [fundeque_foreach$fwork]
//
var env: tenv = 0
val () = fundeque_foreach_env<a><tenv> (xs, env)
//
in
  // nothing
end // end of [fprint_fundeque]

implement{}
fprint_fundeque$sep (out) = fprint (out, ", ")

(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in (* in of [local] *)

implement{a}
fundeque_listize
  {n} (xs) = let
//
viewtypedef tenv = $Q.qstruct (a)
//
implement
fundeque_foreach$fwork<a><tenv>
  (x, env) = $Q.qstruct_insert<a> (env, x)
//
var env: $Q.qstruct
val () = $Q.qstruct_initize {a} (env)
val () = $effmask_all (fundeque_foreach_env (xs, env))
val res = $Q.qstruct_takeout_list (env)
val () = $Q.qstruct_uninitize {a} (env)
//
in
  $UN.castvwtp0{list_vt(a,n)}(res)
end // end of [fundeque_listize]

end // end of [local]

(* ****** ****** *)

(* end of [fundeque.hats] *)
