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

(* end of [introxmpl1_server.dats] *)
