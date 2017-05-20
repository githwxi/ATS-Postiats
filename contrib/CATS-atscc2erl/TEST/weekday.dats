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
-module(weekday_dats).
%%
-export([main0_erl/0]).
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
#include
"{$LIBATSCC2ERL}/staloadall.hats"
//
(* ****** ****** *)

datatype
weekday =
  | Monday of ()
  | Tuesday of ()
  | Wednesday of ()
  | Thursday of ()
  | Friday of ()
  | Saturday of ()
  | Sunday of ()
// end of [weekday]

(* ****** ****** *)

fun
isweekend
  (x: weekday): bool =
(
  case+ x of
  | Saturday () => true | Sunday () => true | _ => false 
) (* end of [isweekend] *)

(* ****** ****** *)

extern
fun
main0_erl (): void = "mac#"

(* ****** ****** *)

implement
main0_erl () =
{
  val () = println! ("isweekend(Monday) = ", isweekend(Monday))
  val () = println! ("isweekend(Saturday) = ", isweekend(Saturday))
}

(* ****** ****** *)

(* end of [weekday.dats] *)
