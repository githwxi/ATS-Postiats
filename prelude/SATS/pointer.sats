(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [pointer.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

praxi ptr_is_gtez
  {l:addr} (p: ptr l):<> [l >= null] void
// end of [ptr_is_gtez]

(* ****** ****** *)

fun ptr_is_null {l:addr}
  (p: ptr l):<> bool (l==null) = "atspre_ptr_is_null"
// end of [ptr_is_null]

fun ptr_isnot_null {l:addr}
  (p: ptr):<> bool (l > null) = "atspre_ptr_isnot_null"
// end of [ptr_isnot_null]

(* ****** ****** *)
//
// implemented in [prelude/DATS/pointer.dats]
//
fun{a:t@ype}
ptr_get {l:addr} (pf: !a @ l | p: ptr l):<> a

fun{a:t@ype}
ptr_set {l:addr}
  (pf: !a? @ l >> a @ l | p: ptr l, x: a):<!wrt> void
// end of [ptr_set]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [pointer.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [pointer.sats] *)
