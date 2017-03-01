(* ****** ****** *)
//
// This example is at
// http://pastebin.com/JmZRukRi
//
(* ****** ****** *)

(*
**
** For testing g-sessions
**
** This famous example is taken from
** a paper on multiparty session types
** by Kohei Honda et al.
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

staload
UNISTD = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload
"./../SATS/basis_intset.sats"
staload _ =
"./../DATS/basis_intset.dats"

(* ****** ****** *)
//
staload
"./../SATS/basis_ssntype.sats"
staload
"./../SATS/basis_ssntype2r.sats"
//
(* ****** ****** *)
//
staload _ =
"libats/DATS/deqarray.dats"
//
(* ****** ****** *)
//
staload _ =
"libats/DATS/athread.dats"
staload _ =
"libats/DATS/athread_posix.dats"
//
(* ****** ****** *)
//
staload _ =
"./../DATS/basis_uchan.dats"
staload _ =
"./../DATS/basis_channel0.dats"
staload _ =
"./../DATS/basis_channel1.dats"
staload _ =
"./../DATS/basis_ssntype2r.dats"
//
(* ****** ****** *)

#define N 3

(* ****** ****** *)

#define SELLER 0
#define BUYER1 1
#define BUYER2 2

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
ssn_s0b1b2 =
msg(BUYER1,SELLER,title) ::
msg(SELLER,BUYER1,price) ::
msg(SELLER,BUYER2,price) ::
msg(BUYER1,BUYER2,price) ::
choose(BUYER2,ssn_s0b1b2_succ,ssn_s0b1b2_fail)

(* ****** ****** *)

stadef S0 = iset(SELLER)
stadef B1 = iset(BUYER1)
stadef B2 = iset(BUYER2)

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
  channel1(S0, N, ssn_s0b1b2)
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
| _(*other*) => 500.0
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
  channel1(S0, N, ssn_s0b1b2_succ)
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
  channel1(S0, N, ssn_s0b1b2_fail)
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
  channel1(B1, N, ssn_s0b1b2)
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
  channel1(B1, N, ssn_s0b1b2_succ)
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
  channel1(B1, N, ssn_s0b1b2_fail)
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

fun
fserv_buyer2
(
  chan:
  channel1(B2, N, ssn_s0b1b2)
) : void = let
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
val test = (price - price2 <= 100.0)
//
in
//
if test
then {
  val () =
  channel1_choose_l(chan, BUYER2)
  val () = fserv_buyer2_succ(chan)
} (* end of [then] *)
else {
  val () =
  channel1_choose_r(chan, BUYER2)
  val () = fserv_buyer2_fail(chan)
} (* end of [else] *)
//
end (* end of [fserv_buyer2] *)

and
fserv_buyer2_succ
(
  chan:
  channel1(B2, N, ssn_s0b1b2_succ)
) : void = let
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

and
fserv_buyer2_fail
(
  chan:
  channel1(B2, N, ssn_s0b1b2_fail)
) : void =
{
  val () = channel1_close(chan)
} (* end of [fserv_buyer2_fail] *)

end // end of [local]

(* ****** ****** *)
//
// Try the following to see difference:
//
// ./S0B1B2 book1
// ./S0B1B2 book2
// ./S0B1B2 book3
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
val S0 = intset_int{N}(SELLER)
val B1 = intset_int{N}(BUYER1)
val B2 = intset_int{N}(BUYER2)
//
val chn0 =
cchannel1_create_exn
(
  N, S0, llam(chp) => fserv_seller(chp)
) (* end of [val] *)
val chn2 =
cchannel1_create_exn
(
  N, B2, llam(chp) => fserv_buyer2(chp)
) (* end of [val] *)
//
val () = fserv_buyer1(channel1_link(chn0, chn2))
//
in
  ignoret($UNISTD.usleep(250000u)) // wait for S0 and B2
end // end of [main0]

(* ****** ****** *)

(* end of [S0B1B2-pastebin.dats] *)
