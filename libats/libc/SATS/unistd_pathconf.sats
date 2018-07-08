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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)

(* ****** ****** *)

typedef pathconfname = int

(* ****** ****** *)
//
fun
pathconf
  (path: NSH(string), name: pathconfname): lint = "mac#%"
//
fun fpathconf (fd: int, name: pathconfname): lint = "mac#%"
//
(* ****** ****** *)

macdef _PC_LINK_MAX = $extval (pathconfname, "_PC_LINK_MAX")
macdef _PC_MAX_CANON = $extval (pathconfname, "_PC_MAX_CANON")
macdef _PC_MAX_INPUT = $extval (pathconfname, "_PC_MAX_INPUT")
macdef _PC_NAME_MAX = $extval (pathconfname, "_PC_NAME_MAX")
macdef _PC_PATH_MAX = $extval (pathconfname, "_PC_PATH_MAX")
macdef _PC_PIPE_BUF = $extval (pathconfname, "_PC_PIPE_BUF")
macdef _PC_CHOWN_RESTRICTED = $extval (pathconfname, "_PC_CHOWN_RESTRICTED")
macdef _PC_NO_TRUNC = $extval (pathconfname, "_PC_NO_TRUNC")
macdef _PC_VDISABLE = $extval (pathconfname, "_PC_VDISABLE")
macdef _PC_SYNC_IO = $extval (pathconfname, "_PC_SYNC_IO")
macdef _PC_ASYNC_IO = $extval (pathconfname, "_PC_ASYNC_IO")
macdef _PC_PRIO_IO = $extval (pathconfname, "_PC_PRIO_IO")
macdef _PC_SOCK_MAXBUF = $extval (pathconfname, "_PC_SOCK_MAXBUF")
macdef _PC_FILESIZEBITS = $extval (pathconfname, "_PC_FILESIZEBITS")
macdef _PC_REC_INCR_XFER_SIZE = $extval (pathconfname, "_PC_REC_INCR_XFER_SIZE")
macdef _PC_REC_MAX_XFER_SIZE = $extval (pathconfname, "_PC_REC_MAX_XFER_SIZE")
macdef _PC_REC_MIN_XFER_SIZE = $extval (pathconfname, "_PC_REC_MIN_XFER_SIZE")
macdef _PC_REC_XFER_ALIGN = $extval (pathconfname, "_PC_REC_XFER_ALIGN")
macdef _PC_ALLOC_SIZE_MIN = $extval (pathconfname, "_PC_ALLOC_SIZE_MIN")
macdef _PC_SYMLINK_MAX = $extval (pathconfname, "_PC_SYMLINK_MAX")
macdef _PC_2_SYMLINK = $extval (pathconfname, "_PC_2_SYMLINK")

(* ****** ****** *)

(* end of [unistd_pathconf.sats] *)
