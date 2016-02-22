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
staload
"{$LIBATSCC2JS}/SATS/Worker/channel_session.sats"
//
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos_session.dats"
//
(* ****** ****** *)

staload "./introxmpl1_prtcl.sats" // for protocol

(* ****** ****** *)

overload :: with chanpos1_session_cons

(* ****** ****** *)
//
fun
Q_session
(
// argless
) : chanpos_session(Q_ssn) = let
//
val i1_ref = ref{int}(0)
val i2_ref = ref{int}(0)
//
val ss1 =
  chanpos1_session_recv<int>(lam(i) => i1_ref[] := i)
val ss2 =
  chanpos1_session_recv<int>(lam(i) => i2_ref[] := i)
val ss3 =
  chanpos1_session_send<bool>(lam() => i1_ref[] < i2_ref[])
//
in
  ss1 :: ss2 :: ss3 :: chanpos1_session_nil()
end // end of [Q_session]
//
(* ****** ****** *)

val () =
{
//
val ((*void*)) =
  chanpos1_session_run_close(Q_session(), $UN.castvwtp0(0))
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
