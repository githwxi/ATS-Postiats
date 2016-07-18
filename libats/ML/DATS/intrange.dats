(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: September, 2014 *)

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"
staload "libats/ML/SATS/intrange.sats"

(* ****** ****** *)
//
implement
{}(*tmp*)
int_repeat_lazy
  (n, f) =
  int_repeat_cloref<> (n, lazy2cloref(f))
//
(* ****** ****** *)

implement
{}(*tmp*)
int_repeat_cloref
  (n, f) = let
//
fun
loop
(
  n: int, f: cfun0(void)
) : void = (
//
if n > 0
  then let val () = f () in loop (n-1, f) end
  else ()
//
) (* end of [loop] *)
//
in
  loop (n, f)
end // end of [int_repeat_cloref]

(* ****** ****** *)
//
implement
{}(*tmp*)
int_forall_cloref
  (n, f) =
  intrange_forall_cloref<> (0, n, f)
//
implement
{}(*tmp*)
int_forall_method
  (n) = lam(f) => int_forall_cloref (n, f)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int_foreach_cloref
  (n, f) =
  intrange_foreach_cloref<> (0, n, f)
//
implement
{}(*tmp*)
int_foreach_method
  (n) = lam(f) => int_foreach_cloref (n, f)
//
(* ****** ****** *)
//
implement
{res}(*tmp*)
int_foldleft_cloref
  (n, ini, f) =
  intrange_foldleft_cloref<res> (0, n, ini, f)
//
implement
{res}(*tmp*)
int_foldleft_method
  (n, tres) =
  lam(ini, f) => int_foldleft_cloref (n, ini, f)
//
(* ****** ****** *)

implement
{}(*tmp*)
intrange_forall_cloref
  (l, r, f) = let
//
fun
loop
(
  l: int, r: int
, f: cfun1(int, bool)
) : bool = (
//
if l < r
  then (
    if f(l) then loop(l+1, r, f) else false
  ) else true
//
) (* end of [loop] *)
//
in
  loop (l, r, f)
end // end of [intrange_forall_cloref]
//
implement
{}(*tmp*)
intrange_forall_method
  ( @(l, r) ) = lam(f) => intrange_forall_cloref (l, r, f)
//
(* ****** ****** *)

implement
{}(*tmp*)
intrange_foreach_cloref
  (l, r, f) = let
//
fun
loop
(
  l: int, r: int, f: cfun1(int, void)
) : void = (
//
if l < r
  then let val () = f(l) in loop(l+1, r, f) end
  else ()
//
) (* end of [loop] *)
//
in
  loop (l, r, f)
end // end of [intrange_foreach_cloref]

(* ****** ****** *)

implement
{}(*tmp*)
intrange_foreach_method
  ( @(l, r) ) = lam(f) => intrange_foreach_cloref (l, r, f)
//
(* ****** ****** *)

implement
{res}(*tmp*)
intrange_foldleft_cloref
  (l, r, ini, fopr) = let
//
fun
loop
(
  l: int, r: int
, ini: res, f: cfun2(res, int, res)
) : res = (
//
if l < r then loop (l+1, r, f(ini, l), f) else ini
//
) (* end of [loop] *)
//
in
  loop (l, r, ini, fopr)
end // end of [intrange_foldleft_cloref]

(* ****** ****** *)
//
implement
{res}(*tmp*)
intrange_foldleft_method
  ( @(l, r), tres ) =
  lam(ini, f) => intrange_foldleft_cloref<res> (l, r, ini, f)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
int_list_map_cloref
  (n, f) = list0_tabulate<a> (n, f)
//
implement
{a}(*tmp*)
int_list_map_method
  (n, tres) = lam(f) => int_list_map_cloref<a> (n, f)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
int_array_map_cloref
  (n, f) = array0_tabulate<a> (i2sz(n), f)
//
implement
{a}(*tmp*)
int_array_map_method
  (n, tres) = lam(f) => int_array_map_cloref<a> (n, f)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
int2_foreach_cloref
  (n1, n2, f) =
  intrange2_foreach_cloref<> (0, n1, 0, n2, f)
//
implement
{}(*tmp*)
intrange2_foreach_cloref
  (l1, r1, l2, r2, f) = let
//
fnx
loop1
(
  m1: int, r1: int
, l2: int, r2: int
, f: cfun2 (int, int, void)
) : void = (
//
if
m1 < r1
then loop2(m1, r1, l2, l2, r2, f)
else ()
//
) (* end of [loop1] *)
//
and
loop2
(
  m1: int, r1: int
, l2: int, m2: int, r2: int
, f: cfun2 (int, int, void)
) : void = (
//
if
m2 < r2
then (
//
f(m1, m2);
loop2(m1, r1, l2, m2+1, r2, f)
//
) (* end of [then] *)
else loop1(m1+1, r1, l2, r2, f)
//
) (* end of [loop2] *)
//
in
  loop1 (l1, r1, l2, r2, f)
end // end of [intrange2_foreach_cloref]
//
(* ****** ****** *)

(* end of [intrange.dats] *)
