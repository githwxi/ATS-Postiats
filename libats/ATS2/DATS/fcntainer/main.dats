(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2017 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: December, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

typedef N0 = intGte(0)

(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
#staload
"libats/ML/SATS/atspre.sats"
#staload
"libats/ATS2/SATS/fcntainer.sats"
//
(* ****** ****** *)

implement
{xs}{x0}
forall(xs) =
  loop(xs) where
{
//
val xs =
streamize_vt<xs><x0>(xs)
//
fun
loop
(xs: stream_vt(x0)): bool =
(
case+ !xs of
| ~stream_vt_nil() => true
| ~stream_vt_cons(x0, xs) =>
  (
    if
    forall$test<x0>(x0)
    then loop(xs) else (~xs; false)
  )
)
//
} (* end of [forall] *)

(* ****** ****** *)

implement
{xs}{x0}
iforall(xs) = let
//
var i0: Nat = 0
val p0 = addr@(i0)
//
implement
forall$test<x0>(x0) =
iforall$test<x0>(i0, x0) where
{
val i0 = $UN.ptr0_get<intGte(0)>(p0)
val () = $UN.ptr0_set<intGte(0)>(p0, i0+1)
}
//
in
  forall<xs><x0>(xs)
end // end of [iforall]

implement
{xs}{x0}
iforall_cloref
  (xs, ftest) = let
//
implement
iforall$test<x0>
  (i0, x0) = ftest(i0, x0)
//
in
  $effmask_all(iforall<xs><x0>(xs))
end // end of [iforall_cloref]

(* ****** ****** *)

implement
{xs}{x0}
exists(xs) = let
//
implement
forall$test<x0>(x0) =
not(exists$test<x0>(x0))
//
in
//
  not(forall<xs><x0>(xs))
//
end // end of [exists]

(* ****** ****** *)

implement
{xs}{x0}
rexists(xs) = let
//
implement
rforall$test<x0>(x0) =
not(rexists$test<x0>(x0))
//
in
//
  not(rforall<xs><x0>(xs))
//
end // end of [rexists]

(* ****** ****** *)

implement
{xs}{x0}
foreach(xs) = let
//
implement
forall$test<x0>(x0) =
let
val () =
foreach$work<x0>(x0) in true
end // end of [forall$test]
//
in
  ignoret(forall<xs><x0>(xs))
end // end of [foreach]

implement
{xs}{x0}
foreach_cloref
  (xs, fwork) = let
//
implement
foreach$work<x0>
  (x0) = fwork(x0)
//
in
  $effmask_all(foreach<xs><x0>(xs))
end // end of [foreach_cloref]

(* ****** ****** *)

implement
{xs}{x0}
iforeach(xs) = let
//
var i0: N0 = 0
val p0 = addr@(i0)
//
implement
foreach$work<x0>(x0) =
iforeach$work<x0>(i0, x0) where
{
val i0 = $UN.ptr0_get<intGte(0)>(p0)
val () = $UN.ptr0_set<intGte(0)>(p0, i0+1)
}
//
in
  foreach<xs><x0>(xs)
end // end of [iforeach]

implement
{xs}{x0}
iforeach_cloref
  (xs, fwork) = let
//
implement
iforeach$work<x0>
  (i0, x0) = fwork(i0, x0)
//
in
  $effmask_all(iforeach<xs><x0>(xs))
end // end of [iforeach_cloref]

(* ****** ****** *)

implement
{xs}{x0}
rforeach(xs) = let
//
implement
rforall$test<x0>(x0) =
let
val () =
rforeach$work<x0>(x0) in true
end // end of [rforall$test]
//
in
  ignoret(rforall<xs><x0>(xs))
end // end of [rforeach]

implement
{xs}{x0}
rforeach_cloref
  (xs, fwork) = let
//
implement
rforeach$work<x0>(x0) = fwork(x0)
//
in
  $effmask_all(rforeach<xs><x0>(xs))
end // end of [rforeach_cloref]

(* ****** ****** *)

implement
{xs}{r0}{x0}
foldleft
  (xs, ini) = let
//
var rr: r0 = ini
val pr = addr@(rr)
//
implement
foreach$work<x0>(x0) =
{
  val rr =
  $UN.ptr0_get<r0>(pr)
  val rr =
  foldleft$fopr<r0><x0>(rr, x0)
  val ((*void*)) =
  $UN.ptr0_set<r0>(pr, rr)
} // end of [foreach$work]
//
in
  let val () = foreach<xs><x0>(xs) in rr end
end // end of [foldleft]

implement
{xs}{r0}{x0}
foldleft_cloref
  (xs, ini, fopr) = let
//
implement
foldleft$fopr<r0><x0>
  (r0, x0) = fopr(r0, x0)
//
in
  $effmask_all(foldleft<xs><r0><x0>(xs, ini))
end // end of [foldleft_cloref]

(* ****** ****** *)

implement
{xs}{r0}{x0}
ifoldleft
  (xs, ini) = let
//
var ii: N0 = 0
var rr: r0 = ini
val pi = addr@(ii)
val pr = addr@(rr)
//
implement
foreach$work<x0>(x0) =
{
//
  val i0 =
  $UN.ptr0_get<N0>(pi)
  val r0 =
  $UN.ptr0_get<r0>(pr)
//
  val r0 =
  ifoldleft$fopr<r0><x0>(r0, i0, x0)
//
  val i0 = i0 + 1
  val ((*void*)) =
  $UN.ptr0_set<N0>(pi, i0)
  val ((*void*)) =
  $UN.ptr0_set<r0>(pr, r0)
//
} // end of [foreach$work]
//
in
  let val () = foreach<xs><x0>(xs) in rr end
end // end of [foldleft]

implement
{xs}{r0}{x0}
ifoldleft_cloref
  (xs, ini, fopr) = let
//
implement
ifoldleft$fopr<r0><x0>
  (r0, i0, x0) = fopr(r0, i0, x0)
//
in
//
$effmask_all(ifoldleft<xs><r0><x0>(xs, ini))
//
end // end of [ifoldleft_cloref]

(* ****** ****** *)

implement
{xs}{x0}
listize(xs) = let
//
vtypedef
res = List0_vt(x0)
//
var r0: res
var r1: ptr = addr@r0
//
val pp = addr@r1
//
implement
foreach$work<x0>(x0) =
{
//
  val nx0 =
  list_vt_cons{x0}{0}(x0, _)
  val+
  list_vt_cons(x1, nx1) = nx0
//
  val pr =
  $UN.ptr0_get<ptr>(pp)
  val () = 
  $UN.ptr0_set<ptr>(pp, addr@nx1)
//
  val xs =
  $UN.castvwtp0{res}
    ((view@x1, view@nx1 | nx0))
  // end of [castvwtp0]
  val () = $UN.ptr0_set<res>(pr, xs)
//
} (* end of [foreach$work] *)
//
val () =
(r0 := list_vt_nil())
//
in
//
r0 where
{
  val () =
  $effmask_all
  (foreach<xs><x0>(xs))
  val pr =
  $UN.ptr0_get<ptr>(pp)
  val () =
  $UN.ptr0_set<res>
    (pr, $UN.castvwtp0{res}(list_vt_nil()))
  // end of [val]
} (* end of [where] *)
end // end of [listize]

(* ****** ****** *)

implement
{xs}{x0}
rlistize(xs) = let
//
vtypedef
res = List0_vt(x0)
//
var r0: res
val pr: ptr = addr@r0
//
implement
foreach$work<x0>(x0) =
{
  val xs =
  $UN.ptr0_get<res>(pr)
  val () =
  $UN.ptr0_set<res>
    (pr, list_vt_cons(x0, xs))
  // end of [val]
}
//
val () = r0 := list_vt_nil()
//
in
$effmask_all
(
  let val () =
    foreach<xs><x0>(xs) in r0
  end // end of [let]
)
end // end of [rlistize]

(* ****** ****** *)
//
implement
{xs}{x0}
streamize(xs) =
$effmask_all
(
stream_vt2t(streamize_vt<xs><x0>(xs))
) (* end of [streamize] *)
//
(* ****** ****** *)

implement
{xs}
{x0,y0}
map_forall
  (xs, f0) =
  loop(xs) where
{
//
val xs =
streamize_vt<xs><x0>(xs)
//
fun
loop
(xs: stream_vt(x0)): bool =
(
case+ !xs of
| ~stream_vt_nil() => true
| ~stream_vt_cons(x0, xs) =>
  (
    if
    map_forall$test<y0>(f0(x0))
    then loop(xs) else (~xs; false)
  )
)
//
} (* end of [map_forall] *)

(* ****** ****** *)

implement
{xs,ys}
{x0,y0}
zip_forall
  (xs, ys) = let
//
fun
loop
(
xs: stream_vt(x0)
,
ys: stream_vt(y0)
) : bool =
(
case+ !xs of
| ~stream_vt_nil() =>
  (
    let val () = ~ys in true end
  )
| ~stream_vt_cons(x0, xs) =>
  (
    case+ !ys of
    | ~stream_vt_nil() =>
      (
        let val () = ~xs in true end
      )
    | ~stream_vt_cons(y0, ys) =>
      (
        if
        zip_forall$test<x0,y0>(x0, y0)
        then loop(xs, ys) else (~xs; ~ys; false)
      )
  )
) (* end of [loop] *)
//
in
//
loop
(streamize_vt<xs><x0>(xs), streamize_vt<ys><y0>(ys))
//
end // end of [zip_forall]

(* ****** ****** *)

implement
( xs:t@ype
, ys:t@ype
, x0:t@ype
, y0:t@ype)
forall<zip(xs, ys)><(x0,y0)>
  (ZIP(xs, ys)) = let
//
implement
zip_forall$test<x0,y0>
  (x0, y0) =
  forall$test<(x0,y0)>((x0, y0))
//
in
  zip_forall<xs,ys><x0,y0>(xs, ys)
end // end of [forall<zip>]

(* ****** ****** *)

implement
{xs,ys}
{x0,y0}
zip_streamize_vt
  (xs, ys) = let
//
typedef
xy0 = (x0, y0)
//
fun
auxmain
(
xs: stream_vt(x0)
,
ys: stream_vt(y0)
) : stream_vt(xy0) = $ldelay
(
//
case+ !xs of
| ~stream_vt_nil
    () =>
    (~ys; stream_vt_nil())
| ~stream_vt_cons
    (x0, xs) =>
  (
    case+ !ys of
    | ~stream_vt_nil
        () =>
        (~xs; stream_vt_nil())
    | ~stream_vt_cons
        (y0, ys) => let
        val xy0 = (x0, y0)
      in
        stream_vt_cons(xy0, auxmain(xs, ys))
      end // end of [stream_vt_cons]
  ) (* end of [stream_vt_cons] *)
, (lazy_vt_free(xs); lazy_vt_free(ys))
//
) (* end of [auxmain] *)
//
in
//
$effmask_all
( auxmain
  (streamize_vt<xs><x0>(xs), streamize_vt<ys><y0>(ys))
) // $effmask_all
//
end // end of [zip_streamize_vt]

(* ****** ****** *)
//
implement
( xs:t@ype
, ys:t@ype
, x0:t@ype
, y0:t@ype)
streamize_vt<zip(xs, ys)><(x0,y0)>
  (ZIP(xs, ys)) =
(
  zip_streamize_vt<xs,ys><x0,y0>(xs, ys)
)
//
(* ****** ****** *)

implement
{xs,ys}
{x0,y0}
cross_forall
  (xs, ys) = let
//
fun
loop1
(
  x0: x0
, ys: !List0_vt(y0)
) : bool =
(
case+ ys of
| list_vt_nil() => true
| list_vt_cons(y0, ys) =>
  if
  cross_forall$test<x0,y0>
    (x0, y0)
  then loop1(x0, ys) else false
)
//
fun
loop2
(
  xs: stream_vt(x0)
, ys: (List0_vt(y0))
) : bool =
(
case+ !xs of
| ~stream_vt_nil() =>
  (
    list_vt_free(ys); true
  )
| ~stream_vt_cons(x0, xs) =>
  (
    if
    loop1(x0, ys)
    then loop2(xs, ys)
    else
    (
      ~(xs); list_vt_free(ys); false
    )
  ) (* end of [stream_vt_cons] *)
)
//
in
//
loop2
(streamize_vt<xs><x0>(xs), listize<ys><y0>(ys))
//
end // end of [cross_forall]

(* ****** ****** *)

implement
( xs:t@ype
, ys:t@ype
, x0:t@ype
, y0:t@ype)
forall<cross(xs, ys)><(x0,y0)>
  (CROSS(xs, ys)) = let
//
implement
cross_forall$test<x0,y0>
  (x0, y0) =
  forall$test<(x0,y0)>((x0, y0))
//
in
  cross_forall<xs,ys><x0,y0>(xs, ys)
end // end of [forall<cross>]

(* ****** ****** *)

implement
{xs,ys}
{x0,y0}
cross_streamize_vt
  (xs, ys) = let
//
typedef
xy0 = (x0, y0)
//
fun
concat
(
ps: List_vt(xy0)
,
qs: stream_vt(xy0)
) : stream_vt(xy0) = $ldelay
(
(
case+ ps of
| ~list_vt_nil() => !(qs)
| ~list_vt_cons(p, ps) =>
   stream_vt_cons(p, concat(ps, qs))
)
, (list_vt_free(ps); lazy_vt_free(qs))
)
//
fun
auxelt
( x0: x0
, ys: !List0_vt(y0)): List0_vt(xy0) =
(
  list_vt_map_cloptr<y0><xy0>(ys, lam(y) => (x0, y))
)
//
fun
auxlst
(
xs:
stream_vt(x0)
,
ys: List0_vt(y0)
) : stream_vt(xy0) = $ldelay
(
(
case+ !xs of
| ~stream_vt_nil() =>
   stream_vt_nil() where
  {
    val () = list_vt_free(ys)
  } (* end of [stream_vt_nil] *)
| ~stream_vt_cons(x0, xs) =>
   !(concat(xys0, xys1)) where
  {
    val xys0 = auxelt(x0, ys)
    val xys1 = auxlst(xs, ys)
  } (* end of [stream_vt_cons] *)
)
, (lazy_vt_free(xs); list_vt_free<y0>(ys))
)
//
in
//
$effmask_all
(auxlst(streamize_vt<xs><x0>(xs), listize<ys><y0>(ys)))
//
end // end of [cross_streamize_vt]

(* ****** ****** *)
//
implement
( xs:t@ype
, ys:t@ype
, x0:t@ype
, y0:t@ype)
streamize_vt<cross(xs, ys)><(x0,y0)>
  (CROSS(xs, ys)) =
(
  cross_streamize_vt<xs,ys><x0,y0>(xs, ys)
)
//
(* ****** ****** *)

(* end of [fcntainer_main.dats] *)
