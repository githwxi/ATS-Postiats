(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)
//
// HX: indexed by list length
//
abstype
ralist_t0ype_int_type (a:t@ype+, n:int)
stadef ralist = ralist_t0ype_int_type
typedef ralist (a:t@ype) = [n:int] ralist (a, n)
//
(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

prfun lemma_ralist_param
  {a:t0p}{n:int} (xs: ralist (a, n)): [n >= 0] void
// end of [lemma_ralist_param]

(* ****** ****** *)

fun{}
funralist_nil {a:t0p} ():<> ralist (a, 0)

(* ****** ****** *)

fun funralist_length
  {a:t0p}{n:nat} (xs: ralist (a, n)):<> int (n)
// end of [funralist_length]

(* ****** ****** *)

fun{a:t0p}
funralist_cons {n:int}
  (x: a, xs: ralist (INV(a), n)):<> ralist (a, n+1)
// end of [funralist_cons]

fun{a:t0p}
funralist_uncons {n:pos}
  (xs: ralist (INV(a), n), x: &a? >> a):<!wrt> ralist (a, n-1)
// end of [funralist_uncons]

(* ****** ****** *)

fun{a:t0p}
funralist_head
  {n:pos} (xs: ralist (INV(a), n)):<> a
fun{a:t0p}
funralist_tail
  {n:pos} (xs: ralist (INV(a), n)):<> ralist (a, n-1)
// end of [funralist_tail]

(* ****** ****** *)

fun{a:t0p}
funralist_lookup
  {n:int} (xs: ralist (INV(a), n), i: natLt n):<> a
// end of [funralist_lookup]

fun{a:t0p}
funralist_update
  {n:int} (xs: ralist (INV(a), n), i: natLt n, x: a):<> ralist (a, n)
// end of [funralist_update]

(* ****** ****** *)

fun{a:t0p}{env:vt0p}
funralist_foreach__fwork (x: a, env: &env): void

fun{a:t0p}
funralist_foreach (xs: ralist (a)): void
fun{a:t0p}{env:vt0p}
funralist_foreach_env (xs: ralist (a), env: &INV(env)>>env): void

(* ****** ****** *)

(* end of [funralist_nested.sats] *)
