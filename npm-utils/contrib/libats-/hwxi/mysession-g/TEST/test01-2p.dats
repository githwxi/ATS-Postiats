(*
** For testing g-sessions
*)

(* ****** ****** *)

%{^
//
#include <pthread.h>
//
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload _ =
"libats/DATS/deqarray.dats"
//
(* ****** ****** *)
//
#staload _ =
"libats/DATS/athread.dats"
#staload _ =
"libats/DATS/athread_posix.dats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload $INTSET // opening it
#staload $SSNTYPE // opening it
#staload $SSNTYPE2R // opening it
//
(* ****** ****** *)
//
typedef
ssn_hello =
msg(0, 1, string) ::
msg(1, 0, string) ::
msg(0, 1, string) :: nil
//
(* ****** ****** *)
//
extern
fun
hello_server(chan: chan1pos(ssn_hello)): void
extern
fun
hello_client(chan: chan1neg(ssn_hello)): void
//
(* ****** ****** *)

implement
hello_server(chan) =
{
//
val ((*void*)) =
  chan1pos_send(chan, "Hi!")
//
val msg =
  chan1pos_recv_val(chan)
val ((*void*)) =
  println! ("hello_server: msg = ", msg)
//
val ((*void*)) =
  chan1pos_send(chan, "Bye-bye!")
//
val ((*closed*)) = channel1_close(chan)
//
} (* end of [hello_server] *)

(* ****** ****** *)

implement
hello_client(chan) =
{
//
val msg = chan1neg_send_val(chan)
val ((*void*)) =
  println! ("hello_client: msg = ", msg)
//
val () =
  chan1neg_recv(chan, "Hello?")
//
val msg = chan1neg_send_val(chan)
val ((*void*)) =
  println! ("hello_client: msg = ", msg)
//
val ((*closed*)) = channel1_close(chan)
//
} (* end of [hello_client] *)

(* ****** ****** *)

implement
main0
(
  argc, argv
) = let
//
val chn =
chan1neg_create_exn
(
  llam(chp) => hello_server(chp)
) (* end of [val] *)
//
in
  hello_client(chn)
end // end of [main0]

(* ****** ****** *)

(* end of [test01-2p.dats] *)
