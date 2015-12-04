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
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos_session.dats"
//
(* ****** ****** *)

staload "./multest_prtcl.sats" // for protocol

(* ****** ****** *)
//
abstype state_type = ptr
typedef state = state_type
//
(* ****** ****** *)

extern fun state_new(): state

(* ****** ****** *)
//
extern fun state_get_test_arg1: (state) -> int
extern fun state_get_test_arg2: (state) -> int
extern fun state_set_test_arg1: (state, int) -> void
extern fun state_set_test_arg2: (state, int) -> void
//
extern fun state_get_pass_result: (state) -> bool
extern fun state_set_pass_result: (state, bool) -> void
//
extern fun state_get_answer_result: (state) -> bool
extern fun state_set_answer_result: (state, bool) -> void
//
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

overload :: with chanpos1_session_cons

implement
{}(*tmp*)
f_ss_pass(state) = let
//
val
pass = ref{string}("")
//
fun
pass_check
  (x: string): bool =
  if x = "AboveTopSecret" then true else false
fun
pass_check2
(
  x: string
) : bool = passed where
{
  val passed = pass_check(x)
  val ((*void*)) =
    if passed then state_set_pass_result(state, true)
  // end of [val]
} (* end of [pass_check2] *)
//
typedef str = string
//
val ss1 =
  chanpos1_session_recv_cloref<str>(lam(x) => pass[] := x)
val ss2 =
  chanpos1_session_send_cloref<bool>(lam() => pass_check2(pass[]))
//
in
  ss1 :: ss2 :: chanpos1_session_nil()
end // end of [f_ss_pass]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_pass_try(state) = let
//
val mtry = 3
val ntry = ref{int}(0)
//
val ((*void*)) =
  state_set_pass_result(state, false)
//
val ss_pass = f_ss_pass(state)
//
implement
chanpos1_repeat_disj$choose<>() =
(
if state_get_pass_result(state)
  then 0 else (if (ntry[] >= mtry) then 0 else 1)
)
//
in
  chanpos1_session_repeat_disj(ss_pass)
end // end of [f_ss_pass_try]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_answer(state) = let
//
val res = ref{int}(0)
//
val arg1 = state_get_test_arg1(state)
val arg2 = state_get_test_arg2(state)
//
fun
answer_check
(
  ans: int
) : bool =
  if (ans = arg1*arg2) then true else false
//
fun
answer_check2
(
  ans: int
) : bool = passed where
{
  val passed = answer_check(ans)
  val ((*void*)) =
    if passed then state_set_answer_result(state, true)
  // end of [val]
}
//
val ss1 =
  chanpos1_session_recv_cloref<int>(lam(x) => res[] := x)
val ss2 =
  chanpos1_session_send_cloref<bool>(lam() => answer_check(res[]))
//
in
  ss1 :: ss2 :: chanpos1_session_nil()  
end // end of [f_ss_answer]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_answer_try(state) = let
//
val mtry = 3
val ntry = ref{int}(0)
//
val ((*void*)) =
  state_set_answer_result(state, false)
//
val ss_answer = f_ss_answer(state)
//
implement
chanpos1_repeat_disj$choose<>() =
(
if state_get_answer_result(state)
  then 0 else (if (ntry[] >= mtry) then 0 else 1)
)
//
in
  chanpos1_session_repeat_disj(ss_answer)
end // end of [f_ss_answer_try]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_test_one(state) = let
//
#define N 100
#define d2i double2int
//
val
arg1 = d2i(N*JSmath_random())
val
arg2 = d2i(N*JSmath_random())
//
val () = state_set_test_arg1(state, arg1)
val () = state_set_test_arg1(state, arg2)
//
val ss1 = 
  chanpos1_session_send_cloref<int>(lam((*void*)) => arg1)
val ss2 = 
  chanpos1_session_send_cloref<int>(lam((*void*)) => arg2)
//
in
  ss1 :: ss2 :: f_ss_answer_try(state)
end // end of [f_ss_test_one]

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
  ((*void*)) =
  if state_get_pass_result(state) then 0 else 1
//
in
  chanpos1_session_option_disj(ss_test_loop)
end // end of [f_ss_test_loop_opt]

(* ****** ****** *)

implement
chanpos_session_multest() = let
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

val () =
{
//
val ((*void*)) =
  chanpos1_session_run_close(chanpos_session_multest())
//
} (* end of [val] *)

(* ****** ****** *)

%{$
//
theWorker_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [multest_server.dats] *)
