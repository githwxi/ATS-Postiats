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
//
staload "libats/SATS/qlist.sats"
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/qlistref.sats"
//
(* ****** ****** *)
//
#define qencode qlist_encode
#define qdecode qlist_decode
//
extern
castfn
qlist_encode
  {a:vt0p}: qlist(a) -<> qlistref(a)
extern
castfn
qlist_decode
  {a:vt0p}: qlistref(a) -<> qlist(a)
//
(* ****** ****** *)

implement
{}(*tmp*)
qlistref_make_nil
  {a}((*void*)) =
  qencode(qlist_make_nil())
//
(* ****** ****** *)

implement
{a}(*tmp*)
qlistref_insert
  (q0, x) = () where
{
//
val q0 = qdecode(q0)
//
val () =
$effmask_wrt
  (qlist_insert<a>(q0, x))
//
prval () = $UN.cast2void(q0)
//
} (* end of [qlistref_insert] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
qlistref_takeout_opt
  (q0) = opt where
{
//
val q0 = qdecode(q0)
//
val opt =
$effmask_wrt
  (qlist_takeout_opt(q0))
//
prval () = $UN.cast2void(q0)
//
} (* end of [qlistref_takeout_opt] *)
//
(* ****** ****** *)

(* end of [qlistref.dats] *)
