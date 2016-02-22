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
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
//
(* ****** ****** *)

typedef
ss_pass =
chrcv(string)::chsnd(bool)::chnil

typedef
ss_pass_try = ssrepeat_disj(ss_pass)

(* ****** ****** *)

typedef
ss_login = chrcv(string) :: ss_pass_try

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
ss_multest = ssappend(ss_login, ss_test_loop_opt)

(* ****** ****** *)

(* end of [multest_prtcl.sats] *)
