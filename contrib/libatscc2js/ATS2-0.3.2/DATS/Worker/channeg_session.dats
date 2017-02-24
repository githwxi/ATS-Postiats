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
"./../../basics_js.sats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../../SATS/Worker/channel.sats"
staload "./../../SATS/Worker/channel_session.sats"

(* ****** ****** *)
//
extern
castfn
channeg1_session_encode{ss:type}
  : channeg_nullify(ss) -<fun0> channeg_session(ss)
extern
castfn
channeg1_session_decode{ss:type}
  : channeg_session(ss) -<fun0> channeg_nullify(ss)
//
(* ****** ****** *)

implement
{a}(*tmp*)
channeg1_session_recv
  (fwork) = let
(*
//
val () =
  println! ("channeg1_session_recv")
//
*)
in
//
channeg1_session_encode(
//
lam(chn, k0) => channeg1_recv(chn, fwork((*void*)), k0)
//
) (* channeg1_session_encode *)
//
end // end of [channeg1_session_recv]

(* ****** ****** *)

implement
{a}(*tmp*)
channeg1_session_send
  (fwork) = let
(*
//
val () =
  println! ("channeg1_session_send")
//
*)
in
//
channeg1_session_encode(
//
lam(chn, k0) =>
  channeg1_send
  ( chn
  , lam(chn, msg) => let val () = fwork(chmsg_parse<a>(msg)) in k0(chn) end
  ) (* channeg1_send *)
//
) (* channeg1_session_encode *)
//
end // end of [channeg1_session_send]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_initize
  (fwork, ssn) = let  
//
val
fnullify =
channeg1_session_decode(ssn)
//
in
//
channeg1_session_encode
(
//
lam(chn, k0) => let
  val () = fwork((*bef*)) in fnullify(chn, k0)
end // end of [let]
//
) (* channeg1_session_encode *)
//
end // end of [channneg1_session_initize]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_finalize
  (ssn, fwork) = let  
//
val
fnullify =
channeg1_session_decode(ssn)
//
in
//
channeg1_session_encode
(
//
lam(chn, k0) =>
  fnullify(chn, lam(chn) => let val () = fwork() in k0(chn) end)
//
) (* channeg1_session_encode *)
//
end // end of [channneg1_session_finalize]

(* ****** ****** *)
//
implement
channeg1_session_nil() =
  channeg1_session_encode(lam(chn, k0) => k0(chn))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
channeg1_session_cons
  (x, xs) = $UN.cast(channeg1_session_append(x, xs))
//
(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_append
  (ss1, ss2) = let
//
val ss1 = channeg1_session_decode(ss1)
val ss2 = channeg1_session_decode(ss2)
//
in
  channeg1_session_encode(lam(chn, k0) => channeg1_append(chn, k0, ss1, ss2))
end // end of [channel1_session_append]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_option_conj
  (ss0) = let
//
val ss0 = channeg1_session_decode(ss0)
//
in
  channeg1_session_encode(lam(chn, k0) => channeg1_option_conj(chn, k0, ss0))
end // end of [channeg1_session_option_conj]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_option_disj
  (ss0) = let
//
val ss0 = channeg1_session_decode(ss0)
//
in
  channeg1_session_encode(lam(chn, k0) => channeg1_option_disj(chn, k0, ss0))
end // end of [channeg1_session_option_disj]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_repeat_conj
  (ss0) = let
//
val ss0 = channeg1_session_decode(ss0)
//
in
  channeg1_session_encode(lam(chn, k0) => channeg1_repeat_conj(chn, k0, ss0))
end // end of [channeg1_session_repeat_conj]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_repeat_disj
  (ss0) = let
//
val ss0 = channeg1_session_decode(ss0)
//
in
  channeg1_session_encode(lam(chn, k0) => channeg1_repeat_disj(chn, k0, ss0))
end // end of [channeg1_session_repeat_disj]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_run
  (ss0, chn, kx0) = let
//
val
fnullify =
channeg1_session_decode(ss0) in fnullify(chn, kx0)
//
end // end of [channeg1_session_run]

(* ****** ****** *)

implement
{}(*tmp*)
channeg1_session_run_close
  (ss0, chn) =
(
//
channeg1_session_run(ss0, chn, lam(chn) => channeg1_close(chn))
//
) // end of [channeg1_session_run_close]

(* ****** ****** *)

(* end of [channeg_session.dats] *)
