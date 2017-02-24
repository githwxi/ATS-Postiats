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
** Start Time: October, 2015
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)
//
// HX-2015-12-09:
//
(* ****** ****** *)
(*
#define
ATS_STALOADFLAG 0
*)
//
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2js_worker_"
//
(* ****** ****** *)
//
// Session Combinators
//
(* ****** ****** *)
//
staload "./channel.sats"
staload "./channel_session.sats"
//
(* ****** ****** *)
//
fun{}
chanpos1_session_guardby
  {ss1,ss2:type}
(
  ss1: chanpos_session(ss1)
, ss2: chanpos_session(ss2)
) : chanpos_session(ssappend(ss2, ssoption_disj(ss1)))
//
fun{}
chanpos1_session_guardby$guard((*void*)): bool
//
(* ****** ****** *)

(* end of [channel_session2.sats] *)
