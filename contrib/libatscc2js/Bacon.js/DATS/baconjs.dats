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
** Start Time: November, 2016
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0 // no run-time dynloading
//
#define
ATS_EXTERN_PREFIX
"ats2js_baconjs_" // prefix for extern names
#define
ATS_STATIC_PREFIX
"_ats2js_baconjs_" // prefix for static names
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
#include
  "{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
staload "./../SATS/baconjs.sats"
//
(* ****** ****** *)
//
implement
EStream_map_method
  (xs, _) =
  lam(fopr) => EStream_map(xs, fopr)
//
implement
Property_map_method
  (xs, _) =
  lam(fopr) => Property_map(xs, fopr)
//
(* ****** ****** *)
//
implement
EStream_filter_method
  (xs) =
  lam(pred) => EStream_filter(xs, pred)
//
(* ****** ****** *)
//
implement
EStream_scan_method
  (xs, _(*type*)) =
  lam(ini, fopr) => EStream_scan(xs, ini, fopr)
//
(* ****** ****** *)
//
implement
EStream_flatMap_method
  (xs, _) =
  lam(fopr) => EStream_flatMap(xs, fopr)
//
implement
Property_flatMap_method
  (xs, _) =
  lam(fopr) => Property_flatMap(xs, fopr)
//
(* ****** ****** *)
//
implement
EStream_onValue_method
  (xs) =
  lam(fopr) => EStream_onValue(xs, fopr)
//
implement
Property_onValue_method
  (xs) =
  lam(fopr) => Property_onValue(xs, fopr)
//
(* ****** ****** *)
//
implement
EStream_subscribe_method
  (xs) =
  lam(fopr) => EStream_subscribe(xs, fopr)
//
implement
Property_subscribe_method
  (xs) =
  lam(fopr) => Property_subscribe(xs, fopr)
//
(* ****** ****** *)
//
implement
EStream_doAction_method
  (xs) =
  lam(fopr) => EStream_doAction(xs, fopr)
//
implement
Property_doAction_method
  (xs) =
  lam(fopr) => Property_doAction(xs, fopr)
//
(* ****** ****** *)

(* end of [baconjs.dats] *)
