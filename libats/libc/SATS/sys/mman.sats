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
// Start Time: October, 2013
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/sys/mman.cats"
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

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)
//
staload
FCNTL =
"libats/libc/SATS/fcntl.sats"
//
typedef mode_t = $FCNTL.mode_t
typedef fcntlflags = $FCNTL.fcntlflags
stadef fildes = $FCNTL.fildes
vtypedef Fildes = $FCNTL.Fildes
//
(* ****** ****** *)
//
abst@ype protflags = int
//
macdef PROT_NONE = $extval (protflags, "PROT_NONE")
macdef PROT_EXEC = $extval (protflags, "PROT_EXEC")
macdef PROT_READ = $extval (protflags, "PROT_READ")
macdef PROT_WRITE = $extval (protflags, "PROT_WRITE")
//                      
fun lor_protflags_protflags
  : (protflags, protflags) -<> protflags = "ext#atspre_lor_int_int"
overload lor with lor_protflags_protflags
//
(* ****** ****** *)
//
abst@ype mmapflags = int
//
macdef MAP_SHARED = $extval (mmapflags, "MAP_SHARED")
macdef MAP_PRIVATE = $extval (mmapflags, "MAP_PRIVATE")
//
macdef MAP_ANONYMOUS = $extval (mmapflags, "MAP_ANONYMOUS")
//
fun lor_mmapflags_mmapflags
  : (mmapflags, mmapflags) -<> mmapflags = "ext#atspre_lor_int_int"
overload lor with lor_mmapflags_mmapflags
//
(* ****** ****** *)

macdef MAP_FAILED = $extval (ptr, "MAP_FAILED") // = (void*)-1

(* ****** ****** *)

(*
/*
** Open shared memory segment
*/
extern
int shm_open
(
  __const char *__name, int __oflag, mode_t __mode
 ) ; // end of [shm_open]
*)
fun shm_open
(
  path: NSH(string), flags: fcntlflags, mode: mode_t
) : Fildes = "mac#%" // endfun

(* ****** ****** *)

(*
/*
** Remove shared memory segment
*/
extern int shm_unlink (__const char *__name);
*)
fun shm_unlink (path: NSH(string)):<!ref> intLte(0) = "mac#%"

(* ****** ****** *)

(* end of [mman.sats] *)
