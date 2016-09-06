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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: March, 2013
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/fcntl.cats"
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

vtypedef
RD(a:vt0p) = a // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)
//
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
typedef mode_t = $TYPES.mode_t
//
vtypedef
fildes (i:int) = $TYPES.fildes (i)
//
vtypedef Fildes = $TYPES.Fildes
vtypedef Fildes0 = $TYPES.Fildes0
//
(* ****** ****** *)
//
praxi
fildes_neg_elim
  {fd:int | fd < 0}(fd: fildes(fd)): void
//
(* ****** ****** *)
//
// HX: this is just a castfn
//
fun fildes_get_int
  {fd:int} (fd: !fildes (fd)):<> int (fd) = "mac#%"
//
fun fildes_isgtez
  {fd:int} (fd: !fildes (fd)):<> bool (fd >= 0) = "mac#%"
//
(* ****** ****** *)
//
fun fildes_iget_int
  (fd: int):<> [fd:int] vttakeout0 (fildes (fd)) = "ext#%"
//
(* ****** ****** *)

abst@ype fcntlflags = int
//
macdef O_CREAT  = $extval (fcntlflags, "O_CREAT")
macdef O_EXCL   = $extval (fcntlflags, "O_EXCL")
macdef O_TRUNC  = $extval (fcntlflags, "O_TRUNC")
macdef O_APPEND = $extval (fcntlflags, "O_APPEND")
//
macdef O_RDWR   = $extval (fcntlflags, "O_RDWR")
macdef O_RDONLY = $extval (fcntlflags, "O_RDONLY")
macdef O_WRONLY = $extval (fcntlflags, "O_WRONLY")
//
macdef O_SYNC   = $extval (fcntlflags, "O_SYNC")
macdef O_ASYNC  = $extval (fcntlflags, "O_ASYNC")
//
macdef O_NOCTTY = $extval (fcntlflags, "O_NOCTTY")
//  
(* ****** ****** *)

fun lor_fcntlflags_fcntlflags
  : (fcntlflags, fcntlflags) -<> fcntlflags = "ext#atspre_lor_int_int"
overload lor with lor_fcntlflags_fcntlflags

(* ****** ****** *)

fun open_flags
(
  path: NSH(string), flags: fcntlflags
) : Fildes = "mac#%" // endfun

fun open_flags_mode
(
  path: NSH(string), flags: fcntlflags, mode: mode_t
) : Fildes = "mac#%" // endfun

(* ****** ****** *)

fun fcntl_getfl (fd: !Fildes0): fcntlflags = "mac#%"
fun fcntl_setfl (fd: !Fildes0, flags: fcntlflags): int = "mac#%"

(* ****** ****** *)

(* end of [fcntl.sats] *)
