(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "theWorker_start"
//
(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
  
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel_session.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos.dats"
//
(* ****** ****** *)

staload "./multest_prtcl.sats" // for protocol

(* ****** ****** *)

abstype state

(* ****** ****** *)

extern fun state_new(): state

(* ****** ****** *)
//
extern
fun{}
f_ss_pass(state) : chanpos_session(ss_pass)
extern
fun{}
f_ss_pass_try(state) : chanpos_session(ss_pass_try)
//
extern
fun{}
f_ss_answer(state) : chanpos_session(ss_answer)
extern
fun{}
f_ss_answer_try(state) : chanpos_session(ss_answer_try)
//
extern
fun{}
f_ss_test_one(state) : chanpos_session(ss_test_one)
extern
fun{}
f_ss_test_loop(state) : chanpos_session(ss_test_loop)
extern
fun{}
f_ss_test_loop_opt(state) : chanpos_session(ss_test_loop_opt)
//
(* ****** ****** *)

implement
{}(*tmp*)
f_ss_pass_try(state) = let
//
val ss_pass = f_ss_pass(state)
//
implement
chanpos1_repeat_disj$choose<>() = 1
//
in
  chanpos1_session_repeat_disj(ss_pass)
end // end of [f_ss_pass_try]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_answer_try(state) = let
//
val ss_answer = f_ss_answer(state)
//
implement
chanpos1_repeat_disj$choose<>() = 1
//
in
  chanpos1_session_repeat_disj(ss_answer)
end // end of [f_ss_answer_try]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_test_loop(state) = let
//
val ss_test_one = f_ss_test_one(state)
//
in
  chanpos1_session_repeat_conj(ss_test_one)
end // end of [f_ss_test_loop]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_test_loop_opt(state) = let
//
val ss_test_loop = f_ss_test_loop(state)
//
implement
chanpos1_option_disj$choose<>
  ((*void*)) = state_get_passed(state)
//
in
  chanpos1_session_option_disj(ss_test_loop)
end // end of [f_ss_test_loop_opt]

(* ****** ****** *)
//
extern
fun{}
f_ss_multest((*void*)) : chanpos_session(ss_multest)
//
(* ****** ****** *)

implement
{}(*tmp*)
f_ss_multest((*void*)) = let
//
val state = state_new()
//
val ss_pass_try = f_ss_pass_try(state)
val ss_test_loop_opt = f_ss_test_loop_opt(state)
//
in
  chanpos1_session_append(ss_pass_try, ss_test_loop_opt)
end // end of [f_ss_multest]

(* ****** ****** *)

(*
val () =
{
//
val ((*void*)) = multest_server($UN.castvwtp0{chanpos(ss_multest)}(0))
//
} (* end of [val] *)
*)

(* ****** ****** *)

%{$
//
theWorker_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [multest_server.dats] *)
