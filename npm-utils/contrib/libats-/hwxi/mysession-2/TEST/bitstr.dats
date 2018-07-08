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
staload UN = $UNSAFE
//
(* ****** ****** *)
//
staload
UNISTD =
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/basis.sats"
//
(* ****** ****** *)
//
staload "./../SATS/list.sats"
//
(* ****** ****** *)

staload
_ = "libats/DATS/deqarray.dats"

(* ****** ****** *)
//
staload
_ = "libats/DATS/athread.dats"
staload
_ = "libats/DATS/athread_posix.dats"
//
(* ****** ****** *)
//
staload _ = "./../DATS/basis_uchan.dats"
staload _ = "./../DATS/basis_chan0.dats"
//
staload _ = "./../DATS/basis_ssntyp.dats"
//
staload _(*anon*) = "./../DATS/list.dats"
//
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
  {n:nat}(int(n)): channeg(sslist(bit))
//
(* ****** ****** *)

implement
int2bits(n) = let
//
fun
fserv{n:nat}
(
  n: int(n), chp: chanpos(sslist(bit))
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
  val () = chanpos_list_cons (chp)
  val ((*void*)) = chanpos_send<bit> (chp, bit)
in
  fserv (n2, chp)
end // end of [then]
else let
  val () = chanpos_list_nil (chp) in chanpos_nil_wait(chp)
end // end of [else]
//
) (* end of [fserv] *)
//
in
  channeg_create_exn{sslist(bit)}(llam(chp) => fserv (n, chp))
end // end of [int2bits]

(* ****** ****** *)
//
(*
extern
fun
{a:vt0p}
chanposneg_link_list
(
  chp: chanpos(sslist(a)), chn: channeg(sslist(a))
) : void // end of [chanposneg_link_list]
//
implement
{a}(*tmp*)
chanposneg_link_list
  (chp, chn) = let
//
val opt = channeg_list (chn)
//
in
//
case+ opt of
| ~channeg_list_nil(chn) =>
  {
    val () = chanpos_list_nil(chp)
    val () = chanpos_nil_wait(chp)
    val () = channeg_nil_close(chn)
  }
| ~channeg_list_cons(chn) =>
  {
    val () = chanpos_list_cons(chp)
    val () = chanpos_send(chp, channeg_send_val(chn))
    val () = chanposneg_link_list(chp, chn)
  }
//
end // end of [chanposneg_link_list]
*)
//
(* ****** ****** *)
//
extern
fun
succ_bits (channeg(sslist(bit))): channeg(sslist(bit))
//
(* ****** ****** *)

implement
succ_bits(chn) = let
//
fun
fserv
(
  chp: chanpos(sslist(bit))
, chn: channeg(sslist(bit))
) : void = let
//
val opt = channeg_list (chn)
//
in
//
case+ opt of
| channeg_list_nil() => let
    val () =
      chanpos_list_cons (chp)
    val () =
      chanpos_send<bit> (chp, B1)
    val () = chanpos_list_nil (chp)
    val () = chanpos_nil_wait(chp)
    val () = channeg_nil_close(chn)
  in
    // nothing
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val () =
      chanpos_list_cons (chp)
    val bit = channeg_send_val<bit> (chn)
    val bit_ = bit2bit_(bit)
  in
    if bit_ > 0
      then let
        val () = chanpos_send (chp, B0)
      in
        fserv (chp, chn)
      end // end of [then]
      else let
        val () = chanpos_send (chp, B1)
      in
        chanposneg_link (chp, chn)
      end // end of [else]
  end // end of [channeg_list_cons]
//
end // end of [fserv]
//
in
  channeg_create_exn{sslist(bit)}(llam(chp) => fserv (chp, chn))
end // end of [succ_bits]
  
(* ****** ****** *)

extern
fun
add_bits_bits
(
  channeg(sslist(bit))
, channeg(sslist(bit))
) : channeg(sslist(bit))

(* ****** ****** *)

implement
add_bits_bits
  (chn1, chn2) = let
//
fun
fserv
(
  chp: chanpos(sslist(bit))
, chn1: channeg(sslist(bit))
, chn2: channeg(sslist(bit))
) : void = let
//
val opt1 = channeg_list (chn1)
//
in
//
case+ opt1 of
| channeg_list_nil() => let
    val () = channeg_nil_close(chn1)
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val () =
      chanpos_list_cons (chp)
    // end of [val]
    val opt2 = channeg_list (chn2)
  in
    case+ opt2 of
    | channeg_list_nil() => let
        val () = channeg_nil_close(chn2)
      in
        chanposneg_link (chp, chn1)
      end // end of [channeg_list_nil]
    | channeg_list_cons() => let
        val b1 = channeg_send_val(chn1)
        and b2 = channeg_send_val(chn2)
        val b1_ = bit2bit_(b1) and b2_ = bit2bit_(b2)
      in
        case+ b1_ of
        | 0 => (
            chanpos_send (chp, b2); fserv (chp, chn1, chn2)
          ) (* end of [0] *)
        | 1 => (
            case+ b2_ of
            | 0 => (chanpos_send (chp, B1); fserv (chp, chn1, chn2))
            | 1 => (chanpos_send (chp, B0); fserv (chp, chn1, succ_bits(chn2)))
          ) (* end of [1] *)
      end // end of [channeg_list_cons]
  end // end of [channeg_list_cons]
//
end // end of [fserv]
//
in
  channeg_create_exn{sslist(bit)}(llam(chp) => fserv (chp, chn1, chn2))
end // end of [add_bits_bits]

(* ****** ****** *)
//
extern
fun
bits2int(channeg(sslist(bit))): intGte(0)
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
  chn: channeg(sslist(bit)), xs: List0_vt(bit)
) : List0_vt(bit) = let
//
val opt = channeg_list(chn)
//
in
//
case+ opt of
| channeg_list_nil() => let
    val () =
      channeg_nil_close(chn) in xs
    // end of [val]
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val x =
      channeg_send_val<bit> (chn)
    // end of [val]
  in
    loop2 (chn, list_vt_cons(x, xs))
  end // end of [channeg_list_cons]
//
end // end of [loop2]
//
in
  loop(loop2(chn, list_vt_nil), 0)
end // end of [bits2int]

(* ****** ****** *)
//
extern
fun
succ_int (intGte(0)): intGte(0)
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
add_int_int (intGte(0), intGte(0)): intGte(0)
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
  if argc >= 2 then g0string2int(argv[1]) else 0
) : int // end of [val]
//
val a1 =
(
  if argc >= 3 then g0string2int(argv[2]) else 0
) : int // end of [val]
//
val a0 = g1ofg0(a0)
and a1 = g1ofg0(a1)
//
val () = assertloc (a0 >= 0)
val () = assertloc (a1 >= 0)
//
val () = println! (a0, " + ", a1, " = ", add_int_int(a0, a1))
//
val _(*left*) = $UNISTD.usleep(100000u)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bitstr.dats] *)
