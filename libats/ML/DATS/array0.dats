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
array0_get_size (A) = let
  val A = arrszref_of_array0 (A) in arrszref_get_size (A)
end // end of [array0_get_size]

(* ****** ****** *)

implement{tk}{a}
array0_get_at_gint (A, i) = let
  val A = arrszref_of_array0 (A) in A[i]
end // end of [array0_get_at_gint]
implement{tk}{a}
array0_get_at_guint (A, i) = let
  val A = arrszref_of_array0 (A) in A[i]
end // end of [array0_get_at_guint]

(* ****** ****** *)

implement{tk}{a}
array0_set_at_gint (A, i, x) = let
  val A = arrszref_of_array0 (A) in A[i] := x
end // end of [array0_set_at_gint]
implement{tk}{a}
array0_set_at_guint (A, i, x) = let
  val A = arrszref_of_array0 (A) in A[i] := x
end // end of [array0_set_at_guint]

(* ****** ****** *)

implement{tk}{a}
array0_exch_at_gint (A, i, x) = let
  val A = arrszref_of_array0 (A) in arrszref_exch_at_gint (A, i, x)
end // end of [array0_exch_at_gint]
implement{tk}{a}
array0_exch_at_guint (A, i, x) = let
  val A = arrszref_of_array0 (A) in arrszref_exch_at_guint (A, i, x)
end // end of [array0_exch_at_guint]

(* ****** ****** *)

implement{a}
array0_make_elt (asz, x) = let
  val A = arrszref_make_elt<a> (asz, x) in array0_of_arrszref (A)
end // end of [array0_make_elt]

(* ****** ****** *)

implement{a}
array0_make_list
  (xs) = let
  val xs = list_of_list0 (xs)
  val A = arrszref_make_list (xs)
in
  array0_of_arrszref (A)
end // end of [array0_make_list]

(* ****** ****** *)

implement{a}
array0_foreach
  (A, f) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
implement(env)
array_foreach$cont<a><env> (x, env) = true
implement(env)
array_foreach$fwork<a><env> (x, env) = f (x)
//
val _ = arrayref_foreach<a> (A, asz)
//
in
  // nothing
end // end of [array0_foreach]

(* ****** ****** *)

implement{a}
array0_iforeach
  (A, f) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
typedef env = size_t
//
implement
array_foreach$cont<a><env> (x, env) = true
implement
array_foreach$fwork<a><env>
  (x, env) = let val i = env in env := succ(i); f (i, x) end
//
var idx: env = g1int2uint (0)
val _ = arrayref_foreach_env<a><env> (A, asz, idx)
//
in
  // nothing
end // end of [array0_iforeach]

(* ****** ****** *)

implement{a}
array0_find_exn (A, p) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
implement(env)
array_foreach$cont<a><env> (x, env) = ~p(x)
implement(env)
array_foreach$fwork<a><env> (x, env) = ((*nothing*))
//
val idx = arrayref_foreach<a> (A, asz)
//
in
  if idx < asz then idx else $raise NotFoundExn()
end // end of [array0_find_exn]

implement{a}
array0_find_opt (A, p) =
  try Some0 (array0_find_exn<a> (A, p)) with ~NotFoundExn() => None0 ()
// end of [array0_find_opt]

(* ****** ****** *)

implement
{a}{res}
array0_foldleft
  (A, ini, f) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
typedef env = res
//
implement
array_foreach$cont<a><env> (x, env) = true
implement
array_foreach$fwork<a><env> (x, env) = env := f (env, x)
//
var res: env = ini
val _ = arrayref_foreach_env<a><env> (A, asz, res)
//
in
  res
end // end of [array0_foldleft]

(* ****** ****** *)

implement
{a}{res}
array0_ifoldleft
  (A, ini, f) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
typedef env = (res, size_t)
//
implement
array_foreach$cont<a><env> (x, env) = true
implement
array_foreach$fwork<a><env>
  (x, env) = let
  val i = env.1; val () = env.1 := succ(i)
in
  env.0 := f (env.0, i, x)
end // end of [array_foreach$fwork]
//
var residx: env = (ini, g1int2uint(0))
val _ = arrayref_foreach_env<a><env> (A, asz, residx)
//
in
  residx.0
end // end of [array0_ifoldleft]

(* ****** ****** *)

implement{a}
array0_rforeach
  (A, f) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
implement(env)
array_rforeach$cont<a><env> (x, env) = true
implement(env)
array_rforeach$fwork<a><env> (x, env) = f (x)
//
val _ = arrayref_rforeach<a> (A, asz)
//
in
  // nothing
end // end of [array0_rforeach]

(* ****** ****** *)

implement
{a}{res}
array0_foldright
  (A, f, snk) = let
//
val A = arrszref_of_array0 (A)
//
var asz: size_t
val A = arrszref_get_refsize (A, asz)
//
typedef env = res
//
implement
array_rforeach$cont<a><env> (x, env) = true
implement
array_rforeach$fwork<a><env> (x, env) = env := f (x, env)
//
var res: env = snk
val _ = arrayref_rforeach_env<a><env> (A, asz, snk)
//
in
  res
end // end of [array0_foldright]

(* ****** ****** *)

(* end of [array0.dats] *)
  