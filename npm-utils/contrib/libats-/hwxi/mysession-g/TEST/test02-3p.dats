(* ****** ****** *)

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
#staload
UNISTD =
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload $INTSET // opening it
#staload $SSNTYPE // opening it
#staload $SSNTYPE2R // opening it
//
(* ****** ****** *)

#define N 3

(* ****** ****** *)
//
typedef
ssn_hello =
msg(1, 2, string) ::
msg(2, 0, string) ::
msg(2, 1, string) ::
msg(0, 1, string) :: nil
//
(* ****** ****** *)

stadef S0 = iset(0)
stadef C1 = iset(1)
stadef C2 = iset(2)

(* ****** ****** *)
//
extern
fun
hello_server0(chan: channel1(S0, N, ssn_hello)): void
extern
fun
hello_client1(chan: channel1(C1, N, ssn_hello)): void
extern
fun
hello_client2(chan: channel1(C2, N, ssn_hello)): void
//
(* ****** ****** *)

implement
hello_server0(chan) =
{
//
prval() =
lemma_iset_sing_is_member{0}()
prval() =
lemma_iset_sing_isnot_member{0,1}()
prval() =
lemma_iset_sing_isnot_member{0,2}()
//
val () = channel1_skipex(chan)
//
val msg = channel1_recv_val(chan, 2, 0)
val ((*void*)) =
  println! ("hello_server0: msg = ", msg)
//
val () = channel1_skipex(chan)
//
val () = channel1_send(chan, 0, 1, "msg(0, 1)")
//
val ((*closed*)) = channel1_close(chan)
//
} (* end of [hello_server0] *)

(* ****** ****** *)

implement
hello_client1(chan) =
{
//
prval() =
lemma_iset_sing_is_member{1}()
prval() =
lemma_iset_sing_isnot_member{1,0}()
prval() =
lemma_iset_sing_isnot_member{1,2}()
//
val () =
  channel1_send
    (chan, 1, 2, "msg(1, 2)")
  // channel1_send
//
val () = channel1_skipex(chan)
//
val msg =
  channel1_recv_val(chan, 2, 1)
val ((*void*)) =
  println! ("hello_client1: msg = ", msg)
//
val msg =
  channel1_recv_val(chan, 0, 1)
val ((*void*)) =
  println! ("hello_client1: msg = ", msg)
//
val ((*closed*)) = channel1_close(chan)
//
} (* end of [hello_client1] *)
//
(* ****** ****** *)

implement
hello_client2(chan) =
{
//
prval() =
lemma_iset_sing_is_member{2}()
prval() =
lemma_iset_sing_isnot_member{2,0}()
prval() =
lemma_iset_sing_isnot_member{2,1}()
//
val msg =
  channel1_recv_val(chan, 1, 2)
val ((*void*)) =
  println! ("hello_client2: msg = ", msg)
//
val () =
channel1_send(chan, 2, 0, "msg(2, 0)")
val () =
channel1_send(chan, 2, 1, "msg(2, 1)")
//
val () = channel1_skipex(chan)
//
val ((*closed*)) = channel1_close(chan)
//
} (* end of [hello_client2] *)
//
(* ****** ****** *)

implement
main0
(
  argc, argv
) = let
//
val S0 = intset_int{N}(0)
val C1 = intset_int{N}(1)
val C2 = intset_int{N}(2)
//
val chn0 =
cchannel1_create_exn
(
  N, S0, llam(chp) => hello_server0(chp)
) (* end of [val] *)
val chn2 =
cchannel1_create_exn
(
  N, C2, llam(chp) => hello_client2(chp)
) (* end of [val] *)
//
in
  hello_client1(channel1_link(chn0, chn2))
end // end of [main0]

(* ****** ****** *)

(* end of [test02-3p.dats] *)
