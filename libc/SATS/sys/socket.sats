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
#include "libc/CATS/sys/socket.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

abst@ype
sa_family_t = $extype"sa_family_t"
//
// HX: these are the primary ones:
//
macdef AF_UNIX = $extval (sa_family_t, "AF_UNIX")
macdef AF_INET = $extval (sa_family_t, "AF_INET")
macdef AF_INET6 = $extval (sa_family_t, "AF_INET6")
macdef AF_UNSPEC = $extval (sa_family_t, "AF_UNSPEC")
//
macdef AF_LOCAL = $extval (sa_family_t, "AF_LOCAL")
macdef AF_FILE = $extval (sa_family_t, "AF_FILE")
macdef AF_AX25 = $extval (sa_family_t, "AF_AX25")
macdef AF_IPX = $extval (sa_family_t, "AF_IPX")
macdef AF_APPLETALK = $extval (sa_family_t, "AF_APPLETALK")
macdef AF_NETROM = $extval (sa_family_t, "AF_NETROM")
macdef AF_BRIDGE = $extval (sa_family_t, "AF_BRIDGE")
macdef AF_ATMPVC = $extval (sa_family_t, "AF_ATMPVC")
macdef AF_X25 = $extval (sa_family_t, "AF_X25")
macdef AF_ROSE = $extval (sa_family_t, "AF_ROSE")
macdef AF_DECnet = $extval (sa_family_t, "AF_DECnet")
macdef AF_NETBEUI = $extval (sa_family_t, "AF_NETBEUI")
macdef AF_SECURITY = $extval (sa_family_t, "AF_SECURITY")
macdef AF_KEY = $extval (sa_family_t, "AF_KEY")
macdef AF_NETLINK = $extval (sa_family_t, "AF_NETLINK")
macdef AF_ROUTE = $extval (sa_family_t, "AF_ROUTE")
macdef AF_PACKET = $extval (sa_family_t, "AF_PACKET")
macdef AF_ASH = $extval (sa_family_t, "AF_ASH")
macdef AF_ECONET = $extval (sa_family_t, "AF_ECONET")
macdef AF_ATMSVC = $extval (sa_family_t, "AF_ATMSVC")
macdef AF_RDS = $extval (sa_family_t, "AF_RDS")
macdef AF_SNA = $extval (sa_family_t, "AF_SNA")
macdef AF_IRDA = $extval (sa_family_t, "AF_IRDA")
macdef AF_PPPOX = $extval (sa_family_t, "AF_PPPOX")
macdef AF_WANPIPE = $extval (sa_family_t, "AF_WANPIPE")
macdef AF_LLC = $extval (sa_family_t, "AF_LLC")
macdef AF_CAN = $extval (sa_family_t, "AF_CAN")
macdef AF_TIPC = $extval (sa_family_t, "AF_TIPC")
macdef AF_BLUETOOTH = $extval (sa_family_t, "AF_BLUETOOTH")
macdef AF_IUCV = $extval (sa_family_t, "AF_IUCV")
macdef AF_RXRPC = $extval (sa_family_t, "AF_RXRPC")
macdef AF_ISDN = $extval (sa_family_t, "AF_ISDN")
macdef AF_PHONET = $extval (sa_family_t, "AF_PHONET")
macdef AF_IEEE802154 = $extval (sa_family_t, "AF_IEEE802154")
macdef AF_MAX = $extval (sa_family_t, "AF_MAX")
//
(* ****** ****** *)
//
abst@ype
sp_family_t = $extype"sp_family_t"
//
macdef PF_UNIX = $extval (sp_family_t, "PF_UNIX")
macdef PF_INET = $extval (sp_family_t, "PF_INET")
macdef PF_INET6 = $extval (sp_family_t, "PF_INET6")
//
(* ****** ****** *)
//
abst@ype
socktype_t = int
//
macdef SOCK_RAW = $extval (socktype_t, "SOCK_RAW")
macdef SOCK_RDM = $extval (socktype_t, "SOCK_RDM")
macdef SOCK_DCCP = $extval (socktype_t, "SOCK_DCCP")
macdef SOCK_DGRAM = $extval (socktype_t, "SOCK_DGRAM")
macdef SOCK_PACKET = $extval (socktype_t, "SOCK_PACKET")
macdef SOCK_STREAM = $extval (socktype_t, "SOCK_STREAM")
macdef SOCK_SEQPACKET = $extval (socktype_t, "SOCK_SEQPACKET")
//
(* ****** ****** *)
//
abst@ype
socklen_t(n:int) = $extype"socklen_t"
//
castfn
int2socklen
  : {n:nat} (int n) -<> socklen_t(n)
castfn
size2socklen
  : {n:int} (size_t n) -<> socklen_t(n)
//
(* ****** ****** *)

stacst socklen_max : int // HX: sockaddr length

(* ****** ****** *)
//
abst@ype
sockaddr_struct(n:int) = $extype"sockaddr_struct"
stadef SA = sockaddr_struct
//
(* ****** ****** *)
//
// HX:
// client: init -> connect
// server:
// init -> bind -> listen -> accept
//
datasort
status =
| init | conn | bind | listen
//
absview socket_v (int, status)
//
(* ****** ****** *)
  
fun
socket_AF_type
(
  af: sa_family_t, st: socktype_t
) : [fd:int]
(
  option_v (socket_v (fd, init), fd >= 0) | int fd
) = "mac#%" // end-of-function
  
fun
socket_AF_type_exn
(
  af: sa_family_t, st: socktype_t
) : [fd:nat] (socket_v(fd, init) | int fd) = "ext#%"

