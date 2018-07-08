(*
** Mergesort
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "mergesort2_"
#define
ATS_STATIC_PREFIX "_mergesort2_"

(* ****** ****** *)

%{^
%%
-module(mergesort2_dats).
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
staload "./../SATS/array.sats"
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
mergesort{n:nat}(list(a, n)): list(a, n)
//
(* ****** ****** *)

extern
fun
{a:t@ype}
ssarray_merge
  {n1,n2:nat}
(
  int(n1), channeg(ssarray(a, n1))
, int(n2), channeg(ssarray(a, n2))
) : channeg(ssarray(a, n1+n2))

(* ****** ****** *)
//
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
ssarray_merge
  (n1, chn1, n2, chn2) = let
//
fnx
fserv
  {n1,n2:nat}
(
  chp: chanpos(ssarray(a,n1+n2))
, n1: int(n1), chn1: channeg(ssarray(a,n1))
, n2: int(n2), chn2: channeg(ssarray(a,n2))
) : void = let
//
val opt1 = (n1 = 0)
//
in
//
case+ opt1 of
| true => let
    prval
    () = channeg_array_nil(chn1)
    val () = channeg_nil_close(chn1)
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_array_nil]
| false => let
    prval
    () = channeg_array_cons(chn1)
    val x1 = channeg_send{a}(chn1)
  in
    fserv1(chp, x1, n1-1, chn1, n2, chn2)
  end // end of [channeg_array_cons]
//
end // end of [fserv]
//
and
fserv1
  {n1,n2:nat}
(
  chp: chanpos(ssarray(a, n1+n2+1))
, x1: a
, n1: int(n1), chn1: channeg(ssarray(a, n1))
, n2: int(n2), chn2: channeg(ssarray(a, n2))
) : void = let
//
val opt2 = (n2 = 0)
//
prval() =
  chanpos_array_cons(chp)
//
in
//
case+ opt2 of
| true => let
    prval
    () = channeg_array_nil(chn2)
    val () = channeg_nil_close(chn2)
    val () = chanpos_send(chp, x1)
  in
    chanposneg_link (chp, chn1)
  end // end of [channeg_array_nil]
| false => let
    prval
    () = channeg_array_cons(chn2)
    val x2 = channeg_send{a}(chn2)
    val sgn = gcompare_val_val<a> (x1, x2)
  in
    if sgn <= 0
      then let
        val () =
          chanpos_send(chp, x1)
        // end of [val]
      in
        fserv2 (chp, n1, chn1, x2, n2-1, chn2)
      end // end of [then]
      else let
        val () =
          chanpos_send(chp, x2)
        // end of [val]
      in
        fserv1 (chp, x1, n1, chn1, n2-1, chn2)
      end // end of [else]
  end // end of [channeg_array_cons]
//
end // end of [fserv1]
//
and
fserv2
  {n1,n2:nat}
(
  chp: chanpos(ssarray(a,n1+n2+1))
, n1: int(n1), chn1: channeg(ssarray(a, n1))
, x2: a
, n2: int(n2), chn2: channeg(ssarray(a, n2))
) : void = let
//
prval () =
  chanpos_array_cons (chp)
//
val opt1 = (n1 = 0)
//
in
//
case+ opt1 of
| true => let
    prval
    () = channeg_array_nil(chn1)
    val () = channeg_nil_close(chn1)
    val () = chanpos_send(chp, x2)
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_list_nil]
| false => let
    prval
    () = channeg_array_cons(chn1)
    val x1 = channeg_send{a}(chn1)
    val sgn = gcompare_val_val<a> (x1, x2)
  in
    if sgn <= 0
      then let
        val () =
          chanpos_send(chp, x1)
        // end of [val]
      in
        fserv2 (chp, n1-1, chn1, x2, n2, chn2)
      end // end of [then]
      else let
        val () =
          chanpos_send(chp, x2)
        // end of [val]
      in
        fserv1 (chp, x1, n1-1, chn1, n2, chn2)
      end // end of [else]
  end // end of [channeg_list_cons]
end // end of [fserv2]
//
in
  channeg_create(llam(chp) => fserv(chp, n1, chn1, n2, chn2))
end // end of [ssarray_merge]

(* ****** ****** *)
//
extern
fun{a:t@ype}
ssarray_msort{n:nat}
  (int(n), channeg(ssarray(a, n))): channeg(ssarray(a, n))
//
(* ****** ****** *)

implement
{a}(*tmp*)
ssarray_msort
  (n, chn) = let
(*
val () =
println! ("ssarray_msort")
*)
in
//
if
n <= 1
then chn
else let
//
val n1 = half(n)
val n2 = n - n1
//
val xs =
channeg_array_takeout_list
  (chn, n1)
//
val chn2 = chn
val chn1 = list2ssarray_vt(xs)
//
val chn1 = ssarray_msort(n1, chn1)
val chn2 = ssarray_msort(n2, chn2)
//
in
  ssarray_merge(n1, chn1, n2, chn2)
end // end of [else]
//
end // end of [ssarray_msort]

(* ****** ****** *)

implement
{a}(*tmp*)
mergesort(xs) = let
//
val n = length(xs)
val chn = list2ssarray(xs)
val chn = ssarray_msort(n, chn)
//
in
  ssarray2list(chn, n)
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

(* end of [mergesort2.dats] *)
