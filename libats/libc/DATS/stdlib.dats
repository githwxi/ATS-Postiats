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
// Start Time: May, 2012
// Authoremail: gmhwxiATgmailDOTcom
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

%{^
//
#include "share/H/pats_atslib.h"
//
%} // end of [%{^]

(* ****** ****** *)
//
staload "libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)

implement
{}(*tmp*)
getenv_gc
  (name) = str2 where
{
//
val
fpfstr = getenv(name)
//
val str2 = strptr0_copy(fpfstr.1)
//
prval ((*void*)) = fpfstr.0(fpfstr.1)
//
} (* end of [getenv_gc] *)

(* ****** ****** *)

%{$
//
extern
atstype_ptr
atslib_libats_libc_malloc_libc_exn
  (atstype_size bsz)
{
  void *p0 ;
  p0 = atslib_libats_libc_malloc_libc(bsz) ;
  if (!p0) {
    fprintf(stderr, "exit(ATSLIB): [malloc] failed\n") ; exit(1) ;
  } // end of [if]
  return p0 ;
} /* end of [atslib_libats_libc_malloc_libc_exn] */
//
%}

(* ****** ****** *)

(* end of [stdlib.dats] *)
