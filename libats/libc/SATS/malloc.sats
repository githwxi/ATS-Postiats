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
"libats/libc/CATS/malloc.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_libats_libc_"
//
(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)
//
abst@ype
mallopt_param = int
//
macdef M_MXFAST = $extval (mallopt_param, "M_MXFAST")
macdef M_TRIM_THRESHOLD = $extval (mallopt_param, "M_TRIM_THRESHOLD")
macdef M_TOP_PAD = $extval (mallopt_param, "M_TOP_PAD")
macdef M_MMAP_THRESHOLD = $extval (mallopt_param, "M_MMAP_THRESHOLD")
macdef M_MMAP_MAX = $extval (mallopt_param, "M_MMAP_MAX")
macdef M_CHECK_ACTION = $extval (mallopt_param, "M_CHECK_ACTION")
//
(* ****** ****** *)

fun mallopt
(
  param: mallopt_param, value: int(*bsz*)
) : int = "mac#%" // endfun // succ/fail: 1/0

(* ****** ****** *)

fun malloc_trim
  (pad: size_t): int (*1/0:some/none*) = "mac#%"

(* ****** ****** *)

fun malloc_usable_size
  {l:addr} (!mfree_libc_v l | ptr l): size_t = "mac#%"
// end of [malloc_usable_size]

(* ****** ****** *)

fun malloc_stats (): void = "mac#%" // it outputs to stderr

(* ****** ****** *)

(*
fun malloc_get_state (): ptr = "mac#%"
fun malloc_set_state (ptr: ptr): int = "mac#%"
*)

(* ****** ****** *)

(* end of [malloc.sats] *)
