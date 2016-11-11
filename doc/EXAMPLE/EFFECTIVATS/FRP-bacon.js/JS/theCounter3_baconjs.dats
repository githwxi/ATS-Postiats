(*
theCounter3_baconjs
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"theCounter3_baconjs_start"
//
#define
ATS_STATIC_PREFIX "theCounter3_baconjs_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Bacon.js/baconjs.sats"
//
(* ****** ****** *)

local
//
datatype act = Up | Down | Reset | Skip
//
val theUp_btn = $extval(ptr, "$(\"#theUp3_btn\")")
val theDown_btn = $extval(ptr, "$(\"#theDown3_btn\")")
val theReset_btn = $extval(ptr, "$(\"#theReset3_btn\")")
//
val theUp_clicks = $extmcall(EStream(ptr), theUp_btn, "asEventStream", "click")
val theDown_clicks = $extmcall(EStream(ptr), theDown_btn, "asEventStream", "click")
val theReset_clicks = $extmcall(EStream(ptr), theReset_btn, "asEventStream", "click")
//
val theUp_clicks = theUp_clicks.map(TYPE{act})(lam _ => Up())
val theDown_clicks = theDown_clicks.map(TYPE{act})(lam _ => Down())
val theReset_clicks = theReset_clicks.map(TYPE{act})(lam _ => Reset())
//
val theComb_clicks = merge(theUp_clicks, theDown_clicks, theReset_clicks)
//
val theAuto_btn = $extval(ptr, "$(\"#theAuto3_btn\")")
val theAuto_clicks = $extmcall(EStream(ptr), theAuto_btn, "asEventStream", "click")
val theAuto_clicks = theAuto_clicks.map(TYPE{act})(lam _ => Skip())
val theAuto_toggles = scan{bool}{act}(theAuto_clicks, false, lam(res, _) => ~res)
//
val () =
theAuto_toggles.onValue()
(
lam(tf) =>
if tf
then $extmcall(void, theAuto_btn, "addClass", "btn-primary")
else $extmcall(void, theAuto_btn, "removeClass", "btn-primary")
)
//
val theAutoComb_stream =
  Property_sampledBy_estream_cfun
    (theAuto_toggles, theComb_clicks, lam(x, y) => if x then Skip else y)
//
val theTick_stream =
  Property_sampledBy_estream
    (theAuto_toggles, Bacon_interval{int}(1000(*ms*), 0))
//
val theComb2_clicks = merge(theComb_clicks, theAuto_clicks)
val theComb2_property = EStream_toProperty_init(theComb2_clicks, Skip)
//
val theComb2Tick_stream =
  Property_sampledBy_estream_cfun
    (theComb2_property, theTick_stream, lam(x, y) => if y then x else Skip)
//
val
theCounts =
scan{int}{act}
(
  merge
  (
    theAutoComb_stream
  , theComb2Tick_stream
  )
, 0 (*initial*)
, lam(res, act) =>
  (
    case+ act of
    | Up() => min(res+1, 99)
    | Down() => max(0, res-1)
    | Reset() => (0) | Skip() => res
  )
) (* end of [theCounts] *)
//
in (* in-of-local *)
//
val () =
theCounts.onValue()
(
lam(count) =>
{
  val d0 = count%10 and d1 = count/10
  val d0 = String(d0) and d1 = String(d1)
  val theCount3_p = $extfcall(ptr, "jQuery", "#theCount3_p")
  val ( (*void*) ) = $extmcall(void, theCount3_p, "text", d1+d0)
}
) (* end of [val] *)
//
end // end of [local]

(* ****** ****** *)

%{^
//
var the_atsptr_null = 0;
//
%} // end of [%{$]
%{$
//
theCounter3_baconjs_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [theCounter3_baconjs.dats] *)
