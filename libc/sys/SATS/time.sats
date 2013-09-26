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
// Start Time: August, 2013
//
(* ****** ****** *)

%{#
#include "libc/sys/CATS/time.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload
TYPES = "libc/sys/SATS/types.sats"
typedef time_t = $TYPES.time_t
typedef suseconds_t = $TYPES.suseconds_t

(* ****** ****** *)

typedef
timeval_struct =
$extype_struct"atslib_timeval_type" of
{ // = struct timeval
  tv_sec= time_t // seconds  
, tv_usec=  suseconds_t // microseconds
} // end of [timeval_struct]
typedef timeval = timeval_struct

(* ****** ****** *)

(*
//
// HX: these macros seem only available in BSD
//
fun timerisset (tv: &timeval):<> bool = "mac#%"
fun timerclear (tv: &timeval >> _):<> bool = "mac#%"
*)

(* ****** ****** *)

typedef
timezone_struct =
$extype_struct"atslib_timezone_type" of
{ // = struct timezone
  tz_minuteswest= int // minutes west of GMT
, tz_dsttime= int // nonzero if DST is ever in effect
} // end of [timezone_struct]
typedef timezone = timezone_struct

(* ****** ****** *)
//
symintr gettimeofday
//
fun gettimeofday_tv
(
  tv: &timeval? >> opt (timeval, i==0)
) :<> #[i:int | i <= 0] int(i) = "mac#%"
overload gettimeofday with gettimeofday_tv
//
fun gettimeofday_tz
(
  tz: &timezone? >> opt (timezone, i==0)
) :<> #[i:int | i <= 0] int(i) = "mac#%"
overload gettimeofday with gettimeofday_tz
//
(* ****** ****** *)
//
symintr settimeofday
//
fun settimeofday_tv
  (tv: &timeval):<> [i:int | i <= 0] int(i) = "mac#%"
overload settimeofday with settimeofday_tv
//
fun settimeofday_tz
  (tz: &timezone):<> [i:int | i <= 0] int(i) = "mac#%"
overload settimeofday with settimeofday_tz
//
fun settimeofday_tvtz
  (tv: &timeval, tz: &timezone):<> [i:int | i <= 0] int(i) = "mac#%"
overload settimeofday with settimeofday_tvtz
//
(* ****** ****** *)

fun utimes
( // -1 on error // errno set
  path: string, buf: &(@[timeval][2])
) : int = "mac#%" // end of [utimes]

fun futimes {fd:nat}
( // -1 on error // errno set
  fd: int (fd), buf: &(@[timeval][2])
) : int = "mac#%" // end of [futimes]

fun futimesat
( // -1 on error // errno set
  dirfd: int, path: string, buf: &(@[timeval][2])
) : int = "mac#%" // end of [futimesat]

(* ****** ****** *)

abst@ype
itimerknd_t0ype = int
typedef itimerknd = itimerknd_t0ype
macdef ITIMER_REAL = $extval (itimerknd, "ITIMER_REAL")
macdef ITIMER_VIRTUAL = $extval (itimerknd, "ITIMER_VIRTUAL")
macdef ITIMER_PROF = $extval (itimerknd, "ITIMER_PROF")

typedef
itimerval_struct =
$extype_struct"atslib_itimerval_type" of
{
  it_interval= timeval, it_value= timeval
} // end of [itimerval_struct]
typedef itimerval = itimerval_struct

(* ****** ****** *)
//
// HX: -1/0 : succ/fail // errno set
//
fun getitimer
(
  which: itimerknd
, itval: &itimerval? >> opt (itimerval, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // endfun

fun setitimer
(
  which: itimerknd, itval: &itimerval
, itval_old: &itimerval? >> opt (itimerval, i==0)
) : #[i:int | i <= 0] int(i) = "mac#%" // endfun

fun setitimer_null
  (which: itimerknd, itval: &itimerval): int = "mac#%"
// end of [setitimer_null]

(* ****** ****** *)

(* end of [time.sats] *)
