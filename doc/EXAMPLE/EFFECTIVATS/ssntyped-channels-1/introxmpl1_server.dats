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
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "theWorker_start"
//
(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
  
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
"{$LIBATSCC2JS}/DATS/Worker/chanpos.dats"
//
(* ****** ****** *)

staload "./introxmpl1_prtcl.sats" // for protocol

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

val () =
{
//
val ((*void*)) = Q($UN.castvwtp0{chanpos(Q_ssn)}(0))
//
} (* end of [val] *)

(* ****** ****** *)

%{$
//
theWorker_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [introxmpl1_server.dats] *)
