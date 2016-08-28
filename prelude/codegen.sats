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
//
// Author of the file:
// Hongwei Xi (gmhwxiATgmailDOTcom)
// Start Time: August, 2016
//
(* ****** ****** *)
//
// HX: For programming productivity, my bet is on meta-programming...
//
(* ****** ****** *)
//
// HX-2016-08-24:
// For #codegen2(absrec, ...)
//
abstype absrec_get(t0ype)
abstype absrec_set(t0ype)
abstype absrec_getset(t0ype)
//
abstype absrec_exch(vt0ype)
//
abstype absrec_vtget(vt0ype)
abstype absrec_getref(vt0ype)
//
typedef get(a:t0ype) = absrec_get(a)
typedef set(a:t0ype) = absrec_set(a)
typedef getset(a:t0ype) = absrec_getset(a)
//
typedef exch(a:vt0ype) = absrec_exch(a)
//
typedef vtget(a:vt0ype) = absrec_vtget(a)
//
typedef getref(a:vt0ype) = absrec_getref(a)
//
(* ****** ****** *)

// (*
typedef
absrec_get_fun(trec: vt@ype, res: t@ype) = (!trec) -<> res
typedef
absrec_set_fun(trec: vt@ype, res: t@ype) = (!trec, res) -<ref> void
typedef
absrec_exch_fun(trec: vt@ype, res: t@ype) = (!trec, res) -<ref> res
typedef
absrec_vtget_fun
  (trec: vt@ype, res: vt@ype) = (!trec, res) -<ref> (minus(trec, res) | res)
// *)

(* ****** ****** *)

(* end of [codegen.sats] *)
