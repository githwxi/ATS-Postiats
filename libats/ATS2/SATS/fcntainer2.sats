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

(*
** Source:
** $PATSHOME/prelude/SATS/CODEGEN/fcntainer.atxt
** Time of generation: Sat Dec 30 21:47:12 2017
*)

(* ****** ****** *)

(*
**
** HX-2012-02:
**
** The basic idea is to implement "everything" else in
** terms of [forall] so that they become available for
** a container-type whenever [forall] is made available
** for that type.
**
*)

(* ****** ****** *)
//
(*
sortdef
t0p = t@ype and vt0p = vt@ype
*)
//
(* ****** ****** *)

fun
{xs:t0p}{x:t0p}
forall(xs: xs): bool
fun
{x:t0p}
forall$test(x: x): bool

(* ****** ****** *)
//
fun{
xs:t0p}{x:t0p
} forall_fun{fe:eff}
( xs: xs
, fopr: (x) -<fun,fe> bool):<fe> bool
// end of [forall_fun]
//
fun{
xs:t0p}{x:t0p
} forall_clo {fe:eff}
( xs: xs
, fopr: &(x) -<clo,fe> bool):<fe> bool
// end of [forall_clo]
fun{
xs:t0p}{x:t0p
} forall_vclo
  {v:view}{fe:eff}
( pf: !v
| xs: xs
, fopr: &(!v | x) -<clo,fe> bool):<fe> bool
// end of [forall_vclo]
//
fun{
xs:t0p}{x:t0p
} forall_cloptr{fe:eff}
( xs: xs
, fopr: (x) -<cloptr,fe> bool):<fe> bool
fun{
xs:t0p}{x:t0p
} forall_vcloptr
  {v:view}{fe:eff}
( pf: !v
| xs: xs
, fopr: (!v | x) -<cloptr,fe> bool):<fe> bool
// end of [forall_vcloptr]
//
fun{
xs:t0p}{x:t0p
} forall_cloref{fe:eff}
  (xs: xs, fopr: (x) -<cloref,fe> bool):<fe> bool
// end of [forall_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}{x:t0p}
rforall(xs: xs): bool
fun
{x:t0p}
rforall$test(x: x): bool
//
fun{
xs:t0p}{x:t0p
} rforall_cloref{fe:eff}
  (xs: xs, fopr: (x) -<cloref,fe> bool):<fe> bool
// end of [rforall_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}{x:t0p}
foreach(xs: xs): void
fun
{x:t0p}
foreach$fwork(x: x): void
//
fun
{xs:t0p}{x:t0p}
foreach_cloref{fe:eff}
(xs: xs, fwork: (x) -<cloref,fe> void):<fe> void
// end of [foreach_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}{x:t0p}
iforeach(xs: xs): void
fun{x:t0p}
iforeach$fwork(i: Nat, x: x): void
//
fun
{xs:t0p}{x:t0p}
iforeach_cloref{fe:eff}
(xs: xs, fwork: (Nat, x) -<cloref,fe> void):<fe> void
// end of [foreach_cloref]
//
(* ****** ****** *)
//
fun
{xs:t0p}{x:t0p}
rforeach(xs: xs): void
fun
{x:t0p}
rforeach$fwork(x: x): void
//
fun
{xs:t0p}{x:t0p}
rforeach_cloref{fe:eff}
(xs: xs, fwork: (x) -<cloref,fe> void):<fe> void
// end of [rforeach_cloref]
//
(* ****** ****** *)
//
fun
{res:vt0p}
{xs:t0p}{x:t0p}
foldleft(xs: xs, ini: res): res
fun
{res:vt0p}{x:t0p}
foldleft$fopr(res: res, x: x): res
//
fun
{res:vt0p}
{xs:t0p}{x:t0p}
foldleft_cloref{fe:eff}
( xs: xs
, ini: res
, fopr: (res, x) -<cloref,fe> res):<fe> res
// end of [foldleft_cloref]
//
(* ****** ****** *)
//
fun
{res:vt0p}
{xs:t0p}{x:t0p}
ifoldleft(xs: xs, ini: res): res
fun
{res:vt0p}{x:t0p}
ifoldleft$fopr(res: res, i: Nat, x: x): res
//
fun
{res:vt0p}
{xs:t0p}{x:t0p}
ifoldleft_cloref{fe:eff}
( xs: xs
, ini: res
, fopr: (res, Nat, x) -<cloref,fe> res):<fe> res
// end of [foldleft_cloref]
//
(* ****** ****** *)

