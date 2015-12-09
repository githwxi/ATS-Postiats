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
// HX: 20 points
//
extern
fun
fserver_multest
(
  chp: chanpos(ss_multest), kx0: chpcont0_nil
) : void // end of [fserver_multest]
//
extern
fun
fserver_multest2
(
  chp: chanpos(ss_multest2), kx0: chpcont0_nil
) : void // end of [fserver_multest2]
//
(* ****** ****** *)

abstype state_type = ptr
typedef state = state_type

(* ****** ****** *)

extern fun state_new(): state

(* ****** ****** *)
//
extern fun state_get_uid: (state) -> string
extern fun state_set_uid: (state, string) -> void
//
extern fun state_get_test_arg1: (state) -> int
extern fun state_set_test_arg1: (state, int) -> void
//
extern fun state_get_test_arg2: (state) -> int
extern fun state_set_test_arg2: (state, int) -> void
//
extern fun state_get_pass_result: (state) -> bool
extern fun state_set_pass_result: (state, bool) -> void
//
extern fun state_get_answer_result: (state) -> bool
extern fun state_set_answer_result: (state, bool) -> void
//
(* ****** ****** *)

local
//
assume state_type = gvhashtbl
//
in (* in-of-local *)
//
implement
state_new() = gvhashtbl_make_nil()
//
implement
state_get_uid(state) =
  let val-GVstring(x) = state["uid"] in x end
implement
state_set_uid(state, x) =
  let val () = state["uid"] := GVstring(x) in () end
//
implement
state_get_test_arg1(state) =
  let val-GVint(x) = state["test_arg1"] in x end
implement
state_set_test_arg1(state, i) =
  let val () = state["test_arg1"] := GVint(i) in () end
//
implement
state_get_test_arg2(state) =
  let val-GVint(x) = state["test_arg2"] in x end
implement
state_set_test_arg2(state, i) =
  let val () = state["test_arg2"] := GVint(i) in () end
//
implement
state_get_pass_result(state) =
  let val-GVbool(x) = state["pass_result"] in x end
implement
state_set_pass_result(state, b) =
  let val () = state["pass_result"] := GVbool(b) in () end
//
implement
state_get_answer_result(state) =
  let val-GVbool(x) = state["answer_result"] in x end
implement
state_set_answer_result(state, b) =
  let val () = state["answer_result"] := GVbool(b) in () end
//
end // end of [local]

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

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_pass(state) = let
//
val
pass = ref{string}("")
//
fun
pass_check
(
  x: string
) : bool = passed where
{
//
val
passed = 
(
  if x = "AboveTopSecret" then true else false
) : bool
//
val ((*void*)) =
  if passed then state_set_pass_result(state, true)
//
} (* pass-check *)
//
typedef str = string
//
val ss1 =
  chanpos1_session_recv_cloref<str>(lam(x) => pass[] := x)
val ss2 =
  chanpos1_session_send_cloref<bool>(lam() => pass_check(pass[]))
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
implement
chanpos1_repeat_disj$choose<>() = let
  val n0 = ntry[]
  val () = ntry[] := n0 + 1
in
//
if state_get_pass_result(state)
  then 0 else (if (n0 >= mtry) then 0 else 1)
//
end // end of [chanpos1_repeat_disj$choose]
//
in
  chanpos1_session_repeat_disj(f_ss_pass(state))
end // end of [f_ss_pass_try]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_answer
  (state) = let
//
val r0 = ref{int}(0)
//
fun
answer_check
  (x: int): bool = a0 where
{
//
val i1 = state_get_test_arg1(state)
val i2 = state_get_test_arg2(state)
//
val a0 = (x = i1 * i2)
val () = if a0 then state_set_answer_result(state, true)
} (* end of [answer_check] *)
//
val ss1 =
  chanpos1_session_recv_cloref<int>(lam(x) => r0[] := x)
val ss2 =
  chanpos1_session_send_cloref<bool>(lam() => answer_check(r0[]))
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
implement
chanpos1_repeat_disj$init<>() =
{
  val () = ntry[] := 0
  val () = state_set_answer_result(state, false)
}
//
implement
chanpos1_repeat_disj$choose<>
  ((*void*)) = let
  val n0 = ntry[]
  val () = ntry[] := n0 + 1
  val b0 = state_get_answer_result(state)
in
  if b0 then 0 else (if (n0 >= mtry) then 0 else 1)
end // end of [chanpos1_repeat_disj$choose]
//
in
  chanpos1_session_repeat_disj(f_ss_answer(state))
end // end of [f_ss_answer_try]

(* ****** ****** *)

implement
{}(*tmp*)
f_ss_test_one(state) = let
//
#define N 100
#define d2i double2int
//
fun
arg1_gen(): int = i1 where
{
  val i1 = d2i(N*JSmath_random())
  val () = state_set_test_arg1(state, i1)
}  
//
fun
arg2_gen(): int = i2 where
{
  val i2 = d2i(N*JSmath_random())
  val () = state_set_test_arg2(state, i2)
}  
//
val ss1 = 
  chanpos1_session_send_cloref<int>(lam((*void*)) => arg1_gen())
val ss2 = 
  chanpos1_session_send_cloref<int>(lam((*void*)) => arg2_gen())
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
implement
chanpos1_option_disj$choose<>
  ((*void*)) =
  if state_get_pass_result(state) then 1 else 0
//
in
  chanpos1_session_option_disj(f_ss_test_loop(state))
end // end of [f_ss_test_loop_opt]

(* ****** ****** *)
//
extern
fun
chanpos_session_multest2
  ((*void*)): chanpos_session(ss_multest2)
//
implement
chanpos_session_multest2() = let
//
val state = state_new()
//
val ss0 =
  chanpos1_session_recv_cloref<string>
    (lam(uid) => state_set_uid(state, uid))
//
val ss_pass_try = f_ss_pass_try(state)
val ss_test_loop_opt = f_ss_test_loop_opt(state)
//
in
  ss0 :: chanpos1_session_append(ss_pass_try, ss_test_loop_opt)
end // end of [chanpos_session_multest2]
//
(* ****** ****** *)

val () =
{
//
val chn = $UN.castvwtp0{chanpos(ss_multest2)}(0)
//
val ((*void*)) =
  chanpos1_session_run_close(chanpos_session_multest2(), chn)
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
