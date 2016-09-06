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
ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define
ATS_EXTERN_PREFIX "atslib_libc_" // prefix for external names
//
(* ****** ****** *)

%{^
#include"share/H/pats_atslib.h"
%} // end of [%{^]

(* ****** ****** *)
//
staload "libats/libc/SATS/errno.sats"
staload "libats/libc/SATS/fcntl.sats"
staload "libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)

%{$
extern
atsvoid_t0ype
atslib_libc_close_exn
(
  atstype_int fd
) {
  int err ;
  err = atslib_libc_close(fd) ;
  if (0 > err) ATSLIBfailexit("close") ;
  return ;
} /* end of [atslib_libc_close_exn] */
%}

(* ****** ****** *)

%{$
extern
atstype_int
atslib_libc_dup2_fildes
(
  atstype_int fd, atstype_int fd2
) {
  int flags ;
//
  flags = fcntl(fd, F_GETFD) ;
//
  if (flags >= 0) {
    errno = EINVAL ; return -1 ; // [fd2] in use
  } /* end of [if] */
//
  return atslib_libc_dup2(fd, fd2) ;
//
} /* end of [atslib_libc_dup2_fildes] */
%}

(* ****** ****** *)

%{$
extern
atstype_strptr
atslib_libc_getcwd_gc (
) {
  char *p_cwd ;
  int bsz ;
  int myeno ;
  char *p2_cwd ;
//
// HX: [64] is chosen nearly randomly
//
  bsz = 64 ;
  p_cwd = (char*)0 ;
//
  while (1)
  {
    p_cwd = atspre_malloc_gc(bsz) ;
    p2_cwd = atslib_libc_getcwd(p_cwd, bsz) ; myeno = errno ;
    if (p2_cwd != 0) return p_cwd ; else atspre_mfree_gc(p_cwd) ;
    if (myeno != ERANGE) break ;
    bsz = 2 * bsz ;
  }
//
  return (char*)0 ;
//
} /* end of [atslib_libc_getcwd_gc] */
%}

(* ****** ****** *)

%{$
extern
atstype_strptr
atslib_libc_getlogin_r_gc (
) {
  char *p_uid ;
  int bsz ;
  int err, myeno ;
//
// HX: [16] is chosen nearly randomly
//
  bsz = 16 ;
  p_uid = (char*)0 ;
//
  while (1)
  {
    p_uid = atspre_malloc_gc(bsz) ;
    err = atslib_libc_getlogin_r(p_uid, bsz) ; myeno = errno ;
    if (err==0) return p_uid ; else atspre_mfree_gc(p_uid) ;
    if (myeno != ERANGE) break ;
    bsz = 2 * bsz ;
  }
//
  return (char*)0 ;
//
} /* end of [atslib_libc_getlogin_r_gc] */
%}

(* ****** ****** *)

%{$
extern
atsvoid_t0ype
atslib_libc_rmdir_exn
(
  atstype_string path
) {
  int err ;
  err = atslib_libc_rmdir(path) ;
  if (0 > err) ATSLIBfailexit("rmdir") ;
  return ;
} /* end of [atslib_libc_rmdir_exn] */
%}

(* ****** ****** *)

%{$
extern
atsvoid_t0ype
atslib_libc_link_exn
(
  atstype_string old, atstype_string new
) {
  int err ;
  err = atslib_libc_link(old, new) ;
  if (0 > err) ATSLIBfailexit("link") ;
  return ;
} /* end of [atslib_libc_link_exn] */
%}

(* ****** ****** *)

%{$
extern
atsvoid_t0ype
atslib_libc_unlink_exn
(
  atstype_string path
) {
  int err ;
  err = atslib_libc_unlink(path) ;
  if (0 > err) ATSLIBfailexit("unlink") ;
  return ;
} /* end of [atslib_libc_unlink_exn] */
%}

(* ****** ****** *)

%{$
extern
atsvoid_t0ype
atslib_libc_symlink_exn
(
  atstype_string old, atstype_string new
) {
  int err ;
  err = atslib_libc_symlink(old, new) ;
  if (0 > err) ATSLIBfailexit("symlink") ;
  return ;
} /* end of [atslib_libc_symlink_exn] */
%}

(* ****** ****** *)

%{$
extern
atstype_strptr
atslib_libc_readlink_gc
(
  atstype_string path
) {
  char *bfp ;
//
// HX: [64] is chosen nearly randomly
//
  int bsz = 64 ;
  ssize_t bsz2 ;
  bfp = (char*)0 ;
//
  while (1)
  {
    bfp = atspre_malloc_gc(bsz) ;
    bsz2 = atslib_libc_readlink(path, bfp, bsz) ;
/*
    fprintf(stderr, "atslib_libc_readlink_gc: bsz2 = %li\n", bsz2) ;
*/
    if (bsz2 < 0) {
      atspre_mfree_gc(bfp) ; break ;
    }
    if (bsz2 < bsz) {
      bfp[bsz2] = '\000' ; return bfp ;
    }
    atspre_mfree_gc(bfp) ; bsz *= 2 ;
  }
//
  return (char*)0 ; // HX: deadcode
//
} /* end of [atslib_libc_readlink_gc] */
%}

(* ****** ****** *)

(* end of [unistd.dats] *)
