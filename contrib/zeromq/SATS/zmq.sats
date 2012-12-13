(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

typedef SHR(x:type) = x // for commenting purpose
typedef NSH(x:type) = x // for commenting purpose

(* ****** ****** *)

absviewtype zmqctx (l:addr)

viewtypedef zmqctx0 = [l:addr] zmqctx (l)
viewtypedef zmqctx1 = [l:addr | l > null] zmqctx (l)

castfn zmqctx2ptr {l:addr} (ctx: !zmqctx (l)):<> ptr (l)

(* ****** ****** *)

absviewtype zmqctxopt (l:addr, b:bool)

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

macdef ZMQ_REP = $extval (int, "ZMQ_REP")
macdef ZMQ_REQ = $extval (int, "ZMQ_REQ")

absviewtype zmqsock (l:addr)
viewtypedef zmqsock0 = [l:addr] zmqsock (l)
viewtypedef zmqsock1 = [l:addr | l > null] zmqsock (l)

castfn zmqsock2ptr {l:addr} (sock: !zmqsock (l)): ptr (l)

(* ****** ****** *)

typedef interr = [i:int | i <= 0] int (i)

(* ****** ****** *)

(*
int zmq_errno (void);
*)
fun zmq_errno (): int = "mac#atsctrb_zmq_errno"

(* ****** ****** *)

fun zmq_ctx_new (): zmqctx0 = "mac#atsctrb_zmq_ctx_new"

(* ****** ****** *)

fun zmq_ctx_destroy
  {l:agz} (
  ctx: !zmqctx (l) >> zmqctxopt (l, i < 0)
) : #[i:int | i <= 0] int (i) = "mac#atsctrb_zmq_ctx_destroy"

fun zmq_ctx_destroy_exn (ctx: zmqctx1): void

(* ****** ****** *)

(*
void *zmq_socket (void *context, int type);
*)
fun zmq_socket (ctx: !zmqctx1, type: int): zmqsock0
fun zmq_socket_exn (ctx: !zmqctx1, type: int): zmqsock1

(* ****** ****** *)

(*
int zmq_bind (void *socket, const char *endpt);
*)
fun zmq_bind (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#atsctrb_zmq_bind" // endfun

fun zmq_bind_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_bind_exn]

(* ****** ****** *)

(*
int zmq_unbind (void *socket, const char *endpoint);
*)
fun zmq_unbind (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#atsctrb_zmq_unbind"

fun zmq_unbind_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_unbind_exn]

(* ****** ****** *)

(*
int zmq_connect (void *socket, const char *endpt);
*)
fun zmq_connect (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#atsctrb_zmq_connect"

fun zmq_connect_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_connect_exn]

(* ****** ****** *)

(*
int zmq_disconnect (void *socket, const char *endpt);
*)
fun zmq_disconnect (
  sock: !zmqsock1, endpt: NSH(string)
) : interr = "mac#atsctrb_zmq_disconnect"

fun zmq_disconnect_exn
  (sock: !zmqsock1, endpt: NSH(string)): void
// end of [zmq_disconnect_exn]

(* ****** ****** *)

(*
int zmq_close (void *socket);
*)
fun zmq_close
  (sock: zmqsock1): interr = "mac#atsctrb_zmq_close"
// end of [zmq_close]

fun zmq_close_exn (sock: zmqsock1) : void

(* ****** ****** *)

(*
int zmq_send (void *socket, void *buf, size_t len, int flags);
*)
fun zmq_send
  {m:int}{n:int | n <= m} (
  sock: !zmqsock1, buf: &(@[byte][m]), len: size_t (n), flags: int
) : int(*verr*) = "mac#atsctrb_zmq_send" // end of [zmq_send]

(* ****** ****** *)

(*
int zmq_recv (void *socket, void *buf, size_t len, int flags);
*)
fun zmq_recv
  {m:int}{n:int | n <= m} (
  sock: !zmqsock1, buf: &(@[byte][m]), len: size_t (n), flags: int
) : int(*verr*) = "mac#atsctrb_zmq_recv" // end of [zmq_recv]

(* ****** ****** *)

absviewt@ype
zmqmsg_viewt0ype = $extype"zmq_msg_t"
viewtypedef zmqmsg = zmqmsg_viewt0ype

(* ****** ****** *)

(*
void *zmq_msg_size (zmq_msg_t *msg);
*)
fun zmq_msg_size
  (msg: &zmqmsg):<> size_t = "mac#atsctrb_zmq_msg_size"
// end of [zmq_msg_size]

(*
void *zmq_msg_data (zmq_msg_t *msg);
*)
fun zmq_msg_data
  (msg: &zmqmsg):<> Ptr1 = "mac#atsctrb_zmq_msg_data"
// end of [zmq_msg_data]

(*
int zmq_msg_more (zmq_msg_t *message);
*)
fun zmq_msg_more (msg: &zmqmsg):<> natLt(2)

(* ****** ****** *)

macdef ZMQ_MORE = $extval (int, "ZMQ_MORE")

(*
int zmq_msg_get (zmq_msg_t *message, int property);
*)
fun zmq_msg_get
  (msg: &zmqmsg, property: int): int(*verr*) = "mac#atsctrb_zmq_msg_get"
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
) : interr = "mac#atsctrb_zmq_msg_set" // endfun

