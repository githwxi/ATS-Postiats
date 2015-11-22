(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
staload
"{$LIBATSCC2ERL}/Session/SATS/basis.sats"
//
(* ****** ****** *)

typedef
Q_ssn =
chrcv(int)::chrcv(int)::chsnd(bool)::chnil

(* ****** ****** *)

fun
P (
  chn: channeg(Q_ssn), i1: int, i2: int
): bool = lt where
{
  val () =
    channel_send(chn, i1)
  val () =
    channel_send(chn, i2)
  val lt = channel_recv(chn)
  val () = channel_close(chn)
}

(* ****** ****** *)

fun
Q (
  chp: chanpos(Q_ssn)
) : void =
{
  val i1 = channel_recv(chp)
  val i2 = channel_recv(chp)
  val () = channel_send(chp, i1 < i2)
  val () = channel_close(chp)
}

(* ****** ****** *)

(* end of [intro.dats] *)
