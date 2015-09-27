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
(* Start time: September, 2015 *)

(* ****** ****** *)

implement
{a}(*tmp*)
compare_elt_elt = gcompare_val_val<a>

(* ****** ****** *)
//
implement
{}(*tmp*)
funmset_isnot_nil
  (xs) = not(funmset_is_nil<> (xs))
//
(* ****** ****** *)

implement
{a}(*tmp*)
funmset_size(xs) = let
//
typedef tenv = size_t
//
implement(a)
funmset_foreach$fwork<a><tenv>
  (n, x, env) = (env := env + i2sz(n))
//
var env: tenv = i2sz(0)
//
in
//
  $effmask_all(funmset_foreach_env<a><tenv> (xs, env)); env
//
end // end of [funmset_size]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
funmset_isnot_member
  (xs, x0) = not(funmset_is_member<a> (xs, x0))
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
funmset_insert
  (xs, x0) = funmset_insert2<a>(xs, 1, x0)
implement
{a}(*tmp*)
funmset_remove
  (xs, x0) = funmset_remove2<a>(xs, 1, x0)
//
(* ****** ****** *)

implement
{a}(*tmp*)
funmset_foreach
  (nxs) = let
//
var env: void = ()
//
in
  funmset_foreach_env<a><void> (nxs, env)
end // end of [funmset_foreach]

(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_funmset$sep
  (out) = fprint_string (out, ", ")
//
implement
{a}(*tmp*)
fprint_funmset_sep
  (out, xs, sep) = let
//
implement{}
fprint_funmset$sep(out) = fprint_string(out, sep)
//
in
  fprint_funmset<a> (out, xs)
end // end of [fprint_funmset]
//
(* ****** ****** *)

implement
{a}(*tmp*)
fprint_funmset
  (out, xs) = let
//
typedef tenv = int
//
implement
funmset_foreach$fwork<a><tenv>
  (n, x, env) = () where
{
//
  val () =
  if env > 0
    then fprint_funmset$sep(out)
  // end of [if]
  val () = env := env + 1
  val () = fprint_val<a> (out, x)
  val () = fprint! (out, "(", n, ")")
} (* end of [fprint_funmset$fwork] *)
//
var env: tenv = 0
//
in
  funmset_foreach_env<a><tenv> (xs, env)
end // end of [fprint_funmset]

(* ****** ****** *)

(* end of [funmset.hats] *)
