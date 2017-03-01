(*
**
** For testing g-sessions
**
** This example involves 4 parties,
** passing 4 messages in a ring-like
** fashion.
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: the 8th of March, 2016
**
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

#staload UN = $UNSAFE

(* ****** ****** *)
//
#staload
UNISTD =
"libats/libc/SATS/unistd.sats"
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

#define N 4

(* ****** ****** *)
//
typedef
ssn_ring4 =
msg(0, 1, string) ::
msg(1, 2, string) ::
msg(2, 3, string) ::
msg(3, 0, string) :: nil
//
(* ****** ****** *)
//
stadef S0 = iset(0)
stadef S1 = iset(1)
stadef S2 = iset(2)
stadef S3 = iset(3)
//
stadef S02 = iset(0,2)
stadef S13 = iset(1,3)
//
(* ****** ****** *)
//
fun
fserv_client0
(
  chan:
  channel1(S0, N, ssn_ring4)
) : void =
{
//
prval() =
lemma_iset_sing_is_member{0}()
prval() =
lemma_iset_sing_isnot_member{0,1}()
prval() =
lemma_iset_sing_isnot_member{0,2}()
prval() =
lemma_iset_sing_isnot_member{0,3}()
//
val () =
channel1_send
  (chan, 0, 1, "msg(0, 1)")
//
val () = channel1_skipex(chan)
val () = channel1_skipex(chan)
//
val
msg = channel1_recv_val(chan, 3, 0)
val () = println! ("client0: msg = ", msg)
//
val () = channel1_close(chan)
//
} (* end of [fserv_client0] *)
//
(* ****** ****** *)
//
fun
fserv_client1
(
  chan:
  channel1(S1, N, ssn_ring4)
) : void =
{
//
prval() =
lemma_iset_sing_is_member{1}()
prval() =
lemma_iset_sing_isnot_member{1,0}()
prval() =
lemma_iset_sing_isnot_member{1,2}()
prval() =
lemma_iset_sing_isnot_member{1,3}()
//
val
msg =
channel1_recv_val(chan, 0, 1)
val () =
println! ("client1: msg = ", msg)
//
val () =
channel1_send(chan, 1, 2, "msg(1, 2)")
//
val () = channel1_skipex(chan)
val () = channel1_skipex(chan)
//
val () = channel1_close(chan)
//
} (* end of [fserv_client1] *)
//
(* ****** ****** *)
//
fun
fserv_client2
(
  chan:
  channel1(S2, N, ssn_ring4)
) : void =
{
//
prval() =
lemma_iset_sing_is_member{2}()
prval() =
lemma_iset_sing_isnot_member{2,0}()
prval() =
lemma_iset_sing_isnot_member{2,1}()
prval() =
lemma_iset_sing_isnot_member{2,3}()
//
val () =
  channel1_skipex(chan)
//
val
msg =
channel1_recv_val(chan, 1, 2)
val () =
println! ("client2: msg = ", msg)
//
val () =
channel1_send(chan, 2, 3, "msg(2, 3)")
//
val () = channel1_skipex(chan)
//
val () = channel1_close(chan)
//
} (* end of [fserv_client2] *)
//
(* ****** ****** *)
//
fun
fserv_client3
(
  chan:
  channel1(S3, N, ssn_ring4)
) : void =
{
//
prval() =
lemma_iset_sing_is_member{3}()
prval() =
lemma_iset_sing_isnot_member{3,0}()
prval() =
lemma_iset_sing_isnot_member{3,1}()
prval() =
lemma_iset_sing_isnot_member{3,2}()
//
val () =
  channel1_skipex(chan)
val () =
  channel1_skipex(chan)
//
val
msg =
channel1_recv_val(chan, 2, 3)
val () =
println!("client3: msg = ", msg)
//
val () =
channel1_send(chan, 3, 0, "msg(3, 0)")
//
val () = channel1_close(chan)
//
} (* end of [fserv_client3] *)
//
(* ****** ****** *)

implement
main0
(
  argc, argv
) = let
//
val S0 = intset_int{N}(0)
val S1 = intset_int{N}(1)
val S2 = intset_int{N}(2)
val S3 = intset_int{N}(3)
//
val chn0 =
cchannel1_create_exn
(
  N, S0, llam(chp) => fserv_client0(chp)
) (* end of [val] *)
val chn2 =
cchannel1_create_exn
(
  N, S2, llam(chp) => fserv_client2(chp)
) (* end of [val] *)
//
val chn1 =
cchannel1_create_exn
(
  N, S1, llam(chp) => fserv_client1(chp)
) (* end of [val] *)
val chn3 =
cchannel1_create_exn
(
  N, S3, llam(chp) => fserv_client3(chp)
) (* end of [val] *)
//
val () =
channel1_link_elim
(
  channel1_link(chn0, $UN.castvwtp0(chn2))
, channel1_link(chn1, $UN.castvwtp0(chn3))
) (* end of [val] *)
//
in
  ignoret($UNISTD.usleep(250000u)) // wait until the 4 threads finish
end // end of [main0]

(* ****** ****** *)

(* end of [test03-4p.dats] *)
