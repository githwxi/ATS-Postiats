(* ****** ****** *)
//
// Testing WebWorker
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
//
#define
WORKERSESSION_CHANNEG 1
//
#include "./../mylibies.dats"
//
#include
"./../mylibies.hats"; staload $CHANNEL
//
(* ****** ****** *)
//
extern
fun
console_log(string): void = "mac#"
//
(* ****** ****** *)

%{^
//
function
console_log(x) { return console.log(x); }
//
function
theArg1_set(a1)
{
  document.getElementById('theArg1').value = a1;
}
function
theArg2_set(a2)
{
  document.getElementById('theArg2').value = a2;
}
function
theResult_get()
{
  return parseInt(document.getElementById('theResult').value);
}
function
theResult_set(value)
{
  document.getElementById('theResult').value = value;
}
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Started = false;
//
function
Start_onclick()
{
  if (!Started)
  {
    Started = true; return StartIt();
  } else
  {
    alert ('The session is in progress!'); return;
  }
}
//
var
AnswerIt = 0;
var
AnswerIt_do = 0;
//
function
AnswerIt_onclick()
{
  if (AnswerIt)
  {
    AnswerIt = 0;
    return ats2jspre_cloref0_app(AnswerIt_do);
  } else {
    alert('The AnswerIt button is not ready yet!'); return;
  } // end of [if]
}
//
function
AnswerIt_do_set(fclo)
  { AnswerIt = 1; AnswerIt_do = fclo; return; }
//
%} // end of [%{^]
//
(* ****** ****** *)
//
staload
PROTOCOL = "./test2_prot.sats"
//
typedef sstest1 = $PROTOCOL.sstest1
typedef sstest2 = $PROTOCOL.sstest2
typedef sstest3 = $PROTOCOL.sstest3
//
(* ****** ****** *)
//
extern
fun
StartIt(): void = "mac#"
//
extern
fun
PostRep
(
  channeg(chnil), k0: chncont0_nil, yn: bool
) : void = "mac#" // end-of-fun
extern
fun
ReplyIt
(
  channeg(sstest1), k0: chncont0_nil, a1: int, a2: int
) : void = "mac#" // end-of-fun
//
extern
fun
StartIt_aft
  (chn: channeg(ssdisj(ssrepeat(sstest2)))): void = "mac#"
//
(* ****** ****** *)
//
implement
StartIt() = let
//
val
chn =
channeg0_new_file("./test2_server_dats_.js")
//
val
chn = $UN.castvwtp0{channeg(sstest3)}(chn)
//
in
//
channeg1_recv(chn, 0, lam(chn) => StartIt_aft(chn))
//
end // end of [Start_onclick]

(* ****** ****** *)

implement
StartIt_aft
  (chn) = let
//
val k0 =
lam(chn: channeg_nil) =<cloref1>
  let extvar "Started" = false in channeg1_close(chn) end
//
(*
implement
channeg1_repeat_disj$fwork_tag<>
  (tag) =
(
  console_log("fwork_tag: tag = " + String(tag))
)
*)
//
in
//
channeg1_repeat_disj
(
  chn, k0
, lam(chn, k0) =>
  channeg1_send
  ( chn
  , lam(chn, a1) =>
    channeg1_send
    ( chn
    , lam(chn, a2) =>
      ReplyIt(chn, k0, chmsg_parse(a1), chmsg_parse(a2))
    )
  )
)
//
end // end of [StartIt_aft]

(* ****** ****** *)

implement
ReplyIt
  (chn, k0, a1, a2) = let
//
val () =
  $extfcall(void, "theArg1_set", a1)
val () =
  $extfcall(void, "theArg2_set", a2)
//
val () =
  $extfcall(void, "theResult_set", "")
//
val
ReplyIt_do =
llam() =<lincloptr1> let
  val res = $extfcall(int, "theResult_get")
in
//
channeg1_recv
( chn, res
, lam(chn) =>
  channeg1_send
  ( chn
  , lam(chn, yn) => PostRep(chn, k0, chmsg_parse(yn))
  )
)
//
end // end of [ReplyIt_do]
//
in
//
$extfcall
(
  void , "AnswerIt_do_set", $UN.castvwtp0{JSobj}(ReplyIt_do)
)
//
end // end of [ReplyIt]

(* ****** ****** *)

implement
PostRep(chn, k0, yn) = let
//
  val () = k0(chn)
//
in
  if yn
    then alert("The replied answer is right :)")
    else alert("The replied answer is wrong :(")
  // end of [if]
end // end of [PostRep]

(* ****** ****** *)

(* end of [test2_client.dats] *)
