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

implement{a}
array0_get_at (A0, i) = let
  val A0 = arrszref_of_array0 (A0) in A0[i]
end // end of [array0_get_at]

implement{a}
array0_set_at (A0, i, x) = let
  val A0 = arrszref_of_array0 (A0) in A0[i] := x
end // end of [array0_set_at]

implement{a}
array0_exch_at (A0, i, x) = let
  val A0 = arrszref_of_array0 (A0) in arrszref_exch_at (A0, i, x)
end // end of [array0_exch_at]

(* ****** ****** *)

implement{a}
array0_make_elt (asz, x) = let
  val A0 = arrszref_make_elt (asz, x) in array0_of_arrszref (A0)
end // end of [array0_make_elt]

(* ****** ****** *)

implement{a}
array0_make_list
  (xs) = let
  val xs = list_of_list0 (xs)
  val A0 = arrszref_make_list (xs)
in
  array0_of_arrszref (A0)
end // end of [array0_make_list]

(* ****** ****** *)

implement{a}
array0_foreach
  (A0, f) = let
//
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
implement(env)
array_foreach__cont<a><env> (x, env) = true
implement(env)
array_foreach__fwork<a><env> (x, env) = f (x)
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
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
typedef env = size_t
//
implement
array_foreach__cont<a><env> (x, env) = true
implement
array_foreach__fwork<a><env>
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
array0_find_exn (A0, p) = let
//
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
implement(env)
array_foreach__cont<a><env> (x, env) = ~p(x)
implement(env)
array_foreach__fwork<a><env> (x, env) = ((*nothing*))
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
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
typedef env = res
//
implement
array_foreach__cont<a><env> (x, env) = true
implement
array_foreach__fwork<a><env> (x, env) = env := f (env, x)
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
  (A0, ini, f) = let
//
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
typedef env = (res, size_t)
//
implement
array_foreach__cont<a><env> (x, env) = true
implement
array_foreach__fwork<a><env>
  (x, env) = let
  val i = env.1; val () = env.1 := succ(i)
in
  env.0 := f (env.0, i, x)
end // end of [array_foreach__fwork]
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
  (A0, f) = let
//
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
implement(env)
array_rforeach__cont<a><env> (x, env) = true
implement(env)
array_rforeach__fwork<a><env> (x, env) = f (x)
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
  (A0, f, snk) = let
//
val A0 = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (A0, asz)
//
typedef env = res
//
implement
array_rforeach__cont<a><env> (x, env) = true
implement
array_rforeach__fwork<a><env> (x, env) = env := f (x, env)
//
var res: env = snk
val _ = arrayref_rforeach_env<a><env> (A, asz, snk)
//
in
  res
end // end of [array0_foldright]

(* ****** ****** *)

(* end of [array0.dats] *)
  