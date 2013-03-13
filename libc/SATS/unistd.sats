(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)

(* ****** ****** *)

%{#
#include "libc/CATS/unistd.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define SHR(x) x // SHARED // HX: for commenting
#define NSH(x) x // NSHARED // HX: for commenting

(* ****** ****** *)

typedef interr = int

(* ****** ****** *)

/*
int close (int);
*/
fun close (fd: int): interr = "mac#%"
fun close_exn (fd: int): void = "mac#%"

(* ****** ****** *)

fun execv {n:pos}{l:addr}
(
  pf: !parray_v (string, l, n) | path: NSH(string), argv: ptr l
) : intLt(0) = "mac#atslib_execv"
fun execv_unsafe // HX: for failure, ~1 is returned
  (path: NSH(string), argv: ptr): intLt(0) = "mac#atslib_execv"

fun execvp {n:pos}{l:addr}
(
  pf: !parray_v (string, l, n) | fname: NSH(string), argv: ptr l
) : intLt(0) = "mac#atslib_execvp"
fun execvp_unsafe // HX: for failure, ~1 is returned
  (fname: NSH(string), argv: ptr): intLt(0) = "mac#atslib_execvp"

(* ****** ****** *)
/*
int execve(const char *filename, char *const argv[], char *const envp[]);
*/
fun execve
  {n1,n2:pos}{l1,l2:addr}
(
  pf1: !parray_v (string, l1, n1)
, pf2: !parray_v (string, l2, n2)
| fname: NSH(string), argv: ptr l1, envp: ptr l2
) : intLt(0) = "mac#atslib_execve"
fun execve_unsafe // HX: for failure, ~1 is returned
  (fname: NSH(string), argv: ptr, envp: ptr): intLt(0) = "mac#atslib_execve"
// end of [execve_unsafe]

(* ****** ****** *)

/*
void encrypt(char block[64], int edflag);
*/
fun encrypt
(
  block: &(@[char][64]), edflag: int
) :<!ref> void = "mac#atslib_encrypt"

(* ****** ****** *)

dataview
getcwd_v
(
  m:int, l:addr, addr
) =
  | {l>null} {n:nat}
    getcwd_v_succ (m, l, l) of strbuf (l, m, n)
  | getcwd_v_fail (m, l, null) of b0ytes (m) @ (l)
// end of [getcwd_v]

fun getcwd
  {m:nat} {l:addr}
(
  pf: !b0ytes (m) @ l >> getcwd_v (m, l, l1) | p: ptr l, m: size_t m
) : #[l1:addr] ptr (l1) = "mac#%" // end of [getcwd]

fun getcwd_gc (): Strptr1 = "mac#%" // HX: this is a convenient function

(* ****** ****** *)

/*
int unlink(const char *pathname);
*/
fun unlink (path: NSH(string)): interr = "mac#%"
fun unlink_exn (path: NSH(string)): void = "mac#%"

(* ****** ****** *)

(* end of [unistd.sats] *)
