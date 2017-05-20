(* ****** ****** *)
//
// HX-2015-07:
// A running example
// from ATS2 to Erlang
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2ERL}/basics_erl.sats"
staload
"{$LIBATSCC2ERL}/SATS/integer.sats"
//
(* ****** ****** *)

%{^
%%
-module(isevn_dats).
%%
-export([isevn/1]).
-export([isodd/1]).
-export([mytest/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-include("./libatscc2erl/libatscc2erl_all.hrl").
%%
%} // end of [%{]

(* ****** ****** *)
//
fnx isevn_ (n: int): bool =
  if n > 0 then isodd_(n-1) else true
and isodd_ (n: int): bool =
  if n > 0 then isevn_(n-1) else false
//
(* ****** ****** *)
//
extern
fun isevn
  : (int) -> bool = "mac#isevn"
extern
fun isodd
  : (int) -> bool = "mac#isodd"
//
implement isevn (x) = isevn_(x)
implement isodd (x) = if x > 0 then isevn_(x-1) else false
//
(* ****** ****** *)

%{$
mytest() ->
  N = 100
, io:format("isevn(~p) = ~p~n", [N, isevn(N)])
, io:format("isodd(~p) = ~p~n", [N, isodd(N)])
, io:format("isevn(~p) = ~p~n", [N, isevn(N+1)])
, io:format("isevn(~p) = ~p~n", [N, isodd(N+1)])
. %% mytest()
%} // end of [%{$]

(* ****** ****** *)

(* end of [isevn.dats] *)