////
fun{
xs:t0p}{x:t0p}{res:vt0p
} foldleft_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v
| xs: xs, ini: res
, f: (!v | res, x, !vt) -<fun,fe> res, env: !vt
) :<fe> res // end of [foldleft_funenv]

fun{
xs:t0p}{x:t0p}{res:vt0p
} foldleft_clo {fe:eff} (
  xs: xs, ini: res, f: &(res, x) -<clo,fe> res
) :<fe> res // end of [foldleft_clo]
fun{
xs:t0p}{x:t0p}{res:vt0p
} foldleft_vclo {v:view}{fe:eff} (
  pfv: !v
| xs: xs, ini: res, f: &(!v | res, x) -<clo,fe> res
) :<fe> res // end of [foldleft_vclo]

fun{
xs:t0p}{x:t0p}{res:vt0p
} foldleft_cloref {fe:eff} (
  xs: xs, ini: res, f: &(res, x) -<cloref,fe> res
) :<fe> res // end of [foldleft_cloref]

(* ****** ****** *)

fun{
x:t0p}{res:vt0p
} foldright$fwork
  (x: x, res: res): res
fun{
xs:t0p}{x:t0p}{res:vt0p
} foldright (xs: xs, snk: res): res

fun{
xs:t0p}{x:t0p}{res:vt0p
} foldright_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v
| xs: xs, f: (!v | x, res, !vt) -<fun,fe> res, snk: res, env: !vt
) :<fe> res // end of [foldright_funenv]

fun{
xs:t0p}{x:t0p}{res:vt0p
} foldright_clo {fe:eff} (
  xs: xs, f: &(x, res) -<clo,fe> res, snk: res
) :<fe> res // end of [foldright_clo]
fun{
xs:t0p}{x:t0p}{res:vt0p
} foldright_vclo {v:view}{fe:eff} (
  pfv: !v
| xs: xs, f: &(!v | x, res) -<clo,fe> res, snk: res
) :<fe> res // end of [foldright_vclo]

fun{
xs:t0p}{x:t0p}{res:vt0p
} foldright_cloref {fe:eff} (
  xs: xs, f: (x, res) -<cloref,fe> res, snk: res
) :<fe> res // end of [foldright_cloref]

(* ****** ****** *)

fun{x:t0p} exists$pred (x: x): bool
fun{xs:t0p}{x:t0p} exists (xs: xs): bool

fun{
xs:t0p}{x:t0p
} exists_funenv
  {v:view}{vt:viewtype}{pe:eff} (
  pf: !v | xs: xs, p: (!v | x, !vt) -<fun,pe> bool, env: !vt
) :<pe> bool // end of [exists_funenv]

fun{
xs:t0p}{x:t0p
} exists_clo {fe:eff}
  (xs: xs, f: &(x) -<clo,fe> void):<fe> bool
// end of [exists_clo]
fun{
xs:t0p}{x:t0p
} exists_vclo
  {v:view}{fe:eff}
  (pfv: !v | xs: xs, f: &(!v | x) -<clo,fe> void):<fe> bool
// end of [exists_vclo]

(* ****** ****** *)

fun{x:t0p} forall$pred (x: x): bool
fun{xs:t0p}{x:t0p} forall (xs: xs): bool

fun{
xs:t0p}{x:t0p
} forall_funenv
  {v:view}{vt:viewtype}{pe:eff} (
  pf: !v | xs: xs, p: (!v | x, !vt) -<fun,pe> bool, env: !vt
) :<pe> bool // end of [forall_funenv]

(* ****** ****** *)

fun{
xs:t0p}{x:t0p
} ismember_fun {fe:eff}
  (xs: xs, x0: x, eq: (x, x) -<fun,fe> void):<fe> bool
// end of [ismember_fun]

(* ****** ****** *)

fun{
xs:t0p}{x:t0p
} listize (xs: xs):<> List0_vt (x)
fun{
xs:t0p}{x:t0p}{y:vt0p
} listize_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v | xs: xs, f: (!v | x, !vt) -<fun,fe> y, env: !vt
) :<fe> List0_vt (y)

(* ****** ****** *)

fun{
xs:t0p}{x:t0p
} rlistize (xs: xs):<> List0_vt (x)
fun{
xs:t0p}{x:t0p}{y:vt0p
} rlistize_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v | xs: xs, f: (!v | x, !vt) -<fun,fe> y, env: !vt
) :<fe> List0_vt (y)

(* ****** ****** *)

fun{
xs:t0p}{x:t0p
} streamize (xs: xs):<> stream (x)
fun{
xs:t0p}{x:t0p
} streamize_vt (xs: xs):<> stream_vt (x)

(* ****** ****** *)

(* end of [fcntainer.sats] *)
