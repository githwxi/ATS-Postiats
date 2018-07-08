(*
** Erathosthene's sieve
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "sieve_"
#define
ATS_STATIC_PREFIX "_sieve_"

(* ****** ****** *)

%{^
%%
-module(sieve_dats).
%%
-export([main0_erl/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-export([ats2erlpre_cloref1_app/2]).
-export([libats2erl_session_chanpos_xfer/0]).
-export([libats2erl_session_chanposneg_link_pn/2]).
-export([libats2erl_session_chanposneg_link_np/3]).
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
staload "./../SATS/co-list.sats"
//
(* ****** ****** *)
//
extern
fun
primes_gen
(
// argumentless
) : channeg(sslist(int)) = "mac#"
//
extern
fun
ints_from (n0: int): channeg(sslist(int)) = "mac#"
//
extern
fun
ints_filter
  (channeg(sslist(int)), n0: int): channeg(sslist(int)) = "mac#"
//
(* ****** ****** *)
  
implement
primes_gen() = let
//
fun
fserv
(
  chp: chanpos(sslist(int))
, chn: channeg(sslist(int))
) : void = let
//
val opt = chanpos_list (chp)
//
in
//
case+ opt of
| chanpos_list_nil() =>
  (
    chanpos_nil_wait(chp);
    channeg_list_nil(chn); channeg_nil_close(chn)
  )
| chanpos_list_cons() => let
    val () =
      channeg_list_cons(chn)
    // end of [val]
    val p0 = channeg_send(chn)
  in
    chanpos_send(chp, p0); fserv(chp, ints_filter(chn, p0))
  end // end of [channeg_list_cons]
//
end // end of [fserv]
//
in
  channeg_create(llam(chp) => fserv(chp, ints_from(2)))
end // end of [primes_gen]

(* ****** ****** *)

implement
ints_from(n0) = let
//
fun
fserv
(
  chp: chanpos(sslist(int)), n0: int
) : void = let
//
val opt = chanpos_list (chp)
//
in
//
case+ opt of
| chanpos_list_nil() =>
    chanpos_nil_wait(chp)
| chanpos_list_cons() =>
    (chanpos_send{int}(chp, n0); fserv(chp, n0+1))
//
end // end of [fserv]
//
in
  channeg_create(llam(chp) => fserv(chp, n0))
end // end of [ints_from]

(* ****** ****** *)

implement
ints_filter
  (chn, n0) = let
//
fun
getfst
(
  chn: !channeg(sslist(int))
) : int = let
//
val () =
  channeg_list_cons(chn)
//
val fst = channeg_send(chn)
//
in
  if fst mod n0 > 0 then fst else getfst(chn)
end // end of [getfst]
//
fun
fserv
(
  chp: chanpos(sslist(int))
, chn: channeg(sslist(int))
) : void = let
//
val opt = chanpos_list (chp)
//
in
//
case+ opt of
| chanpos_list_nil() =>
  (
    chanpos_nil_wait(chp);
    channeg_list_nil(chn); channeg_nil_close(chn)
  )
| chanpos_list_cons() =>
  (
    chanpos_send(chp, getfst(chn)); fserv(chp, chn)
  )
//
end // end of [fserv]
//
in
  channeg_create(llam(chp) => fserv(chp, chn))
end // end of [ints_filter]

(* ****** ****** *)
//
extern
fun
print_primes
(
  n0: int
, chn: !channeg(sslist(int))
) : void = "mac#"
//
implement
print_primes
  (n0, chn) = (
//
if
n0 > 0
then let
//
val () = channeg_list_cons(chn)
val px = channeg_send{int}(chn)
//
in
  println! (px); print_primes (n0-1, chn)
end // end of [then]
else () // end of [else]
//
) (* end of [print_primes] *)
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
val chn = primes_gen()
val ((*void*)) = print_primes(10, chn)
//
val ((*void*)) = channeg_list_nil(chn)
val ((*void*)) = channeg_nil_close(chn)
//
} (* end of [main0_erl] *)

(* ****** ****** *)

(* end of [sieve.dats] *)
