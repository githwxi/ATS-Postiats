(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmmhwxiATgmailDOTcom *)
(* Start time: October, 2016 *)

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.ML"
#define
ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
fun
{a:t0p}{b:t0p}
stream_map_method
(
  stream(a), TYPE(b)
) (fopr: (a) -<cloref> b):<!laz> stream(b)
//
overload .map with stream_map_method
//
(* ****** ****** *)
//
fun
{a:t0p}{b:t0p}
stream_imap_method
(
  stream(a), TYPE(b)
) (fopr: (intGte(0), a) -<cloref> b):<!laz> stream(b)
//
overload .imap with stream_imap_method
//
(* ****** ****** *)
//
fun
{a:t0p}
stream_filter_method
  (xs: stream(a))
  (pred: (a) -<cloref> bool):<!laz> stream(a)
//
overload .filter with stream_filter_method
//
(* ****** ****** *)
//
fun{
res:t0p}{x:t0p
} stream_scan_method
(
  stream(INV(x)), TYPE(res))(res, (res, x) -<cloref> res
) :<!laz> stream(res) // end-of-function
//
overload .scan with stream_scan_method
//
(* ****** ****** *)
//
fun
{a:t0p}
stream_foreach_method
  (xs: stream(a))(fwork: (a) -<cloref1> void): void
//
overload .foreach with stream_foreach_method
//
(* ****** ****** *)
//
fun{
res:vt0p}{a:t0p
} stream_foldleft_method
  (stream(a), TYPE(res))(res, (res, a) -<cloref1> res): res
//
overload .foldleft with stream_foldleft_method
//
(* ****** ****** *)

(* end of [stream.sats] *)
