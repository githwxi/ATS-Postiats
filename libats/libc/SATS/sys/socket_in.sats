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

%{#
#include \
"libats/libc/CATS/sys/socket_in.cats"
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
//
staload
"libats/libc/SATS/sys/socket.sats"
staload
IN = "libats/libc/SATS/netinet/in.sats"
//
(* ****** ****** *)
//
typedef
in_port_t = $IN.in_port_t
typedef
in_port_nbo_t = $IN.in_port_nbo_t
//
(* ****** ****** *)
//
typedef
in_addr_hbo_t = $IN.in_addr_hbo_t
typedef
in_addr_nbo_t = $IN.in_addr_nbo_t
//
(* ****** ****** *)
//
typedef
in_addr_struct = $IN.in_addr_struct
//  
(* ****** ****** *)
//
typedef
sockaddr_in_struct =
$extype_struct
"sockaddr_in_struct" of
{
  sin_family = sa_family_t
, sin_port(**) = in_port_nbo_t // uint16
, sin_addr(**) = in_addr_struct
} // end of [sockaddr_in_struct]
//
typedef SA_in = sockaddr_in_struct
typedef sockaddr_in = sockaddr_in_struct
//
stacst socklen_in : int // HX: length of [sockaddr_in]
(*
stadef socklen_in = sizeof (sockaddr_in_struct)
*)
macdef socklen_in =
  $extval (socklen_t(socklen_in), "atslib_libc_socklen_in")
//
praxi socklen_lte_in (): [socklen_in <= socklen_max] void
praxi sockaddr_in_trans {l:addr}
  (pf: !sockaddr_in_struct @ l >> sockaddr_struct(socklen_in) @ l): void
praxi sockaddr_trans_in {l:addr}
  (pf: !sockaddr_struct(socklen_in) @ l >> sockaddr_in_struct @ l): void
//
(* ****** ****** *)
//
fun
sockaddr_in_init
(
  sa: &SA_in? >> SA_in
, af: sa_family_t, inp: in_addr_nbo_t, port: in_port_nbo_t
) :<> void = "mac#%" // end of [sockaddr_in_init]

(* ****** ****** *)

fun
bind_in_exn
  {fd:int}
(
  pf: !socket_v(fd, init) >> socket_v(fd, bind) | fd: int fd, sa: &SA_in
) :<!exnref> void = "ext#%" // end of [bind_in_exn]

(* ****** ****** *)

fun
connect_in_exn
  {fd:int}
(
  pf: !socket_v(fd, init) >> socket_v(fd, conn) | fd: int fd, sa: &SA_in
) :<!exnref> void = "ext#%" // end of [connect_in_exn]

(* ****** ****** *)

(* end of [socket_in.sats] *)
