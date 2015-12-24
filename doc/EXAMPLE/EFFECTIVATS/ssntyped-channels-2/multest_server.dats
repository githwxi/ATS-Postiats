(* ****** ****** *)
(*
//
// For use in Effiective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)
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
staload
"{$LIBATSCC2JS}/SATS/Worker/channel_session2.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos_session.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos_session2.dats"
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
overload .uid with state_get_uid
overload .uid with state_set_uid
overload .test_arg1 with state_get_test_arg1
overload .test_arg1 with state_set_test_arg1
overload .test_arg2 with state_get_test_arg2
overload .test_arg2 with state_set_test_arg2
overload .pass_result with state_get_pass_result
overload .pass_result with state_set_pass_result
overload .answer_result with state_get_answer_result
overload .answer_result with state_set_answer_result
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
fun
f_ss_pass(state) : chanpos_session(ss_pass)
extern
fun
f_ss_pass_try(state) : chanpos_session(ss_pass_try)
//
extern
fun
f_ss_login(state): chanpos_session(ss_login)
//
extern
fun
f_ss_answer(state) : chanpos_session(ss_answer)
extern
fun
f_ss_answer_try(state) : chanpos_session(ss_answer_try)
//
extern
fun
f_ss_test_one(state) : chanpos_session(ss_test_one)
extern
fun
f_ss_test_loop(state) : chanpos_session(ss_test_loop)
//
(* ****** ****** *)

overload :: with chanpos1_session_cons

(* ****** ****** *)

implement
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
  if x = "multest" then true else false
) : bool
//
val ((*void*)) =
  if passed then state.pass_result(true)
//
} (* pass-check *)
//
typedef str = string
//
val ss1 =
  chanpos1_session_recv<str>(lam(x) => pass[] := x)
val ss2 =
  chanpos1_session_send<bool>(lam() => pass_check(pass[]))
//
in
  ss1 :: ss2 :: chanpos1_session_nil()
end // end of [f_ss_pass]

(* ****** ****** *)

implement
f_ss_pass_try(state) = let
//
val mtry = 3
val ntry = ref{int}(0)
//
val ((*void*)) =
  state.pass_result(false)
//
implement
chanpos1_repeat_disj$choose<>() = let
  val n0 = ntry[]
  val () = ntry[] := n0 + 1
in
//
if state.pass_result()
  then 0 else (if (n0 >= mtry) then 0 else 1)
//
end // end of [chanpos1_repeat_disj$choose]
//
in
  chanpos1_session_repeat_disj(f_ss_pass(state))
end // end of [f_ss_pass_try]

(* ****** ****** *)

implement
f_ss_login
  (state) =
  ss0 :: f_ss_pass_try(state) where
{
//
val ss0 =
  chanpos1_session_recv<string>(lam(uid) => state.uid(uid))
//
} (* end of [f_ss_login] *)

(* ****** ****** *)

implement
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
val i1 = state.test_arg1()
val i2 = state.test_arg2()
//
val a0 = (x = i1 * i2)
val () =
  if a0 then state.answer_result(true)
// end of [val]
//
} (* end of [answer_check] *)
//
val ss1 =
  chanpos1_session_recv<int>(lam(x) => r0[] := x)
val ss2 =
  chanpos1_session_send<bool>(lam() => answer_check(r0[]))
//
in
  ss1 :: ss2 :: chanpos1_session_nil()  
end // end of [f_ss_answer]

(* ****** ****** *)

implement
f_ss_answer_try(state) = let
//
val mtry = 3
val ntry = ref{int}(0)
//
implement
chanpos1_repeat_disj$init<>() =
{
  val () = ntry[] := 0
  val () =
    state.answer_result(false)
  // end of [val]
}
//
implement
chanpos1_repeat_disj$choose<>
  ((*void*)) = let
  val n0 = ntry[]
  val () = ntry[] := n0 + 1
  val b0 = state.answer_result()
in
  if b0 then 0 else (if (n0 >= mtry) then 0 else 1)
end // end of [chanpos1_repeat_disj$choose]
//
in
  chanpos1_session_repeat_disj(f_ss_answer(state))
end // end of [f_ss_answer_try]

(* ****** ****** *)

implement
f_ss_test_one(state) = let
//
#define N 100
#define d2i double2int
//
fun
arg1_gen(): int = i1 where
{
  val i1 =
    d2i(N*JSmath_random())
  // end of [val]
  val () = state.test_arg1(i1)
}  
//
fun
arg2_gen(): int = i2 where
{
  val i2 =
    d2i(N*JSmath_random())
  // end of [val]
  val () = state.test_arg2(i2)
}  
//
val ss1 = 
  chanpos1_session_send<int>(lam((*void*)) => arg1_gen())
val ss2 = 
  chanpos1_session_send<int>(lam((*void*)) => arg2_gen())
//
in
  ss1 :: ss2 :: f_ss_answer_try(state)
end // end of [f_ss_test_one]

(* ****** ****** *)

implement
f_ss_test_loop(state) = let
//
val ss_test_one = f_ss_test_one(state)
//
in
  chanpos1_session_repeat_conj(ss_test_one)
end // end of [f_ss_test_loop]

(* ****** ****** *)
//
extern
fun
chanpos_session_multest
  ((*void*))
: chanpos_session(ss_multest)
//
implement
chanpos_session_multest
  ((*void*)) = let
//
val state = state_new()
//
val ss_login = f_ss_login(state)
val ss_test_loop = f_ss_test_loop(state)
//
implement
chanpos1_session_guardby$guard<>
  ((*void*)) = state.pass_result()
//
in
  chanpos1_session_guardby(ss_test_loop, ss_login)
end // end of [chanpos_session_multest]
//
(* ****** ****** *)

val () =
{
//
val chn = $UN.castvwtp0{chanpos(ss_multest)}(0)
//
val ((*void*)) =
  chanpos1_session_run_close(chanpos_session_multest(), chn)
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
