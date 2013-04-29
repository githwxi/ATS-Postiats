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
#include "libc/CATS/fcntl.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

vtypedef
RD(a:vt0p) = a // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)

staload
TYPES =
"libc/sys/SATS/types.sats"
typedef mode_t = $TYPES.mode_t

(* ****** ****** *)
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

praxi
fildes_neg_elim {fd:int | fd < 0} (fd: fildes (fd)): void

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

typedef fcntlflags = int

(* ****** ****** *)

macdef O_RDWR   = $extval (fcntlflags, "O_RDWR")
macdef O_RDONLY = $extval (fcntlflags, "O_RDONLY")
macdef O_WRONLY = $extval (fcntlflags, "O_WRONLY")

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
//
// HX-2013-03-25: should this be moved to unistd.sats?
//
dataview
close_v
  (fd:int, int) =
  | close_v_succ (fd, 0) of ()
  | {i:int | i < 0} close_v_fail (fd, i) of fildes (fd)
// end of [close_v]

fun close
  {fd:nat}
(
  fd: fildes (fd)
) : [i:int]
(
  close_v (fd, i) | int i
) = "mac#%" // endfun

fun close_exn
  {fd:nat} (fd: fildes (fd)):<!exn> void = "mac#%"
// end of [close_exn]

(* ****** ****** *)

fun fcntl_getfl (fd: !Fildes0): fcntlflags = "mac#%"
fun fcntl_setfl (fd: !Fildes0, flags: fcntlflags): int = "mac#%"

(* ****** ****** *)

(* end of [fcntl.sats] *)
