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
// Start Time: May, 2013
//
(* ****** ****** *)

%{#
#include "libc/CATS/sys/wait.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

staload
TYPES =
"libc/sys/SATS/types.sats"
typedef pid_t = $TYPES.pid_t

(* ****** ****** *)

absprop
WIFEXITED_p (s:int, b:bool)

fun WEXITSTATUS{s:int}
(
  pf: WIFEXITED_p (s, true) | status: int s
) : int = "mac#%" // end of [WEXITSTATUS]

fun WIFEXITED{s:int}
  (status: int s): [b:bool] (WIFEXITED_p (s, b) | bool b) = "mac#%"
// end of [WIFEXITED]

(* ****** ****** *)

absprop
WIFSIGNALED_p (s:int, b:bool)

fun WTERMSIG{s:int}
(
  pf: WIFSIGNALED_p (s, true) | status: int s
) : int = "mac#%" // end of [WTERMSIG]

fun WIFSIGNALED{s:int}
  (status: int s): [b:bool] (WIFSIGNALED_p (s, b) | bool b) = "mac#%"
// end of [WIFSIGNALED]

(* ****** ****** *)

absprop
WIFSTOPPED_p(s:int, b:bool)

fun WSTOPSIG{s:int}
(
  pf: WIFSTOPPED_p (s, true) | status: int s
) : int = "mac#%" // end of [WSTOPSIG]

fun
WIFSTOPPED
  {s:int}(status: int s)
: [b:bool] (WIFSTOPPED_p(s, b) | bool b) = "mac#%"
// end of [WIFSTOPPED]

(* ****** ****** *)

absprop
WCOREDUMP_p (s:int, b:bool)

fun
WCOREDUMP
  {s:int}(status: int s)
: [b:bool] (WCOREDUMP_p(s, b) | bool(b)) = "mac#%"
// end of [WCOREDUMP]

(* ****** ****** *)

absprop
WIFCONTINUED_p(s:int, b:bool)

fun
WIFCONTINUED
  {s:int}(status: int s)
: [b:bool] (WIFCONTINUED_p(s, b) | bool b) = "mac#%"
// end of [WIFCONTINUED]

(* ****** ****** *)
//
symintr wait
fun wait_void (): pid_t = "mac#%"
fun wait_status (status: &int? >> int): pid_t = "mac#%"
overload wait with wait_void
overload wait with wait_status
//
(* ****** ****** *)

abst@ype
waitopt_t0ype = $extype"ats_int_type"
typedef waitopt = waitopt_t0ype
macdef WNONE = $extval (waitopt, "0")
macdef WNOHANG = $extval (waitopt, "WNOHANG")
macdef WUNTRACED = $extval (waitopt, "WUNTRACED")
macdef WCONTINUED = $extval (waitopt, "WCONTINUED")

fun lor_waitopt_waitopt
  (opt1: waitopt, opt2: waitopt): waitopt
overload lor with lor_waitopt_waitopt

(* ****** ****** *)

fun waitpid
(
  chldpid: pid_t, status: &int? >> int, opt: waitopt
) : pid_t = "mac#%" // end of [waitpid]

(* ****** ****** *)

(* end of [wait.sats] *)
