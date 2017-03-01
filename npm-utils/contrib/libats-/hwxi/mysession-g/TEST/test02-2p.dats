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
stadef C12 = iset(1,2)

(* ****** ****** *)
//
extern
fun
hello_server0(chan: channel1(S0, N, ssn_hello)): void
extern
fun
hello_client12(chan: channel1(C12, N, ssn_hello)): void
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
hello_client12(chan) =
{
//
val () = channel1_skipin(chan)
//
val () =
channel1_send(chan, 2, 0, "msg(2, 0)")
//
val () = channel1_skipin(chan)
//
val msg = channel1_recv_val(chan, 0, 1)
//
val () = println! ("hello_client12: msg = ", msg)
//
val ((*closed*)) = channel1_close(chan)
//
} (* end of [hello_client12] *)
//
(* ****** ****** *)

implement
main0
(
  argc, argv
) = let
//
val S0 = intset_int{N}(0)
val C12 = intset_int2{N}(1,2)
//
val chn0 =
cchannel1_create_exn
(
  N, S0
, llam(chp) => hello_server0(chp)
) (* end of [val] *)
//
val ((*void*)) = hello_client12(chn0)
//
in
  // nothiong
end // end of [main0]

(* ****** ****** *)

(* end of [test02-2p.dats] *)
