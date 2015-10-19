(*
** FRP via Bacon.js
*)

(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

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
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Bacon.js/baconjs.sats"
//
(* ****** ****** *)

%{^
//
var
theUps = $("#up").asEventStream("click")
var
theDowns = $("#down").asEventStream("click")
var
theResets = $("#reset").asEventStream("click")
//
var theCounts = 0
//
%} // end of [%{^]

(* ****** ****** *)
//
val theUps =
  $extval(EStream(void), "theUps")
val theDowns =
  $extval(EStream(void), "theDowns")
val theResets =
  $extval(EStream(void), "theResets")
//
(* ****** ****** *)

datatype action = Up | Down | Reset

(* ****** ****** *)
//
val theUps = map (theUps, lam(x) =<cloref1> Up())
val theDowns = map (theDowns, lam(x) =<cloref1> Down())
val theResets = map (theResets, lam(x) =<cloref1> Reset())
//
val theClicks = theUps
val theClicks = merge(theClicks, theDowns)
val theClicks = merge(theClicks, theResets)
//
(* ****** ****** *)
//
extern
fun
fact(n:int): int = "mac#_ATSJS_fact_"
//
(* ****** ****** *)
//
val
theCounts =
scan
{int,action}
(
  theClicks, 0
, lam(y, x) =<cloref1>
  case+ x of
  | Up() => min(99, y+1)
  | Down() => max(0, y-1)
  | Reset() => 0
)
//
(* ****** ****** *)
//
val
theCounts =
map{int}{int}
(
  theCounts, lam(x) =<cloref1> fact(x)
)
//
extvar "theCounts" = theCounts
//
(* ****** ****** *)
    
%{$
//
function
Counter_initize()
{
  var _ = my_dynload()
  var _ = theCounts.assign($("#factval"), "text")
}
//
jQuery(document).ready(function(){Counter_initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact2_counter.dats] *)
