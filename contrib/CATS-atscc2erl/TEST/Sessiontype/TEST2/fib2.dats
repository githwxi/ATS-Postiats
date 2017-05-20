(*
** Fibonacci numbers
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "fib2_"
#define
ATS_STATIC_PREFIX "_fib2_"

(* ****** ****** *)

%{^
%%
-module(fib2_dats).
%%
-export([main0_erl/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-export([ats2erlpre_cloref1_app/2]).
-export([libats2erl_session_chque_server/0]).
-export([libats2erl_session_chanpos_server/2]).
-export([libats2erl_session_channeg_server/2]).
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
#include
"{$LIBATSCC2ERL}/staloadall.hats"
//
(* ****** ****** *)
//
staload "./../SATS/basis.sats"
//
(* ****** ****** *)
//
dataprop
FIB(int, int) =
| FIBbas0 (0, 0) of ()
| FIBbas1 (1, 1) of ()
| {n:nat}{r0,r1:int}
  FIBind2 (n+2, r0+r1) of (FIB(n, r0), FIB(n+1, r1))
//
(* ****** ****** *)
//
extern
praxi
fib_istot{n:nat}(): [r:int] FIB(n, r)
extern
praxi
fib_isfun
{n:nat}
{r1,r2:int}
  (FIB(n, r1), FIB(n, r2)): [r1==r2] void
//
(* ****** ****** *)
//
extern
fun
channeg_fib2
  {n:nat}(n:int(n))
: [r:int] (FIB(n, r) | channeg(chsnd(int(r))::nil))
//
(* ****** ****** *)

implement
channeg_fib2{n}(n) = let
//
prval
[r:int] pf = fib_istot{n}()
//
fun
fserv
(
  chp: chanpos(chsnd(int(r))::nil)
) : void = let
//
val r = (
//
if
n >= 2
then let
  val (pf_1 | chn_1) = channeg_fib2(n-1)
  val (pf_2 | chn_2) = channeg_fib2(n-2)
  prval () = fib_isfun(pf, FIBind2(pf_2, pf_1))
in
  channel_recv_close(chn_1) + channel_recv_close(chn_2)
end // end of [then]
else (
  if n >= 1
    then let prval FIBbas1() = pf in 1 end
    else let prval FIBbas0() = pf in 0 end
  // end of [if]
) (* end of [else] *)
) : int(r) // end of [val]
//
in
  channel_send_close(chp, r)
end (* end of [chanpos_send_close] *)
//
in
  (pf | channeg_create(llam(chp) => fserv(chp)))
end // end of [channeg_fib2]

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
val N = 20
//
val
(_|chn) = channeg_fib2(N)
//
val ans = channeg_send(chn)
//
val ((*void*)) = channeg_nil_close(chn)
//
val ((*void*)) = println! ("channeg_fib2(", N, ") = ", ans)
//
} (* end of [main0_erl] *)

(* ****** ****** *)

(* end of [fib2.dats] *)
