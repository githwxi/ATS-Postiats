(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

sortdef t0p = t@ype
sortdef vt0p = viewt@ype

(* ****** ****** *)

(*
//
// HX: [array_v] can also be defined as follows:
//
dataview
array_v (
  a:viewt@ype+, addr, int
) =
  | {n:int} {l:addr}
    array_v_cons (a, l, n+1) of (a @ l, array_v (a, l+sizeof a, n))
  | {l:addr} array_v_nil (a, l, 0)
// end of [array_v]
*)
viewdef
array_v (a:viewt@ype, l:addr, n:int) = @[a][n] @ l

(* ****** ****** *)

prfun
lemma_array_v_params{a:vt0p}
  {l:addr}{n:int} (pf: !array_v (INV(a), l, n)): [n >= 0] void
// end of [lemma_array_v_params]

(* ****** ****** *)

praxi array_v_nil :
  {a:vt0p} {l:addr} () -<prf> array_v (a, l, 0)
praxi array_v_unnil :
  {a:vt0p} {l:addr} array_v (a, l, 0) -<prf> void

praxi array_v_cons :
  {a:vt0p} {l:addr} {n:int}
  (a @ l, array_v (INV(a), l+sizeof(a), n)) -<prf> array_v (a, l, n+1)
praxi array_v_uncons :
  {a:vt0p} {l:addr} {n:int | n > 0}
  array_v (INV(a), l, n) -<prf> (a @ l, array_v (a, l+sizeof(a), n-1))

(* ****** ****** *)

prfun array_v_sing
  {a:vt0p} {l:addr} (pf: INV(a) @ l): array_v (a, l, 1)
prfun array_v_unsing
  {a:vt0p} {l:addr} (pf: array_v (INV(a), l, 1)): a @ l

(* ****** ****** *)

dataview
arrayopt_v (
  a:viewt@ype+, addr, int, bool
) =
  | {n:int} {l:addr}
    arrayopt_v_some (a, l, n, true) of array_v (a, l, n)
  | {n:int} {l:addr}
    arrayopt_v_none (a, l, n, false) of array_v (a?, l, n)
// end of [arrayopt_v]

(* ****** ****** *)

fun{a:t0p}
array_get_at {n:int} (A: &(@[a][n]), i: sizeLt n):<> a
fun{a:t0p}
array_set_at {n:int} (A: &(@[a][n]), i: sizeLt n, x: a): void
overload [] with array_get_at
overload [] with array_set_at

(* ****** ****** *)

fun{a:vt0p}
array_exch_at
  {n:int} (A: &(@[a][n]), i: sizeLt n, x: &a >> a): void
// end of [array_exch_at]

(* ****** ****** *)

fun
array_foreach_funenv_tsz
  {a:vt0p}
  {v:view}
  {vt:viewtype}
  {n:int}
  {fe:eff} (
  pfv: !v
| A: &(@[a][n])
, f: (!v | &WRT(a), !vt) -<fun,fe> void
, env: !vt
, asz: size_t n
, tsz: sizeof_t a
) :<fe> void
  = "atspre_array_foreach_funenv_tsz"
// end of [array_foreach_funenv_tsz]

fun{a:vt0p}
array_foreach_funenv
  {v:view}
  {vt:viewtype}
  {n:int}
  {fe:eff} (
  pfv: !v
| A: &(@[a][n])
, f: (!v | &WRT(a), !vt) -<fun,fe> void
, env: !vt
, asz: size_t n
) :<fe> void
// end of [array_foreach_funenv]

fun{a:vt0p}
array_foreach_fun
  {n:int} {fe:eff} (
  A: &(@[a][n]), f: (&a) -<fun,fe> void, asz: size_t n
) :<fe> void // end of [array_foreach_fun]

fun{a:viewt@ype}
array_foreach_clo
  {n:int} {fe:eff} (
  A: &(@[a][n]), f: &(&a) -<clo,fe> void, asz: size_t n
) :<fe> void // end of [array_foreach_clo]
fun{a:viewt@ype}
array_foreach_vclo
  {v:view} {n:int} {fe:eff} (
  pfv: !v
| base: &(@[a][n]), f: &(!v | &a) -<clo,fe> void, asz: size_t n
) :<fe> void // end of [array_foreach_vclo]

fun{a:viewt@ype}
array_foreach_cloptr
  {n:int} {fe:eff} (
  A: &(@[a][n]), f: (&a) -<cloptr,fe> void, asz: size_t n
) :<fe> void // end of [array_foreach_cloptr]
fun{a:viewt@ype}
array_foreach_vcloptr
  {v:view} {n:int} {fe:eff} (
  pfv: !v
| base: &(@[a][n]), f: (!v | &a) -<cloptr,fe> void, asz: size_t n
) :<fe> void // end of [array_foreach_vcloptr]

fun{a:viewt@ype}
array_foreach_clopref
  {n:int} {fe:eff} (
  A: &(@[a][n]), f: (&a) -<cloref,fe> void, asz: size_t n
) :<fe> void // end of [array_foreach_cloref]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [array.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [array.sats] *)
