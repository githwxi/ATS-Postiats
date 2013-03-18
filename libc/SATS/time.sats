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
#include "libc/CATS/time.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

staload
TYPES = "libc/sys/SATS/types.sats"
typedef time_t = $TYPES.time_t

(* ****** ****** *)

fun time2lint (t: time_t):<> lint = "mac#%"
fun time2double (t: time_t):<> double = "mac#%"

fun difftime
  (fi: time_t, st: time_t) :<> double = "mac#%"
// end of [difftime]

(* ****** ****** *)
//
symintr time
//
fun time_get
  ():<> time_t = "mac#%"
fun time_getset
(
  t: &time_t? >> opt (time_t, b)
) :<> #[b:bool] bool (b) = "mac#%"
//
overload time with time_get
overload time with time_getset
//
(* ****** ****** *)

fun ctime
(
  t: &time_t
) :<!ref> [l:addr] vttakeout (void, strptr l) = "mac#%" // endfun

(* ****** ****** *)
//
#define CTIME_BUFSZ 26
//
dataview
ctime_v (m:int, addr, addr) =
  | {l:addr}
    ctime_v_fail (m, l, null) of b0ytes_v (l, m)
  | {l:agz}
    ctime_v_succ (m, l, l) of strbuf_v (l, m, CTIME_BUFSZ-1)
//
fun ctime_r
  {l:addr}{m:int | m >= CTIME_BUFSZ}
(
  !b0ytes_v (l, m) >> ctime_v (m, l, l1) | &time_t, ptr (l)
) :<!wrt> #[l1:addr] ptr (l1) = "mac#%" // end of [ctime_r]
//
fun{
} ctime_r_gc (&time_t):<!wrt> Strptr0 // end of [ctime_r_gc]
//
(* ****** ****** *)

typedef
tm_struct =
$extype_struct "atslib_tm_struct_type" of
{
  tm_sec= int
, tm_min= int
, tm_hour= int
, tm_mon= int (* month *)
, tm_year= int (* year *)
, tm_wday= int (* day of the week *)
, tm_mday= int (* day of the month *)
, tm_yday= int (* day in the year *)
, tm_isdst= int (* daylight saving time *)
} // end of [tm_struct]

(* ****** ****** *)

(* end of [time.sats] *)
