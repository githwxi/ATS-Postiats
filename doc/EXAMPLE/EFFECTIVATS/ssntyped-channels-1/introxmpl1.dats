(* ****** ****** *)

(*
//
// For use in Effective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
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
) : void = (
//
channeg1_recv
( chn, i1
, lam(chn) =>
  channeg1_recv
  ( chn, i2
  , lam(chn) =>
    channeg1_send
    ( chn
    , lam(chn, lt) => let
      val lt = chmsg_parse<bool>(lt)
      (*
      // Some code for processing [lt]
      *)
      in
        channeg1_close(chn)
      end
    )
  ) 
)
//
) (* end of [P] *)

(* ****** ****** *)

fun
Q (
  chp: chanpos(Q_ssn)
) : void = (
//
chanpos1_recv
( chp
, lam(chp, i1) => let
  val i1 = chmsg_parse<int>(i1) in
  chanpos1_recv
  ( chp
  , lam(chp, i2) => let
    val i2 = chmsg_parse<int>(i2) in
    chanpos1_send
    ( chp, i1 < i2
    , lam(chp) => chanpos1_close(chp)
    )
    end // end-of-let // end-of-lam
  )
  end // end-of-let // end-of-lam
)
//
) (* end of [Q] *)

(* ****** ****** *)

(* end of [introxmpl1.dats] *)
