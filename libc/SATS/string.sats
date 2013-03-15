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
#include "libc/CATS/string.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

absview strdup_view (l:addr)
viewdef strdup_v (l:addr) = strdup_view (l)

fun strdup
(
  str: string
) :<!wrt> [l:addr] (strdup_v (l) | strptr (l)) = "mac#%"
fun strndup
(
  str: string
) :<!wrt> [l:addr] (strdup_v (l) | strptr (l)) = "mac#%"

fun strdup_free
  {l:addr} (pf: strdup_v (l) | x: strptr l):<!wrt> void = "mac#%"
// end of [strdup_free]

(* ****** ****** *)
//
// HX-2013-03:
// strdupa-functions are gcc-functions;
// they use alloca for memory allocation
//
absview strdupa_view (l:addr)
viewdef strdupa_v (l:addr) = strdupa_view (l)

fun strdupa
(
  str: string
) :<!wrt> [l:addr] (strdupa_v (l) | strptr (l)) = "mac#%"
fun strndupa
(
  str: string
) :<!wrt> [l:addr] (strdupa_v (l) | strptr (l)) = "mac#%"

fun strdupa_free
  {l:addr} (pf: strdupa_v (l) | x: strptr l):<!wrt> void = "mac#%"
// end of [strdupa_free]

(* ****** ****** *)

(* end of [string.sats] *)
