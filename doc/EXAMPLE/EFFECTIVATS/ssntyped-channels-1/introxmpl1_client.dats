(* ****** ****** *)
(*
//
// For use in Effective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)
(* ****** ****** *)
//
#define ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME "introxmpl1_client_initize"
//
(* ****** ****** *)
  
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
  
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/channeg.dats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Bacon.js/baconjs.sats"
//
(* ****** ****** *)

staload "./introxmpl1_prtcl.sats" // for protocol

(* ****** ****** *)
//
%{^
//
var
Start_clicks =
  $("#Start").asEventStream("click")
var
theResult_clicks =
  $("#theResult").asEventStream("click")
//
%} // end of [%{^]
//
val Start_clicks =
  $extval(EStream(void), "Start_clicks")
val theResult_clicks =
  $extval(EStream(void), "theResult_clicks")
//
(* ****** ****** *)
//
datatype action = Start | theResult
//
(* ****** ****** *)
//
val
theAction_bus = Bacon_new_bus{action}((*void*))
//
(* ****** ****** *)
//
%{^
//
function
theArg1_get()
{
  return parseInt(document.getElementById("theArg1_input").value);
}
function
theArg2_get()
{
  return parseInt(document.getElementById("theArg2_input").value);
}
function
theResult_set(output)
{
  return document.getElementById("theResult_output").value = output;
}
//
function
Start_reset()
{
  document.getElementById("theArg1_input").value = "";
  document.getElementById("theArg2_input").value = "";
  document.getElementById("theResult_output").value = "";
}
function
Start_output(msg)
{
  document.getElementById("Start_output").innerHTML = msg;
}
//
%} // end of [%{^]
//
extern fun theArg1_get(): int = "mac#"
extern fun theArg2_get(): int = "mac#"
extern fun theResult_set(msg: string): void = "mac#"
//
extern fun Start_reset(): void = "mac#"
extern fun Start_output(msg: string): void = "mac#"
//
val () =
Start_clicks.onValue
  (lam(x) =<cloref1> theAction_bus.push(Start()))
val () =
theResult_clicks.onValue
  (lam(x) =<cloref1> theAction_bus.push(theResult()))
//
(* ****** ****** *)
//
%{^
//
var theAction_fwork0 = 0;
var theAction_fwork1 = 0;
//
function
theAction_fwork0_set(f0)
  { theAction_fwork0 = f0; return; }
function
theAction_fwork1_set(f1)
  { theAction_fwork1 = f1; return; }
function
theAction_fwork01_set(f0, f1)
  { theAction_fwork0 = f0; theAction_fwork1 = f1; return; }
//
function
theAction_fwork0_run()
{
  if(theAction_fwork0)
  {
     var f ;
     f = theAction_fwork0;
     theAction_fwork0 = 0; ats2jspre_cloref0_app(f);
  } ; return /* void */ ;
}
function
theAction_fwork1_run(x)
{
  if(theAction_fwork1) ats2jspre_cloref1_app(theAction_fwork1, x); return;
}
//
%} // end of [%{^]
//
(* ****** ****** *)
//
extern
fun
theAction_fwork0_run(): void = "mac#"
and
theAction_fwork1_run(action): void = "mac#"
//
(* ****** ****** *)
//
val () =
theAction_bus.onValue
  (lam(x) =<cloref1> theAction_fwork1_run(x))
//
(* ****** ****** *)
//
extern fun theSession_loop((*void*)): void
//  
(* ****** ****** *)
//
(*
fun
P (
  i1: int, i2: int
, chn: channeg(Q_ssn)
) : void = (
//
channeg1_recv
( chn, i1
, lam(chn) =>
  channeg1_recv
  ( chn, i2
  , lam(chn) =>
    channeg1_send
    ( chn
    , lam(chn, lt) => let
      val lt = chmsg_parse<bool>(lt)
      (*
      // Some code for processing [lt]
      *)
      in
        channeg1_close(chn)
      end
    )
  ) 
)
//
) (* end of [P] *)
*)
//
(* ****** ****** *)
//
fun
P (
  chn: channeg(Q_ssn)
) : void = let
//
val
fwork0 =
llam() =<lincloptr1> let
//
val i1 = theArg1_get()
val i2 = theArg2_get()
//
in
//
channeg1_recv
( chn, i1
, lam(chn) =>
  channeg1_recv
  ( chn, i2
  , lam(chn) =>
    channeg1_send
    ( chn
    , lam(chn, lt) => let
      val lt = chmsg_parse<bool>(lt)
      val () = theResult_process(lt)
      val () = Start_output("Session over!")
      in
        channeg1_close(chn); theSession_loop()
      end
    )
  ) 
)  
end // end of [val]
//
val fwork0 = $UN.castvwtp0{int}(fwork0)
//
fun
fwork1(x: action): void =
(
case+ x of
| theResult() => theAction_fwork0_run()
| _(*rest-of-action*) => alert("The action is ignored!")
)
val fwork1 = lam(x) =<cloref1> fwork1(x)
//
in
  $extfcall(void, "theAction_fwork01_set", fwork0, fwork1)
end // end of [P]
//
and
theResult_process
  (lt: bool): void =
  theResult_set(if lt then "true" else "false")
//
(* ****** ****** *)
//
implement
theSession_loop() = let
//
val
chn =
channeg0_new_file
  ("./introxmpl1_server_dats_.js")
//
val
chn = $UN.castvwtp0{channeg(Q_ssn)}(chn)
//
val
fwork0 =
$UN.castvwtp0{int}(llam() =<lincloptr1> P(chn))
//
fun
fwork1(x: action): void =
(
case+ x of
//
| Start() => let
    val () =
    Start_reset((*void*))
    val () =
    Start_output("Session is on!")
  in
    theAction_fwork0_run((*void*))
  end // end of [Start]
//
| _(*rest-of-action*) => alert("The action is ignored!")
//
)
val fwork1 = lam(x) =<cloref1> fwork1(x)
//
in
  $extfcall(void, "theAction_fwork01_set", fwork0, fwork1)
end // end of [theSession_loop]

(* ****** ****** *)

val () = theSession_loop((*void*))

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){introxmpl1_client_initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [introxmpl1_client.dats] *)
