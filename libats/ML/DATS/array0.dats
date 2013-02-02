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
(* Start time: July, 2012 *)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"

(* ****** ****** *)

implement
array0_get_size (A0) = let
  val ASZ = arrszref_of_array0 (A0) in arrszref_get_size (ASZ)
end // end of [array0_get_size]

(* ****** ****** *)

implement{tk}{a}
array0_get_at_gint (A0, i) = let
  val ASZ = arrszref_of_array0 (A0) in ASZ[i]
end // end of [array0_get_at_gint]
implement{tk}{a}
array0_get_at_guint (A0, i) = let
  val ASZ = arrszref_of_array0 (A0) in ASZ[i]
end // end of [array0_get_at_guint]

(* ****** ****** *)

implement{tk}{a}
array0_set_at_gint (A0, i, x) = let
  val ASZ = arrszref_of_array0 (A0) in ASZ[i] := x
end // end of [array0_set_at_gint]
implement{tk}{a}
array0_set_at_guint (A0, i, x) = let
  val ASZ = arrszref_of_array0 (A0) in ASZ[i] := x
end // end of [array0_set_at_guint]

(* ****** ****** *)

implement{tk}{a}
array0_exch_at_gint (A0, i, x) = let
  val ASZ = arrszref_of_array0 (A0) in arrszref_exch_at_gint (ASZ, i, x)
end // end of [array0_exch_at_gint]
implement{tk}{a}
array0_exch_at_guint (A0, i, x) = let
  val ASZ = arrszref_of_array0 (A0) in arrszref_exch_at_guint (ASZ, i, x)
end // end of [array0_exch_at_guint]

(* ****** ****** *)

implement{a}
array0_make_elt (asz, x) = let
  val ASZ = arrszref_make_elt<a> (asz, x) in array0_of_arrszref (ASZ)
end // end of [array0_make_elt]

(* ****** ****** *)

implement{a}
array0_make_list
  (xs) = let
  val ASZ = arrszref_make_list ((list_of_list0)xs)
in
  array0_of_arrszref (ASZ)
end // end of [array0_make_list]

(* ****** ****** *)

implement{a}
array0_foreach
  (A0, f) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
implement(tenv)
array_foreach$cont<a><tenv> (x, env) = true
implement(tenv)
array_foreach$fwork<a><tenv> (x, env) = f (x)
//
val _ = arrayref_foreach<a> (A, asz)
//
in
  // nothing
end // end of [array0_foreach]

(* ****** ****** *)

implement{a}
array0_iforeach
  (A0, f) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
implement(tenv)
array_iforeach$cont<a><tenv> (i, x, env) = true
implement(tenv)
array_iforeach$fwork<a><tenv> (i, x, env) = f (i, x)
//
val _ = arrayref_iforeach<a> (A, asz)
//
in
  // nothing
end // end of [array0_iforeach]

(* ****** ****** *)

implement{a}
array0_rforeach
  (A0, f) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
implement(tenv)
array_rforeach$cont<a><tenv> (x, env) = true
implement(tenv)
array_rforeach$fwork<a><tenv> (x, env) = f (x)
//
val _ = arrayref_rforeach<a> (A, asz)
//
in
  // nothing
end // end of [array0_rforeach]

(* ****** ****** *)

implement{a}
array0_find_exn (A0, p) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
implement(tenv)
array_foreach$cont<a><tenv> (x, env) = ~p(x)
implement(tenv)
array_foreach$fwork<a><tenv> (x, env) = ((*nothing*))
//
val idx = arrayref_foreach<a> (A, asz)
//
in
  if idx < asz then idx else $raise NotFoundExn()
end // end of [array0_find_exn]

implement{a}
array0_find_opt (A0, p) =
  try Some0 (array0_find_exn<a> (A0, p)) with ~NotFoundExn() => None0 ()
// end of [array0_find_opt]

(* ****** ****** *)

implement
{a}{res}
array0_foldleft
  (A0, ini, f) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
typedef tenv = res
//
implement
array_foreach$cont<a><tenv> (x, env) = true
implement
array_foreach$fwork<a><tenv> (x, env) = env := f (env, x)
//
var res: tenv = ini
val _ = arrayref_foreach_env<a><tenv> (A, asz, res)
//
in
  res
end // end of [array0_foldleft]

(* ****** ****** *)

implement
{a}{res}
array0_ifoldleft
  (A0, ini, f) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
typedef tenv = res
//
implement
array_iforeach$cont<a><tenv> (i, x, env) = true
implement
array_iforeach$fwork<a><tenv> (i, x, env) = (env := f (env, i, x))
//
var res: tenv = ini
val _ = arrayref_foreach_env<a><tenv> (A, asz, res)
//
in
  res
end // end of [array0_ifoldleft]

(* ****** ****** *)

implement
{a}{res}
array0_foldright
  (A0, f, snk) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
typedef tenv = res
//
implement
array_rforeach$cont<a><tenv> (x, env) = true
implement
array_rforeach$fwork<a><tenv> (x, env) = env := f (x, env)
//
var res: tenv = snk
val _ = arrayref_rforeach_env<a><tenv> (A, asz, snk)
//
in
  res
end // end of [array0_foldright]

(* ****** ****** *)

(* end of [array0.dats] *)
  