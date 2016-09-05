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

#define
ATS_PACKNAME "ATSLIB.libc"
#define
ATS_DYNLOADFLAG 0 // no need for staloading at run-time
#define
ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)
//
staload
"libc/SATS/sys/socket_in.sats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{
ATSextern()
atsvoid_t0ype
atslib_bind_in_exn
(
  atstype_int fd, atstype_ptr addr
) {
  int
  err;
  err =
  bind(
    fd, (const struct sockaddr*)addr, sizeof(struct sockaddr_in)
  ); // end of [connent]
  if(0 > err) ATSLIBfailexit("bind");
  return;
} // end of [atslib_bind_in_exn]
%} // end of [%{]

(* ****** ****** *)

%{
ATSextern()
atsvoid_t0ype
atslib_connect_in_exn
(
  atstype_int fd, atstype_ptr addr
) {
  int
  err;
  err =
  connect(
    fd, (const struct sockaddr*)addr, sizeof(struct sockaddr_in)
  ); // end of [connent]
  if(0 > err) ATSLIBfailexit("connect");
  return;
} // end of [atslib_connect_in_exn]
%} // end of [%{]

(* ****** ****** *)

(* end of [socket_in.dats] *)
