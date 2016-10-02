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
staload "libats/ML/SATS/stream.sats"

(* ****** ****** *)
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
stream_filter_method(xs) =
  lam(pred) => stream_filter_cloref<a>(xs, pred)
//
(* ****** ****** *)
//
implement
{res}{x}
stream_scan_method(xs, _) =
  lam(res, fopr) =>
  stream_scan_cloref<res><x>(xs, res, fopr)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stream_foreach_method(xs) =
  lam(fwork) => stream_foreach_cloref<a>(xs, fwork)
//
(* ****** ****** *)

(* end of [stream.dats] *)
