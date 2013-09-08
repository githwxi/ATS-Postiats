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
//
// HX: no dynloading
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

staload "./../SATS/zmq.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

(*
fun zmq_socket_exn
  (ctx: !zmqctx1, type: int): zmqsock1
// end of [zmq_socket_exn]
*)
implement
zmq_socket_exn
  (ctx, type) = let
  val sock = zmq_socket (ctx, type)
  val p_sock = zmqsock2ptr (sock)
  val () = assertloc (p_sock > nullp)
in
  sock
end // end of [zmq_socket_exn]

(* ****** ****** *)

(*
fun zmq_bind_exn
(
  sock: !zmqsock1, endpt: NSH(string)
) : void // end of [zmq_bind_exn]
*)
implement
zmq_bind_exn
  (sock, endpt) = () where {
  val err = zmq_bind (sock, endpt)
  val () = assertloc (err >= 0)
} // end of [zmq_bind_exn]

(* ****** ****** *)

(*
fun zmq_connect_exn
(
  sock: !zmqsock1, endpt: NSH(string)
) : void // end of [zmq_connect_exn]
*)
implement
zmq_connect_exn
  (sock, endpt) = () where {
  val err = zmq_connect (sock, endpt)
  val () = assertloc (err >= 0)
} // end of [zmq_connect_exn]

(* ****** ****** *)

(*
fun zmq_close_exn (sock: zmqsock1) : void
*)
implement
zmq_close_exn
  (sock) = () where {
  val err = zmq_close (sock)
  val () = assertloc (err >= 0)
} // end of [zmq_close_exn]

(* ****** ****** *)

(*
fun zmq_msg_init_exn
  (msg: &zmqmsg? >> zmqmsg): void
*)
implement
zmq_msg_init_exn
  (msg) = () where {
  val err = zmq_msg_init (msg)
  val () = assertloc (err >= 0)
  prval () = opt_unsome {zmqmsg} (msg)
} // end of [zmq_msg_init_exn]

(* ****** ****** *)

(*
fun zmq_msg_init_size_exn
  (msg: &zmqmsg? >> zmqmsg, n: size_t): void
*)
implement
zmq_msg_init_size_exn
  (msg, size) = () where {
  val err = zmq_msg_init_size (msg, size)
  val () = assertloc (err >= 0)
  prval () = opt_unsome {zmqmsg} (msg)
} // end of [zmq_msg_init_size_exn]

(* ****** ****** *)

(*
fun zmq_msg_close_exn
  (msg: &zmqmsg >> zmqmsg?): void
*)
implement
zmq_msg_close_exn
  (msg) = () where {
  val err = zmq_msg_close (msg)
  val () = assertloc (err >= 0)
  prval () = opt_unnone {zmqmsg} (msg)
} // end of [zmq_msg_close_exn]

(* ****** ****** *)

(*
fun zmq_msg_send_exn
(
  msg: &zmqmsg, sock: !zmqsock1, flags: int
) : intGte(0) // end of [zmq_msg_send_exn]
*)
implement
zmq_msg_send_exn (
  msg, sock, flags
) = valerr where {
  val valerr = zmq_msg_send (msg, sock, flags)
  val () = assertloc (valerr >= 0)
} // end of [zmq_msg_send_exn]

(* ****** ****** *)

(*
fun zmq_msg_recv_exn
(
  msg: &zmqmsg, sock: !zmqsock1, flags: int
) : intGte(0) // end of [zmq_msg_recv_exn]
*)
implement
zmq_msg_recv_exn (
  msg, sock, flags
) = valerr where {
  val valerr = zmq_msg_recv (msg, sock, flags)
  val () = assertloc (valerr >= 0)
} // end of [zmq_msg_recv_exn]

(* ****** ****** *)

(* end of [zmq.dats] *)
