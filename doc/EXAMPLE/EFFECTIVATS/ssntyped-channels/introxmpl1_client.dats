(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
  
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
  
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/channeg.dats"
//
(* ****** ****** *)

staload "./introxmpl1_prot.sats" // for protocol

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

(* end of [introxmpl1_client.dats] *)
