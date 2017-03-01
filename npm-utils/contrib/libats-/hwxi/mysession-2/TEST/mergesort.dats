(*
** Mergesort channels
*)

(* ****** ****** *)

%{^
//
#include <pthread.h>
//
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../SATS/basis.sats"
//
staload "./../SATS/list.sats"
//
(* ****** ****** *)

staload
_ = "libats/DATS/deqarray.dats"

(* ****** ****** *)
//
staload
_ = "libats/DATS/athread.dats"
staload
_ = "libats/DATS/athread_posix.dats"
//
(* ****** ****** *)
//
staload "./../DATS/basis_uchan.dats"
staload "./../DATS/basis_chan0.dats"
//
staload "./../DATS/basis_ssntyp.dats"
//
(* ****** ****** *)

staload _(*anon*) = "./../DATS/list.dats"

(* ****** ****** *)
//
extern
fun
{a:t@ype}
sslist_take
(
  !channeg(sslist(a)) >> _, n: intGte(0)
) : List0_vt(a)
//
implement
{a}(*tmp*)
sslist_take(chn, n) = let
//
fun
loop
(
  chn: !channeg(sslist(a)) >> _, n: int, res: List0_vt(a)
) : List0_vt(a) =
(
//
if
n > 0
then let
//
  val-
  channeg_list_cons
  ((*void*)) = channeg_list(chn)
//
  val x0 = channeg_send_val(chn) 
//
in
  loop (chn, n-1, list_vt_cons(x0, res))
end // end of [then]
else res // end of [else]
//
) (* end of [loop] *)
//
in
  list_vt_reverse(loop(chn, n, list_vt_nil((*void*))))
end // end of [sslist_take]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
sslist_split
(
  n: intGte(2), channeg(sslist(a))
) : (channeg(chsnd(int)::sslist(a)),
     channeg(chsnd(int)::sslist(a)))
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
{a}(*tmp*)
sslist_split
  (n, chn) = let
//
val n1 = half(n)
//
var chn = chn
val xs1 = sslist_take(chn, n1)
val chn = chn
//
val chn1 =
channeg_create_exn
(
  llam (chp) => (chanpos_send(chp, n1); chanposneg_link(chp, list2sslist_vt(xs1)))
) (* end of [val] *)
//
val chn2 =
channeg_create_exn(llam (chp) => (chanpos_send(chp, n1); chanposneg_link(chp, chn)))
//
in
  (chn1, chn2)
end // end of [sslist_split]

(* ****** ****** *)

implement
{a}(*tmp*)
sslist_merge
  (chn1, chn2) = let
//
overload <= with glte_val_val
//
fnx
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
    val x1 =
      channeg_send_val(chn1)
    // end of [val]
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
    val () = chanpos_send(chp, x1)
  in
    chanposneg_link (chp, chn1)
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val x2 = channeg_send_val(chn2)
  in
    if x1 <= x2
      then let
        val () =
          chanpos_send(chp, x1)
        // end of [val]
      in
        fserv2 (chp, chn1, x2, chn2)
      end // end of [then]
      else let
        val () =
          chanpos_send(chp, x2)
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
    val () = chanpos_send(chp, x2)
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_list_nil]
| channeg_list_cons() => let
    val x1 = channeg_send_val(chn1)
  in
    if x1 <= x2
      then let
        val () =
          chanpos_send(chp, x1)
        // end of [val]
      in
        fserv2 (chp, chn1, x2, chn2)
      end // end of [then]
      else let
        val () =
          chanpos_send(chp, x2)
        // end of [val]
      in
        fserv1 (chp, x1, chn1, chn2)
      end // end of [else]
  end // end of [channeg_list_cons]
end // end of [fserv2]
//
in
  channeg_create_exn(llam (chp) => fserv(chp, chn1, chn2))
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
(
chn1
,
chn2
) = sslist_split(n, chn)
//
val n1 = channeg_send_val(chn1)
val chn1 = sslist_msort(n1, chn1)
//
val n2 = channeg_send_val(chn2)
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

(*
implement
channel_cap<> () = 1024
*)

(* ****** ****** *)

implement
main0 () =
{
val xs =
$list{int}(3, 9, 8, 2, 5, 7, 4, 6, 0, 1)
//
val () = fprintln! (stdout_ref, "xs =\n", xs)
//
val xs = mergesort<int> (xs)
//
val () = fprintln! (stdout_ref, "xs(sorted) =\n", xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mergesort.dats] *)
