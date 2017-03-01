(*
** Bit-strings
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
#staload UN = $UNSAFE
//
(* ****** ****** *)
//
#staload
UNISTD =
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
#staload
_ = "libats/DATS/deqarray.dats"
//
(* ****** ****** *)
//
#staload
_ = "libats/DATS/athread.dats"
#staload
_ = "libats/DATS/athread_posix.dats"
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
abstype
ssn_list(a:vt@ype)
//
(* ****** ****** *)
//
datatype
chan1neg_list
  (a:vt@ype, type) =
| chan1neg_list_nil(a, nil) of ()
| chan1neg_list_cons
    (a, snd(a) :: ssn_list(a)) of ()
  // chan1neg_list_cons
//
(* ****** ****** *)
//
extern
fun{}
chan1neg_list
  {a:vt@ype}
(
  chneg:
  !chan1neg(ssn_list(a)) >> chan1neg(ss)
) : #[ss:type] chan1neg_list(a, ss)
//
(* ****** ****** *)
//
extern
fun{}
chan1pos_list_nil
  {a:vt@ype}
(
  chpos:
  !chan1pos(ssn_list(a)) >> chan1pos(nil)
) : void // end of [chan1pos_list_nil]
extern
fun{}
chan1pos_list_cons
  {a:vt@ype}
(
  chpos:
  !chan1pos(ssn_list(a)) >> chan1pos(snd(a)::ssn_list(a))
) : void // end of [chan1pos_list_cons]
//
(* ****** ****** *)

implement
{}(*tmp*)
chan1pos_list_nil
  (chpos) = () where
{
//
vtypedef
chan0 = $CHANNEL0.channel0(ptr, 2)
//
val
chan0 = $UN.castvwtp1{chan0}(chpos)
//
val () =
$CHANNEL0.channel0_send(chan0, 0, 1, $UN.int2ptr(0))
//
prval () = $UN.cast2void(chan0)
prval () = $UN.castview2void(chpos)
//
} (* end of [chan1pos_list_nil] *)
//
(* ****** ****** *)

implement
{}(*tmp*)
chan1pos_list_cons
  (chpos) = () where
{
//
vtypedef
chan0 = $CHANNEL0.channel0(ptr, 2)
//
val
chan0 = $UN.castvwtp1{chan0}(chpos)
//
val () =
$CHANNEL0.channel0_send(chan0, 0, 1, $UN.int2ptr(1))
//
prval () = $UN.cast2void(chan0)
prval () = $UN.castview2void(chpos)
//
} (* end of [chan1pos_list_cons] *)

(* ****** ****** *)

implement
{}(*tmp*)
chan1neg_list
  (chneg) = let
//
vtypedef
chan0 = $CHANNEL0.channel0(ptr, 2)
val
chan0 = $UN.castvwtp1{chan0}(chneg)
//
val tag =
  $CHANNEL0.channel0_recv_val(chan0, 0, 1)
//
prval () = $UN.cast2void(chan0)
//
in
//
if
iseqz(tag)
then let
  prval () = $UN.castview2void(chneg) in chan1neg_list_nil()
end // end of [then]
else let
  prval () = $UN.castview2void(chneg) in chan1neg_list_cons()
end // end of [else]
//
end // end of [chan1neg_list]

(* ****** ****** *)
//
abst@ype bit = int
//
macdef B0 = $UN.cast{bit}(0)
macdef B1 = $UN.cast{bit}(1)
//
typedef bit_ = natLt(2)
//
extern castfn bit2bit_(bit): bit_
//
(* ****** ****** *)
//
extern
fun
int2bits
  {n:nat}(int(n)): chan1neg(ssn_list(bit))
//
(* ****** ****** *)

implement
int2bits(n) = let
//
fun
fserv{n:nat}
(
  n: int(n), chp: chan1pos(ssn_list(bit))
) : void = (
//
if
n > 0
then let
  val n2 = half(n)
  val bit =
  (
    if n = 2*n2 then B0 else B1
  ) : bit // end of [val]
  val () = chan1pos_list_cons(chp)
  val ((*void*)) = chan1pos_send<bit>(chp, bit)
in
  fserv(n2, chp)
end // end of [then]
else let
  val () = chan1pos_list_nil(chp) in channel1_close(chp)
end // end of [else]
//
) (* end of [fserv] *)
//
in
  chan1neg_create_exn{ssn_list(bit)}(llam(chp) => fserv(n, chp))
end // end of [int2bits]

(* ****** ****** *)
//
extern
fun
succ_bits
(
  chneg:
  chan1neg(ssn_list(bit))
) : chan1neg(ssn_list(bit))
//
(* ****** ****** *)

implement
succ_bits(chn) = let
//
fun
fserv
(
  chp: chan1pos(ssn_list(bit))
, chn: chan1neg(ssn_list(bit))
) : void = let
//
val opt = chan1neg_list(chn)
//
in
//
case+ opt of
| chan1neg_list_nil() => let
    val () =
      chan1pos_list_cons(chp)
    val () =
      chan1pos_send<bit>(chp, B1)
    val () =
      chan1pos_list_nil(chp)
    // end of [val]
    val () = channel1_close(chp)
    val () = channel1_close(chn)
  in
    // nothing
  end // end of [chan1neg_list_nil]
| chan1neg_list_cons() => let
    val () =
      chan1pos_list_cons (chp)
    val bit = chan1neg_send_val<bit> (chn)
    val bit_ = bit2bit_(bit)
  in
    if bit_ > 0
      then let
        val () =
          chan1pos_send (chp, B0)
        // end of [val]
      in
        fserv(chp, chn)
      end // end of [then]
      else let
        val () =
          chan1pos_send (chp, B1)
        // end of [val]
      in
        chan1posneg_elim(chp, chn)
      end // end of [else]
  end // end of [chan1neg_list_cons]
//
end // end of [fserv]
//
in
  chan1neg_create_exn{ssn_list(bit)}(llam(chp) => fserv(chp, chn))
end // end of [succ_bits]
  
(* ****** ****** *)

extern
fun
add_bits_bits
(
  chan1neg(ssn_list(bit))
, chan1neg(ssn_list(bit))
) : chan1neg(ssn_list(bit))

(* ****** ****** *)

implement
add_bits_bits
  (chn1, chn2) = let
//
fun
fserv
(
  chp: chan1pos(ssn_list(bit))
, chn1: chan1neg(ssn_list(bit))
, chn2: chan1neg(ssn_list(bit))
) : void = let
//
val opt1 = chan1neg_list (chn1)
//
in
//
case+ opt1 of
| chan1neg_list_nil() => let
    val () = channel1_close(chn1)
  in
    chan1posneg_elim (chp, chn2)
  end // end of [chan1neg_list_nil]
| chan1neg_list_cons() => let
    val () =
      chan1pos_list_cons (chp)
    // end of [val]
    val opt2 = chan1neg_list (chn2)
  in
    case+ opt2 of
    | chan1neg_list_nil() => let
        val () =
          channel1_close(chn2)
        // end of [val]
      in
        chan1posneg_elim(chp, chn1)
      end // end of [chan1neg_list_nil]
    | chan1neg_list_cons() => let
        val b1 = chan1neg_send_val(chn1)
        and b2 = chan1neg_send_val(chn2)
        val b1_ = bit2bit_(b1) and b2_ = bit2bit_(b2)
      in
        case+ b1_ of
        | 0 => (
            chan1pos_send(chp, b2); fserv(chp, chn1, chn2)
          ) (* end of [0] *)
        | 1 => (
            case+ b2_ of
            | 0 => (chan1pos_send(chp, B1); fserv(chp, chn1, chn2))
            | 1 => (chan1pos_send(chp, B0); fserv(chp, chn1, succ_bits(chn2)))
          ) (* end of [1] *)
      end // end of [chan1neg_list_cons]
  end // end of [chan1neg_list_cons]
//
end // end of [fserv]
//
in
  chan1neg_create_exn{ssn_list(bit)}(llam(chp) => fserv(chp, chn1, chn2))
end // end of [add_bits_bits]

(* ****** ****** *)
//
extern
fun
bits2int
(
  chn: chan1neg(ssn_list(bit))
) : intGte(0) // end-of-function
//
(* ****** ****** *)

implement
bits2int(chn) = let
//
fun
loop
(
  xs: List0_vt(bit), res: intGte(0)
) : intGte(0) =
(
case+ xs of
| ~list_vt_nil() => res
| ~list_vt_cons(x, xs) =>
    loop (xs, 2*res + bit2bit_(x))
) (* end of [loop] *)
//
//
fun
loop2
(
  chn: chan1neg(ssn_list(bit)), xs: List0_vt(bit)
) : List0_vt(bit) = let
//
val opt = chan1neg_list(chn)
//
in
//
case+ opt of
| chan1neg_list_nil() => let
    val () =
      channel1_close(chn) in xs
    // end of [val]
  end // end of [chan1neg_list_nil]
| chan1neg_list_cons() => let
    val x =
      chan1neg_send_val<bit> (chn)
    // end of [val]
  in
    loop2(chn, list_vt_cons(x, xs))
  end // end of [chan1neg_list_cons]
//
end // end of [loop2]
//
in
  loop(loop2(chn, list_vt_nil(*void*)), 0)
end // end of [bits2int]

(* ****** ****** *)
//
extern
fun
succ_int(intGte(0)): intGte(0)
//
(* ****** ****** *)
//
implement
succ_int(x) =
  bits2int(succ_bits(int2bits(x)))
//
(* ****** ****** *)
//
extern
fun
add_int_int(intGte(0), intGte(0)): intGte(0)
//
(* ****** ****** *)
//
implement
add_int_int(x, y) =
  bits2int(add_bits_bits(int2bits(x), int2bits(y)))
//
(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val a0 =
(
if argc >= 2
  then g0string2int(argv[1]) else 0
// end of [if]
) : int // end of [val]
//
val a1 =
(
if argc >= 3
  then g0string2int(argv[2]) else 0
// end of [if]
) : int // end of [val]
//
val a0 = g1ofg0(a0)
and a1 = g1ofg0(a1)
//
val () = assertloc (a0 >= 0)
val () = assertloc (a1 >= 0)
//
val () =
println!
  (a0, " + ", a1, " = ", add_int_int(a0, a1))
//
val _(*left*) = $UNISTD.usleep(250000u)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bitstr.dats] *)
