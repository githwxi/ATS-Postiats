(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
staload
"{$LIBATSCC2ERL}/Session/SATS/basis.sats"
//
(* ****** ****** *)
//
(*
typedef
P_ssn =
chsnd(int)::chsnd(int)::chrcv(bool)::chnil
*)
//
typedef
Q_ssn =
chrcv(int)::chrcv(int)::chsnd(bool)::chnil
//
(* ****** ****** *)

fun
P (
  i1: int, i2: int
, chn: channeg(Q_ssn)
) : bool = lt where
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

(* end of [introxmpl0.dats] *)
