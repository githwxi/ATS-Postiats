(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: April, 2014
//
(* ****** ****** *)
//
#define ATS_PACKNAME "ATSLIB.libats.libc"
#define ATS_DYNLOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_libc_" // prefix for external names
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/sys/types.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
// HX-2014-04-29: it is still empty
//
(* ****** ****** *)

(* end of [types.dats] *)
