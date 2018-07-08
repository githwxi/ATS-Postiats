(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: October, 2016 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
#staload "libats/ML/SATS/basis.sats"
#staload "libats/ML/SATS/list0.sats"
#staload "libats/ML/SATS/list0_vt.sats"
#staload "libats/ML/SATS/stream_vt.sats"
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream2list0_vt
  (xs) =
(
list0_vt2t
(g0ofg1(stream2list_vt<a>(xs)))
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
intGte_stream_vt(n) = f(n) where
{
fun
f(n:int):<!laz> stream_vt(int) =
 $ldelay(stream_vt_cons(n, f(n+1)))
}
//
(* ****** ****** *)

implement
{a}(*tmp*)
stream_vt_make_list0
  (xs) =
  auxmain(xs) where
{
//
fun
auxmain:
$d2ctype
(
stream_vt_make_list0<a>
) = lam(xs) => $ldelay
(
case+ xs of
| list0_nil() =>
  stream_vt_nil()
| list0_cons(x, xs) =>
  stream_vt_cons(x, auxmain(xs))
)
//
} (* end of [stream_vt_make_list0] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
stream_vt_make_intrange_lr
  (l, r) =
(
stream_vt_make_intrange_lrd<>(l, r, 1)
)
//
implement
{}(*tmp*)
stream_vt_make_intrange_lrd
  (l, r, d) = let
//
fun
auxmain
(
  l: int
, r: int
, d: int
) :<!laz> stream_vt(int) = $ldelay
(
if
(l >= r)
then stream_vt_nil()
else stream_vt_cons(l, auxmain(l+d, r, d))
)
//
in
  auxmain(l, r, d)
end // end of [stream_vt_make_intrange_lrd]
//
(* ****** ****** *)
//
implement
{a}{b}
stream_vt_map_method
  (xs, _) =
(
llam(fopr) => stream_vt_map_cloptr<a><b>(xs, fopr)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_vt_filter_method
  (xs) =
(
  llam(pred) => stream_vt_filter_cloptr<a>(xs, pred)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_vt_foreach_method
  (xs) =
(
llam(fwork) => stream_vt_foreach_cloptr<a>(xs, fwork)
)
//
implement
{a}(*tmp*)
stream_vt_rforeach_method
  (xs) =
(
llam(fwork) => stream_vt_rforeach_cloptr<a>(xs, fwork)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_vt_iforeach_method
  (xs) =
(
llam(fwork) => stream_vt_iforeach_cloptr<a>(xs, fwork)
)
//
(* ****** ****** *)
//
implement
{res}{a}
stream_vt_foldleft_method
  (xs, _(*TYPE*)) =
(
llam(ini, fwork) => stream_vt_foldleft_cloptr<res><a>(xs, ini, fwork)
)
//
implement
{res}{a}
stream_vt_ifoldleft_method
  (xs, _(*TYPE*)) =
(
llam(ini, fwork) => stream_vt_ifoldleft_cloptr<res><a>(xs, ini, fwork)
)
//
(* ****** ****** *)

(* end of [stream_vt.dats] *)
