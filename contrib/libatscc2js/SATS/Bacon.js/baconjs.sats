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
** Start Time: April, 2015
*)

(* ****** ****** *)

#define
ATS_STALOADFLAG 0 // no staloading at run-time
#define
ATS_EXTERN_PREFIX "ats2js_bacon_" // prefix for external names

(* ****** ****** *)
//
staload
"./../../basics_js.sats"
//
(* ****** ****** *)
//
(*
For Opaque values
*)
abstype Value = ptr
//
abstype Event = ptr
//
abstype
EStream(a:t@ype) = ptr // invariant!
abstype
Property(a:t@ype) = ptr // invariant!
//
(* ****** ****** *)

fun Bacon_more(): Value = "mac#%"
fun Bacon_noMore(): Value = "mac#%"

(* ****** ****** *)
//
fun
Bacon_once
  {a:t0p}(x: a): EStream(a) = "mac#%"
fun
Bacon_never
  {a:t0p}((*void*)): EStream(a) = "mac#%"
//
(* ****** ****** *)
//
fun
Bacon_later
  {a:t0p}
  (ms: intGte(0), x: a): EStream(a) = "mac#%"
//
(* ****** ****** *)
//
fun
Bacon_interval
  {a:t0p}
  (ms: intGte(0), x: a): EStream(a) = "mac#%"
//
fun
Bacon_repeatedly
  {a:t0p}
  (ms: intGte(0), xs: JSarray(a)): EStream(a) = "mac#%"
//
fun
Bacon_sequentially
  {a:t0p}
  (ms: intGte(0), xs: JSarray(a)): EStream(a) = "mac#%"
