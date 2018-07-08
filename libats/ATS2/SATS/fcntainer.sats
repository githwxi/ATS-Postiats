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

(* Author: Hongwei Xi *)
(* Start time: December, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)

typedef
cfun
(
  x0:t@ype
, y0:t@ype
) = (x0) -<cloref1> y0

(* ****** ****** *)
//
datatype
intrange =
INTRANGE of (int, int)
//
(* ****** ****** *)
//
fun{}
intrange_make_int(int): intrange
fun{}
intrange_make_int2(int, int): intrange
//
overload intrange with intrange_make_int
overload intrange with intrange_make_int2
//
(* ****** ****** *)

datatype
map(
  xs:t@ype
, x0:t@ype
, y0: t@ype
) = MAP of (xs, cfun(x0, y0))

(* ****** ****** *)

datatype
zip(xs:t@ype, ys:t@ype) = ZIP of (xs, ys)

(* ****** ****** *)

datatype
cross(xs:t@ype, ys:t@ype) = CROSS of (xs, ys)

(* ****** ****** *)

(*
**
** HX-2012-02:
** The basic idea is to implement "everything" else in
** terms of [forall] so that they become available for
** a container-type whenever [forall] is made available
** for that type.
**
** HX-2018-01:
** It seems that [forall] is not enough and [streamize]
** is needed after all.
**
*)

