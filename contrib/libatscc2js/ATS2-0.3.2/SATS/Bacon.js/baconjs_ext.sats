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
** Start Time: October, 2015
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)
//
(*
#define
ATS_STALOADFLAG 0
// no staloading at run-time
*)
//
// HX:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2js_bacon_ext_"
//
(* ****** ****** *)
//
staload
"./../../basics_js.sats"
//
(* ****** ****** *)
//
staload "./baconjs.sats"
//
(* ****** ****** *)
//
// HX:
// EValue is
// updated by EStream
//
abstype
EValue(a:t@ype) = ptr // invariant!
//
(* ****** ****** *)
//
fun
EStream_scan_stream_opt
  {a,b,c:t0p}
(
  xs: EStream(b)
, ini: a, ys: stream(c)
, fopr: cfun(a, b, c, Option_vt(a))
) : Property(a) = "mac#%" // end-of-function
//
overload scan with EStream_scan_stream_opt
overload .scan with EStream_scan_stream_opt
//
(* ****** ****** *)
//
fun
EValue_get_elt
  {a:t0p}
  (x: EValue(a)): (a) = "mac#%"
//
overload [] with EValue_get_elt
//
fun
EValue_make_property
  {a:t0p}(Property(a)): EValue(a) = "mac#%"
fun
EValue_make_estream_scan
  {a,b:t0p}
(
x0: a, ys: EStream(b), fopr: cfun(a, b, a)
) : EValue(a) = "mac#%" // EValue_make_estream_scan
//
(* ****** ****** *)
//
datatype
singpair(a: t@ype+) =
  | Sing of (a) | Pair of (a, a)
//
(* ****** ****** *)
//
// HX-2016-11-13:
//
// For grouping two consecutive events
// if the second occurs with delta ms of the first
// For instance, [EStream_singpair_trans] can be employed
// to support an implementation of double clicking
//
fun
EStream_singpair_trans
  {a:t0p}
(
xs: EStream(a), delta(*ms*): intGte(0)
) : EStream(singpair(a)) = "mac#%" // EStream_singpair_trans
//
(* ****** ****** *)

(* end of [baconjs_ext.sats] *)