(* ****** ****** *)  
//
dataview
bind_v
  (fd:int, int) = 
  | bind_v_succ (fd,  0) of socket_v (fd, bind)
  | bind_v_fail (fd, ~1) of socket_v (fd, init)
// end of [bind_v]
//
fun
bind_err
  {fd:int}{n:int}
(
  pf: socket_v (fd, init)
| fd: int fd, sockaddr: &SA(n), salen: socklen_t(n)
) : [i:int] (bind_v (fd, i) | int i) = "mac#%"
//
fun
bind_exn
  {fd:int}{n:int}
(
  pf: !socket_v(fd, init) >> socket_v(fd, bind)
| fd: int fd, sockaddr: &SA(n), salen: socklen_t(n)
) : void = "exn#%" // end of [bind_exn]
//
(* ****** ****** *)
//
dataview
listen_v
  (fd:int, int) = 
  | listen_v_succ (fd,  0) of socket_v (fd, listen)
  | listen_v_fail (fd, ~1(*err*)) of socket_v (fd, bind) 
// end of [listen_v]
//
fun
listen_err
  {fd:int}
(
  pf: socket_v(fd, bind)
| fd: int fd, backlog: intGt(0)
) : [i:int] (listen_v (fd, i) | int i) = "mac#%"
//
fun
listen_exn {fd:int}
(
  pf: !socket_v(fd, bind) >> socket_v(fd, listen)
| fd: int fd, backlog: intGt(0)
) : void = "ext#%" // end of [listen_exn]
//
(* ****** ****** *)
//
dataview
connect_v
(
  fd:int, int
) =
  | connect_v_succ (fd,  0) of socket_v (fd, conn)
  | connect_v_fail (fd, ~1(*err*)) of socket_v (fd, init)
// end of [connect_v]
//
fun
connect_err
  {fd:int}{n:int}
(
  pf: socket_v (fd, init)
| fd: int fd, sockaddr: &SA(n), salen: socklen_t(n)
) : [i:int] (connect_v (fd, i) | int i) = "mac#%"
//
fun
connect_exn
  {fd:int}{n:int}
(
  pf: !socket_v(fd, init) >> socket_v(fd, conn)
| fd: int fd, sockaddr: &SA(n), salen: socklen_t(n)
) : void = "exn#%" // end of [connect_exn]
//
(* ****** ****** *)
//
dataview
accept_v
  (fd1: int, int) =
  | {fd2:nat}
    accept_v_succ (fd1, fd2) of socket_v (fd2, conn)
  | accept_v_fail (fd1, ~1(*err*)) of () // failed attempt
// end of [accept_v]

fun
accept_err
  {fd1:int}{n:int}
(
  pf: !socket_v(fd1, listen)
| fd1: int fd1
, sa: &SA(n)? >> opt(SA(n), fd2 >= 0)
, salen: &socklen_t(n) >> socklen_t(n2)
) : #[fd2:int;n2:nat] (accept_v (fd1, fd2) | int fd2) = "mac#%"

fun
accept_null_err
  {fd1:int}
(
  pf: !socket_v(fd1, listen) | fd1: int fd1
) : [fd2:int]
(
  option_v (socket_v (fd2, conn), fd2 >= 0) | int fd2
) = "mac#%" // end-of-function

(* ****** ****** *)
//
fun
socket_close
  {fd:int}{s:status}
(
  pf: socket_v (fd, s) | fd: int fd
) : [i:int | i <= 0]
(
  option_v (socket_v (fd, s), i < 0) | int i
) = "mac#%" // end of [socket_close_err]
//
fun
socket_close_exn
  {fd:int}{s:status}
  (pf: socket_v (fd, s) | fd: int fd): void = "ext#%"
// end of [socket_close_exn]
//
(* ****** ****** *)

abst@ype
shutkind_t = int
macdef SHUT_RD = $extval(shutkind_t, "SHUT_RD")
macdef SHUT_WR = $extval(shutkind_t, "SHUT_WR")
macdef SHUT_RDWR = $extval(shutkind_t, "SHUT_RDWR")

(* ****** ****** *)
//
// HX: what error can occur?
//
fun
shutdown
  {fd:int} // 0/-1 : succ/fail // errno set
(
  pf: socket_v (fd, conn) | fd: int fd, how: shutkind_t
) : [i:int | i <= 0]
(
  option_v (socket_v (fd, conn), i < 0) | int i
) = "mac#%" // end of [shutdown]
//
fun
shutdown_exn
  {fd:int} // 0/-1 : succ/fail // errno set
(
  pf: socket_v (fd, conn) | fd: int fd, how: shutkind_t
) : void = "ext#%" // end of [shutdown_exn]
//
(* ****** ****** *)
//
// HX: it is just [read] in [unistd]
//
fun
socket_read
  {fd:int}
  {n,sz:int |
   0 <= n; n <= sz}
(
  pf: !socket_v(fd, conn) | fd: int fd, buf: &bytes(sz), ntot: size_t(n)
) : ssizeBtwe(~1, n) = "mac#%" // end of [socket_read]

(* ****** ****** *)
//
// HX: it is just [write] in [unistd]
//
fun
socket_write
  {fd:int}
  {n,sz:int |
   0 <= n; n <= sz}
(
  pf: !socket_v(fd, conn) | fd: int fd, buf: &bytes(sz), ntot: size_t(n)
) : ssizeBtwe(~1, n) = "mac#%" // end of [socket_write]
//
(* ****** ****** *)

(* end of [socket.sats] *)