(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
forall(xs: xs): bool
fun
{x0:t0p}
forall$test(x0: x0): bool
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
forall_fun{fe:eff}
( xs: xs
, fopr: (x0) -<fun,fe> bool):<fe> bool
// end of [forall_fun]
//
fun
{xs:t0p}
{x0:t0p}
forall_clo{fe:eff}
( xs: xs
, fopr: &(x0) -<clo,fe> bool):<fe> bool
// end of [forall_clo]
fun
{xs:t0p}
{x0:t0p}
forall_vclo{v:view}{fe:eff}
( pf: !v
| xs: xs
, fopr: &(!v | x0) -<clo,fe> bool):<fe> bool
// end of [forall_vclo]
//
fun
{xs:t0p}
{x0:t0p}
forall_cloptr{fe:eff}
( xs: xs
, fopr: (x0) -<cloptr,fe> bool):<fe> bool
fun
{xs:t0p}
{x0:t0p}
forall_vcloptr{v:view}{fe:eff}
( pf: !v
| xs: xs
, fopr: (!v | x0) -<cloptr,fe> bool):<fe> bool
// end of [forall_vcloptr]
//
fun
{xs:t0p}
{x0:t0p}
forall_cloref{fe:eff}
( xs: xs
, fopr: (x0) -<cloref,fe> bool):<fe> bool
// end of [forall_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
rforall(xs: xs): bool
fun
{x0:t0p}
rforall$test(x0: x0): bool
//
fun
{xs:t0p}
{x0:t0p}
rforall_cloref{fe:eff}
( xs: xs
, fopr: (x0) -<cloref,fe> bool):<fe> bool
// end of [rforall_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
iforall(xs: xs): bool
fun
{x0:t0p}
iforall$test(i: Nat, x0: x0): bool
//
fun
{xs:t0p}
{x0:t0p}
iforall_cloref{fe:eff}
( xs: xs
, fopr: (int, x0) -<cloref,fe> bool):<fe> bool
// end of [iforall_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
exists(xs: xs): bool
fun
{x0:t0p}
exists$test(x0: x0): bool
//
fun
{xs:t0p}
{x0:t0p}
rexists(xs: xs): bool
fun
{x0:t0p}
rexists$test(x0: x0): bool
//
fun
{xs:t0p}
{x0:t0p}
rexists_cloref{fe:eff}
( xs: xs
, fopr: (x0) -<cloref,fe> bool):<fe> bool
// end of [rexists_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
foreach(xs: xs): void
fun
{x0:t0p}
foreach$work(x0: x0): void
//
fun
{xs:t0p}
{x0:t0p}
foreach_cloref{fe:eff}
( xs: xs
, fwork: (x0) -<cloref,fe> void):<fe> void
// end of [foreach_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
rforeach(xs: xs): void
fun
{x0:t0p}
rforeach$work(x0: x0): void
//
fun
{xs:t0p}{x0:t0p}
rforeach_cloref{fe:eff}
( xs: xs
, fwork: (x0) -<cloref,fe> void):<fe> void
// end of [rforeach_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
iforeach(xs: xs): void
fun
{x0:t0p}
iforeach$work(i: Nat, x0: x0): void
//
fun
{xs:t0p}
{x0:t0p}
iforeach_cloref{fe:eff}
( xs: xs
, fwork: (Nat, x0) -<cloref,fe> void):<fe> void
// end of [foreach_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{r0:t0p}
{x0:t0p}
foldleft(xs: xs, ini: r0): r0
fun
{r0:t0p}
{x0:t0p}
foldleft$fopr(r0: r0, x0: x0): r0
//
fun
{xs:t0p}
{r0:t0p}
{x0:t0p}
foldleft_cloref{fe:eff}
( xs: xs
, ini: r0
, fopr: (r0, x0) -<cloref,fe> r0):<fe> r0
// end of [foldleft_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
{r0:t0p}
foldright(xs: xs, snk: r0): r0
fun
{x0:t0p}
{r0:t0p}
foldright$fopr(x0: x0, r0: r0): r0
fun
{xs:t0p}
{x0:t0p}
{r0:t0p}
foldright_cloref{fe:eff}
( xs: xs
, snk: r0
, fopr: (x0, r0) -<cloref,fe> r0):<fe> r0
// end of [foldright_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{r0:t0p}
{x0:t0p}
ifoldleft(xs: xs, ini: r0): r0
fun
{r0:t0p}
{x0:t0p}
ifoldleft$fopr(r0: r0, i: Nat, x0: x0): r0
//
fun
{xs:t0p}
{r0:t0p}
{x0:t0p}
ifoldleft_cloref{fe:eff}
( xs: xs
, ini: r0
, fopr: (r0, Nat, x0) -<cloref,fe> r0):<fe> r0
// end of [ifoldleft_cloref]
//
(* ****** ****** *)
//
fun
{r0:t0p}
{xs:t0p}
{x0:t0p}
ifoldright(xs: xs, snk: r0): r0
fun
{r0:t0p}
{x0:t0p}
ifoldright$fopr(r0: r0, i: Nat, x0: x0): r0
//
fun
{r0:t0p}
{xs:t0p}
{x0:t0p}
ifoldright_cloref{fe:eff}
( xs: xs
, snk: r0
, fopr: (r0, Nat, x0) -<cloref,fe> r0):<fe> r0
// end of [ifoldright_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}
{x0:t0p}
listize(xs: xs):<!wrt> List0_vt(x0)
//
fun
{xs:t0p}
{x0:t0p}
rlistize(xs: xs):<!wrt> List0_vt(x0)
//
(* ****** ****** *)

fun
{xs:t0p}
{x0:t0p}
{y0:t0p}
list_map(xs: xs):<!wrt> List0_vt(y0)
fun
{xs:t0p}
{x0:t0p}
{y0:t0p}
rlist_map(xs: xs):<!wrt> List0_vt(y0)

(* ****** ****** *)

fun
{xs:t0p}
{x0:t0p}
streamize(xs: xs):<> stream(x0)
fun
{xs:t0p}
{x0:t0p}
streamize_vt(xs: xs):<!wrt> stream_vt(x0)

(* ****** ****** *)
//
fun
{xs:t0p}
{x0
,y0:t0p}
map_forall
( xs: xs
, f0: cfun(x0, y0)): bool
fun
{y0:t0p}
map_forall$test(y0: y0): bool
//
(* ****** ****** *)
//
fun
{xs
,ys:t0p}
{x0
,y0:t0p}
zip_forall(xs: xs, ys: ys): bool
fun
{x0,y0:t0p}
zip_forall$test(x0: x0, y0: y0): bool
//
fun
{xs
,ys:t0p}
{x0
,y0:t0p}
zip_streamize_vt
(xs: xs, ys: ys):<!wrt> stream_vt(@(x0, y0))
//
(* ****** ****** *)
//
fun
{xs
,ys:t0p}
{x0
,y0:t0p}
cross_forall(xs: xs, ys: ys): bool
fun
{x0,y0:t0p}
cross_forall$test(x0: x0, y0: y0): bool
//
fun
{xs
,ys:t0p}
{x0
,y0:t0p}
cross_streamize_vt
(xs: xs, ys: ys):<!wrt> stream_vt(@(x0, y0))
//
(* ****** ****** *)

(* end of [fcntainer.sats] *)
