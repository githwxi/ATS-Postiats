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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: October, 2016 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/stream.sats"

(* ****** ****** *)
//
implement
{}(*tmp*)
intgte_stream(n) = f(n) where
{
fun
f(n:int):<!laz> stream(int) =
 $delay(stream_cons(n, f(n+1)))
}
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream2list0(xs) =
list0_of_list_vt(stream2list(xs))
//
(* ****** ****** *)

implement
{a}(*tmp*)
stream_make_list0
  (xs) =
  auxmain(xs) where
{
//
fun
auxmain:
$d2ctype
(
stream_make_list0<a>
) = lam(xs) => $delay
(
case+ xs of
| list0_nil() =>
  stream_nil()
| list0_cons(x, xs) =>
  stream_cons(x, auxmain(xs))
)
//
} (* end of [stream_make_list0] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
stream_make_intrange_lr
  (l, r) =
(
stream_make_intrange_lrd<>(l, r, 1)
)
//
implement
{}(*tmp*)
stream_make_intrange_lrd
  (l, r, d) = let
//
fun
auxmain
(
  l: int
, r: int
, d: int
) :<!laz> stream(int) = $delay
(
if
(l >= r)
then stream_nil()
else stream_cons(l, auxmain(l+d, r, d))
)
//
in
  auxmain(l, r, d)
end // end of [stream_make_intrange_lrd]
//
(* ****** ****** *)
//
implement
{a}{b}
stream_map
  (xs, fopr) =
(
  stream_map_cloref<a><b>(xs, fopr)
)
//
implement
{a}{b}
stream_map_method
  (xs, _) =
(
lam(fopr) => stream_map_cloref<a><b>(xs, fopr)
)
//
(* ****** ****** *)
//
implement
{a}{b}
stream_imap
  (xs, fopr) =
(
  stream_imap_cloref<a><b>(xs, fopr)
)
//
implement
{a}{b}
stream_imap_method
  (xs, _) =
(
lam(fopr) => stream_imap_cloref<a><b>(xs, fopr)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_filter
  (xs, pred) = stream_filter_cloref<a>(xs, pred)
implement
{a}(*tmp*)
stream_filter_method
  (xs) =
(
  lam(pred) => stream_filter_cloref<a>(xs, pred)
)
//
(* ****** ****** *)
//
implement
{res}{x}
stream_scan
  (xs, res, fopr) =
(
stream_scan_cloref<res><x>(xs, res, fopr)
)
//
implement
{res}{x}
stream_scan_method(xs, _) =
(
lam(res, fopr) =>
  stream_scan_cloref<res><x>(xs, res, fopr)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_foreach
  (xs, fwork) =
  stream_foreach_cloref<a>(xs, fwork)
//
implement
{a}(*tmp*)
stream_foreach_method(xs) =
(
  lam(fwork) =>
    stream_foreach_cloref<a>(xs, fwork)
  // end of [lam]
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_iforeach
  (xs, fwork) =
  stream_iforeach_cloref<a>(xs, fwork)
//
implement
{a}(*tmp*)
stream_iforeach_method(xs) =
(
  lam(fwork) =>
    stream_iforeach_cloref<a>(xs, fwork)
  // end of [lam]
)
//
(* ****** ****** *)
//
implement
{res}{a}
stream_foldleft
  (xs, ini, fopr) =
  stream_foldleft_cloref<res><a>(xs, ini, fopr)
//
implement
{res}{a}
stream_foldleft_method
  (xs, _(*TYPE*)) =
  lam(ini, fopr) =>
    stream_foldleft_cloref<res><a>(xs, ini, fopr)
  // end of [lam]
//
(* ****** ****** *)

(* end of [stream.dats] *)
