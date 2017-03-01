(*
** Erathosthene's sieve
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

#staload
_ = "libats/DATS/deqarray.dats"

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
ssn_colist(a:vt@ype)
//
(* ****** ****** *)
//
datatype
chan1pos_list
  (a:vt@ype, type) =
| chan1pos_list_nil(a, nil) of ()
| chan1pos_list_cons(a, snd(a) :: ssn_colist(a)) of ()
//
(* ****** ****** *)
//
extern
fun{}
chan1pos_list
  {a:vt@ype}
(
  !chan1pos(ssn_colist(a)) >> chan1pos(ssn)
) : #[ssn:type] chan1pos_list(a, ssn)
//
(* ****** ****** *)
//
extern
fun{}
chan1neg_list_nil
  {a:vt@ype}
  (!chan1neg(ssn_colist(a)) >> chan1neg(nil)): void
extern
fun{}
chan1neg_list_cons
  {a:vt@ype}
  (!chan1neg(ssn_colist(a)) >> chan1neg(snd(a)::ssn_colist(a))): void
//
(* ****** ****** *)

implement
{}(*tmp*)
chan1pos_list
  (chpos) = let
//
vtypedef
chan0 = $CHANNEL0.channel0(ptr, 2)
val
chan0 = $UN.castvwtp1{chan0}(chpos)
//
val tag = $CHANNEL0.channel0_recv_val(chan0, 1, 0)
//
prval () = $UN.cast2void(chan0)
//
in
//
if
iseqz(tag)
then let
  prval () = $UN.castview2void(chpos) in chan1pos_list_nil()
end // end of [then]
else let
  prval () = $UN.castview2void(chpos) in chan1pos_list_cons()
end // end of [else]
//
end // end of [chan1pos_list]

(* ****** ****** *)

implement
{}(*tmp*)
chan1neg_list_nil
  (chneg) = () where
{
//
vtypedef
chan0 = $CHANNEL0.channel0(ptr, 2)
val
chan0 = $UN.castvwtp1{chan0}(chneg)
//
val () = $CHANNEL0.channel0_send(chan0, 1, 0, $UN.int2ptr(0))
//
prval () = $UN.cast2void(chan0)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [chan1neg_list_nil] *)

(* ****** ****** *)

implement
{}(*tmp*)
chan1neg_list_cons
  (chneg) = () where
{
//
vtypedef
chan0 = $CHANNEL0.channel0(ptr, 2)
val
chan0 = $UN.castvwtp1{chan0}(chneg)
//
val () = $CHANNEL0.channel0_send(chan0, 1, 0, $UN.int2ptr(1))
//
prval () = $UN.cast2void(chan0)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [chan1neg_list_cons] *)

(* ****** ****** *)
//
extern
fun
ints_from (n: int): chan1neg(ssn_colist(int))
//
extern
fun
ints_filter
  (chan1neg(ssn_colist(int)), n: int): chan1neg(ssn_colist(int))
//
(* ****** ****** *)
  
implement
ints_from (n) = let
//
fun
fserv
(
  chp: chan1pos(ssn_colist(int)), n: int
) : void = let
//
val opt = chan1pos_list (chp)
//
in
//
case+ opt of
| chan1pos_list_nil() =>
    channel1_close(chp)
| chan1pos_list_cons() =>
    (chan1pos_send<int>(chp, n); fserv(chp, n+1))
//
end // end of [fserv]
//
in
  chan1neg_create_exn(llam(chp) => fserv(chp, n))
end // end of [ints_from]

(* ****** ****** *)

implement
ints_filter
  (chn, n0) = let
//
fun
getfst
(
  chn: !chan1neg(ssn_colist(int))
) : int = let
//
val () =
  chan1neg_list_cons(chn)
//
val fst = chan1neg_send_val(chn)
//
in
  if fst mod n0 > 0 then fst else getfst(chn)
end // end of [getfst]
//
fun
fserv
(
  chp: chan1pos(ssn_colist(int))
, chn: chan1neg(ssn_colist(int))
) : void = let
//
val opt = chan1pos_list (chp)
//
in
//
case+ opt of
| chan1pos_list_nil() =>
  (
    channel1_close(chp);
    chan1neg_list_nil(chn); channel1_close(chn)
  )
| chan1pos_list_cons() =>
  (
    chan1pos_send(chp, getfst(chn)); fserv(chp, chn)
  )
//
end // end of [fserv]
//
in
  chan1neg_create_exn(llam(chp) => fserv(chp, chn))
end // end of [ints_filter]

(* ****** ****** *)

extern
fun
primes_gen(): chan1neg(ssn_colist(int))

(* ****** ****** *)

implement
primes_gen() = let
//
fun
fserv
(
  chp: chan1pos(ssn_colist(int))
, chn: chan1neg(ssn_colist(int))
) : void = let
//
val opt = chan1pos_list (chp)
//
in
//
case+ opt of
| chan1pos_list_nil() =>
  (
    channel1_close(chp);
    chan1neg_list_nil(chn); channel1_close(chn)
  )
| chan1pos_list_cons() => let
    val () =
      chan1neg_list_cons(chn)
    // end of [val]
    val p0 = chan1neg_send_val(chn)
  in
    chan1pos_send(chp, p0); fserv(chp, ints_filter(chn, p0))
  end // end of [chan1neg_list_cons]
//
end // end of [fserv]
//
in
  chan1neg_create_exn(llam(chp) => fserv(chp, ints_from(2)))
end // end of [primes_gen]

(* ****** ****** *)
//
extern
fun
fprint_primes
(
  out: FILEref
, n: int, chn: !chan1neg(ssn_colist(int))
) : void // end-of-function
//
implement
fprint_primes
  (out, n, chn) =
(
if
n > 0
then let
//
val () =
  chan1neg_list_cons(chn)
// end of [val]
val px = chan1neg_send_val<int> (chn)
val () = fprintln! (out, px)
//
in
  fprint_primes (out, n-1, chn)
end // end of [then]
else () // end of [else]
) (* end of [fprint_primes] *)
//
(* ****** ****** *)

fun
wait_for_closing
  (N: int): void = let
//
fun log (N: int, n: int, i: int): int =
  if n >= N then i else log(N, n+n, i+1)
//
fun
loop
(
  n: int
) : void =
if
n > 0
then let
  val _ = $UNISTD.usleep(250000u)
  val () = fprint(stdout_ref, ".")
  val () = fileref_flush(stdout_ref)
in
  loop (n-1)
end (* end of [if] *)
//
val () = loop(3+log(N/8, 1, 0))
val () = fprint_newline (stdout_ref)
//
in
  // nothing
end // end of [wait_for_closing]

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val N =
(
//
if argc >= 2
  then g0string2int(argv[1]) else 10
//
) : int // end of [val]
//
val N = g1ofg0(N)
val () = assertloc (N >= 0)
//
val out = stdout_ref
//
val chn = primes_gen()
//
val () = fprint_primes(out, N, chn)
//
val () =
  chan1neg_list_nil(chn)
//
val () = channel1_close(chn)
//
val () =
print!
(
  "Waiting for the created threads to finish"
) (* end of [val] *)
//
val () = wait_for_closing(N)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [sieve.dats] *)
