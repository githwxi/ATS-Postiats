(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: December, 2015
*)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../SATS/channel.sats"
staload "./../SATS/channel_session.sats"

(* ****** ****** *)
//
extern
castfn
chanpos1_session_encode{ss:type}
  : chanpos_nullify(ss) -<fun0> chanpos_session(ss)
extern
castfn
chanpos1_session_decode{ss:type}
  : chanpos_session(ss) -<fun0> chanpos_nullify(ss)
//
(* ****** ****** *)

implement
{a}(*tmp*)
chanpos1_session_send
  (fwork) = let
(*
//
val () =
  println! ("chanpos1_session_send")
//
*)
in
//
chanpos1_session_encode(
//
lam(chp, k0) => chanpos1_send(chp, fwork((*void*)), k0)
//
) (* chanpos1_session_encode *)
//
end // end of [chanpos1_session_send]

(* ****** ****** *)

implement
{a}(*tmp*)
chanpos1_session_recv
  (fwork) = let
(*
//
val () =
  println! ("chanpos1_session_recv")
//
*)
in
//
chanpos1_session_encode(
//
lam(chp, k0) =>
  chanpos1_recv
  ( chp
  , lam(chp, msg) => let val () = fwork(chmsg_parse<a>(msg)) in k0(chp) end
  ) (* chanpos1_recv *)
//
) (* chanpos1_session_encode *)
//
end // end of [chanpos1_session_recv]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_initize
  (fwork, ssp) = let  
//
val
fnullify =
chanpos1_session_decode(ssp)
//
in
//
chanpos1_session_encode
(
//
lam(chp, k0) => let
  val () = fwork((*bef*)) in fnullify(chp, k0)
end // end of [let]
//
) (* chanpos1_session_encode *)
//
end // end of [channpos1_session_initize]
  
(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_finalize
  (ssp, fwork) = let  
//
val
fnullify =
chanpos1_session_decode(ssp)
//
in
//
chanpos1_session_encode
(
//
lam(chp, k0) =>
  fnullify(chp, lam(chp) => let val () = fwork() in k0(chp) end)
//
) (* chanpos1_session_encode *)
//
end // end of [channpos1_session_finalize]

(* ****** ****** *)
//
implement
chanpos1_session_nil() =
  chanpos1_session_encode(lam(chp, k0) => k0(chp))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
chanpos1_session_cons
  (x, xs) = $UN.cast(chanpos1_session_append(x, xs))
//
(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_append
  (ss1, ss2) = let
//
val ss1 = chanpos1_session_decode(ss1)
val ss2 = chanpos1_session_decode(ss2)
//
in
  chanpos1_session_encode(lam(chp, k0) => chanpos1_append(chp, k0, ss1, ss2))
end // end of [channel1_session_append]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_option_conj
  (ss0) = let
//
val ss0 = chanpos1_session_decode(ss0)
//
in
  chanpos1_session_encode(lam(chp, k0) => chanpos1_option_conj(chp, k0, ss0))
end // end of [chanpos1_session_option_conj]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_option_disj
  (ss0) = let
//
val ss0 = chanpos1_session_decode(ss0)
//
in
  chanpos1_session_encode(lam(chp, k0) => chanpos1_option_disj(chp, k0, ss0))
end // end of [chanpos1_session_option_disj]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_repeat_conj
  (ss0) = let
//
val ss0 = chanpos1_session_decode(ss0)
//
in
  chanpos1_session_encode(lam(chp, k0) => chanpos1_repeat_conj(chp, k0, ss0))
end // end of [chanpos1_session_repeat_conj]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_repeat_disj
  (ss0) = let
//
val ss0 = chanpos1_session_decode(ss0)
//
in
  chanpos1_session_encode(lam(chp, k0) => chanpos1_repeat_disj(chp, k0, ss0))
end // end of [chanpos1_session_repeat_disj]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_run
  (ss0, chp, kx0) = let
//
val
fnullify =
chanpos1_session_decode(ss0) in fnullify(chp, kx0)
//
end // end of [chanpos1_session_run]

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_run_close
  (ss0, chp) =
(
//
chanpos1_session_run(ss0, chp, lam(chp) => chanpos1_close(chp))
//
) // end of [chanpos1_session_run_close]

(* ****** ****** *)

(* end of [chanpos_session.dats] *)
