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
"libats/libc/CATS/arpa/inet.cats"
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
staload IN =
"libats/libc/SATS/netinet/in.sats"
//
typedef in_port_nbo_t = $IN.in_port_nbo_t
typedef in_addr_hbo_t = $IN.in_addr_hbo_t
typedef in_addr_nbo_t = $IN.in_addr_nbo_t
typedef in_addr_struct = $IN.in_addr_struct
//
(* ****** ****** *)
//
abst@ype
uint16_t0ype_netbyteord = uint16
typedef uint16_nbo = uint16_t0ype_netbyteord
//
fun htons
  (i: uint16): uint16_nbo = "mac#%"
fun ntohs
  (i: uint16_nbo): uint16 = "mac#%"
//
(* ****** ****** *)
//
abst@ype
uint32_t0ype_netbyteord = uint32
typedef uint32_nbo = uint32_t0ype_netbyteord
//
fun htonl (i: uint32): uint32_nbo = "mac#%"
fun ntohl (i: uint32_nbo): uint32 = "mac#%"
//
(* ****** ****** *)
//
castfn
in_port_of_uint16_nbo (x: uint16_nbo): in_port_nbo_t
castfn
uint16_of_in_port_nbo (x: in_port_nbo_t): uint16_nbo
//
(* ****** ****** *)

fun
inet_aton
(
  cp: string
, inp: &in_addr_struct? >> opt(in_addr_struct, b)
) : #[b:bool] bool(b) = "mac#%" // end-of-function

(* ****** ****** *)
//
// HX: note that this one cannot tell
// -1 from 255.255.255.255 (a valid address)
//
fun inet_addr (cp: string): in_addr_nbo_t = "mac#%"
fun inet_network (cp: string): in_addr_hbo_t = "mac#%"
//
(* ****** ****** *)
//
fun
inet_makeaddr
  (net: int, host: int): in_addr_struct = "mac#%"
// end of [inet_makeaddr]
//
(* ****** ****** *)
//
// HX: this function is not reentrant
//
fun
inet_ntoa
  (inp: in_addr_struct) :<!ref> vStrptr1 = "mac#%"
//
(* ****** ****** *)
//
fun
inet_lnaof
  (addr: in_addr_struct): in_addr_hbo_t = "mac#%"
//
fun inet_netof
  (addr: in_addr_struct): in_addr_hbo_t = "mac#%"
//
(* ****** ****** *)

fun
inet4_pton
(
  cp: string // af=AF_INET
, inp: &in_addr_struct? >> opt (in_addr_struct, i > 0)
) : #[i:int] int (i) = "mac#%" // end-of-fun

fun
inet6_pton
(
  cp: string // af= AF_INET6
, inp: &in_addr_struct? >> opt (in_addr_struct, i > 0)
) : #[i:int] int (i) = "mac#%" // end-of-fun

(* ****** ****** *)

(* end of [inet.sats] *)
