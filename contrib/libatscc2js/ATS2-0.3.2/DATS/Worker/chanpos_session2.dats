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
staload "./../../SATS/Worker/channel_session2.sats"

(* ****** ****** *)

implement
{}(*tmp*)
chanpos1_session_guardby
  (ssp1, ssp2) = let
//
implement
chanpos1_option_disj$choose<>() =
(
  if chanpos1_session_guardby$guard<>() then 1 else 0
)
//
in
  chanpos1_session_append(ssp2, chanpos1_session_option_disj(ssp1))
end // end of [chanpos1_session_guardby]

(* ****** ****** *)

(* end of [chanpos_session2.dats] *)
