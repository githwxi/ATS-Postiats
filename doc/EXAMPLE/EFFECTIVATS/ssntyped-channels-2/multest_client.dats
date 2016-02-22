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
// WebWorker-based
//
(* ****** ****** *)
//
#define ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME "multest_client_dynload"

(* ****** ****** *)
  
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
  
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Bacon.js/baconjs.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/SATS/Worker/channel_session.sats"
//
staload
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
//
#include
"{$LIBATSCC2JS}/DATS/Worker/channeg.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/channeg_session.dats"
//
(* ****** ****** *)

staload "./multest_prtcl.sats"

(* ****** ****** *)
//
// Please implement a client based on the given protocol
//
(* ****** ****** *)
//
%{^
//
var
login_clicks =
  $("#login_button").asEventStream("click")
//
var
passwd_clicks =
  $("#passwd_button").asEventStream("click")
//
var
multest_clicks =
  $("#multest_button").asEventStream("click")
//
var
answer_clicks = $("#answer_button").asEventStream("click")
var
logout_clicks = $("#logout_button").asEventStream("click")
//
%} // end of [%{^]
//
val login_clicks =
  $extval(EStream(void), "login_clicks")
val passwd_clicks =
  $extval(EStream(void), "passwd_clicks")
val multest_clicks =
  $extval(EStream(void), "multest_clicks")
val answer_clicks =
  $extval(EStream(void), "answer_clicks")
val logout_clicks =
  $extval(EStream(void), "logout_clicks")
//
(* ****** ****** *)

datatype click =
  | Login | Passwd | Multest | Answer | Logout

(* ****** ****** *)
//
val
theClicks_bus = Bacon_new_bus{click}((*void*))
//
val () =
login_clicks.onValue
  (lam(x) =<cloref1> theClicks_bus.push(Login))
val () =
passwd_clicks.onValue
  (lam(x) =<cloref1> theClicks_bus.push(Passwd))
val () =
multest_clicks.onValue
  (lam(x) =<cloref1> theClicks_bus.push(Multest))
val () =
answer_clicks.onValue
  (lam(x) =<cloref1> theClicks_bus.push(Answer))
val () =
logout_clicks.onValue
  (lam(x) =<cloref1> theClicks_bus.push(Logout))
//
(* ****** ****** *)
//
%{^
//
var
theClicks_cont0 = 0;
var
theClicks_cont1 = 0;
//
function
theClicks_cont0_set(f0)
  { theClicks_cont0 = f0; return; }
//
function
theClicks_cont1_set(f1)
  { theClicks_cont1 = f1; return; }
//
function
theClicks_cont01_set(f0, f1)
  { theClicks_cont0 = f0; theClicks_cont1 = f1; return; }
//
function
theClicks_cont0_run()
{
  if(theClicks_cont0)
  {
     var f ;
     f = theClicks_cont0; theClicks_cont0 = 0; ats2jspre_cloref0_app(f);
  } ; return /* void */ ;
}
function
theClicks_cont1_run(x)
{
  if(theClicks_cont1) ats2jspre_cloref1_app(theClicks_cont1, x); return;
}
//
%} // end of [%{^]
//
extern
fun
theClicks_cont0_run(): void = "mac#"
and
theClicks_cont1_run(click): void = "mac#"
//
(* ****** ****** *)
//
val () =
theClicks_bus.onValue
  (lam(x) =<cloref1> theClicks_cont1_run(x))
//
(* ****** ****** *)
//
val () = $extfcall(void, "theClicks_cont01_set", 0, 0)
//
(* ****** ****** *)
//
extern
fun
theSession_loop_initize(): void
//  
(* ****** ****** *)
//
extern
fun
userid_get(): string = "mac#"
//
extern
fun
passwd_get(): string = "mac#"
//
%{^
//
function
userid_get()
{
  return document.getElementById("userid_input_text").value;
}
function
passwd_get()
{
  return document.getElementById("passwd_input_text").value;
}
//
%} // end of [%{^]
//
(* ****** ****** *)

fun
channeg1_session_thunkify
  {ss:type}
(
  ssn: channeg_session(ss), cont1: cfun1(click, void)
) : channeg_session(ss) = (
//
channeg1_session_encode
(
lam(chn, kx0) => let
//
  val
  cont0 =
  $UN.castvwtp0{int}
  (
    llam() =<lincloptr1>
      channeg1_session_run(ssn, chn, kx0)
    // end of [llam]
  )
//
in
  $extfcall(void, "theClicks_cont01_set", cont0, cont1)
end // end of [lam]
)
//
) // end of [channeg1_session_thunkify]

