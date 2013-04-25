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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: April, 2013
//
(* ****** ****** *)

%{#
#include "libc/CATS/math.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define RD(x) x // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)

macdef M_E = 2.7182818284590452354	// e
macdef M_PI = 3.14159265358979323846	// pi
macdef M_PI_2 = 1.57079632679489661923	// pi/2
macdef M_PI_4 = 0.78539816339744830962	// pi/4

(* ****** ****** *)

macdef INFINITY = $extval (float, "INFINITY")

(* ****** ****** *)
//
fun{a:t@ype} ceil (x: INV(a)):<> a
//
fun ceil_float (f: float):<> float = "mac#%"
fun ceil_double (d: double):<> double = "mac#%"
fun ceil_ldouble (ld: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)
//
fun{a:t@ype} floor (x: INV(a)):<> a
//
fun floor_float (f: float):<> float = "mac#%"
fun floor_double (d: double):<> double = "mac#%"
fun floor_ldouble (ld: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)
//
fun{a:t@ype} round (x: INV(a)):<> a
//
fun round_float (f: float):<> float = "mac#%"
fun round_double (d: double):<> double = "mac#%"
fun round_ldouble (ld: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)
//
fun{a:t@ype} trunc (x: INV(a)):<> a
//
fun trunc_float (f: float):<> float = "mac#%"
fun trunc_double (d: double):<> double = "mac#%"
fun trunc_ldouble (ld: ldouble):<> ldouble = "mac#%"
//
(* ****** ****** *)

(* end of [math.sats] *)
