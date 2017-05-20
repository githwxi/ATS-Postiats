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

%{^
%%
-module(f91_dats).
%%
-export([f91/1]).
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
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2ERL}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun f91 : int -> int = "mac#f91"
//
implement
f91 (x) =
if x >= 101
  then x - 10 else f91(f91(x+11))
//
(* ****** ****** *)

%{$
mytest() ->
  N = 10
, io:format("f91(~p) = ~p~n", [N, f91(N)])
. %% mytest()
%} // end of [%{$]

(* ****** ****** *)

(* end of [f91.dats] *)