(* ****** ****** *)

macdef :: = channeg1_session_cons

(* ****** ****** *)

fun
f_ss_pass
  (passed: ref(bool)) = let
//
typedef str = string
//
val ss1 =
  channeg1_session_recv<str>(lam() => passwd_get())
val ss2 =
  channeg1_session_send<bool>(lam(yn) => passed[] := yn)
//
in
  ss1 :: ss2 :: channeg1_session_nil()
end // end of [f_ss_pass]

(* ****** ****** *)

fun
f_ss_pass_
  (passed: ref(bool)) = let
//
fun
cont1(x: click): void =
(
case+ x of
| Passwd() => theClicks_cont0_run()
| _(*rest-of-action*) => alert("The action is ignored!")
)
//
in
  channeg1_session_thunkify(f_ss_pass(passed), lam(x) =<cloref1> cont1(x))
end // end of [f_ss_pass_]

(* ****** ****** *)

fun
f_ss_pass_try
(
// argumentless
): channeg_session(ss_pass_try) = let
//
val rn0 = ref{int}(0)
val ryn = ref{bool}(false)
//
implement
channeg1_repeat_disj$fwork_tag<>
  (tag) = let
//
val n0 = rn0[]
val () = rn0[] := n0 + 1
//
in
//
case+ tag of
| 0 =>
  (
    // nothing
  )
| _ =>
  (
    if n0 > 0 then alert("Please try again!")
  )
//
end // end of [channeg1_repeat_disj$fwork_tag]
//
in
//
channeg1_session_repeat_disj(f_ss_pass_(ryn))
//
end (* end of [f_ss_pass_try] *)

(* ****** ****** *)

fun
f_ss_login
(
) : channeg_session(ss_login) =
  ss0 :: f_ss_pass_try() where
{
//
val ss0 = 
  channeg1_session_recv<string>(lam() => "userid")
//
} (* end of [f_ss_login] *)

(* ****** ****** *)

fun
f_ss_login_
(
) : channeg_session(ss_login) = let
//
fun
cont1(x: click): void =
(
case+ x of
| Login() =>
  theClicks_cont0_run() where
  {
    val () =
      alert("Try the password: multest")
    // end of [val]
  }
| _(*rest*) => ((*other-events-are-ignored*))
)
//
in
//
channeg1_session_thunkify(f_ss_login(), lam(x) =<cloref1> cont1(x))
//
end // end of [f_ss_login_]

(* ****** ****** *)
//
extern
fun
multest_input_set(string): void = "mac#"
//
%{^
//
function
multest_input_set(msg)
{
  document.getElementById("multest_input_text").value = msg;
}
//
%} // end of [%{^]
//
(* ****** ****** *)
//
extern
fun
answer_input_get(): string = "mac#"
extern
fun
answer_input_set(string): void = "mac#"
//
extern
fun
answer_output_set(resp: string): void = "mac#"
//
%{^
//
function
answer_input_get()
{
  var req;
  req =
  document.getElementById("answer_input_text").value;
  return String(req);
}
function
answer_input_set(ans)
{
  document.getElementById("answer_input_text").value = ans;
}
function
answer_output_set(resp)
{
  document.getElementById("answer_output_text").value = resp;
}
//
%} // end of [%{^]
//
(* ****** ****** *)
//
fun
f_ss_answer
  (ryn: ref(bool)) = let
//
val ss1 =
  channeg1_session_recv<int>
    (lam() => parseInt(answer_input_get()))
val ss2 =
  channeg1_session_send<bool>(lam(yn) => ryn[] := yn)
//
in
  ss1 :: ss2 :: channeg1_session_nil()
end // end of [f_ss_answer]
//
(* ****** ****** *)

fun
f_ss_answer_
  (ryn: ref(bool)) = let
//
fun
cont1(x: click): void =
(
case+ x of
| Answer() => theClicks_cont0_run()
| _(*rest-of-action*) => alert("The action is ignored!")
)
//
in
  channeg1_session_thunkify(f_ss_answer(ryn), lam(x) =<cloref1> cont1(x))
end // end of [f_ss_answer_]

(* ****** ****** *)

