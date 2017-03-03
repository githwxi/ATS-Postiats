(*
**
** For testing g-sessions
**
** This famous example is taken from
** a paper on multiparty session types
** by Kohei Honda et al.
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

#define N2 2
#define N3 3

(* ****** ****** *)

#define SELLER 0
#define BUYER1 1
#define BUYER2 2

(* ****** ****** *)

#define BUYER_1 1
#define BUYER_2 0

(* ****** ****** *)

typedef title = string
typedef price = double
typedef proof = string
typedef receipt = string

(* ****** ****** *)

typedef
ssn_s0b1b2_succ =
msg(BUYER2,SELLER,proof) ::
msg(SELLER,BUYER2,receipt) :: nil

typedef
ssn_s0b1b2_fail = nil

typedef
ssn_s0b1b2_b2_choose =
choose(BUYER2,ssn_s0b1b2_succ,ssn_s0b1b2_fail)

typedef
ssn_s0b1b2 =
msg(BUYER1,SELLER,title) ::
msg(SELLER,BUYER1,price) ::
msg(SELLER,BUYER2,price) ::
msg(BUYER1,BUYER2,price) :: ssn_s0b1b2_b2_choose

(* ****** ****** *)

stadef S0 = iset(SELLER)
stadef B1 = iset(BUYER1)
stadef B2 = iset(BUYER2)

(* ****** ****** *)

stadef B_1 = iset(BUYER_1)
stadef B_2 = iset(BUYER_2)

(* ****** ****** *)
//
typedef result = bool
//
stadef
channel_choose =
channel1
  (B2, N3, ssn_s0b1b2_b2_choose)
//
typedef
ssn_b_1_b_2 =
msg(BUYER_1, BUYER_2, price) ::
msg(BUYER_1, BUYER_2, channel_choose) ::
msg(BUYER_2, BUYER_1, result) :: nil
//
(* ****** ****** *)
//
extern
fun
fserv_buyer_1
(
  k: int
, p0: price
, ch: channel_choose
) : result // end-of-function
extern
fun
fserv_buyer_1_
(
  k: int
, p0: price
, ch: channel_choose
) : result // end-of-function
//
extern
fun
fserv_buyer_2
(
  k: int
, chan:
  chan1pos(ssn_b_1_b_2)
) : void // end-of-function
//
(* ****** ****** *)

extern
fun
fserv_buyer2
(
  chan:
  channel1(B2, N3, ssn_s0b1b2)
) : void // end-of-function
and
fserv_buyer2_succ
(
  chan:
  channel1(B2, N3, ssn_s0b1b2_succ)
) : void // end-of-function

(* ****** ****** *)

implement
fserv_buyer_1
  (k, p0, ch0) = let
//
prval() =
lemma_iset_sing_is_member{BUYER2}()
//
val p1 = p0 - 100.0
//
in
if
p1 > 0.0
then (
//
if k > 0
  then fserv_buyer_1_(k-1, p1, ch0)
  else false where
  {
    val () =
      channel1_choose_r(ch0, BUYER2)
    // end of [val]
    val ((*closed*)) = channel1_close(ch0)
  } (* end of [else] *)
//
) (* end of [then] *)
else true where
{
  val () =
  channel1_choose_l(ch0, BUYER2)
  val () = fserv_buyer2_succ(ch0)
} (* end of [else] *)
end // end of [fserv_buyer_1]

implement
fserv_buyer_1_
  (k, p0, ch0) =
  res where
{
//
val
chneg =
chan1neg_create_exn
(
  llam(chp) => fserv_buyer_2(k, chp)
) (* end of [val] *)
//
val () = chan1neg_recv(chneg, p0)
val () = chan1neg_recv(chneg, ch0)
val res = chan1neg_send_val(chneg)
val ((*closed*)) = channel1_close(chneg)
} (* end of [fserv_buyer_1_] *)

(* ****** ****** *)

implement
fserv_buyer_2
  (k, chpos) = let
//
val p0 = chan1pos_recv_val(chpos)
val ch = chan1pos_recv_val(chpos)
//
val res = fserv_buyer_1(k, p0, ch)
//
val () = chan1pos_send(chpos, res)
val ((*closed*)) = channel1_close(chpos)
//
in
  
end // end of [fserv_buyer_2]

(* ****** ****** *)

local
//
prval() =
lemma_iset_sing_is_member{SELLER}()
prval() =
lemma_iset_sing_isnot_member{SELLER,BUYER1}()
prval() =
lemma_iset_sing_isnot_member{SELLER,BUYER2}()
//
prval() = lemma_iset_sing_isnot_nil{SELLER}()
//
in (* in-of-local *)

fun
fserv_seller
(
  chan:
  channel1(S0, N3, ssn_s0b1b2)
) : void = let
//
val
title =
channel1_recv_val(chan, BUYER1, SELLER)
val () =
println! ("SELLER: title = ", title)
//
val
price =
(
case+
title of
| "book1" => 100.0
| "book2" => 200.0
| _(*other*) => 1000.0
) : price
//
val () =
channel1_send
  (chan, SELLER, BUYER1, price)
val () =
channel1_send
  (chan, SELLER, BUYER2, price)
//
val () = channel1_skipex(chan)
//
val tag =
  channel1_choose_tag(chan, BUYER2)
//
in
//
case+ tag of
| choosetag_l() => fserv_seller_succ(chan)
| choosetag_r() => fserv_seller_fail(chan)
//
end (* end of [fserv_seller] *)

and
fserv_seller_succ
(
  chan:
  channel1(S0, N3, ssn_s0b1b2_succ)
) : void = let
//
val
proof =
channel1_recv_val(chan, BUYER2, SELLER)
val
receipt = "receipt-for-sale"
val () =
channel1_send(chan, SELLER, BUYER2, receipt)
//
in
  channel1_close(chan)
end (* end of [fserv_seller_succ] *)

and
fserv_seller_fail
(
  chan:
  channel1(S0, N3, ssn_s0b1b2_fail)
) : void =
{
  val () = channel1_close(chan)
  val () = println! ("SELLER: no sale is made!")
} (* end of [fserv_seller_fail] *)

end // end of [local]

(* ****** ****** *)

local

val
title_ref = ref<string>("book1")

in
//
fun the_title_get() = !title_ref
fun the_title_set(title: string): void = !title_ref := title
//
end // end of [local]

(* ****** ****** *)

local
//
prval() =
lemma_iset_sing_is_member{BUYER1}()
prval() =
lemma_iset_sing_isnot_member{BUYER1,SELLER}()
prval() =
lemma_iset_sing_isnot_member{BUYER1,BUYER2}()
//
prval() = lemma_iset_sing_isnot_nil{BUYER1}()
//
in (* in-of-local *)

fun
fserv_buyer1
(
  chan:
  channel1(B1, N3, ssn_s0b1b2)
) : void = let
//
val
title = the_title_get()
//
val () =
channel1_send
  (chan, BUYER1, SELLER, title)
//
val
price = 
channel1_recv_val
  (chan, SELLER, BUYER1)
val () =
println!("BUYER1: price = ", price)
//
val () = channel1_skipex(chan)
//
val () =
channel1_send
  (chan, BUYER1, BUYER2, price / 2)
//
val tag =
  channel1_choose_tag(chan, BUYER2)
//
in
//
case+ tag of
| choosetag_l() => fserv_buyer1_succ(chan)
| choosetag_r() => fserv_buyer1_fail(chan)
//
end // end of [fserv_buyer1]

and
fserv_buyer1_succ
(
  chan:
  channel1(B1, N3, ssn_s0b1b2_succ)
) : void =
{
  val () = channel1_skipex(chan)
  val () = channel1_skipex(chan)
  val ((*closed*)) = channel1_close(chan)
} (* end of [fserv_buyer1_succ] *)

and
fserv_buyer1_fail
(
  chan:
  channel1(B1, N3, ssn_s0b1b2_fail)
) : void =
{
  val ((*closed*)) = channel1_close(chan)
} (* end of [fserv_buyer1_fail] *)

end // end of [local]

(* ****** ****** *)

local
//
prval() =
lemma_iset_sing_is_member{BUYER2}()
prval() =
lemma_iset_sing_isnot_member{BUYER2,SELLER}()
prval() =
lemma_iset_sing_isnot_member{BUYER2,BUYER1}()
//
prval() = lemma_iset_sing_isnot_nil{BUYER2}()
//
in (* in-of-local *)

implement
fserv_buyer2
  (chan) = let
//
val () = channel1_skipex(chan)
val () = channel1_skipex(chan)
//
val
price =
channel1_recv_val
  (chan, SELLER, BUYER2)
val
price2 =
channel1_recv_val
  (chan, BUYER1, BUYER2)
//
val () =
println!("BUYER2: price = ", price)
val () =
println!("BUYER2: price2 = ", price2)
//
val res =
  fserv_buyer_1(1, price - price2, chan)
//
in
//
  println! ("fserv_buyer2: res = ", res)  
//
end (* end of [fserv_buyer2] *)

implement
fserv_buyer2_succ
  (chan) = let
//
val
proof = "proof-of-payment"
val () =
channel1_send
  (chan, BUYER2, SELLER, proof)
//
val
receipt =
channel1_recv_val(chan, SELLER, BUYER2)
val () =
println! ("BUYER2: receipt = ", receipt)
//
in
  channel1_close(chan)
end (* end of [fserv_buyer2_succ] *)

end // end of [local]

(* ****** ****** *)
//
// HX:
//
// Try the following to see difference:
//
// ./S0B1B2_rec book1
// ./S0B1B2_rec book2
// ./S0B1B2_rec book3
//
implement
main0
(
  argc, argv
) = let
//
val () =
if argc >= 2
  then the_title_set(argv[1])
// end of [if]
//
val S0 = intset_int{N3}(SELLER)
val B1 = intset_int{N3}(BUYER1)
val B2 = intset_int{N3}(BUYER2)
//
val chn0 =
cchannel1_create_exn
(
  N3, S0, llam(chp) => fserv_seller(chp)
) (* end of [val] *)
val chn2 =
cchannel1_create_exn
(
  N3, B2, llam(chp) => fserv_buyer2(chp)
) (* end of [val] *)
//
val () = fserv_buyer1(channel1_link(chn0, chn2))
//
in
  ignoret($UNISTD.usleep(250000u)) // wait for S0 and B2
end // end of [main0]

(* ****** ****** *)

(* end of [S0B1B2.dats] *)