fun zmq_msg_set_exn
  (msg: &zmqmsg >> _, property: int, value: int): void
// end of [zmq_msg_set_exn]

(* ****** ****** *)

(*
int zmq_msg_init (zmq_msg_t *msg);
*)
fun zmq_msg_init (
  msg: &zmqmsg? >> opt (zmqmsg, i==0)
) : #[i:int | i <= 0] int (i) = "mac#atsctrb_zmq_msg_init"

fun zmq_msg_init_exn (msg: &zmqmsg? >> zmqmsg): void

(* ****** ****** *)

(*
int zmq_msg_init_size (zmq_msg_t *msg, size_t size);
*)
fun zmq_msg_init_size (
  msg: &zmqmsg? >> opt (zmqmsg, i==0), n: size_t
) : #[i:int | i <= 0] int (i) = "mac#atsctrb_zmq_msg_init_size"

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
fun zmq_msg_init_data (
  msg: &zmqmsg? >> opt (zmqmsg, i==0)
, data: ptr, size: size_t, ffn: zmq_free_fn, hint: ptr
) : #[i:int | i <= 0] int (i) = "mac#atsctrb_zmq_msg_init_data"

fun zmq_msg_init_data_exn
  (msg: &zmqmsg? >> zmqmsg, data: ptr, size: size_t, ffn: zmq_free_fn, hint: ptr): void
 // end of [zmq_msg_init_data_exn]

(* ****** ****** *)

(*
int zmq_msg_close (zmq_msg_t *msg);
*)
fun zmq_msg_close (
  msg: &zmqmsg >> opt(zmqmsg, i < 0)
) : #[i:int | i <= 0] int (i) = "mac#atsctrb_zmq_msg_close"

fun zmq_msg_close_exn (msg: &zmqmsg >> zmqmsg?): void

(* ****** ****** *)

(*
int zmq_msg_copy (zmq_msg_t *dest, zmq_msg_t *src);
*)
fun zmq_msg_copy
  (dst: &zmqmsg >> _, src: &zmqmsg): interr = "mac#atsctrb_zmq_msg_copy"
// end of [zmq_msg_copy]

fun zmq_msg_copy_exn (dst: &zmqmsg >> _, src: &zmqmsg): void

(* ****** ****** *)

(*
int zmq_msg_move (zmq_msg_t *dest, zmq_msg_t *src);
*)
fun zmq_msg_move
  (dst: &zmqmsg >> _, src: &zmqmsg): interr = "mac#atsctrb_zmq_msg_move"
// end of [zmq_msg_move]

fun zmq_msg_move_exn (dst: &zmqmsg >> _, src: &zmqmsg): void

(* ****** ****** *)

macdef
ZMQ_DONTWAIT =
  $extval (int, "ZMQ_DONTWAIT") // non-blocking send/receive
// end of [ZMQ_DONTWAIT]
macdef
ZMQ_SNDMORE =
  $extval (int, "ZMQ_SNDMORE") // for sending multi-part messages
macdef ZMQ_SENDMORE = ZMQ_SNDMORE // alias of more appropriate spelling

(* ****** ****** *)

(*
int zmq_msg_send (zmq_msg_t *msg, void *socket, int flags);
*)
fun zmq_msg_send (
  msg: &zmqmsg, sock: !zmqsock1, flags: int
) : interr = "mac#atsctrb_zmq_msg_send" // endfun

fun zmq_msg_send_exn
  (msg: &zmqmsg, sock: !zmqsock1, flags: int): intGte(0)
// end of [zmq_msg_send_exn]

(* ****** ****** *)

(*
int zmq_msg_recv (zmq_msg_t *msg, void *socket, int flags);
*)
fun zmq_msg_recv (
  msg: &zmqmsg >> _, sock: !zmqsock1, flags: int
) : interr = "mac#atsctrb_zmq_msg_recv" // endfun

fun zmq_msg_recv_exn
  (msg: &zmqmsg >> _, sock: !zmqsock1, flags: int): intGte(0)
// end of [zmq_msg_recv_exn]

(* ****** ****** *)

(*
void zmq_version (int *major, int *minor, int *patch);
*)
fun zmq_version (
  major: &int? >> int, minor: &int? >> int, patch: &int? >> int
) : void = "mac#atsctrb_zmq_version" // end of [zmq_version]

(* ****** ****** *)

(*
** HX: this one has been deprecated!
*)
fun zmq_term
  {l:agz} (
  ctx: !zmqctx (l) >> zmqctxopt (l, i < 0)
) : #[i:int | i <= 0] int (i) = "mac#atsctrb_zmq_term"

fun zmq_term_exn (ctx: zmqctx1): void

(* ****** ****** *)

(*
** HX: this one has been deprecated!
*)
fun zmq_sendmsg (
  msg: &zmqmsg, sock: !zmqsock1, flags: int
) : interr = "mac#atsctrb_zmq_sendmsg" // endfun

(*
** HX: this one has been deprecated!
*)
fun zmq_recvmsg (
  msg: &zmqmsg >> _, sock: !zmqsock1, flags: int
) : interr = "mac#atsctrb_zmq_recvmsg" // endfun

(* ****** ****** *)

(* end of [zmq.sats] *)
