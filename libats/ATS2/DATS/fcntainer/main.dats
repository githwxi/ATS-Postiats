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
UN =
"prelude/SATS/unsafe.sats"
//
#staload
"libats/ATS2/SATS/fcntainer.sats"
//
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
iforeach$work(i0, x0) where
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
{r0}{xs}{x0}
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
{r0}{xs}{x0}
foldleft_cloref
  (xs, ini, fopr) = let
//
implement
foldleft$fopr<r0><x0>
  (r0, x0) = fopr(r0, x0)
//
in
  $effmask_all(foldleft<r0><xs><x0>(xs, ini))
end // end of [foldleft_cloref]

(* ****** ****** *)

implement
{r0}{xs}{x0}
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
{r0}{xs}{x0}
ifoldleft_cloref
  (xs, ini, fopr) = let
//
implement
ifoldleft$fopr<r0><x0>
  (r0, i0, x0) = fopr(r0, i0, x0)
//
in
//
$effmask_all(ifoldleft<r0><xs><x0>(xs, ini))
//
end // end of [ifoldleft_cloref]

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
        zip_forall$test(x0, y0)
        then loop(xs, ys) else (~xs; ~ys; false)
      )
  )
) (* end of [loop] *)
//
in
//
  loop(streamize_vt<xs><x0>(xs), streamize_vt<ys><y0>(ys))
//
end // end of [zip_forall]

(* ****** ****** *)

(* end of [fcntainer_main.dats] *)
