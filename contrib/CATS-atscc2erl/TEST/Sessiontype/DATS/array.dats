(*
** Session Array
*)

(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
#define
ATS_STATIC_PREFIX "_libats2erl_session_ssarray_"
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
#include
"{$LIBATSCC2ERL}/staloadall.hats"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/basis.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/array.sats" // session-typed
//
staload "./basis_chan2.dats" // un-session-typed
//
(* ****** ****** *)

implement
chanpos_arrsz
  {a}{n}(chp, n) = let
//
typedef
ss = chsnd(int)::ssarray(a,n)
prval() =
  $UN.castview2void{chanpos(ss)}(chp)
//
in
  chanpos_send{int}(chp, n)
end // end of [chanpos_arrsz]

(* ****** ****** *)

implement
channeg_arrsz
  {a}(chn) = asz where
{
//
prval
[n:int](_) = g1ofg0(0)
//
typedef
ss = chsnd(int)::ssarray(a,n)
prval() =
  $UN.castview2void{channeg(ss)}(chn)
//
val
asz = channeg_send{int}(chn)
//
val
[n:int]
asz = $UN.cast{intGte(0)}(asz)
//
prval() =
  $UN.castview2void{channeg(ssarray(a,n))}(chn)
//
} (* end of [channeg_arrsz] *)

(* ****** ****** *)
//
implement
ssarray2list
  {a}(chn, n) =
  list_vt2t(ssarray2list_vt(chn, n))
//
(* ****** ****** *)

implement
list2ssarray
  {a}(xs) = let
//
fun
fserv{n:int}
(
  chp: chanpos(ssarray(a, n)), xs: list(a, n)
) : void =
(
case+ xs of
| list_nil () => let
    prval() =
    chanpos_array_nil(chp)
  in
    chanpos_nil_wait (chp)
  end // end of [nil]
| list_cons (x, xs) => let
    prval() =
    chanpos_array_cons(chp)
    val () = chanpos_send{a}(chp, x)
  in
    fserv(chp, xs)
  end // end of [cons]
) (* end of [fserv] *)
//
in
  channeg_create(llam(chp) => fserv(chp, xs))
end // end of [list2ssarray]

(* ****** ****** *)

implement
list2ssarray_vt
  {a}(xs) = let
//
fun
fserv{n:int}
(
  chp: chanpos(ssarray(a, n)), xs: list_vt(a, n)
) : void =
(
case+ xs of
| ~nil_vt () => let
    prval() =
    chanpos_array_nil(chp)
  in
    chanpos_nil_wait (chp)
  end // end of [nil]
| ~cons_vt (x, xs) => let
    prval() =
    chanpos_array_cons(chp)
    val () = chanpos_send{a}(chp, x)
  in
    fserv(chp, xs)
  end // end of [cons]
) (* end of [fserv] *)
//
in
  channeg_create(llam(chp) => fserv(chp, xs))
end // end of [list2ssarray_vt]

(* ****** ****** *)

implement
ssarray2list_vt
  {a}{n}(chn, n) = xs where
{
//
prval
() = $UN.prop_assert{n >= 0}()
//
val xs =
channeg_array_takeout_list{a}(chn, n)
//
prval() = channeg_array_nil (chn)
val ((*closed*)) = channeg_nil_close (chn)
//
} (* end of [ssarray2list_vt] *)

(* ****** ****** *)

implement
channeg_array_takeout_list
  {a}{n}{i}(chn, i) = let
//
vtypedef
chan(n:int) = channeg(ssarray(a, n))
//
fun
revapp
{i,j:nat}
(
  xs: list_vt(a, i)
, ys: list_vt(a, j)
) : list_vt(a, i+j) =
(
case+ xs of
| ~nil_vt() => ys
| ~cons_vt(x, xs) =>
    revapp(xs, list_vt_cons{a}(x, ys))
  // end of [cons_vt]
) (* end of [revapp] *)
//
fun
loop
{n:int}
{i,j:nat | i <= n}
(
  chn:
  !chan(n) >> chan(n-i)
, i: int(i), res: list_vt(a, j)
) : list_vt(a, i+j) = (
//
if
i > 0
then let
//
prval() =
  channeg_array_cons(chn)
//
val x0 = channeg_send{a}(chn)
//
in
//
loop(chn, i-1, list_vt_cons{a}(x0, res))
//
end // end of [then]
else res // end of [else]
//
) (* end of [loop] *)
//
in
  revapp(loop(chn, i, list_vt_nil), list_vt_nil)
end // end of [channeg_array_takeout_list]

(* ****** ****** *)

(* end of [array.dats] *)