//
(* ****** ****** *)
//
fun
Bacon_repeat{a:t0p}
(
  fopr: cfun(intGte(0), EStream(a))
) : EStream(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
EStream_map
  {a:t0p}{b:t0p}
(
  xs: EStream(a), fopr: cfun(a, b)
) : EStream(b) = "mac#%" // end-of-fun
fun
EStream_map_method
  {a:t0p}{b:t0p}
(
  xs: EStream(a), TYPE(b))(fopr: cfun(a, b)
) : EStream(b) = "mac#%" // end-of-fun
//
fun
Property_map
  {a:t0p}{b:t0p}
(
  xs: Property(a), fopr: cfun(a, b)
) : Property(b) = "mac#%" // end-of-fun
fun
Property_map_method
  {a:t0p}{b:t0p}
(
  xs: Property(a), TYPE(b))(fopr: cfun(a, b)
) : Property(b) = "mac#%" // end-of-fun
//
(*
overload map with EStream_map
overload map with Property_map
*)
overload .map with EStream_map_method
overload .map with Property_map_method
//
(* ****** ****** *)
//
fun
EStream_map_property
  {a:t0p}{b:t0p}
(
  xs: EStream(a), ys: Property(b)
) : EStream(b) = "mac#%" // end-of-fun
//
overload map with EStream_map_property
overload .map with EStream_map_property
//
(* ****** ****** *)
//
fun
EStream_filter
  {a:t0p}
(
  xs: EStream(a), test: cfun(a, bool)
) : EStream(a) = "mac#%" // end-of-fun
fun
EStream_filter_method
  {a:t0p}
(
  xs: EStream(a))(test: cfun(a, bool)
) : EStream(a) = "mac#%" // end-of-fun
//
(*
overload filter with EStream_filter
*)
overload .filter with EStream_filter_method
//
(* ****** ****** *)
//
fun
EStream_filter_property
  {a:t0p}
(
  xs: EStream(a), bs: Property(bool)
) : EStream(a) = "mac#%" // end-of-fun
//
overload filter with EStream_filter_property
overload .filter with EStream_filter_property
//
(* ****** ****** *)
//
fun
EStream_scan
  {a:t0p}{b:t0p}
(
xs: EStream(b), ini: a, fopr: cfun(a, b, a)
) : Property(a) = "mac#%" // end-of-function
fun
EStream_scan_method
  {a:t0p}{b:t0p}
(
xs: EStream(b), _: TYPE(a))(ini: a, fopr: cfun(a, b, a)
) : Property(a) = "mac#%" // end-of-function
//
(*
overload scan with EStream_scan
*)
overload .scan with EStream_scan_method
//
(* ****** ****** *)
//
fun
EStream_merge2
  {a:t0p}
  (EStream(a), EStream(a)): EStream(a) = "mac#%"
fun
EStream_merge3
  {a:t0p}
  (EStream(a), EStream(a), EStream(a)): EStream(a) = "mac#%"
fun
EStream_merge4
  {a:t0p}
  (EStream(a), EStream(a), EStream(a), EStream(a)): EStream(a) = "mac#%"
fun
EStream_merge5
  {a:t0p}
  (EStream(a), EStream(a), EStream(a), EStream(a), EStream(a)): EStream(a) = "mac#%"
fun
EStream_merge6
  {a:t0p}
  (EStream(a), EStream(a), EStream(a), EStream(a), EStream(a), EStream(a)): EStream(a) = "mac#%"
//
overload merge with EStream_merge2
overload merge with EStream_merge3
overload merge with EStream_merge4
overload merge with EStream_merge5
overload merge with EStream_merge6
//
(*
overload .merge with EStream_merge2
overload .merge with EStream_merge3
overload .merge with EStream_merge4
*)
//
(* ****** ****** *)
//
fun
EStream_flatMap
  {a:t0p}{b:t0p}
(
xs: EStream(a), fopr: cfun(a, EStream(b))
) : EStream(b) = "mac#%" // end-of-function
fun
EStream_flatMap_method
  {a:t0p}{b:t0p}
(
  EStream(a), TYPE(b))(fopr: cfun(a, EStream(b))
) : EStream(b) = "mac#%" // end-of-function
//
fun
Property_flatMap
  {a:t0p}{b:t0p}
(
xs: Property(a), fopr: cfun(a, EStream(b))
) : EStream(b) = "mac#%" // end-of-function
fun
Property_flatMap_method
  {a:t0p}{b:t0p}
(
  Property(a), TYPE(b))(fopr: cfun(a, EStream(b))
) : EStream(b) = "mac#%" // end-of-function
//
(*
overload flatMap with EStream_flatMap
overload flatMap with Property_flatMap
*)
overload .flatMap with EStream_flatMap_method
overload .flatMap with Property_flatMap_method
//
(* ****** ****** *)
//
fun
Bacon_combineWith2
  {a,b:t0p}{c:t0p}
(
  Property(a), Property(b), cfun(a, b, c)
) : Property(c) = "mac#%" // end-of-function
fun
Bacon_combineWith3
  {a,b,c:t0p}{d:t0p}
(
  Property(a), Property(b), Property(c), cfun(a, b, c, d)
) : Property(d) = "mac#%" // end-of-function
//
overload combineWith with Bacon_combineWith2
overload combineWith with Bacon_combineWith3
//
(* ****** ****** *)
//
fun
EStream_toProperty
  {a:t0p}(EStream(a)): Property(a) = "mac#%"
fun
EStream_toProperty_init
  {a:t0p}(EStream(a), x0: a): Property(a) = "mac#%"
//
overload toProperty with EStream_toProperty
overload toProperty with EStream_toProperty_init
overload .toProperty with EStream_toProperty
overload .toProperty with EStream_toProperty_init
//
(* ****** ****** *)
//
fun
Property_changes
  {a:t0p}(Property(a)): EStream(a) = "mac#%"
//
overload changes with Property_changes
overload .changes with Property_changes
//
fun
Property_toEventStream
  {a:t0p}(Property(a)): EStream(a) = "mac#%"
//
overload toEventStream with Property_toEventStream
overload .toEventStream with Property_toEventStream
//
(* ****** ****** *)
//
fun
EStream_onValue
  {a:t0p}(EStream(a), cfun(a, void)): void = "mac#%"
fun
Property_onValue
  {a:t0p}(Property(a), cfun(a, void)): void = "mac#%"
fun
EStream_onValue_method
  {a:t0p}(EStream(a))(cfun(a, void)): void = "mac#%"
fun
Property_onValue_method
  {a:t0p}(Property(a))(cfun(a, void)): void = "mac#%"
//
(*
overload onValue with EStream_onValue
overload onValue with Property_onValue
*)
overload .onValue with EStream_onValue_method
overload .onValue with Property_onValue_method
//
(* ****** ****** *)
//
fun
EStream_subscribe
  {a:t0p}(EStream(a), cfun(Event, void)): void = "mac#%"
fun
Property_subscribe
  {a:t0p}(Property(a), cfun(Event, void)): void = "mac#%"
fun
EStream_subscribe_method
  {a:t0p}(EStream(a))(cfun(Event, void)): void = "mac#%"
fun
Property_subscribe_method
  {a:t0p}(Property(a))(cfun(Event, void)): void = "mac#%"
//
(*
overload subscribe with EStream_subscribe
overload subscribe with Property_subscribe
*)
overload .subscribe with EStream_subscribe_method
overload .subscribe with Property_subscribe_method
//
(* ****** ****** *)
//
fun
Property_startWith
  {a:t0p}(Property(a), a): Property(a) = "mac#%"
//
(* ****** ****** *)
//
fun
EStream_doAction
  {a:t0p}
  (xs: EStream(a), f: cfun(a, void)): EStream(a) = "mac#%"
fun
Property_doAction
  {a:t0p}
  (xs: Property(a), f: cfun(a, void)): Property(a) = "mac#%"
fun
EStream_doAction_method
  {a:t0p}
  (xs: EStream(a))(f: cfun(a, void)): EStream(a) = "mac#%"
fun
Property_doAction_method
  {a:t0p}
  (xs: Property(a))(f: cfun(a, void)): Property(a) = "mac#%"
//
(*
overload doAction with EStream_doAction
overload doAction with Property_doAction
*)
overload .doAction with EStream_doAction_method
overload .doAction with Property_doAction_method
//
(* ****** ****** *)
//
fun
Property_sampledBy_estream
  {a,b:t0p}(Property(a), EStream(b)): EStream(a) = "mac#%"
fun
Property_sampledBy_property
  {a,b:t0p}(Property(a), Property(b)): Property(a) = "mac#%"
//
overload sampledBy with Property_sampledBy_estream
overload sampledBy with Property_sampledBy_property
overload .sampledBy with Property_sampledBy_estream
overload .sampledBy with Property_sampledBy_property
//
(* ****** ****** *)
//
fun
Property_sampledBy_estream_cfun
  {a,b:t0p}{c:t0p}
(
  Property(a), EStream(b), cfun(a, b, c)
) : EStream(c) = "mac#%" // end-of-function
fun
Property_sampledBy_property_cfun
  {a,b:t0p}{c:t0p}
(
  Property(a), Property(b), cfun(a, b, c)
) : Property(c) = "mac#%" // end-of-function
//
overload sampledBy with Property_sampledBy_estream_cfun
overload sampledBy with Property_sampledBy_property_cfun
//
(* ****** ****** *)
//
fun
EStream_zipwith_estream_cfun
  {a,b:t0p}{c:t0p}
(
xs: EStream(a), ys: EStream(b), fopr: cfun(a, b, c)
) : EStream(c) = "mac#%" // end-of-function
//
overload zipwith with EStream_zipwith_estream_cfun
//
(* ****** ****** *)
//
// HX-2015-10-10:
// Bus: an estream
// onto which values can be pushed
//
fun
Bacon_new_bus{a:t0p}(): EStream(a) = "mac#%"
//
fun
EStream_bus_push
  {a:t0p}(bus: EStream(a), x0: a): void = "mac#%"
fun
EStream_bus_plug
  {a:t0p}(bus: EStream(a), xs: EStream(a)): void = "mac#%"
//
overload push with EStream_bus_push
overload plug with EStream_bus_plug
//
overload .push with EStream_bus_push
overload .plug with EStream_bus_plug
//
(* ****** ****** *)

(* end of [baconjs.sats] *)
