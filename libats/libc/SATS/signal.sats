(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: April, 2014
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/signal.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "atslib_libc_"
//
(* ****** ****** *)
//
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
typedef pid_t = $TYPES.pid_t
typedef uid_t = $TYPES.uid_t
typedef clock_t = $TYPES.clock_t
//
(*
staload
PTHREAD =
"libats/libc/SATS/pthread.sats"
typedef pthread_t = $PTHREAD.pthread_t
*)
abst@ype
pthread_t0ype =
$extype "pthread_t"
//
typedef pthread_t = pthread_t0ype
//
(* ****** ****** *)
//
// HX: defined in
// [libats/libc/CATS/signal.cats]
//
abst@ype
signum_t0ype =
$extype"signum_t"
//
typedef signum_t = signum_t0ype
//
macdef SIGHUP = $extval (signum_t, "SIGHUP") // 1
macdef SIGINT = $extval (signum_t, "SIGINT") // 2
macdef SIGQUIT = $extval (signum_t, "SIGQUIT") // 3
macdef SIGILL = $extval (signum_t, "SIGILL") // 4
macdef SIGABRT = $extval (signum_t, "SIGABRT") // 6
macdef SIGFPE = $extval (signum_t, "SIGFPE") // 8
macdef SIGKILL = $extval (signum_t, "SIGKILL") // 9
macdef SIGSEGV = $extval (signum_t, "SIGSEGV") // 11
macdef SIGPIPE = $extval (signum_t, "SIGPIPE") // 13
macdef SIGALRM = $extval (signum_t, "SIGALRM") // 14
macdef SIGTERM = $extval (signum_t, "SIGTERM") // 15
macdef SIGUSR1 = $extval (signum_t, "SIGUSR1")
macdef SIGUSR2 = $extval (signum_t, "SIGUSR2")
macdef SIGCHLD = $extval (signum_t, "SIGCHLD")
macdef SIGCONT = $extval (signum_t, "SIGCONT")
macdef SIGSTOP = $extval (signum_t, "SIGSTOP")
macdef SIGTSTP = $extval (signum_t, "SIGTSTP")
macdef SIGTTIN = $extval (signum_t, "SIGTTIN")
macdef SIGTTOU = $extval (signum_t, "SIGTTOU")
//
macdef SIGBUS = $extval (signum_t, "SIGBUS")
macdef SIGTRAP = $extval (signum_t, "SIGTRAP") // 5
//
macdef SIGIO = $extval (signum_t, "SIGIO")
//
(* ****** ****** *)
//
abstype
sighandler_type = ptr
typedef
sighandler_t = sighandler_type
//
macdef SIG_DFL = $extval (sighandler_t, "SIG_DFL")
macdef SIG_IGN = $extval (sighandler_t, "SIG_IGN")
macdef SIG_HOLD = $extval (sighandler_t, "SIG_HOLD")
macdef SIG_ERR = $extval (sighandler_t, "SIG_ERR")
//
castfn sighandler (f: (signum_t) -<fun1> void): sighandler_t
//
(* ****** ****** *)
//
abst@ype
sigset_t0ype =
$extype"sigset_t"
//
typedef sigset_t = sigset_t0ype
//
// HX-2014-04-07:
// errno [EINVAL] is set in case of failure
//
fun
sigemptyset // 0/-1 : succ/fail
(
  set: &sigset_t? >> opt (sigset_t, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"
//
fun
sigfillset // 0/-1 : succ/fail
(
  set: &sigset_t? >> opt (sigset_t, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"
//
fun
sigaddset // 0/-1 : succ/fail
  (set: &sigset_t, sgn: signum_t): int = "mac#%"
//
fun
sigdelset // 0/-1 : succ/fail
  (set: &sigset_t, sgn: signum_t): int = "mac#%"
//
fun
sigismember // 0/1/-1 : false/true/error
  (set: &sigset_t, sgn: signum_t): int = "mac#%"
//
(* ****** ****** *)
//
abst@ype
sigmaskhow_t0ype = int
//
typedef sigmaskhow_t = sigmaskhow_t0ype
//
macdef SIG_BLOCK = $extval (sigmaskhow_t, "SIG_BLOCK")
macdef SIG_UNBLOCK = $extval (sigmaskhow_t, "SIG_UNBLOCK")
macdef SIG_SETMASK = $extval (sigmaskhow_t, "SIG_SETMASK")
//
(* ****** ****** *)
//
abst@ype
sigval_t0ype =
$extype"sigval_t"
typedef sigval_t = sigval_t0ype
//
abst@ype
saflag_t0ype = uint
typedef saflag_t = saflag_t0ype
//
macdef
SA_NOCLDSTOP = $extval (saflag_t, "SA_NOCLDSTOP")
macdef
SA_NOCLDWAIT = $extval (saflag_t, "SA_NOCLDWAIT")
macdef SA_NODEFER = $extval (saflag_t, "SA_NODEFER")
macdef SA_ONSTACK = $extval (saflag_t, "SA_ONSTACK")
macdef SA_RESETHAND = $extval (saflag_t, "SA_RESETHAND")
macdef SA_RESTART = $extval (saflag_t, "SA_RESTART")
macdef SA_SIGINFO = $extval (saflag_t, "SA_SIGINFO")
//
(* ****** ****** *)
//
// HX: this one is deprecated; please use [sigaction]
//
fun signal
  (sgn: signum_t, act: sighandler_t): sighandler_t = "mac#%"
// end of [signal]
//
(* ****** ****** *)
//
typedef
siginfo_struct =
$extype_struct"siginfo_t" of
{
  si_signo= int // signal number
, si_sigerror= int // error value
, si_code= int // signal code
, si_trapno= int // trap number that caused HW signal
, si_pid= pid_t // proc ID of the sending process
, si_uid= uid_t // real user ID of the sending process
, si_status= int // exit value or signal
, si_utime= clock_t // user time consumed
, si_stime= clock_t // system time consumed
, si_value= sigval_t // signal value
, si_int= int // signal (POSIX.1b)
, si_ptr= ptr // signal (POSIX.1b)
, si_overrun= int // timer overrun count (POSIX.1b)
, si_timerid= int // timer ID (POSIX.1b)
, si_addr= ptr // memory location that caused fault
, si_band= int // band event
, si_fd= int // file descriptor
} (* end of [siginfo_struct] *)
//
typedef siginfo = siginfo_struct
//
(* ****** ****** *)
//
typedef
sigaction_struct =
$extype_struct
"atslib_libc_sigaction_struct" of
{
  sa_handler= sighandler_t
, sa_sigaction= (int, &siginfo, ptr) -<fun1> void
, sa_mask= sigset_t
, sa_flags= saflag_t
, sa_restorer= ((*void*)) -<fun1> void
} (* end of [sigaction_struct] *)
//
typedef sigaction = sigaction_struct
//
fun sigaction
(
  sgn: signum_t
, newact: &RD(sigaction)
, oldact: &sigaction? >> opt (sigaction, i==0)
) : #[i:int | i <= 0] int i = "mac#%" // 0/-1 : succ/fail
//
fun sigaction_null
  (sgn: signum_t, newact: &RD(sigaction)): int = "mac#%"
//
(* ****** ****** *)
//
fun kill // 0/-1 : succ/fail // errno set
  (proc: pid_t, sgn: signum_t): int = "mac#%"
//
// HX: killpg (pgrp, sgn) = kill (-pgrp, sgn)
//
fun killpg // 0/-1 : succ/fail // errno set
  (pgrp: pid_t, sgn: signum_t): int = "mac#%"
//
(* ****** ****** *)
//
// HX-2014-04:
// raise(sgn) =
// pthread_kill (pthread_self, sgn)
//
fun raise (signum_t): int = "mac#%"
//
fun pthread_kill // 0/errno : succ/fail
  (tid: pthread_t, sgn: signum_t): int = "mac#%"
//
(* ****** ****** *)
//
// HX-2014-04-07: 0/errno : succ/fail
//
fun sigwait
(
  set: &sigset_t
, sgn: &signum_t? >> opt (signum_t, i==0)
) : #[i:int | i >= 0] int(i) = "mac#%"
//
(* ****** ****** *)
//
// HX-2014-04-07:
// [sigpause] is deprecated
// please use [sigsuspend] instead
//
// always -1: fail // errno set
fun sigpause (sgn: signum_t): int = "mac#%"
//
// HX-2014-04-07:
// always -1: fail // errno set // EINTR is set normally
//
fun sigsuspend (mask: &sigset_t): int = "mac#%"
//
(* ****** ****** *)
//
// HX-2014-04-07:
// 0/-1 : succ/fail // errno set
//
fun sigpending
(
  set: &sigset_t? >> opt (sigset_t, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"
//
//
// HX-2014-04-07:
// 0/-1 : succ/fail // errno set
//
fun siginterrupt (sgn: signum_t, flag: int): int = "mac#%"
//
(* ****** ****** *)
//
(*
//
// HX: print onto stderr
//
*)
fun psignal
  (sgn: signum_t, msg: string): void = "mac#%"
// end of [psignal]
fun strsignal
  (sgn: signum_t) // HX: errno set?
  :<!ref> [l:addr] (strptr(l) -<lin,prf> void | strptr(l)) = "mac#%"
// end of [strsignal]
//
(* ****** ****** *)

(* end of [signal.sats] *)
