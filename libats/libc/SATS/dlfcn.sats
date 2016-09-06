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
// Start Time: December, 2013
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/dlfcn.cats"
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

#define RD(x) x // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)
//
macdef RTLD_NOW = $extval (uint, "RTLD_NOW")
macdef RTLD_LAZY = $extval (uint, "RTLD_LAZY")
//
(* ****** ****** *)
//
macdef RTLD_LOCAL = $extval (uint, "RTLD_LOCAL")
macdef RTLD_GLOBAL = $extval (uint, "RTLD_GLOBAL")
macdef RTLD_NOLOAD = $extval (uint, "RTLD_NOLOAD") // glibc-2.2
macdef RTLD_NODELETE = $extval (uint, "RTLD_NODELETE") // glibc-2.2
macdef RTLD_DEEPBIND = $extval (uint, "RTLD_DEEPBIND") // glibc-2.3.4
//
(* ****** ****** *)

absview dlopen_v (l:addr)

(* ****** ****** *)

fun dlopen (
  filename: NSH(stropt), flag: uint
) : [l:addr] (option_v (dlopen_v(l), l > null) | ptr l) = "mac#%"

(* ****** ****** *)

fun dlclose{l:agz}
  (pf: dlopen_v (l) | p: ptr (l)): [i:int | i >= 0] int(i) = "mac#%"
// end of [dlclose]

(* ****** ****** *)
//
praxi
dlopen_v_elim_null{l:addr | l <= null} (pf: dlopen_v (l)): void
//
(* ****** ****** *)

fun dlerror ((*void*)): vStrptr0 = "mac#%"

(* ****** ****** *)
//
fun dlsym{l:agz}
  (pf: !dlopen_v l | handle: ptr l, sym: NSH(string)): Ptr0 = "mac#%"
//
(* ****** ****** *)

(* end of [dlfcn.sats] *)
