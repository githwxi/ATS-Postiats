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

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

%{
ATSinline()
atstype_strptr
atslib_getcwd_gc (
) {
  char *p_cwd ;
  int bsz = 32 ; // HX: [32] is chosen nearly randomly
  char *p2_cwd ;
  p_cwd = (char*)0 ;
  while (1) {
    p_cwd = atspre_malloc_gc(bsz) ;
    p2_cwd = atslib_getcwd(p_cwd, bsz) ;
    if (p2_cwd != 0) return p_cwd ; else atspre_mfree_gc(p_cwd) ;
    bsz = 2 * bsz ;
  }
  return (char*)0 ; // HX: deadcode
} // end of [atslib_getcwd_gc]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_link_exn
(
  atstype_string old, atstype_string new
) {
  int err ;
  err = atslib_link(old, new) ;
  if (0 > err) ATSLIBfailexit("link") ;
  return ;
} /* end of [atslib_link_exn] */
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_unlink_exn
(
  atstype_string path
) {
  int err ;
  err = atslib_unlink(path) ;
  if (0 > err) ATSLIBfailexit("unlink") ;
  return ;
} /* end of [atslib_unlink_exn] */
%}

(* ****** ****** *)

(* end of [unistd.dats] *)
