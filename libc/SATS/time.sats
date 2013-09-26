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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
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

#define RD(x) x // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)
//
staload
TYPES = "libc/sys/SATS/types.sats"
//
typedef time_t = $TYPES.time_t
typedef clock_t = $TYPES.clock_t
typedef clockid_t = $TYPES.clockid_t
//
macdef
CLOCKS_PER_SEC = $extval (clock_t, "CLOCKS_PER_SEC")
//
macdef
CLOCK_REALTIME = $extval (clockid_t, "CLOCK_REALTIME")
macdef
CLOCK_MONOTONIC = $extval (clockid_t, "CLOCK_MONOTONIC")
//
macdef
CLOCK_THREAD_CPUTIME_ID = $extval (clockid_t, "CLOCK_THREAD_CPUTIME_ID")
macdef
CLOCK_PROCESS_CPUTIME_ID = $extval (clockid_t, "CLOCK_PROCESS_CPUTIME_ID")
//
(* ****** ****** *)

fun difftime
(
  finish: time_t, start: time_t
) :<> double = "mac#%" // endfun

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

fun ctime // non-reentrant
(
  t: &RD(time_t) // read-only
) :<!ref> [l:addr] vttakeout0 (strptr l) = "mac#%" // endfun

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
fun ctime_r // reentrant-version
  {l:addr}{m:int | m >= CTIME_BUFSZ}
(
  !b0ytes_v (l, m) >> ctime_v (m, l, l1) | &RD(time_t), ptr (l)
) :<!wrt> #[l1:addr] ptr (l1) = "mac#%" // end of [ctime_r]
//
fun{
} ctime_r_gc (&RD(time_t)):<!wrt> Strptr0 // end of [ctime_r_gc]
//
(* ****** ****** *)

typedef
tm_struct =
$extype_struct "atslib_tm_struct_type" of
{
  tm_sec= int // natLt(60)
, tm_min= int // natLt(60)
, tm_hour= int // natLt(24)
, tm_mon= int (* month *) // natLt(12)
, tm_year= int (* year *) // starting from 1900
, tm_wday= int (* day of the week *) // natLt(7)
, tm_mday= int (* day of the month *)
, tm_yday= int (* day in the year *)
, tm_isdst= int (* daylight saving time *) // yes/no: 1/0
} // end of [tm_struct]

(* ****** ****** *)

fun mktime (tm: &RD(tm_struct)):<> time_t = "mac#%"

(* ****** ****** *)

fun asctime
(
  tm: &RD(tm_struct)
) :<!ref> [l:addr] vttakeout0 (strptr l) = "mac#%"

(* ****** ****** *)

/*
size_t
strftime
(
  char *s, size_t max, const char *format, const struct tm *tm
) ; // end of [strftime]
*/
fun strftime
  {l:addr}{m:pos} (
  pf: !b0ytes(m) @ l >> strbuf(m, n) @ l
| p: ptr l, m: size_t m, fmt: string, tm: &RD(tm_struct)
) :<> #[n:nat | n < m] size_t n = "mac#%" // endfun

(* ****** ****** *)

fun gmtime // non-reentrant
(
  tval: &RD(time_t)
) :<!ref>
[
  l:addr
] (
  option_v (vtakeout0 (tm_struct@l), l > null) | ptr l
) = "mac#%" // end of [gmtime]

fun gmtime_r // reentrant-version
(
  tval: &RD(time_t), tm: &tm_struct? >> opt (tm_struct, l > null)
) :<> #[l:addr] ptr (l) = "mac#%" // endfun

(* ****** ****** *)

fun localtime // non-reentrant
(
  tval: &RD(time_t) // read-only
) :<!ref>
[
  l:addr
] (
  option_v (vtakeout0 (tm_struct@l), l > null) | ptr l
) = "mac#%" // end of [localtime]

fun localtime_r // reentrant-version
(
  tval: &RD(time_t), tm: &tm_struct? >> opt (tm_struct, l > null)
) :<> #[l:addr] ptr (l) = "mac#%" // endfun

(* ****** ****** *)

fun tzset ():<!ref> void = "mac#%"

(* ****** ****** *)

fun clock (): clock_t = "mac#%" // -1 for error

(* ****** ****** *)

typedef
timespec =
$extype_struct "atslib_timespec_type" of
{
  tv_sec= time_t (*secs*), tv_nsec= lint (*nanosecs*)
} // end of [extype_struct] // end of [timespec]

(* ****** ****** *)

fun nanosleep
(
  tms: &RD(timespec), rem: &timespec? >> opt (timespec, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // endfun

fun nanosleep_null (tms: &RD(timespec)): int = "mac#%" // endfun

(* ****** ****** *)
//
// HX: linking with -lrt is needed for these functions
//
fun clock_getres
(
  id: clockid_t, res: &timespec? >> opt (timespec, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // endfun
//
fun clock_gettime
(
  id: clockid_t, tp: &timespec? >> opt (timespec, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // endfun
//
// HX: this one requires SUPERUSER previlege
//
fun clock_settime (id: clockid_t, tp: &RD(timespec)): int = "mac#%"
//
(* ****** ****** *)

(* end of [time.sats] *)
