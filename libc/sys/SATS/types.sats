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
// Start Time: March, 2013
//
(* ****** ****** *)

%{#
#include "libc/sys/CATS/types.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

abst@ype
time_t0ype = $extype"atslib_time_type"
typedef time_t = time_t0ype // = its C-counterpart

(* ****** ****** *)

fun time2lint (t: time_t):<> lint = "mac#%"
fun time2double (t: time_t):<> double = "mac#%"

(* ****** ****** *)
//
fun lt_time_time (t1: time_t, t2: time_t):<> bool = "mac#%"
fun lte_time_time (t1: time_t, t2: time_t):<> bool = "mac#%"
overload < with lt_time_time
overload <= with lte_time_time
//
fun gt_time_time (t1: time_t, t2: time_t):<> bool = "mac#%"
fun gte_time_time (t1: time_t, t2: time_t):<> bool = "mac#%"
overload > with gt_time_time
overload >= with gte_time_time
//
fun eq_time_time (t1: time_t, t2: time_t):<> bool = "mac#%"
fun neq_time_time (t1: time_t, t2: time_t):<> bool = "mac#%"
overload = with eq_time_time
overload <> with neq_time_time
overload != with neq_time_time
//
(* ****** ****** *)

abst@ype
clock_t0ype = $extype"atslib_clock_type"
typedef clock_t = clock_t0ype // = its C-counterpart

(* ****** ****** *)

fun clock2lint (t: clock_t):<> lint = "mac#%"
fun clock2double (t: clock_t):<> double = "mac#%"

(* ****** ****** *)

abst@ype
clockid_t0ype = $extype"atslib_clockid_type"
typedef clockid_t = clockid_t0ype // = its C-counterpart

(* ****** ****** *)

(* end of [types.sats] *)
