(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: July, 2013
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
%{#
#include \
"libats/libc/CATS/gdbm/gdbm.cats"
%} // end of [%{#]
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.libc.gdbm"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_libats_libc_"
//
(* ****** ****** *)
//
staload
FCNTL =
"libats/libc/SATS/fcntl.sats"
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
typedef mode_t = $TYPES.mode_t
//
(* ****** ****** *)

#include "./SHARE/datum.hats"

(* ****** ****** *)
//
absvtype
GDBMfilptr_vtype (lf:addr) = ptr
vtypedef
GDBMfilptr(lf:addr) = GDBMfilptr_vtype(lf)
//
vtypedef
GDBMfilptr = [lf:addr] GDBMfilptr(lf)
vtypedef
GDBMfilptr0 = [lf:addr | lf >= null] GDBMfilptr(lf)
vtypedef
GDBMfilptr1 = [lf:addr | lf >  null] GDBMfilptr(lf)
//
(* ****** ****** *)
//
praxi
GDBMfilptr_free_null
  (GDBMfilptr(null)): void
//
castfn
GDBMfilptr2ptr
  {lf:addr}
  (!GDBMfilptr(lf)):<> ptr(lf)
//
overload ptrcast with GDBMfilptr2ptr
//
(* ****** ****** *)
//
typedef GDBMerror = int
//
macdef
GDBM_NO_ERROR = $extval (GDBMerror, "GDBM_NO_ERROR")
macdef
GDBM_MALLOC_ERROR = $extval (GDBMerror, "GDBM_MALLOC_ERROR")
macdef
GDBM_BLOCK_SIZE_ERROR = $extval (GDBMerror, "GDBM_BLOCK_SIZE_ERROR")
macdef
GDBM_FILE_OPEN_ERROR = $extval (GDBMerror, "GDBM_FILE_OPEN_ERROR")
macdef
GDBM_FILE_WRITE_ERROR = $extval (GDBMerror, "GDBM_FILE_WRITE_ERROR")
macdef
GDBM_FILE_SEEK_ERROR = $extval (GDBMerror, "GDBM_FILE_SEEK_ERROR")
macdef
GDBM_FILE_READ_ERROR = $extval (GDBMerror, "GDBM_FILE_READ_ERROR")
macdef
GDBM_BAD_MAGIC_NUMBER = $extval (GDBMerror, "GDBM_BAD_MAGIC_NUMBER")
macdef
GDBM_EMPTY_DATABASE = $extval (GDBMerror, "GDBM_EMPTY_DATABASE")
macdef
GDBM_CANT_BE_READER = $extval (GDBMerror, "GDBM_CANT_BE_READER")
macdef
GDBM_CANT_BE_WRITER = $extval (GDBMerror, "GDBM_CANT_BE_WRITER")
macdef
GDBM_READER_CANT_DELETE = $extval (GDBMerror, "GDBM_READER_CANT_DELETE")
macdef
GDBM_READER_CANT_STORE = $extval (GDBMerror, "GDBM_READER_CANT_STORE")
macdef
GDBM_READER_CANT_REORGANIZE = $extval (GDBMerror, "GDBM_READER_CANT_REORGANIZE")
macdef
GDBM_UNKNOWN_UPDATE = $extval (GDBMerror, "GDBM_UNKNOWN_UPDATE")
macdef
GDBM_ITEM_NOT_FOUND = $extval (GDBMerror, "GDBM_ITEM_NOT_FOUND")
macdef
GDBM_REORGANIZE_FAILED = $extval (GDBMerror, "GDBM_REORGANIZE_FAILED")
macdef
GDBM_CANNOT_REPLACE = $extval (GDBMerror, "GDBM_CANNOT_REPLACE")
macdef
GDBM_ILLEGAL_DATA = $extval (GDBMerror, "GDBM_ILLEGAL_DATA")
macdef
GDBM_OPT_ALREADY_SET = $extval (GDBMerror, "GDBM_OPT_ALREADY_SET")
macdef
GDBM_OPT_ILLEGAL = $extval (GDBMerror, "GDBM_OPT_ILLEGAL")
macdef
GDBM_BYTE_SWAPPED = $extval (GDBMerror, "GDBM_BYTE_SWAPPED")
macdef
GDBM_BAD_FILE_OFFSET = $extval (GDBMerror, "GDBM_BAD_FILE_OFFSET")
macdef
GDBM_BAD_OPEN_FLAGS = $extval (GDBMerror, "GDBM_BAD_OPEN_FLAGS")
//
(* ****** ****** *)
//
fun gdbm_errno_get (): GDBMerror = "mac#%"
//
(* ****** ****** *)
//
// statically-allocated
//
val
gdbm_version : string = "mac#%"
val
gdbm_version_number : arrayref(int, 3) = "mac#mac%"
//
(* ****** ****** *)

fun gdbm_version_cmp
  (v1: &(@[int][3]), v2: &(@[int][3])):<> int = "mac#%"
// end of [gdbm_version_cmp]
  
(* ****** ****** *)

(*
#define  GDBM_READER  0		/* A reader. */
#define  GDBM_WRITER  1		/* A writer. */
#define  GDBM_WRCREAT 2		/* A writer.  Create the db if needed. */
#define  GDBM_NEWDB   3		/* A writer.  Always create a new db. */
*)
macdef GDBM_READER = $extval (int, "GDBM_READER")
macdef GDBM_WRITER = $extval (int, "GDBM_WRITER")
macdef GDBM_WRCREAT = $extval (int, "GDBM_WRCREAT")
macdef GDBM_NEWDB = $extval (int, "GDBM_NEWDB")

(*
#define  GDBM_FAST    0x10	/* Write fast! => No fsyncs.  OBSOLETE. */
#define  GDBM_SYNC    0x20	/* Sync operations to the disk. */
#define  GDBM_NOLOCK  0x40	/* Don't do file locking operations. */
*)
macdef GDBM_FAST = $extval (int, "GDBM_FAST")
macdef GDBM_SYNC = $extval (int, "GDBM_SYNC")
macdef GDBM_NOLOCK = $extval (int, "GDBM_NOLOCK")


(* ****** ****** *)

(*
GDBM_FILE gdbm_open
  (name, block_size, flags, mode, fatal_func);
*)
//
// fatal_func: (string) -> void
//
fun gdbm_open
(
  name: string
, block_size: int, flags: int, mode: mode_t, fatal_func: ptr
) : GDBMfilptr0 = "mac#%" // end of [gdbm_open]

(* ****** ****** *)

(*
void gdbm_close(dbf);
*)
fun gdbm_close (dbf: GDBMfilptr) : void = "mac#%"

(* ****** ****** *)

(*
int gdbm_store(dbf, key, content, flag);
*)
(*
#define  GDBM_INSERT  0		/* Never replace old data with new. */
#define  GDBM_REPLACE 1		/* Always replace old data with new. */
*)
macdef GDBM_INSERT = $extval (int, "GDBM_INSERT")
macdef GDBM_REPLACE = $extval (int, "GDBM_REPLACE")

fun gdbm_store
  {l1,l2:addr}{n1,n2:nat}
(
  dbf: !GDBMfilptr1, key: !datum(l1, n1), content: !datum(l2, n2), flag: int
) : int(*err*) = "mac#%" // end of [gdbm_store]

(* ****** ****** *)

(*
datum gdbm_fetch(dbf, key);
*)
//
// HX: the return value is allocated
//
fun gdbm_fetch
  {l:agz}{n:int}
  (dbf: !GDBMfilptr1, key: !datum (l, n)): datum0 = "mac#%"
// end of [gdbm_fetch]

(* ****** ****** *)

(*
int gdbm_exists(dbf, key);
*)
fun gdbm_exists
  {l:agz}{n:int} // true/false: 0/1
  (dbf: !GDBMfilptr1, key: !datum (l, n)): int = "mac#%"
// end of [gdbm_exists]

(* ****** ****** *)

(*
int gdbm_delete(dbf, key);
*)
fun gdbm_delete
  {l:agz}{n:int} // succ/fail: 0/-1
  (dbf: !GDBMfilptr1, key: !datum (l, n)) : int = "mac#%"
// end of [gdbm_delete]

(* ****** ****** *)

(*
datum gdbm_firstkey(dbf);
*)
fun gdbm_firstkey (dbf: !GDBMfilptr1): datum0 = "mac#%"

(* ****** ****** *)

(*
datum gdbm_nextkey(dbf, key);
*)

fun gdbm_nextkey
  {l:agz}{n:int}
  (dbf: !GDBMfilptr, key: !datum(l, n) >> _): datum0 = "mac#%"
// end of [gdbm_nextkey]

(* ****** ****** *)
//
(*
int gdbm_reorganize(dbf);
*)
fun
gdbm_reorganize (!GDBMfilptr1): int = "mac#%"
//
(* ****** ****** *)

(*
void gdbm_sync(dbf);
*)
fun gdbm_sync (dbf: !GDBMfilptr1): void = "mac#%"

(* ****** ****** *)

(*
int gdbm_export
(
  GDBM FILE dbf
, const char *exportfile,int flag, int mode
) ;
*)
fun gdbm_export
(
  dbf: !GDBMfilptr1
, exportfile: string, flag: int, mode: mode_t
) : int = "mac#%" // end of [gdbm_export]

(* ****** ****** *)

(*
int gdbm_import
(
  GDBM FILE dbf , const char *importfile , int flag
) ;
*)
fun gdbm_import
(
  dbf: !GDBMfilptr1, importfile: string, flag: int
) : int = "mac#%" // end of [gdbm_import]

(* ****** ****** *)

(*
char *gdbm_strerror(int errno);
*)
fun gdbm_strerror
  (errno: GDBMerror): string(*pre-allocated*) = "mac#%"
// end of [gdbm_strerror]

(* ****** ****** *)

(*
int gdbm_setopt(dbf, option, value, size);
*)
abst@ype
gdbmsetopt_t0ype (a:t@ype) = int
stadef gdbmsetopt = gdbmsetopt_t0ype
abst@ype
gdbmgetopt_t0ype (a:t@ype) = int
stadef gdbmgetopt = gdbmgetopt_t0ype
//
macdef
GDBM_CACHESIZE = $extval (gdbmsetopt(size_t), "GDBM_CACHESIZE")
macdef
GDBM_SETCACHESIZE = $extval (gdbmsetopt(size_t), "GDBM_SETCACHESIZE")
macdef
GDBM_GETCACHESIZE = $extval (gdbmgetopt(size_t), "GDBM_GETCACHESIZE")
//
macdef GDBM_GETFLAGS = $extval (gdbmgetopt(int), "GDBM_GETFLAGS")
//
macdef GDBM_FASTMODE = $extval (gdbmsetopt(int), "GDBM_FASTMODE")
//
macdef
GDBM_SYNCMODE = $extval (gdbmsetopt(int), "GDBM_SYNCMODE")
macdef
GDBM_SETSYNCMODE = $extval (gdbmsetopt(int), "GDBM_SETSYNCMODE")
macdef
GDBM_GETSYNCMODE = $extval (gdbmgetopt(int), "GDBM_GETSYNCMODE")
//
macdef
GDBM_COALESCEBLKS = $extval (gdbmsetopt(int), "GDBM_COALESCEBLKS")
macdef
GDBM_SETCOALESCEBLKS = $extval (gdbmsetopt(int), "GDBM_SETCOALESCEBLKS")
macdef
GDBM_GETCOALESCEBLKS = $extval (gdbmgetopt(int), "GDBM_GETCOALESCEBLKS")
//
macdef
GDBM_SETMAXMAPSIZE = $extval (gdbmsetopt(size_t), "GDBM_SETMAXMAPSIZE")
macdef
GDBM_GETMAXMAPSIZE = $extval (gdbmgetopt(size_t), "GDBM_GETMAXMAPSIZE")
//
macdef
GDBM_SETMMAP = $extval (gdbmsetopt(int), "GDBM_SETMMAP")
macdef
GDBM_GETMMAP = $extval (gdbmgetopt(int), "GDBM_GETMMAP")
//
macdef
GDBM_GETDBNAME = $extval (gdbmgetopt(ptr), "GDBM_GETDBNAME")
//
(* ****** ****** *)
//
fun
gdbm_setopt
  {a:t@ype}
(
  dbf: !GDBMfilptr1
, option: gdbmsetopt(a), value: &a, size: sizeof_t(a)
) : int(*err*) = "mac#%" // end of [gdbm_setopt]
//
fun
gdbm_getopt
  {a:t@ype}
(
  dbf: !GDBMfilptr1
, option: gdbmgetopt(a), value: &a? >> a, size: sizeof_t(a)
) : int(*err*) = "mac#%" // end of [gdbm_getopt]
//
fun
gdbm_getdbname(dbf: !GDBMfilptr1): Strptr0 = "mac#%"
//
(* ****** ****** *)
//
(*
int gdbm_fdesc(dbf);
*)
fun
gdbm_fdesc(dbf: !GDBMfilptr1): int(*fd*) = "mac#%" // no failure
//
(* ****** ****** *)

(* end of [gdbm.sats] *)
