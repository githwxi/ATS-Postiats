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
#include "libc/sys/CATS/types.cats"
#include "libc/CATS/dirent.cats" // HX: after sys/types
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

staload
TYPES = "libc/sys/SATS/types.sats"
typedef ino_t = $TYPES.ino_t
typedef off_t = $TYPES.off_t

(* ****** ****** *)

(*
abst@ype
DIR_t0ype = $extype"atslib_DIR_type" // = DIR
typedef DIR = DIR_t0ype
*)
absvtype DIRptr_vtype (l:addr)  = ptr
vtypedef DIRptr (l:addr) = DIRptr_vtype (l)
vtypedef DIRptr0 = [l:addr | l >= null] DIRptr (l)
vtypedef DIRptr1 = [l:addr | l >  null] DIRptr (l)

absview DIR_view (l:addr)
viewdef DIR_v (l:addr) = DIR_view (l)

(* ****** ****** *)

praxi DIRptr_free_null (dirp: DIRptr (null)): void

(* ****** ****** *)

castfn DIRptr2ptr {l:addr} (dirp: !DIRptr l):<> ptr (l)

(* ****** ****** *)

abst@ype
dirent_t0ype = $extype"atslib_dirent_type" // = struct dirent
typedef dirent = dirent_t0ype

(* ****** ****** *)

fun dirent_get_d_ino (ent: &dirent):<> ino_t = "mac#%"

(* ****** ****** *)

fun
dirent_get_d_name
  (ent: &dirent):<> [l:agz] vttakeout0 (strptr l) = "mac#%"
// end of [dirent_get_d_name]

fun{}
dirent_get_d_name_gc (ent: &dirent):<!wrt> Strptr1

(* ****** ****** *)

fun opendir (dname: string) : DIRptr0 = "mac#%"
fun opendir_exn (dname: string): DIRptr1 = "mac#%"

(* ****** ****** *)

fun closedir{l:agz}
(
  dirp: DIRptr l
) : [i:int | i <= 0]
(
  option_v (DIR_v (l), i==0) | int i
) = "mac#%" // end of [closedir]

fun closedir_exn (dirp: DIRptr1): void = "mac#%"

(* ****** ****** *)

fun readdir
(
  dirp: !DIRptr1
) :<!refwrt> [l:addr]
(
  option_v (vtakeout0 (dirent@l), l > null) | ptr (l)
) = "mac#%" // end of [readdir]

fun readdir_r
(
  dirp: !DIRptr1
, ent: &dirent? >> opt (dirent, i==0)
, result: &ptr? >> ptr
) :<!wrt> #[i:int | i >= 0] int(i) = "mac#%"

(* ****** ****** *)

/*
int scandir
(
  const char *dirp
, struct dirent ***namelist
, int (*filter)(const struct dirent *)
, int (*compar)(const struct dirent **, const struct dirent**)
) ;
*/
fun scandir
(
  dirp: !DIRptr1
, namelst: &(ptr?) >> ptr(*direntpp*)
, filter: (&dirent) -> int
, compar: (&ptr(*direntp*), &ptr(*direntp*)) -> int
) : int = "mac#%" // endfun

fun alphasort // POSIX-2008
  (entp1: &ptr, entp2: &ptr):<> int = "mac#%"
fun versionsort // GNU-extension
  (entp1: &ptr, entp2: &ptr):<> int = "mac#%"

(* ****** ****** *)

fun rewinddir (dirp: !DIRptr1): void = "mac#%"

(* ****** ****** *)

fun seekdir
  (dirp: !DIRptr1, off: off_t): void = "mac#%"
// end of [seekdir]

(* ****** ****** *)

fun telldir (dirp: !DIRptr1): off_t = "mac#%"

(* ****** ****** *)

(* end of [dirent.sats] *)
