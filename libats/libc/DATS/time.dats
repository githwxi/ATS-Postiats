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
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: May, 2012
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
#define
ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define
ATS_EXTERN_PREFIX "atslib_libc_" // prefix for external names
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/time.sats"
//
(* ****** ****** *)

implement
{}(*tmp*)
ctime_r_gc (tval) = let
//
val bsz = g1i2u(CTIME_BUFSZ)
val (pf, pfgc | p) = malloc_gc (bsz)
//
val p1 = ctime_r (pf | tval, p)
//
in
//
if p1 > 0 then let
  prval ctime_v_succ (pf) = pf
in
  $UN.castvwtp0{Strptr1}((pf, pfgc | p))
end else let
  prval ctime_v_fail (pf) = pf
  val () = mfree_gc (pf, pfgc | p)
in
  strptr_null ()
end // end of [if]
//
end // end of [ctime_r_gc]

(* ****** ****** *)

(* end of [stdlib.dats] *)