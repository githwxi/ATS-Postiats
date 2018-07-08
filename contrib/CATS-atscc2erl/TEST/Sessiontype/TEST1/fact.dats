(*
** Factorials
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "fact_"
#define
ATS_STATIC_PREFIX "_fact_"

(* ****** ****** *)

%{^
%%
-module(fact_dats).
%%
-export([main0_erl/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-export([ats2erlpre_cloref1_app/2]).
-export([ats2erlpre_cloref2_app/3]).
-export([libats2erl_session_chanpos_xfer/0]).
-export([libats2erl_session_chanposneg_link_pn/2]).
-export([libats2erl_session_chanposneg_link_np/3]).
-export([libats2erl_session_chansrvc_create_server/1]).
-export([libats2erl_session_chansrvc2_create_server/1]).
%%
-include("./libatscc2erl/libatscc2erl_all.hrl").
-include("./libatscc2erl/Sessiontype_mylibats2erl_all.hrl").
%%
%} // end of [%{]

(* ****** ****** *)
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2ERL}/staloadall.hats"
//
(* ****** ****** *)
//
staload "./../SATS/basis.sats"
//
(* ****** ****** *)
//
staload UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
extern
fun
channeg_fact
(
  n:int
) : channeg(chsnd(int)::nil)
//
(* ****** ****** *)

implement
channeg_fact(n) = let
//
fun
fserv
(
  chp: chanpos(chsnd(int)::nil)
) : void =
channel_send_close
( chp
, if n > 0
    then n * channel_recv_close(channeg_fact(n-1))
    else 1
  // end-of-if
) (* channel_send_close *)
//
in
  channeg_create(llam(chp) => fserv(chp))
end // end of [channeg_fact]

(* ****** ****** *)
//
typedef
service_fact =
service(int, chsnd(int)::nil)
//
extern
fun
service_fact(): service_fact
//
(* ****** ****** *)

macdef
SERVICE_FACT = $extval(atom, "'SERVICE_FACT'")

(* ****** ****** *)
//
implement
service_fact() =
chansrvc2_create
  (lam(n, chp) => chanposneg_link(chp, channeg_fact(n)))
//
(* ****** ****** *)
//
fun
fact(n: int): int = 
channel_recv_close
(
  chansrvc2_request(n, $UN.cast{service_fact}(SERVICE_FACT))
)
//
(* ****** ****** *)

extern
fun
main0_erl
(
// argumentless
) : void = "mac#"
//
implement
main0_erl () =
{
//
val () =
chansrvc2_register(SERVICE_FACT, service_fact())
//
val N = 10
val ((*void*)) = println! ("fact(", N, ") = ", fact(N))
val N = 12
val ((*void*)) = println! ("fact(", N, ") = ", fact(N))
val N = 100
val ((*void*)) = println! ("fact(", N, ") = ", fact(N))
//
} (* end of [main0_erl] *)

(* ****** ****** *)

(* end of [fact.dats] *)
