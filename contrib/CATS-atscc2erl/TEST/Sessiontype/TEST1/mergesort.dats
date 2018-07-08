(*
** Mergesort
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "mergesort_"
#define
ATS_STATIC_PREFIX "_mergesort_"

(* ****** ****** *)

%{^
%%
-module(mergesort_dats).
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
staload
"./../SATS/basis.sats"
//
staload "./../SATS/list.sats"
//
(* ****** ****** *)
//
extern
fun
sslist_take
{a:t@ype}
(
  !channeg(sslist(a)) >> _, n: intGte(0)
) : List0(a)
//
implement
sslist_take{a}(chn, n) = let
//
fun
loop
(
  chn: !channeg(sslist(a)) >> _, n: int, res: List0(a)
) : List0(a) =
(
//
if
n > 0
then let
  val-
  channeg_list_cons
  (
  ) = channeg_list(chn)
  val x0 = channel_recv(chn) 
in
  loop (chn, n-1, list_cons(x0, res))
end // end of [then]
else res // end of [else]
//
) (* end of [loop] *)
//
in
  list_reverse(loop(chn, n, list_nil((*void*))))
end // end of [sslist_take]

(* ****** ****** *)
//
extern
fun
sslist_split
{a:t@ype}
(
  n: intGte(2), channeg(sslist(a))
) :
$tup
( channeg(chsnd(int)::sslist(a))
, channeg(chsnd(int)::sslist(a))
) (* end of [sslist_split] *)
//
extern
fun
{a:t@ype}
sslist_merge
(
  channeg(sslist(a)), channeg(sslist(a))
) : channeg(sslist(a)) // end-of-fun
//
extern
fun{a:t@ype}
sslist_msort (n: int, channeg(sslist(a))): channeg(sslist(a))
//
(* ****** ****** *)

implement
sslist_split
  {a}(n, chn) = let
//
val n1 = half(n)
//
var chn = chn
val xs1 = sslist_take(chn, n1)
val chn = chn
//
val chn1 =
channeg_create
(
  llam (chp) => (channel_send(chp, n1); chanposneg_link(chp, list2sslist(xs1)))
) (* end of [val] *)
//
val chn2 =
channeg_create(llam (chp) => (channel_send(chp, n1); chanposneg_link(chp, chn)))
//
in
  $tup(chn1, chn2)
end // end of [sslist_split]

(* ****** ****** *)

extern
fun
{a:t@ype}
gcompare_val_val (x: a, y: a): int
//
implement
gcompare_val_val<int> (x, y) = compare(x, y)
implement
gcompare_val_val<double> (x, y) = compare(x, y)
//
(* ****** ****** *)

implement
{a}(*tmp*)
sslist_merge
  (chn1, chn2) = let
//
fun
fserv
(
  chp: chanpos(sslist(a))
, chn1: channeg(sslist(a))
, chn2: channeg(sslist(a))
) : void = let
//
val opt1 = channeg_list(chn1)
//
in
//
case+ opt1 of
| channeg_list_nil() => let
    val () =
      channeg_nil_close(chn1)
    // end of [val]
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val x1 = channel_recv(chn1)
  in
    fserv1(chp, x1, chn1, chn2)
  end // end of [channeg_list_cons]
//
end // end of [fserv]
//
and
fserv1
(
  chp: chanpos(sslist(a))
, x1: a
, chn1: channeg(sslist(a))
, chn2: channeg(sslist(a))
) : void = let
//
val () =
  chanpos_list_cons (chp)
//
val opt2 = channeg_list(chn2)
//
in
//
case+ opt2 of
| channeg_list_nil() => let
    val () =
      channeg_nil_close(chn2)
    // end of [val]
    val () = channel_send(chp, x1)
  in
    chanposneg_link (chp, chn1)
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val x2 = channel_recv(chn2)
    val sgn =
      gcompare_val_val<a> (x1, x2)
    // end of [val]
  in
    if sgn <= 0
      then let
        val () =
          channel_send(chp, x1)
        // end of [val]
      in
        fserv2 (chp, chn1, x2, chn2)
      end // end of [then]
      else let
        val () =
          channel_send(chp, x2)
        // end of [val]
      in
        fserv1 (chp, x1, chn1, chn2)
      end // end of [else]
  end // end of [channeg_list_cons]
//
end // end of [fserv1]
//
and
fserv2
(
  chp: chanpos(sslist(a))
, chn1: channeg(sslist(a))
, x2: a
, chn2: channeg(sslist(a))
) : void = let
//
val () =
  chanpos_list_cons (chp)
//
val opt1 = channeg_list(chn1)
//
in
//
case+ opt1 of
| channeg_list_nil() => let
    val () =
      channeg_nil_close(chn1)
    // end of [val]
    val () = channel_send(chp, x2)
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val x1 = channel_recv(chn1)
    val sgn =
      gcompare_val_val<a> (x1, x2)
    // end of [val]
  in
    if sgn <= 0
      then let
        val () =
          channel_send(chp, x1)
        // end of [val]
      in
        fserv2 (chp, chn1, x2, chn2)
      end // end of [then]
      else let
        val () =
          channel_send(chp, x2)
        // end of [val]
      in
        fserv1 (chp, x1, chn1, chn2)
      end // end of [else]
  end // end of [channeg_list_cons]
end // end of [fserv2]
//
in
  channeg_create(llam (chp) => fserv(chp, chn1, chn2))
end // end of [sslist_merge]

(* ****** ****** *)

implement
{a}(*tmp*)
sslist_msort
  (n, chn) = let
//
val n = g1ofg0(n)
//
in
if
n <= 1
then chn
else let
//
val
$tup
(
chn1
,
chn2
) = sslist_split(n, chn)
//
val n1 = channel_recv(chn1)
val chn1 = sslist_msort(n1, chn1)
//
val n2 = channel_recv(chn2)
val chn2 = sslist_msort(n2, chn2)
//
in
  sslist_merge(chn1, chn2)
end // end of [else]
//
end // end of [sslist_msort]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
mergesort(xs: List(a)): List(a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
mergesort(xs) = let
//
val n = length(xs)
val chn = list2sslist(xs)
val chn = sslist_msort(n, chn)
//
in
  sslist2list(chn)
end // end of [mergesort]

(* ****** ****** *)

implement
{a}(*tmp*)
print_list(xs) = let
//
val sep = ", "
//
fun
loop
(
  i: int, xs: List(a)
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () =
    if i > 0 then print(sep)
    val () = print_val<a> (x)
  in
    loop (i+1, xs)
  end // end of [list_cons]
)
//
in
  loop (0, xs)
end // end of [print_list]

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
#define nil list_nil
#define :: list_cons
#define cons list_cons
//
typedef T = int
//
val xs =
(
  3::9::8::2::5::7::4::6::0::1::nil{T}()
)
//
val () =
print! ("xs(bef) =\n")
val () = print_list<T> (xs)
val () = print_newline()
//
val xs = mergesort<T> (xs)
//
val () =
print! ("xs(aft) =\n")
val () = print_list<T> (xs)
val () = print_newline()
//
typedef T = double
//
val xs =
(
  3.0::9.0::8.0::2.0::5.0::7.0::4.0::6.0::0.0::1.0::nil{T}()
)
//
val () =
print! ("xs(bef) =\n")
val () = print_list<T> (xs)
val () = print_newline()
//
val xs = mergesort<T> (xs)
//
val () =
print! ("xs(aft) =\n")
val () = print_list<T> (xs)
val () = print_newline()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mergesort.dats] *)
