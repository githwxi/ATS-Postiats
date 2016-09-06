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
"libats/libc/CATS/strings.cats"
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
fun
index_int(cs: string, c0: int):<> Ptr0 = "mac#%"
fun
index_char(cs: string, c0: char):<> Ptr0 = "mac#%"
//
symintr index
overload index with index_int
overload index with index_char
//
(* ****** ****** *)
//
fun
rindex_int(cs: string, c0: int):<> Ptr0 = "mac#%"
fun
rindex_char(cs: string, c0: char):<> Ptr0 = "mac#%"
//
symintr rindex
overload rindex with rindex_int
overload rindex with rindex_char
//
(* ****** ****** *)
//                    
fun
strcasecmp (x1: string, x2: string):<> int = "mac#%"
fun
strncasecmp (x1: string, x2: string, n: size_t):<> int = "mac#%"
//
(* ****** ****** *)

(* end of [strings.sats] *)
