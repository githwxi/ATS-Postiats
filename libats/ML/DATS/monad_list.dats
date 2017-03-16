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
(* Start time: July, 2013 *)
(* Authoremail: gmmhwxiATgmailDOTcom *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
//
staload "libats/ML/SATS/monad_list.sats"
//
(* ****** ****** *)

#include "./SHARE/monad.hats"

(* ****** ****** *)

assume monad_type(a:t0p) = list0(a)

(* ****** ****** *)

implement
{a}{b}
monad_bind
  (xs, fopr) = let
//
implement
list_map$fopr<a><list0(b)>(x) = fopr(x)
//
val xss =
list_map<a><list0(b)>(g1ofg0(xs))
val res =
list_concat<b>
  ($UN.castvwtp1{List(List(b))}(xss))
//
val ((*freed*)) = list_vt_free<list0(b)>(xss)
//
in
  list0_of_list_vt{b}(res)
end // end of [monad_bind]

(* ****** ****** *)

implement
{a1,a2}{b}
monad_bind2
  (xs, ys, fopr) = let
//
implement
list_crosswith$fopr<a1,a2><list0(b)>
  (x, y) = fopr(x, y)
//
val
xss =
list_crosswith<a1,a2><list0(b)>
  (g1ofg0(xs), g1ofg0(ys))
//
val
res =
list_concat<b>
  ($UN.castvwtp1{List(List(b))}(xss))
//
val ((*freed*)) = list_vt_free<list0(b)>(xss)
//
in
  list0_of_list_vt{b}(res)
end // end of [monad_bind2]

(* ****** ****** *)
//
implement
{a}(*tmp*)
monad_return(x) =
  list0_cons{a}(x, list0_nil)
//
(* ****** ****** *)

implement
{a}(*tmp*)
monad_list_list(xs) = (xs)

(* ****** ****** *)

implement
{a}(*tmp*)
monad_list_listize(m0) = (m0)

(* ****** ****** *)
//
implement
{a}(*tmp*)
fprint_monad(out, m0) = fprint_list0<a>(out, m0)
//
(* ****** ****** *)

(* end of [monad_list.hats] *)