fun
f_ss_answer_try
(
// argumentless
) : channeg_session(ss_answer_try) = let
//
val rn0 = ref{int}(0)
val ryn = ref{bool}(false)
//
implement
channeg1_repeat_disj$init<>
  () =
{
  val () = rn0[] := 0
  val () = ryn[] := false
}
implement
channeg1_repeat_disj$fwork_tag<>
  (tag) = let
//
val n0 = rn0[]
val () = rn0[] := n0 + 1
//
val () =
if n0 > 0
  then answer_output_set(String(ryn[]))
// end of [if]
//
in
//
case+ tag of
| 0 =>
  (
    // nothing
  )
| _ =>
  (
    if n0 > 0 then alert("Please try again!")
  )
//
end // end of [channeg1_repeat_disj$fwork]
//
fun
fwork_aft
(
// argless
) : void =
if
ryn[]
then alert("You got it right!")
else alert("Sorry, you got it wrong!")
//
in
//
channeg1_session_finalize
(
  channeg1_session_repeat_disj(f_ss_answer_(ryn)), lam() => fwork_aft()
)
//
end (* end of [f_ss_answer_try] *)

(* ****** ****** *)

fun
f_ss_test_one
(
// argumentless
) : channeg_session(ss_test_one) = let
//
(*
val () = console_log("fclient_test_one")
*)
//
val i1 = ref{int}(0)
val i2 = ref{int}(0)
//
val ss1 =
  channeg1_session_send(lam(x) => i1[] := x)
val ss2 =
  channeg1_session_send(lam(x) => i2[] := x)
//
fun
show_question(): void =
multest_input_set
  (String(i1[]) + " * " + String(i2[]) + " = ?")
//
val ss_rest =
channeg1_session_initize
  (lam() => show_question(), f_ss_answer_try())
//
in
  ss1 :: ss2 :: ss_rest
end // end of [f_ss_test_one]
//
(* ****** ****** *)

fun
f_ss_test_loop
(
// argumentless
): channeg_session(ss_test_loop) = let
//
val flag = ref{int}(0)
//
implement
channeg1_repeat_conj$choose<>() = if flag[] > 0 then 1 else 0
//
fun
cont1(x: click) =
(
case+ x of
| Logout() =>
  {
    val () = flag[] := 0
    val () = theClicks_cont0_run()
    val () = alert("The session is over!")
  } (* end of [Logout] *)
| Multest() => (flag[] := 1; theClicks_cont0_run())
| _ (*rest-of-click*) => ()
)
//
implement
channeg1_repeat_conj$spawn<>
  (fclo) =
(
  $extfcall(void, "theClicks_cont0_set", $UN.castvwtp0{int}(fclo));
  $extfcall(void, "theClicks_cont1_set", lam(x) =<cloref1> cont1(x));
) // end of [channeg1_repeat_conj$spawn]
//
in
//
channeg1_session_repeat_conj(f_ss_test_one())
//
end // end of [f_ss_test_loop]
//
(* ****** ****** *)

fun
f_ss_test_loop_opt
(
) : channeg_session(ss_test_loop_opt) = let
//
implement
channeg1_option_disj$fwork_tag<>
  (tag) =
(
case+ tag of
| 0 => alert("No service is provided!")
| _ => alert("Please use the provided service!")
)
//
in
//
channeg1_session_option_disj(f_ss_test_loop())
//
end // end of [f_ss_test_loop_opt]

(* ****** ****** *)

fun
f_ss_multest
(
) : channeg_session(ss_multest) = let
//
val user = userid_get((*void*))
//
in
//
channeg1_session_append(f_ss_login_(), f_ss_test_loop_opt())
//
end // end of [fclient_multest]

(* ****** ****** *)
//
implement
theSession_loop_initize() = let
//
val
chn =
channeg0_new_file
  ("./multest_server_dats_.js")
val
chn =
$UN.castvwtp0{channeg(ss_multest)}(chn)
//
val
kx0 =
lam
(
  chn: channeg_nil
) =<cloref1> let
  val () = channeg1_close(chn) 
in
  theSession_loop_initize((*void*))
end // end of [val]
//
in
  channeg1_session_run(f_ss_multest(), chn, kx0)
end // end of [val]

(* ****** ****** *)

val () = theSession_loop_initize()

(* ****** ****** *)

%{$
//
function
multest_client_initize()
{
  var _ = multest_client_dynload()
}
//
jQuery(document).ready(function(){multest_client_initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [multest_client.dats] *)
