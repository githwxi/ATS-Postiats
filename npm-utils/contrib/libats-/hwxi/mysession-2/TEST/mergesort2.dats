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
staload "./../SATS/array.sats"
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

staload _(*anon*) = "./../DATS/array.dats"

(* ****** ****** *)
//
extern
fun
{a:t@ype}
mergesort
  {n:nat}(list(a, n)): list(a, n)
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

implement
{a}(*tmp*)
ssarray_merge
  (n1, chn1, n2, chn2) = let
//
overload <= with glte_val_val
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
  prval () = channeg_array_nil(chn1)
    val () = channeg_nil_close(chn1)
  in
    chanposneg_link (chp, chn2)
  end // end of [channeg_array_nil]
| false => let
  prval () = channeg_array_cons(chn1)
    val x1 = channeg_send_val(chn1)
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
prval () =
  chanpos_array_cons (chp)
//
  val opt2 = (n2 = 0)
//
in
//
case+ opt2 of
| true => let
  prval () = channeg_array_nil(chn2)
    val () = channeg_nil_close(chn2)
    val () = chanpos_send(chp, x1)
  in
    chanposneg_link (chp, chn1)
  end // end of [channeg_array_nil]
| false => let
  prval () = channeg_array_cons(chn2)
    val x2 = channeg_send_val(chn2)
  in
    ifcase
    | x1 <= x2 => let
        val () = chanpos_send(chp, x1)
      in
        fserv2 (chp, n1, chn1, x2, n2-1, chn2)
      end // end of [then]
    | _(*else*) => let
        val () = chanpos_send(chp, x2)
      in
        fserv1 (chp, x1, n1, chn1, n2-1, chn2)
      end // end of [else]
    // end of [ifcase]
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
  chanpos_array_cons(chp)
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
    val x1 = channeg_send_val(chn1)
  in
    if x1 <= x2
      then let
        val () = chanpos_send(chp, x1)
      in
        fserv2 (chp, n1-1, chn1, x2, n2, chn2)
      end // end of [then]
      else let
        val () = chanpos_send(chp, x2)
      in
        fserv1 (chp, x1, n1-1, chn1, n2, chn2)
      end // end of [else]
  end // end of [channeg_list_cons]
end // end of [fserv2]
//
in
  channeg_create_exn
    (llam (chp) => fserv(chp, n1, chn1, n2, chn2))
  // channeg_create_exn
end // end of [ssarray_merge]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
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

(* end of [mergesort2.dats] *)
