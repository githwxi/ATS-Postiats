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
#include \
"libats/libc/CATS/sys/stat.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_libats_libc_"
//
(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)
//
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
(* ****** ****** *)
//
typedef dev_t = $TYPES.dev_t
typedef ino_t = $TYPES.ino_t
typedef mode_t = $TYPES.mode_t
typedef nlink_t = $TYPES.nlink_t
//
typedef uid_t = $TYPES.uid_t
typedef gid_t = $TYPES.gid_t
//
typedef off_t = $TYPES.off_t
//
typedef blkcnt_t = $TYPES.blkcnt_t
typedef blksize_t = $TYPES.blksize_t
//
typedef time_t = $TYPES.time_t
//
vtypedef
fildes (i:int) = $TYPES.fildes (i)
//
vtypedef Fildes = $TYPES.Fildes
vtypedef Fildes0 = $TYPES.Fildes0
//
(* ****** ****** *)
//
typedef
stat_struct =
$extype_struct
"atslib_libats_libc_stat_struct" of
{
  st_dev= dev_t // device
, st_ino= ino_t // 32-bit file serial number
, st_mode= mode_t // file mode
, st_nlink= nlink_t // link count
, st_uid= uid_t // user ID of the file's owner
, st_gid= gid_t // group ID of the file's group
, st_rdev= dev_t // device number if device
, st_size= off_t // size of file in bytes
, st_blksize= blksize_t // optimal block size for I/O
, st_blocks= blkcnt_t // number 512-byte blocks allocated
, st_atime= time_t // time of last access
, st_mtime= time_t // time of last modification
, st_ctime= time_t // time of last status change
//
, _rest= undefined_t0ype // ...
//
} // end of [stat_struct]
typedef stat = stat_struct
//
(* ****** ****** *)

macdef S_IFMT = $extval (mode_t, "S_IFMT")
macdef S_IFBLK = $extval (mode_t, "S_IFBLK")
macdef S_IFCHR = $extval (mode_t, "S_IFCHR")
macdef S_IFDIR = $extval (mode_t, "S_IFDIR")
macdef S_IFIFO = $extval (mode_t, "S_IFIFO")
macdef S_IFLNK = $extval (mode_t, "S_IFLNK")
macdef S_IFREG = $extval (mode_t, "S_IFREG")
macdef S_IFSOCK = $extval (mode_t, "S_IFSOCK")

(* ****** ****** *)
//
macdef S_IRWXU = $extval (mode_t, "S_IRWXU")
macdef S_IRUSR = $extval (mode_t, "S_IRUSR")
macdef S_IWUSR = $extval (mode_t, "S_IWUSR")
macdef S_IXUSR = $extval (mode_t, "S_IXUSR")
//
macdef S_IRWXG = $extval (mode_t, "S_IRWXG")
macdef S_IRGRP = $extval (mode_t, "S_IRGRP")
macdef S_IWGRP = $extval (mode_t, "S_IWGRP")
macdef S_IXGRP = $extval (mode_t, "S_IXGRP")
//
macdef S_IRWXO = $extval (mode_t, "S_IRWXO")
macdef S_IROTH = $extval (mode_t, "S_IROTH")
macdef S_IWOTH = $extval (mode_t, "S_IWOTH")
macdef S_IXOTH = $extval (mode_t, "S_IXOTH")
//
macdef S_ISUID = $extval (mode_t, "S_ISUID")
macdef S_ISGID = $extval (mode_t, "S_ISGID")
macdef S_ISVTX = $extval (mode_t, "S_ISVTX")
//
(* ****** ****** *)
//
// HX: macros
//
fun S_ISBLK (m: mode_t): bool = "mac#%"
fun S_ISCHR (m: mode_t): bool = "mac#%"
fun S_ISDIR (m: mode_t): bool = "mac#%"
fun S_ISFIFO (m: mode_t): bool = "mac#%"
fun S_ISREG (m: mode_t): bool = "mac#%"
fun S_ISLNK (m: mode_t): bool = "mac#%"
fun S_ISSOCK (m: mode_t): bool = "mac#%"
//
(* ****** ****** *)
//
// HX: (0/1/-1 : false/true/error)
//
fun isfdtype (fildes: int, fdtype: mode_t): int
//
(* ****** ****** *)
//
fun chmod
  (path: NSH(string), mode: mode_t): int = "mac#%"
fun chmod_exn
  (path: NSH(string), mode: mode_t): void = "ext#%"
//
fun fchmod (fd: !Fildes0, mode: mode_t): int = "mac#%"
//
(* ****** ****** *)
//
fun mkdir
  (path: NSH(string), mode: mode_t): int = "mac#%"
fun mkdir_exn
  (path: NSH(string), mode: mode_t): void = "ext#%"
//
(* ****** ****** *)
//
// HX-2014-04: this one is like [mkdir -p]
//
fun{
} mkdirp
  (path: NSH(string), mode: mode_t): int = "mac#%"
//
(* ****** ****** *)
//
fun mkdirat
  (dirfd: int, path: NSH(string), mode: mode_t): int = "mac#%"
//
(* ****** ****** *)
//
fun mkfifo // 0/-1 : succ/fail // errno set
  (path: NSH(string), perm: mode_t): int = "mac#%"
//
(* ****** ****** *)
//
fun stat
(
  path: NSH(string), st: &stat? >> opt (stat, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"
fun stat_exn
  (path: NSH(string), st: &stat? >> stat): void = "ext#%"
//
(* ****** ****** *)
//
fun fstat
(
  fd: !Fildes0, st: &stat? >> opt (stat, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"
fun fstat_exn
  (fd: !Fildes0, st: &stat? >> stat): void = "ext#%"
//
(* ****** ****** *)
//
fun lstat
(
  path: NSH(string), st: &stat? >> opt (stat, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"
fun lstat_exn
  (path: NSH(string), st: &stat? >> stat): void = "ext#%"
//
(* ****** ****** *)

fun umask
  (mask_new: mode_t): mode_t(*old*)  = "mac#%"
// end of [umask]

(* ****** ****** *)

(* end of [stat.sats] *)
