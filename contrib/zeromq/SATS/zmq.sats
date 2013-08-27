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

(*
** Start Time: December, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

%{#
#include "zeromq/CATS/zmq.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.zeromq"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_zeromq_" // prefix for external names

(* ****** ****** *)

typedef SHR(x:type) = x // for commenting purpose
typedef NSH(x:type) = x // for commenting purpose

(* ****** ****** *)

absvtype zmqctx_vtype (l:addr) = ptr(l)
vtypedef zmqctx (l:addr) = zmqctx_vtype(l)
vtypedef zmqctx = [l:addr] zmqctx_vtype(l)
vtypedef zmqctx0 = [l:agez] zmqctx_vtype(l)
vtypedef zmqctx1 = [l:addr | l > null] zmqctx_vtype(l)

(* ****** ****** *)
//
castfn
zmqctx2ptr{l:addr} (!zmqctx (l)):<> ptr(l)
overload ptrcast with zmqctx2ptr
//
(* ****** ****** *)

absvtype
zmqctxopt_vtype (l:addr, b:bool) = ptr
vtypedef
zmqctxopt (l:addr, b:bool) = zmqctxopt_vtype(l, b)

(* ****** ****** *)

castfn
zmqctxopt_unsome
  {l:addr}
  (opt: zmqctxopt (l, true)):<> zmqctx (l)
// end of [zmqctxopt_unsome]
castfn
zmqctxopt_unnone
  {l:addr} (opt: zmqctxopt (l, false)):<> ptr (l)
// end of [zmqctxopt_unnone]

(* ****** ****** *)

macdef ZMQ_REP = $extval(int, "ZMQ_REP")
macdef ZMQ_REQ = $extval(int, "ZMQ_REQ")

absvtype zmqsock (l:addr) = ptr
vtypedef zmqsock = [l:addr] zmqsock(l)
vtypedef zmqsock0 = [l:agez] zmqsock(l)
vtypedef zmqsock1 = [l:addr | l > null] zmqsock(l)

(* ****** ****** *)

castfn
zmqsock2ptr{l:addr} (!zmqsock (l)):<> ptr(l)
overload ptrcast with zmqsock2ptr

(* ****** ****** *)

typedef interr = [i:int | i <= 0] int (i)

(* ****** ****** *)

(*
int zmq_errno (void);
*)
fun zmq_errno (): int = "mac#%"

(* ****** ****** *)

fun zmq_ctx_new (): zmqctx0 = "mac#%"

(* ****** ****** *)

fun zmq_ctx_destroy
  {l:agz} (
  ctx: !zmqctx (l) >> zmqctxopt (l, i < 0)
) : #[i:int | i <= 0] int (i) = "mac#%"

fun zmq_ctx_destroy_exn (ctx: zmqctx1): void

(* ****** ****** *)

fun zmq_ctx_get
  (ctx: !zmqctx1, name: int): int = "mac#%"
// end of [zmq_ctx_get]

fun zmq_ctx_set
  (ctx: !zmqctx1, name: int, value: int): int = "mac#%"
// end of [zmq_ctx_set]

(* ****** ****** *)

(*
void *zmq_socket (void *context, int type);
*)
fun zmq_socket
  (ctx: !zmqctx1, type: int): zmqsock0 = "mac#%"
// end of [zmq_socket]
fun zmq_socket_exn (ctx: !zmqctx1, type: int): zmqsock1

(* ****** ****** *)

abst@ype zmqsockopt (a:t@ype) = int

macdef ZMQ_TYPE = $extval(zmqsockopt(int), "ZMQ_TYPE")

macdef ZMQ_RCVMORE = $extval(zmqsockopt(int), "ZMQ_RCVMORE")

macdef ZMQ_SNDHWM = $extval(zmqsockopt(int), "ZMQ_SNDHWM")
macdef ZMQ_RCVHWM = $extval(zmqsockopt(int), "ZMQ_RCVHWM")

macdef ZMQ_AFFINITY = $extval(zmqsockopt(uint64), "ZMQ_AFFINITY")

macdef ZMQ_IDENTITY = $extval(zmqsockopt(void), "ZMQ_IDENTITY")

macdef ZMQ_SUBSCRIBE = $extval(zmqsockopt(void), "ZMQ_SUBSCRIBE")
macdef ZMQ_UNSUBSCRIBE = $extval(zmqsockopt(void), "ZMQ_UNSUBSCRIBE")

macdef ZMQ_RATE = $extval(zmqsockopt(int), "ZMQ_RATE")

macdef ZMQ_RECOVERY_IVL = $extval(zmqsockopt(int), "ZMQ_RECOVERY_IVL")

macdef ZMQ_RECONNECT_IVL = $extval(zmqsockopt(int), "ZMQ_RECONNECT_IVL")
macdef ZMQ_RECONNECT_IVL_MAX = $extval(zmqsockopt(int), "ZMQ_RECONNECT_IVL_MAX")

macdef ZMQ_SNDBUF = $extval(zmqsockopt(int), "ZMQ_SNDBUF")
macdef ZMQ_RCVBUF = $extval(zmqsockopt(int), "ZMQ_RCVBUF")

macdef ZMQ_LINGER = $extval(zmqsockopt(int), "ZMQ_LINGER")

macdef ZMQ_BACKLOG = $extval(zmqsockopt(int), "ZMQ_BACKLOG")

macdef ZMQ_MAXMSGSIZE = $extval(zmqsockopt(int64), "ZMQ_MAXMSGSIZE")

macdef ZMQ_MULTICAST_HOPS = $extval(zmqsockopt(int64), "ZMQ_MULTICAST_HOPS")

macdef ZMQ_SNDTIMEO = $extval(zmqsockopt(int), "ZMQ_SNDTIMEO")
macdef ZMQ_RCVTIMEO = $extval(zmqsockopt(int), "ZMQ_RCVTIMEO")

macdef ZMQ_IPV4ONLY = $extval(zmqsockopt(int), "ZMQ_IPV4ONLY")

macdef ZMQ_DELAY_ATTACH_ON_CONNECT = $extval(zmqsockopt(int), "ZMQ_DELAY_ATTACH_ON_CONNECT")

macdef ZMQ_FD = $extval(zmqsockopt(int), "ZMQ_FD") // on POSIX
(*
macdef ZMQ_FD = $extval(zmqsockopt(SOCKET), "ZMQ_FD") // on Windows
*)

macdef ZMQ_EVENTS = $extval(zmqsockopt(int), "ZMQ_EVENTS")

macdef ZMQ_LAST_ENDPOINT = $extval(zmqsockopt(void), "ZMQ_LAST_ENDPOINT")

macdef ZMQ_XPUB_VERBOSE = $extval(zmqsockopt(int), "ZMQ_XPUB_VERBOSE")
macdef ZMQ_ROUTER_MANDATORY = $extval(zmqsockopt(int), "ZMQ_ROUTER_MANDATORY")

macdef ZMQ_TCP_KEEPALIVE = $extval(zmqsockopt(int), "ZMQ_TCP_KEEPALIVE")
macdef ZMQ_TCP_KEEPALIVE_IDLE = $extval(zmqsockopt(int), "ZMQ_TCP_KEEPALIVE_IDLE")
macdef ZMQ_TCP_KEEPALIVE_CNT = $extval(zmqsockopt(int), "ZMQ_TCP_KEEPALIVE_CNT")
macdef ZMQ_TCP_KEEPALIVE_INTVL = $extval(zmqsockopt(int), "ZMQ_TCP_KEEPALIVE_INTVL")

macdef ZMQ_TCP_ACCEPT_FILTER = $extval(zmqsockopt(void), "ZMQ_TCP_ACCEPT_FILTER")

(* ****** ****** *)

(*
int zmq_getsockopt (
  void *socket, int name, void *value, size_t *len
) : int ; // end of [zmq_getsockopt]
*)
fun zmq_getsockopt
  {a:t@ype} (
  sock: !zmqsock1
, name: zmqsockopt(a), value: ptr, len: &size_t >> _
) : interr = "mac#%" // endfun

fun zmq_getsockopt2
  {a:t@ype} (
  sock: !zmqsock1
, name: zmqsockopt(a), value: &(a?)>>a, len: &size_t(sizeof(a)) >> _
) : interr = "mac#%" // endfun

(* ****** ****** *)

fun zmq_setsockopt
  {a:t@ype} (
  sock: !zmqsock1
, name: zmqsockopt(a), value: ptr, len: (size_t)
) : interr = "mac#%" // endfun

(* ****** ****** *)

(*
int zmq_bind (void *socket, const char *endpt);
*)
fun zmq_bind (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#%" // endfun

fun zmq_bind_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_bind_exn]

(* ****** ****** *)

(*
int zmq_unbind (void *socket, const char *endpoint);
*)
fun zmq_unbind (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#%" // endfun

fun zmq_unbind_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_unbind_exn]

(* ****** ****** *)

(*
int zmq_connect (void *socket, const char *endpt);
*)
fun zmq_connect (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#%" // endfun

fun zmq_connect_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_connect_exn]

(* ****** ****** *)

(*
int zmq_disconnect (void *socket, const char *endpt);
*)
fun zmq_disconnect (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#%" // endfun

fun zmq_disconnect_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_disconnect_exn]

(* ****** ****** *)

(*
int zmq_close (void *socket);
*)
fun zmq_close
  (sock: zmqsock1): interr = "mac#%"
// end of [zmq_close]

fun zmq_close_exn (sock: zmqsock1) : void

(* ****** ****** *)

(*
int zmq_send (void *socket, void *buf, size_t len, int flags);
*)
fun zmq_send
  {m:int}{n:int | n <= m} (
  sock: !zmqsock1, buf: &(@[byte][m]), len: size_t (n), flags: int
) : int(*verr*) = "mac#%" // end of [zmq_send]

(* ****** ****** *)

(*
int zmq_recv (void *socket, void *buf, size_t len, int flags);
*)
fun zmq_recv
  {m:int}{n:int | n <= m} (
  sock: !zmqsock1, buf: &(@[byte][m]), len: size_t (n), flags: int
) : int(*verr*) = "mac#%" // end of [zmq_recv]

(* ****** ****** *)

absviewt@ype
zmqmsg_viewt0ype = $extype"zmq_msg_t"
viewtypedef zmqmsg = zmqmsg_viewt0ype

(* ****** ****** *)

(*
void *zmq_msg_size (zmq_msg_t *msg);
*)
fun zmq_msg_size (msg: &zmqmsg):<> size_t = "mac#%"

(*
void *zmq_msg_data (zmq_msg_t *msg);
*)
fun zmq_msg_data (msg: &zmqmsg):<> Ptr1 = "mac#%"

(*
int zmq_msg_more (zmq_msg_t *message);
*)
fun zmq_msg_more (msg: &zmqmsg):<> natLt(2) = "mac#%"

(* ****** ****** *)

macdef ZMQ_MORE = $extval(int, "ZMQ_MORE")

(*
int zmq_msg_get (zmq_msg_t *message, int property);
*)
fun zmq_msg_get
  (msg: &zmqmsg, property: int): int(*verr*) = "mac#%"
// end of [zmq_msg_get]

fun zmq_msg_get_exn
  (msg: &zmqmsg, property: int): intGt(0) // valid return value
// end of [zmq_msg_get_exn]

(* ****** ****** *)

(*
int zmq_msg_set (zmq_msg_t *message, int property, int value);
*)
fun zmq_msg_set (
  msg: &zmqmsg >> _, property: int, value: int
) : interr = "mac#%" // endfun

fun zmq_msg_set_exn
  (msg: &zmqmsg >> _, property: int, value: int): void
// end of [zmq_msg_set_exn]

(* ****** ****** *)

(*
int zmq_msg_init (zmq_msg_t *msg);
*)
fun zmq_msg_init (
  msg: &zmqmsg? >> opt (zmqmsg, i==0)
) : #[i:int | i <= 0] int (i) = "mac#%"

fun zmq_msg_init_exn (msg: &zmqmsg? >> zmqmsg): void

(* ****** ****** *)

(*
int zmq_msg_init_size (zmq_msg_t *msg, size_t size);
*)
fun zmq_msg_init_size (
  msg: &zmqmsg? >> opt (zmqmsg, i==0), n: size_t
) : #[i:int | i <= 0] int (i) = "mac#%"

fun zmq_msg_init_size_exn (msg: &zmqmsg? >> zmqmsg, n: size_t): void

(* ****** ****** *)

(*
typedef void (zmq_free_fn) (void *data, void *hint);
int zmq_msg_init_data (
  zmq_msg_t *msg, void *data, size_t size, zmq_free_fn *ffn, void *hint
) ; // end of [zmq_msg_init_data]
*)
//
typedef zmq_free_fn = (ptr(*data*), ptr(*hint*)) -> void
//
fun zmq_msg_init_data
(
  msg: &zmqmsg? >> opt (zmqmsg, i==0)
, data: ptr, size: size_t, ffn: zmq_free_fn, hint: ptr
) : #[i:int | i <= 0] int (i) = "mac#%"

fun zmq_msg_init_data_exn
(
  msg: &zmqmsg? >> zmqmsg
, data: ptr, size: size_t, ffn: zmq_free_fn, hint: ptr
) : void // end of [zmq_msg_init_data_exn]

(* ****** ****** *)

(*
int zmq_msg_close (zmq_msg_t *msg);
*)
fun zmq_msg_close
(
  msg: &zmqmsg >> opt(zmqmsg, i < 0)
) : #[i:int | i <= 0] int (i) = "mac#%"

fun zmq_msg_close_exn (msg: &zmqmsg >> zmqmsg?): void

(* ****** ****** *)

(*
int zmq_msg_copy (zmq_msg_t *dest, zmq_msg_t *src);
*)
fun zmq_msg_copy
  (dst: &zmqmsg >> _, src: &zmqmsg): interr = "mac#%"
// end of [zmq_msg_copy]

fun zmq_msg_copy_exn (dst: &zmqmsg >> _, src: &zmqmsg): void

(* ****** ****** *)

(*
int zmq_msg_move (zmq_msg_t *dest, zmq_msg_t *src);
*)
fun zmq_msg_move
  (dst: &zmqmsg >> _, src: &zmqmsg): interr = "mac#%"
// end of [zmq_msg_move]

fun zmq_msg_move_exn (dst: &zmqmsg >> _, src: &zmqmsg): void

(* ****** ****** *)

macdef
ZMQ_DONTWAIT =
  $extval(int, "ZMQ_DONTWAIT") // non-blocking send/receive
// end of [ZMQ_DONTWAIT]
macdef
ZMQ_SNDMORE =
  $extval(int, "ZMQ_SNDMORE") // for sending multi-part messages
macdef ZMQ_SENDMORE = ZMQ_SNDMORE // alias of more appropriate spelling

(* ****** ****** *)

(*
int zmq_msg_send (zmq_msg_t *msg, void *socket, int flags);
*)
fun zmq_msg_send (
  msg: &zmqmsg, sock: !zmqsock1, flags: int
) : interr = "mac#%" // endfun

fun zmq_msg_send_exn
  (msg: &zmqmsg, sock: !zmqsock1, flags: int): intGte(0)
// end of [zmq_msg_send_exn]

(* ****** ****** *)

(*
int zmq_msg_recv (zmq_msg_t *msg, void *socket, int flags);
*)
fun zmq_msg_recv (
  msg: &zmqmsg >> _, sock: !zmqsock1, flags: int
) : interr = "mac#%" // endfun

fun zmq_msg_recv_exn
  (msg: &zmqmsg >> _, sock: !zmqsock1, flags: int): intGte(0)
// end of [zmq_msg_recv_exn]

(* ****** ****** *)

(*
void zmq_version (int *major, int *minor, int *patch);
*)
fun zmq_version (
  major: &int? >> int, minor: &int? >> int, patch: &int? >> int
) : void = "mac#%" // end of [zmq_version]

(* ****** ****** *)

(*
** HX: this one has been deprecated!
*)
fun zmq_term
  {l:agz} (
  ctx: !zmqctx (l) >> zmqctxopt (l, i < 0)
) : #[i:int | i <= 0] int (i) = "mac#%"

fun zmq_term_exn (ctx: zmqctx1): void

(* ****** ****** *)

(*
** HX: this one has been deprecated!
*)
fun zmq_sendmsg (
  sock: !zmqsock1, msg: &zmqmsg, flags: int
) : interr = "mac#%" // endfun

(*
** HX: this one has been deprecated!
*)
fun zmq_recvmsg (
  sock: !zmqsock1, msg: &zmqmsg >> _, flags: int
) : interr = "mac#%" // endfun

(* ****** ****** *)

(* end of [zmq.sats] *)
