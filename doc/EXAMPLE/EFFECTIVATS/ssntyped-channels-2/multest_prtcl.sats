(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/SATS/Worker/channel_session.sats"
//
(* ****** ****** *)

typedef
ss_pass =
chrcv(string)::chsnd(bool)::chnil

typedef
ss_pass_try = ssrepeat_disj(ss_pass)

(* ****** ****** *)

typedef
ss_answer =
chrcv(int)::chsnd(bool)::chnil

typedef
ss_answer_try = ssrepeat_disj(ss_answer)

(* ****** ****** *)

typedef
ss_test_one =
chsnd(int)::chsnd(int)::ss_answer_try

(* ****** ****** *)

typedef
ss_test_loop = ssrepeat_conj(ss_test_one)

(* ****** ****** *)

typedef
ss_test_loop_opt = ssoption_disj(ss_test_loop)

(* ****** ****** *)

typedef
ss_multest = ssappend(ss_pass_try, ss_test_loop_opt)

(* ****** ****** *)
//
fun
chanpos_session_multest() : chanpos_session(ss_multest)
//
fun
channeg_session_multest() : channeg_session(ss_multest)
//
(* ****** ****** *)

(* end of [multest_prtcl.sats] *)
