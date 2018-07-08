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
// Start Time: November, 2014
//
(* ****** ****** *)

%{^
//
#include "share/H/pats_atslib.h"
//
%} // end of [%{^]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
#define
ATS_DYNLOADFLAG 0 // no staloading at run-time
#define
ATS_EXTERN_PREFIX
"atslib_libats_libc_" // prefix for external names
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/sys/socket.sats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{$
ATSextern()
atstype_int
atslib_libats_libc_socket_AF_type_exn
(
  sa_family_t af, atstype_int tp
) {
  int
  fildes;
  fildes = socket(af, tp, 0);
  if(0 > fildes) ATSLIBfailexit("socket") ; // HX: failure
  return fildes;
} // end of [atslib_libats_libc_socket_AF_type_exn]
%} // end of [%{]

(* ****** ****** *)

%{$
ATSextern()
atsvoid_t0ype
atslib_libats_libc_bind_exn
(
  atstype_int fd
, atstype_ptr addr, socklen_t addrlen
) {
  int
  err;
  err = bind(fd, addr, addrlen);
  if(0 > err) ATSLIBfailexit("bind") ; // HX: failure
  return;
} // end of [atslib_libats_libc_bind_exn]
%} // end of [%{]

(* ****** ****** *)

%{$
ATSextern()
atsvoid_t0ype
atslib_libats_libc_listen_exn
(
  atstype_int fd, atstype_int nq
) {
  int
  err;
  err = listen(fd, nq);
  if(0 > err) ATSLIBfailexit("listen") ; // HX: failure
  return;
} // end of [atslib_libats_libc_listen_exn]
%} // end of [%{]

(* ****** ****** *)

%{$
ATSextern()
atsvoid_t0ype
atslib_libats_libc_connect_exn
(
  atstype_int fd
, atstype_ptr addr, socklen_t addrlen
) {
  int
  err;
  err = connect(fd, addr, addrlen);
  if(0 > err) ATSLIBfailexit("connect") ; // HX: failure
  return;
} // end of [atslib_libats_libc_connect_exn]
%} // end of [%{]

(* ****** ****** *)

%{$
ATSextern()
atsvoid_t0ype
atslib_libats_libc_socket_close_exn
(
  atstype_int fd
) {
  int
  err;
  err = close(fd);
  if(0 > err) ATSLIBfailexit("socket_close") ; // HX: failure
  return;
} // end of [atslib_libats_libc_socket_close_exn]
%} // end of [%{]

(* ****** ****** *)

%{$
ATSextern()
atsvoid_t0ype
atslib_libats_libc_shutdown_exn
(
  atstype_int fd, atstype_int how
) {
  int
  err;
  err = shutdown(fd, how);
  if(0 > err) ATSLIBfailexit("shutdown") ; // HX: failure
  return;
} // end of [atslib_libats_libc_shutdown_exn]
%} // end of [%{]

(* ****** ****** *)

(* end of [socket.dats] *)
