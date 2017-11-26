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
** Start Time: September, 2014
*)

(* ****** ****** *)
//
(*
#define
ATS_STALOADFLAG 0
*)
//
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2js_XMLDOC_"
//
(* ****** ****** *)
//
abstype Xmldoc_type
//
(* ****** ****** *)
//
typedef Xmldoc = Xmldoc_type
typedef Xmldoclst = List0(Xmldoc)
typedef Xmldocopt = Option(Xmldoc)
//
(* ****** ****** *)

(* end of [XMLDOC.sats] *)
