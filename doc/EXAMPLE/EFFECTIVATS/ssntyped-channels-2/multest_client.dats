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
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/channeg.dats"
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
fclient_pass
(
  chn: channeg(ss_pass)
, kx0: chncont0_nil, ryn: ref(bool)
) : void = let
//
val
cont0 =
llam() =<lincloptr1> let
//
val pass = passwd_get()
//
in
//
channeg1_recv
( chn, pass
, lam(chn) =>
  channeg1_send
  ( chn
  , lam(chn, yn) => let
      val yn = chmsg_parse<bool>(yn)
    in
      ryn[] := yn; kx0(chn)
    end // end of [lam]
  ) (* channeg1_send *)
)
//
end // end of [llam]
//
val
cont0 = $UN.castvwtp0{JSobj}(cont0)
//
fun
cont1(x: click): void =
(
case+ x of
| Passwd() => theClicks_cont0_run() | _ => ()
)
//
val cont1 = $UN.cast{JSobj}(lam(x) =<cloref1> cont1(x))
//
in
  $extfcall(void, "theClicks_cont01_set", cont0, cont1)
end // end of [fclient_pass]

(* ****** ****** *)

fun
fclient_pass_try
(
  chn: channeg(ss_pass_try), kx0: chncont0_nil
) : void = let
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
| 0 => ()
| _ => if n0 > 0 then alert("Please try again!")
//
end // end of [channeg1_repeat_disj$fwork_tag]
//
in
//
channeg1_repeat_disj<>
( chn
, kx0, lam(chn, kx0) => fclient_pass(chn, kx0, ryn)
)
//
end (* end of [fclient_pass_try] *)

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
fclient_answer
(
  chn: channeg(ss_answer)
, kx0: chncont0_nil, ryn: ref(bool)
) : void = let
//
val
cont0 =
llam() =<lincloptr1> let
//
val
answer =
  parseInt(answer_input_get())
//
in
//
channeg1_recv
( chn, answer
, lam(chn) =>
  channeg1_send
  ( chn
  , lam(chn, yn) => let
      val yn = chmsg_parse<bool>(yn)
    in
      ryn[] := yn; kx0(chn)
    end // end of [lam]
  ) (* channeg1_send *)
)
//
end // end of [llam]
//
val
cont0 = $UN.castvwtp0{JSobj}(cont0)
//
fun
cont1(x: click): void =
(
case+ x of
| Answer() => theClicks_cont0_run() | _ => ()
)
//
val cont1 = $UN.cast{JSobj}(lam(x) =<cloref1> cont1(x))
//
in
  $extfcall(void, "theClicks_cont01_set", cont0, cont1)
end // end of [fclient_answer]

(* ****** ****** *)

fun
fclient_answer_try
(
  chn: channeg(ss_answer_try), kx0: chncont0_nil
) : void = let
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
val () =
if n0 > 0
  then answer_output_set(String(ryn[]))
// end of [if]
//
in
//
case+ tag of
| 0 => ()
| _ => if n0 > 0 then alert("Please try again!")
//
end // end of [channeg1_repeat_disj$fwork]
//
in
//
channeg1_repeat_disj<>
( chn
, kx0, lam(chn, kx0) => fclient_answer(chn, kx0, ryn)
)
//
end (* end of [fclient_answer_try] *)

(* ****** ****** *)

fun
fclient_test_one
(
  chn: channeg(ss_test_one), kx0: chncont0_nil
) : void = let
//
(*
val () = console_log("fclient_test_one")
*)
//
in
//
channeg1_send
( chn
, lam(chn, arg1) => let
  val arg1 =
    chmsg_parse<int>(arg1)
  in
    channeg1_send
    ( chn
    , lam(chn, arg2) => let
      val arg2 =
        chmsg_parse<int>(arg2)
      val () =
        multest_input_set
        (
          String(arg1) + " * " + String(arg2) + " = ?"
        ) (* multest_input_set *)
      in
        fclient_answer_try(chn, kx0)
      end
    )
  end // end of [lam]
)
//
end // end of [fclient_test_one]

(* ****** ****** *)

fun
fclient_test_loop
(
  chn: channeg(ss_test_loop), kx0: chncont0_nil
) : void = let
//
val flag = ref{int}(0)
//
implement
channeg1_repeat_conj$choose<>
  () = if flag[] > 0 then 1 else 0
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
channeg1_repeat_conj
(
  chn, kx0, lam(chn, kx0) => fclient_test_one(chn, kx0)
)
//
end // end of [fclient_test_loop]

(* ****** ****** *)

fun
fclient_test_loop_opt
(
  chn: channeg(ss_test_loop_opt), kx0: chncont0_nil
) : void = let
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
channeg1_option_disj<>
(
  chn, kx0, lam(chn, kx0) => fclient_test_loop(chn, kx0)
)
//
end // end of [fclient_test_loop_opt]

(* ****** ****** *)

fun
fclient_multest
(
  chn: channeg(ss_multest), kx0: chncont0_nil
) : void = let
//
val user = userid_get((*void*))
//
in
//
channeg1_append
(
  chn, kx0
, lam(chn, kx0) => fclient_pass_try(chn, kx0)
, lam(chn, kx0) => fclient_test_loop_opt(chn, kx0)
) (* end of [channeg1_append] *)
//
end // end of [fclient_multest]

(* ****** ****** *)
//
fun
fclient_multest2
(
  chn: channeg(ss_multest2), kx0: chncont0_nil
) : void =
(
  channeg1_recv(chn, "userid", lam(chn) => fclient_multest(chn, kx0))
)
//
(* ****** ****** *)
//
implement
theSession_loop_initize() = let
//
val
chn =
channeg0_new_file
  ("./multest_server_dats_.js")
//
(*
val () = alert("chn = " + String(chn))
*)
//
val
chn = $UN.castvwtp0{channeg(ss_multest2)}(chn)
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
val
cont0 =
llam () =<lincloptr1>
  fclient_multest2(chn, kx0)
//
val
cont0 = $UN.castvwtp0{JSobj}(cont0)
//
fun
cont1(x: click): void =
(
case+ x of
| Login() =>
  theClicks_cont0_run() where
  {
    val () = alert("Please send password!")
  }
| _(*rest*) => ((*other-events-are-ignored*))
)
val cont1 =
  $UN.cast{JSobj}(lam(x) =<cloref1> cont1(x))
//
in
  $extfcall(void, "theClicks_cont01_set", cont0, cont1)
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
