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
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
#define
ATS_DYNLOADFLAG 0 // no dynloading at run-time
#define
ATS_EXTERN_PREFIX
"atslib_libats_libc_" // prefix for external names
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/string.sats"
//
(* ****** ****** *)

%{$
extern
atstype_ptr
atslib_libats_libc_strerror_r_gc
(
  atstype_int errnum
) {
  char *p_err ;
  int bsz ;
  int myerr, myeno ;
//
// HX: [64] is chosen nearly randomly
//
  bsz = 64 ;
  p_err = (char*)0 ;
//
  while (1)
  {
    p_err = atspre_malloc_gc(bsz) ;
    myerr = atslib_libats_libc_strerror_r(errnum, p_err, bsz) ; myeno = errno ;
    if (!myerr) return p_err ;
    if (myeno != ERANGE) break ;
    atspre_mfree_gc(p_err) ; bsz = 2 * bsz ;
  }
//
  return p_err ;
//
} /* end of [atslib_libats_libc_strerror_r_gc] */
%}

(* ****** ****** *)

(* end of [string.dats] *)
