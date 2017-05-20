(*
** Fibonacci numbers
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "sstree_"
#define
ATS_STATIC_PREFIX "_sstree_"

(* ****** ****** *)

%{^
%%
-module(sstree_dats).
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
datatype
tree(a:t@ype) =
  | tree_nil of ()
  | tree_cons of (a, tree(a), tree(a))
//
(* ****** ****** *)
//
(*
datatype
sstree (a:vt@ype) =
| sstree_nil of (nil)
| sstree_cons of (chsnd(a), sstree(a), sstree(a))
*)
//
abstype sstree(a:vt@ype)
//
(* ****** ****** *)
//
datatype
channeg_tree
  (a:vt@ype, type) =
| channeg_tree_nil(a, nil) of ()
| channeg_tree_cons(a, chsnd(a)::chsnd(channeg(sstree(a)))::chsnd(channeg(sstree(a)))::nil) of ()
//
(* ****** ****** *)
//
extern
fun
chanpos_tree_nil
  {a:vt0p}
(
  !chanpos(sstree(a)) >> chanpos(nil)
) : void = "mac#%"
extern
fun
chanpos_tree_cons
  {a:vt0p}
(
  !chanpos(sstree(a)) >> chanpos(chsnd(a)::chsnd(channeg(sstree(a)))::chsnd(channeg(sstree(a)))::nil)
) : void = "mac#%"
//
(* ****** ****** *)
//
extern
fun
channeg_tree{a:vt0p}
  (!channeg(sstree(a)) >> channeg(ss)): #[ss:type] channeg_tree(a, ss) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
tree2sstree{a:t0p}(xs: tree(a)): channeg(sstree(a))
//
(* ****** ****** *)

implement
tree2sstree{a}(xs) = let
//
fun
fserv
(
  chp: chanpos(sstree(a)), xs: tree(a)
) : void =
(
case+ xs of
| tree_nil() => let
    val () =
    chanpos_tree_nil(chp)
  in
    chanpos_nil_wait(chp)
  end // end of [tree_nil]
| tree_cons (x, xs1, xs2) => let
    val () =
    chanpos_tree_cons(chp)
    val chn1 = tree2sstree(xs1)
    and chn2 = tree2sstree(xs2)
    val ((*void*)) = chanpos_send(chp, x)
    val ((*void*)) = chanpos_send(chp, chn1)
    val ((*void*)) = chanpos_send(chp, chn2)
  in
    chanpos_nil_wait(chp)
  end // end of [tree_cons]
) (* end of [fserv] *)
//
in
  channeg_create(llam(chp) => fserv(chp, xs))
end // end of [tree2sstree]

(* ****** ****** *)

(* end of [sstree.dats] *)
