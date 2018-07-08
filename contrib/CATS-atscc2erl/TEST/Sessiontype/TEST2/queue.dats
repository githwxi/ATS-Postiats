(*
** A queue of channels
*)
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
(*
#define ATS_PACKNAME "queue"
*)
//
#define ATS_EXTERN_PREFIX "queue_"
#define ATS_STATIC_PREFIX "_queue_"
//
(* ****** ****** *)

%{^
%%
-module(queue_dats).
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
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../SATS/basis.sats"
staload "./../DATS/basis_chan2.dats"

(* ****** ****** *)
//
(*
//
datatype
ssque(a:t@ype, int) =
  | ssque_nil(a, 0) of ()
  | {n:pos}
    ssque_deq(a, n) of (snd(a), ssque(a,n-1))
  | {n:nat}
    ssque_enq(a, n) of (rcv(a), ssque(a,n+1))
//
*)
abstype ssque(a:vt@ype, n:int)
//
(* ****** ****** *)
//
datatype
chanpos_ssque
  (a:vt@ype, type, int) =
  | chanpos_ssque_nil(a, nil, 0) of ()
  | {n:pos}
    chanpos_ssque_deq(a,chsnd(a)::ssque(a,n-1),n) of ()
  | {n:nat}
    chanpos_ssque_enq(a,chrcv(a)::ssque(a,n+1),n) of ()
//
(* ****** ****** *)
//
extern
fun
chanpos_ssque
  {a:vt0p}{n:nat}
  (!chanpos(ssque(a,n)) >> chanpos(ss))
: #[ss:type] chanpos_ssque(a, ss, n) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
channeg_ssque_nil
  {a:vt@ype}
  (!channeg(ssque(a,0)) >> channeg(nil)): void = "mac#%"
extern
fun
channeg_ssque_deq
  {a:vt@ype}{n:pos}
  (!channeg(ssque(a,n)) >> channeg(chsnd(a)::ssque(a,n-1))): void = "mac#%"
and
channeg_ssque_enq
  {a:vt@ype}{n:nat}
  (!channeg(ssque(a,n)) >> channeg(chrcv(a)::ssque(a,n+1))): void = "mac#%"
//
(* ****** ****** *)
  
implement
chanpos_ssque
  {a}{n}(chpos) = let
//
val
chpos2 = $UN.castvwtp1{chanpos2}(chpos)
val tag = chanpos2_recv{natLt(3)}(chpos2)
//
prval () = $UN.cast2void(chpos2)
//
in
//
case+ tag of
| 0 => let
    prval () = $UN.prop_assert{n==0}()
    prval () =
    $UN.castview2void(chpos) in chanpos_ssque_nil()
  end // end of [prval]
| 1 => let
    prval () = $UN.prop_assert{n > 0}()
    prval () =
    $UN.castview2void(chpos) in chanpos_ssque_deq()
  end // end of [prval]
| 2 => let
    prval () =
    $UN.castview2void(chpos) in chanpos_ssque_enq()
  end // end of [prval]
//
end // end of [chanpos_ssque]
//
(* ****** ****** *)

implement
channeg_ssque_nil
  (chneg) = () where
{
//
val
chneg2 =
$UN.castvwtp1{channeg2}(chneg)
//
val () =
  channeg2_recv{int}(chneg2, 0)
//
prval () = $UN.cast2void(chneg2)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [channeg_ssque_nil] *)

(* ****** ****** *)

implement
channeg_ssque_deq
  (chneg) = () where
{
//
val
chneg2 =
$UN.castvwtp1{channeg2}(chneg)
//
val () =
  channeg2_recv{int}(chneg2, 1)
//
prval () = $UN.cast2void(chneg2)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [channeg_ssque_deq] *)

(* ****** ****** *)

implement
channeg_ssque_enq
  (chneg) = () where
{
//
val
chneg2 =
$UN.castvwtp1{channeg2}(chneg)
//
val () =
  channeg2_recv{int}(chneg2, 2)
//
prval () = $UN.cast2void(chneg2)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [channeg_ssque_enq] *)

(* ****** ****** *)

extern
fun
chanposneg_link_ssque
  {a:vt0p}{n:nat}
(
  chp: chanpos(ssque(a, n))
, chn: channeg(ssque(a, n))
) : void // end of [chanposneg_link_ssque]
//
implement
chanposneg_link_ssque
  {a}(chp, chn) = let
//
val opt = chanpos_ssque(chp)
//
in
//
case+ opt of
| chanpos_ssque_nil() =>
  {
//
    val () = chanpos_nil_wait(chp)
//
    val () = channeg_ssque_nil(chn)
    val () = channeg_nil_close(chn)
//
  }
| chanpos_ssque_deq() =>
  {
    val () = channeg_ssque_deq(chn)
    val () = chanpos_send{a}(chp, channeg_send{a}(chn))
    val () = chanposneg_link_ssque(chp, chn)
  }
| chanpos_ssque_enq() =>
  {
    val () = channeg_ssque_enq(chn)
    val () = channeg_recv{a}(chn, chanpos_recv{a}(chp))
    val () = chanposneg_link_ssque(chp, chn)
  }
//
end // end of [chanposneg_link_ssque]

(* ****** ****** *)
//
extern
fun
queue_nil{a:vt0p}(): channeg(ssque(a, 0)) = "mac#%"
//
extern
fun
queue_free_nil{a:vt0p}(channeg(ssque(a, 0))): void = "mac#%"
//
extern
fun
queue_deq
  {a:vt0p}{n:pos}
  (que: !channeg(ssque(a,n)) >> channeg(ssque(a,n-1))): (a) = "mac#%"
//
extern
fun
queue_enq
  {a:vt0p}{n:nat}
  (que: !channeg(ssque(a,n)) >> channeg(ssque(a,n+1)), x0: a): void = "mac#%"
//
(* ****** ****** *)

implement
queue_nil
  {a}((*void*)) = let
//
fun
fserv
(
  chp: chanpos(ssque(a,0))
) : void = let
//
val opt = chanpos_ssque(chp)
//
in
//
case+ opt of
| chanpos_ssque_nil() =>
    chanpos_nil_wait (chp)
| chanpos_ssque_enq() => let
    val
    x_fst = chanpos_recv{a}(chp)
  in
    fserv2(x_fst, queue_nil(), chp)
  end // end of [chanpos_ssque_enq]
//
end // end of [fserv]
//
and
fserv2
{n:nat}
(
  x: a
, chn: channeg(ssque(a,n))
, chp: chanpos(ssque(a,n+1))
) : void = let
//
val opt = chanpos_ssque(chp)
//
in
//
case+ opt of
| chanpos_ssque_deq() => let
    val () = chanpos_send{a}(chp, x)
  in
    chanposneg_link (chp, chn)
  end // end of [chanpos_ssque_deq]
| chanpos_ssque_enq() => let
    val y = chanpos_recv{a}(chp)
    val () = channeg_ssque_enq (chn)
    val () = channeg_recv{a}(chn, y)
  in
    fserv2 (x, chn, chp)
  end // end of [chanpos_ssque_enq]
//
end // end of [fserv2]
//
in
  channeg_create(llam(chp) => fserv(chp))
end // end of [queue_nil]

(* ****** ****** *)

implement
queue_free_nil
  {a}(chn) = () where
{
//
val () = channeg_ssque_nil(chn)
val () = channeg_nil_close(chn)
//
} (* end of [queue_free_nil] *)

(* ****** ****** *)

implement
queue_deq
  {a}(chn) =
(
  channeg_ssque_deq(chn); channeg_send{a}(chn)
) (* end of [queue_deq] *)

(* ****** ****** *)

implement
queue_enq
  {a}(chn, x0) =
(
  channeg_ssque_enq(chn); channeg_recv{a}(chn, x0)
) (* end of [queue_enq] *)

(* ****** ****** *)

extern 
fun
main0_erl
(
// argumentless
) : void = "mac#"
//
implement
main0_erl((*void*)) =
{
//
#define N 100
//
val Q0 = queue_nil{int}()
//
val () = queue_enq (Q0, 0)
val () = queue_enq (Q0, 1)
val () = queue_enq (Q0, 2)
//
val x0 = queue_deq (Q0)
val () = println! ("x0(0) = ", x0)
val x1 = queue_deq (Q0)
val () = println! ("x1(1) = ", x1)
//
val () = queue_enq (Q0, 3)
val () = queue_enq (Q0, 4)
//
val x2 = queue_deq (Q0)
val () = println! ("x2(2) = ", x2)
val x3 = queue_deq (Q0)
val () = println! ("x3(3) = ", x3)
//
val () = queue_enq (Q0, 5)
val () = queue_enq (Q0, 6)
val () = queue_enq (Q0, 7)
//
val x4 = queue_deq (Q0)
val () = println! ("x4(4) = ", x4)
val x5 = queue_deq (Q0)
val () = println! ("x5(5) = ", x5)
val x6 = queue_deq (Q0)
val () = println! ("x7(6) = ", x6)
//
val () = queue_enq (Q0, 8)
//
val x7 = queue_deq (Q0)
val () = println! ("x7(7) = ", x7)
val x8 = queue_deq (Q0)
val () = println! ("x8(8) = ", x8)
//
val ((*freed*)) = queue_free_nil{int}(Q0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [queue.dats] *)
