(* ****** ****** *)
//
// HX-2016-05:
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
-module(loop_fnx3_dats).
%%
-export([mytest/0]).
-export([loop_fnx3/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-include("./libatscc2erl/libatscc2erl_all.hrl").
%%
%} // end of [%{]

(* ****** ****** *)
//
// HX:
// loop0, loop1 and loop2
// are required to have the same arity
//
fnx
loop0(_: int, _: int): int = loop1(0, 0)
and
loop1(x: int, _: int): int = loop2(x, 0)
and
loop2(x: int, y: int): int = if x > 0 then loop2(x-1, y+y) else 0
//
(* ****** ****** *)
//
extern
fun
loop_fnx3(): int = "mac#"
implement loop_fnx3() = loop0(0, 0)
//
(* ****** ****** *)
//
%{$
mytest() ->
  io:format("loop_fnx3() = ~p~n", [loop_fnx3()]).
%} // end of [%{$]

(* ****** ****** *)

(* end of [loop_fnx3.dats] *)
