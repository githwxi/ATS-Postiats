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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: April, 2012 *)

(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/unistd.cats"
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

#define SHR(x) x // SHARED // HX: for commenting
#define NSH(x) x // NSHARED // HX: for commenting

(* ****** ****** *)

typedef interr = int

(* ****** ****** *)
//
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
typedef off_t = $TYPES.off_t
//
typedef pid_t = $TYPES.pid_t
typedef uid_t = $TYPES.uid_t
typedef gid_t = $TYPES.gid_t
//
stadef fildes_v = $TYPES.fildes_v
//
vtypedef
fildes (i:int) = $TYPES.fildes (i)
//
vtypedef Fildes = $TYPES.Fildes
vtypedef Fildes0 = $TYPES.Fildes0
//
(* ****** ****** *)

macdef STDIN_FILENO = $extval(int, "STDIN_FILENO")
macdef STDOUT_FILENO = $extval(int, "STDOUT_FILENO")
macdef STDERR_FILENO = $extval(int, "STDERR_FILENO")

(* ****** ****** *)
/*
int close (int);
*/
symintr close
symintr close_exn
//
fun close0 (fd: int): interr = "mac#%"
//
// HX-2013-03-25: should this be moved to unistd.sats?
//
dataview
close_v (fd:int, int) =
  | close_v_succ (fd, 0) of ()
  | {i:int | i < 0} close_v_fail (fd, i) of fildes_v (fd)
//
fun close1{fd:nat}
  (fd: fildes (fd)): [i:int] (close_v (fd, i) | int i) = "mac#%"
//
overload close with close0
overload close with close1
//
fun close0_exn (fd: int): void = "ext#%"
fun close1_exn (fd: Fildes0):<!exn> void = "ext#%"
//
overload close_exn with close0_exn
overload close_exn with close1_exn
//
(* ****** ****** *)

fun dup (fildes: int): int = "mac#%"
fun dup_fildes (fd: !Fildes0): Fildes = "mac#%"

(* ****** ****** *)
//
fun dup2
  (fildes: int, fildes2: int): int = "mac#%"
//
// HX-2013-05:
// this one requires that [fd2] be not in use
//
fun dup2_fildes{fd2:nat}
  (fd: !Fildes0, fd2: int (fd2)): Fildes = "mac#%"
//
(* ****** ****** *)
//
// HX: this one requires -D_GNU_SOURCE
//
fun dup3
  (fildes: int, fildes2: int, flags: int): int = "mac#%"
//
(* ****** ****** *)
//
fun
execv
{n:pos}{l:addr}
(
  pf: !parray_v (string, l, n) | path: NSH(string), argv: ptr l
) : intLt(0) = "mac#atslib_libc_execv"
fun
execv_unsafe // HX: for failure, ~1 is returned
  (path: NSH(string), argv: ptr): intLt(0) = "mac#atslib_libc_execv"
//
fun
execvp
{n:pos}{l:addr}
(
  pf: !parray_v (string, l, n) | fname: NSH(string), argv: ptr l
) : intLt(0) = "mac#atslib_libc_execvp"
fun
execvp_unsafe // HX: for failure, ~1 is returned
  (fname: NSH(string), argv: ptr): intLt(0) = "mac#atslib_libc_execvp"
//
(* ****** ****** *)
/*
int execve(const char *filename, char *const argv[], char *const envp[]);
*/
fun
execve
{n1,n2:pos}{l1,l2:addr}
(
  pf1: !parray_v (string, l1, n1)
, pf2: !parray_v (string, l2, n2)
| fname: NSH(string), argv: ptr l1, envp: ptr l2
) : intLt(0) = "mac#atslib_libc_execve"
fun
execve_unsafe // HX: for failure, ~1 is returned
  (fname: NSH(string), argv: ptr, envp: ptr): intLt(0) = "mac#atslib_libc_execve"
// end of [execve_unsafe]

(* ****** ****** *)

/*
void
encrypt(char block[64], int edflag);
*/
fun
encrypt
(
  block: &(@[char][64]), edflag: int
) :<!ref> void = "mac#%" // endfun

(* ****** ****** *)

fun fork ((*void*)): pid_t = "mac#%"

(* ****** ****** *)

dataview
getcwd_v
(
  m:int, l:addr, addr
) =
  | {l>null} {n:nat}
    getcwd_v_succ (m, l, l) of strbuf_v (l, m, n)
  | getcwd_v_fail (m, l, null) of b0ytes (m) @ (l)
// end of [getcwd_v]

fun getcwd
  {m:nat} {l:addr}
(
  pf: !b0ytes (m) @ l >> getcwd_v (m, l, l1) | p: ptr l, m: size_t m
) : #[l1:addr] ptr (l1) = "mac#%" // end of [getcwd]

fun getcwd_gc (): Strptr0 = "ext#%" // HX: this is a convenient function

(* ****** ****** *)
//
/*
pid_t getpid(void);
pid_t getppid(void);
*/
fun getpid ((*void*)): pid_t = "mac#%"
fun getppid ((*void*)): pid_t = "mac#%"
//
(* ****** ****** *)

fun getuid (): uid_t = "mac#%"
fun setuid (uid: uid_t): int = "mac#%"
fun geteuid (): uid_t = "mac#%"
fun seteuid (uid: uid_t): int = "mac#%"

(* ****** ****** *)

fun getgid (): gid_t = "mac#%"
fun setgid (gid: gid_t): int = "mac#%"
fun getegid (): gid_t = "mac#%"
fun setegid (gid: gid_t): int = "mac#%"
        
(* ****** ****** *)

fun setreuid (ruid: uid_t, euid: uid_t): int = "mac#%"
fun setregid (rgid: gid_t, egid: gid_t): int = "mac#%"

(* ****** ****** *)

fun setresuid (ruid: uid_t, euid: uid_t, suid: uid_t): int = "mac#%"
fun setresgid (rgid: gid_t, egid: gid_t, sgid: gid_t): int = "mac#%"
          
(* ****** ****** *)
//
// HX: these are linux-specific!
//
fun setfsuid(fsuid: uid_t): int = "mac#%"
fun setfsgid(fsgid: gid_t): int = "mac#%"
//
(* ****** ****** *)

fun getlogin (): vStrptr0 = "mac#%"
fun getlogin_r{n:int | n >= 2}
  (buf: &bytes(n), n: size_t n): int = "mac#%"
fun getlogin_r_gc (): Strptr0 = "ext#%"

(* ****** ****** *)
//
// HX: [pause] can only returns -1
//
fun pause ((*void*)): int = "mac#%"
//
(* ****** ****** *)

fun read_err
  {sz,n:nat | n <= sz}
(
  fd: !Fildes0
, buf: &b0ytes(sz) >> bytes(sz), ntotal: size_t(n)
) : ssizeBtw(~1, n+1) = "mac#%" // end-of-fun

fun write_err
  {sz,n:nat | n <= sz}
(
  fd: !Fildes0, buf: &RD(bytes(sz)), ntotal: size_t(n)
) : ssizeBtw(~1, n+1) = "mac#%" // end-of-fun

(* ****** ****** *)

fun pread{n:int}
(
  fd: !Fildes0, buf: &(@[byte][n])>>_, n: size_t (n), ofs: off_t
) : ssize_t = "mac#%" // end of [pread]

fun pwrite{n:int}
(
  fd: !Fildes0, buf: &RD(array(byte, n)), n: size_t (n), ofs: off_t
) : ssize_t = "mac#%" // end of [pwrite]

(* ****** ****** *)
//
absview
alarm_v(n: int) // n: remaining seconds
//
praxi
alarm_v_elim (pfrem: alarm_v(0)): void
//
fun
alarm_set{i:int}
  (t: uint(i)): (alarm_v(i) | uInt) = "mac#%"
// end of [alarm_set]
fun
alarm_cancel{i:int}
  (pf: alarm_v(i) | (*none*)): uInt = "mac#%"
// end of [alarm_cancel]
//
(* ****** ****** *)
//
// HX: [sleep] may be implemented using SIGARM
//
symintr sleep
//
fun sleep_int
  {i:nat} (t: int i): [j:nat | j <= i] int j = "mac#%"
fun sleep_uint
  {i:int} (t: uint i): [j:nat | j <= i] uint j = "mac#%"
//
overload sleep with sleep_int
overload sleep with sleep_uint
//
(* ****** ****** *)
//
// HX: some systems require that the argument <= 1 million
//
symintr usleep
//
fun usleep_int // succ/fail: 0/~1
  {i:nat | i <= 1000000} (n: int i): intLte(0) = "mac#%"
fun usleep_uint // succ/fail: 0/~1
  {i:int | i <= 1000000} (n: uint i): intLte(0) = "mac#%"
//
overload usleep with usleep_int
overload usleep with usleep_uint
//
(* ****** ****** *)

/*
int rmdir(const char *pathname);
*/
fun rmdir (path: NSH(string)): int = "mac#%"
fun rmdir_exn (path: NSH(string)): void = "ext#%"

(* ****** ****** *)
/*
int link(const char *old, const char *new)
*/
fun link
(
  old: NSH(string)
, new: NSH(string)
) :<!ref> intLte(0) = "mac#%"
fun link_exn
  (old: NSH(string), new: NSH(string)):<!ref> void = "ext#%"
//
(* ****** ****** *)
/*
int symlink(const char *old, const char *new)
*/
fun symlink
(
  old: NSH(string)
, new: NSH(string)
) :<!ref> intLte(0) = "mac#%"
fun symlink_exn
  (old: NSH(string), new: NSH(string)):<!ref> void = "ext#%"
//
(* ****** ****** *)
/*
int unlink(const char *pathname);
*/
fun unlink (path: NSH(string)):<!ref> intLte(0) = "mac#%"
fun unlink_exn (path: NSH(string)):<!exnref> void = "ext#%"

(* ****** ****** *)

fun readlink{n:int}
(
  path: NSH(string), buf: &(@[byte][n]) >> _, n: size_t (n)
) : ssizeLte(n) = "mac#%" // end of [readlink]

fun readlink_gc (path: NSH(string)): Strptr0 = "ext#%"

(* ****** ****** *)

fun sync ((*void*)): void = "mac#%"
fun fsync (fd: !Fildes0): int = "mac#%"
fun fdatasync (fd: !Fildes0): int = "mac#%"

(* ****** ****** *)
//
fun truncate
  (path: NSH(string), ofs: off_t): int = "mac#%"
//
fun ftruncate (fd: !Fildes0, ofs: off_t): int = "mac#%"
//
(* ****** ****** *)

#include "./unistd_sysconf.sats"
#include "./unistd_pathconf.sats"

(* ****** ****** *)

(* end of [unistd.sats] *)
