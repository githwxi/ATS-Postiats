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
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: March, 2013
//
(* ****** ****** *)

%{#
#include "libc/CATS/sys/types.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_EXTERN_PREFIX "atslib_"
//
(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

abst@ype
time_t0ype = $extype"atslib_time_type"
typedef time_t = time_t0ype // = its C-counterpart

(* ****** ****** *)
//
fun
time2lint (t: time_t):<> lint = "mac#%"
fun
time2double (t: time_t):<> double = "mac#%"
//
(* ****** ****** *)
//
fun
lt_time_time
  (t1: time_t, t2: time_t):<> bool = "mac#%"
fun
lte_time_time
  (t1: time_t, t2: time_t):<> bool = "mac#%"
fun
gt_time_time
  (t1: time_t, t2: time_t):<> bool = "mac#%"
fun
gte_time_time
  (t1: time_t, t2: time_t):<> bool = "mac#%"
//
overload < with lt_time_time
overload <= with lte_time_time
overload > with gt_time_time
overload >= with gte_time_time
//
fun
eq_time_time
  (t1: time_t, t2: time_t):<> bool = "mac#%"
fun
neq_time_time
  (t1: time_t, t2: time_t):<> bool = "mac#%"
//
overload = with eq_time_time
overload <> with neq_time_time
overload != with neq_time_time
//
(* ****** ****** *)
//
abst@ype
clock_t0ype = $extype"atslib_clock_type"
typedef clock_t = clock_t0ype // = its C-counterpart
abst@ype
clockid_t0ype = $extype"atslib_clockid_type"
typedef clockid_t = clockid_t0ype // = its C-counterpart
//
(* ****** ****** *)

fun clock2lint (t: clock_t):<> lint = "mac#%"
fun clock2double (t: clock_t):<> double = "mac#%"

(* ****** ****** *)

abst@ype
mode_t0ype = $extype"atslib_mode_type"
typedef mode_t = mode_t0ype // = its C-counterpart

(* ****** ****** *)
//
fun
mode2int (m: mode_t):<> int = "mac#%"
fun
mode2uint (m: mode_t):<> uint = "mac#%"
//
(* ****** ****** *)
//
fun
eq_mode_mode
  (m1: mode_t, m2: mode_t):<> bool = "mac#%"
fun
neq_mode_mode
  (m1: mode_t, m2: mode_t):<> bool = "mac#%"
//
overload = with eq_mode_mode
overload != with neq_mode_mode
overload <> with neq_mode_mode
//
(* ****** ****** *)

fun lor_mode_mode
  (m1: mode_t, m2: mode_t):<> mode_t = "mac#%"
overload lor with lor_mode_mode

fun land_mode_mode
  (m1: mode_t, m2: mode_t):<> mode_t = "mac#%"
overload land with land_mode_mode

(* ****** ****** *)

abst@ype
dev_t0ype = $extype"atslib_dev_type"
typedef dev_t = dev_t0ype // = its C-counterpart

(* ****** ****** *)

abst@ype
ino_t0ype = $extype"atslib_ino_type"
typedef ino_t = ino_t0ype // = its C-counterpart

(* ****** ****** *)

abst@ype
nlink_t0ype = $extype"atslib_nlink_type"
typedef nlink_t = nlink_t0ype // = its C-counterpart

(* ****** ****** *)

abst@ype
pid_t0ype = $extype"atslib_pid_type"
typedef pid_t = pid_t0ype // = its C-counterpart
castfn pid2int (x: pid_t):<> int
castfn pid2lint (x: pid_t):<> lint

(* ****** ****** *)

abst@ype
uid_t0ype = $extype"atslib_uid_type"
typedef uid_t = uid_t0ype // = its C-counterpart
abst@ype
gid_t0ype = $extype"atslib_gid_type"
typedef gid_t = gid_t0ype // = its C-counterpart

(* ****** ****** *)

abst@ype
off_t0ype = $extype"atslib_off_type"
typedef off_t = off_t0ype // = its C-counterpart

(* ****** ****** *)

abst@ype
blkcnt_t0ype = $extype"atslib_blkcnt_type"
typedef blkcnt_t = blkcnt_t0ype // = its C-counterpart
abst@ype
blkcnt_t0ype = $extype"atslib_blkcnt_type"
typedef blkcnt_t = blkcnt_t0ype // = its C-counterpart

(* ****** ****** *)

abst@ype
blksize_t0ype = $extype"atslib_blksize_type"
typedef blksize_t = blksize_t0ype // = its C-counterpart
abst@ype
blksize_t0ype = $extype"atslib_blksize_type"
typedef blksize_t = blksize_t0ype // = its C-counterpart

(* ****** ****** *)

fun lint2off (x: lint):<> off_t = "mac#%"
fun off2lint (x: off_t):<> lint = "mac#%"
fun size2off (x: size_t):<> off_t = "mac#%"
fun off2size (x: off_t):<> size_t = "mac#%"

(* ****** ****** *)
//
absview fildes_view (fd: int)
viewdef fildes_v (i:int) = fildes_view (i)
//
absvt@ype
fildes_vtype (fd: int) = int
//
vtypedef
fildes (fd: int) = fildes_vtype (fd)
//
vtypedef Fildes = [fd:int] fildes (fd)
vtypedef Fildes0 = [fd:int | fd >= 0] fildes (fd)
//
(* ****** ****** *)

castfn
fildes_decode
  {fd:nat} (fd: fildes (fd)):<> (fildes_v (fd) | int fd)
// end of [fildes_decode]

castfn fildes_encode
  {fd:nat} (pf: fildes_v (fd) | fd: int fd):<> fildes (fd)
// end of [fildes_encode]

(* ****** ****** *)

abst@ype
useconds_t = // microseconds
$extype"atslib_useconds_type"
castfn usec2lint (x: useconds_t):<> lint

abst@ype
suseconds_t = // microseconds
$extype"atslib_suseconds_type"
castfn susec2lint (x: suseconds_t):<> lint

(* ****** ****** *)

abst@ype
pthread_t =
$extype"atslib_pthread_type"
castfn pthread2lint (x: pthread_t):<> lint

(* ****** ****** *)

(* end of [types.sats] *)
