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
staload "libats/ML/SATS/stream_vt.sats"

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
