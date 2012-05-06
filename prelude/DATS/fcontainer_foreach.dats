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

staload UN = "prelude/SATS/unsafe.sats"
staload "prelude/SATS/fiterator.sats" // HX: preloaded
staload "prelude/SATS/fcontainer.sats" // HX: preloaded

(* ****** ****** *)

implement
{xs}{x}
foreach_fun
  {fe:eff} (xs, f) = let
  val f = coerce (f) where { extern castfn
    coerce (f: (x) -<fe> void):<> (!unit_v | x, !ptr) -<fe> void
  } // end of [val] // HX: this is a safe cast
  prval pfu = unit_v ()
  val () = foreach_funenv<xs><x> {unit_v} {ptr} (pfu | xs, f, null)
  prval unit_v () = pfu
in
  // empty
end // end of [foreach_fun]

implement
{xs}{x}
foreach_clo
  {fe:eff}
  (xs, f) = let
  typedef clo_t = (x) -<clo,fe> void
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v = clo_t @ lf
  fn app (pf: !v | x: x, lf: !ptr lf):<fe> void = !lf (x)
in
  foreach_funenv<xs><x> {v}{ptr lf} (view@ f | xs, app, lf)
end // end of [foreach_clo]
implement
{xs}{x}
foreach_vclo
  {v} {fe:eff}
  (pfv | xs, f) = let
  typedef clo_t = (!v | x) -<clo,fe> void
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v2 = (v, clo_t @ lf)
  fn app (pf: !v2 | x: x, lf: !ptr lf):<fe> void = () where {
    prval (pf1, pf2) = pf
    val () = !lf (pf1 | x)
    prval () = pf := (pf1, pf2)
  } // end of [val]
  prval pf = (pfv, view@ f)
  val () = foreach_funenv<xs><x> {v2} {ptr lf} (pf | xs, app, lf)
  prval () = pfv := pf.0 and () = view@ (f) := pf.1
in
  (*nothing*)
end // end of [foreach_vclo]

implement
{xs}{x}
foreach_cloptr
  {fe:eff} (xs, f) = let
  viewtypedef cloptr0_t = (x) -<cloptr,fe> void
  viewtypedef cloptr1_t = (!unit_v | x) -<cloptr,fe> void
  prval () = __assert(f) where {
    extern prfun __assert (f: !cloptr0_t >> cloptr1_t): void
  } // end of [val] // HX: this is a safe cast
  prval pfu = unit_v ()
  val () = foreach_vcloptr<xs><x> {unit_v} (pfu | xs, f)
  prval unit_v () = pfu
  prval () = __assert(f) where {
    extern prfun __assert (f: !cloptr1_t >> cloptr0_t): void
  } // end of [val] // HX: this is a safe cast
in
  (*nothing*)
end // end of [foreach_cloptr]
implement
{xs}{x}
foreach_vcloptr
  {v} {fe:eff} (pf | xs, f) = let
  viewtypedef cloptr_t = (!v | x) -<cloptr,fe> void
  fn app (pf: !v | x: x, f: !cloptr_t):<fe> void = f (pf | x)
in
  foreach_funenv<xs><x> {v} {cloptr_t} (pf | xs, app, f)
end // end of [foreach_vcloptr]

implement
{xs}{x}
foreach_cloref
  {fe:eff} (xs, f) = let
  typedef cloref_t = (x) -<cloref,fe> void
  fn app (pf: !unit_v | x: x, f: !cloref_t):<fe> void = f (x)
  prval pfu = unit_v ()
  val () = foreach_funenv<xs><x> {unit_v} {cloref_t} (pfu | xs, app, f)
  prval unit_v () = pfu
in
  (*empty*)
end // end of [foreach_cloref]

(* ****** ****** *)

implement
{xs}{x}
iforeach_funenv
  {v}{vt}{fe} (
  pfv | xs, f, env
) = let
var i: int = 0
viewtypedef ivt = (ptr(i), vt)
//
val env1 = __cast (env) where {
  extern castfn __cast (env: !vt >> vt?):<> vt
} // end of [val]
//
var ienv: ivt = (&i, env1)
viewdef v1 = (v, int@i, ivt @ ienv)
fn f1 (
  pf: !v1 | x: x, ienv: !ptr(ienv)
) :<fe> void = let
  prval (pfv, pf1, pf2) = pf
  val i = !(ienv->0)
  val () = f (pfv | i, x, ienv->1)
  val () = !(ienv->0) := i + 1
  prval () = pf := (pfv, pf1, pf2)
in
  (*nothing*)
end // end of [f1]
//
prval pfv1 = (pfv, view@(i), view@(ienv))
val () = foreach_funenv{v1}{ptr(ienv)} (pfv1 | xs, f1, &ienv)
prval () = pfv := pfv1.0
prval () = view@(i) := pfv1.1
prval () = view@(ienv) := pfv1.2
//
prval () = __free (env, ienv.1) where {
  extern praxi __free (env: !vt? >> vt, env1: vt): void
} // end of [prval]
//
in
  uint_of_int (i)
end // end of [iforeach_funenv]

(* ****** ****** *)

implement
{xs}{x}
iforeach_clo
  {fe:eff}
  (xs, f) = let
  typedef clo_t = (int, x) -<clo,fe> void
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v = clo_t @ lf
  fn app (pf: !v | i: int, x: x, lf: !ptr lf):<fe> void = !lf (i, x)
in
  iforeach_funenv<xs><x> {v}{ptr lf} (view@ f | xs, app, lf)
end // end of [iforeach_clo]
implement
{xs}{x}
iforeach_vclo
  {v} {fe:eff}
  (pfv | xs, f) = let
  typedef clo_t = (!v | int, x) -<clo,fe> void
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v2 = (v, clo_t @ lf)
  fn app (
    pf: !v2 | i: int, x: x, lf: !ptr lf
  ) :<fe> void = () where {
    prval (pf1, pf2) = pf
    val () = !lf (pf1 | i, x)
    prval () = pf := (pf1, pf2)
  } // end of [val]
  prval pf = (pfv, view@ f)
  val nxs = iforeach_funenv<xs><x> {v2} {ptr lf} (pf | xs, app, lf)
  prval () = pfv := pf.0 and () = view@ (f) := pf.1
in
  nxs
end // end of [iforeach_vclo]

(* ****** ****** *)

implement
{xs}{x}
iforeach_cloptr
  {fe:eff} (xs, f) = let
  viewtypedef cloptr0_t = (int, x) -<cloptr,fe> void
  viewtypedef cloptr1_t = (!unit_v | int, x) -<cloptr,fe> void
  prval () = __assert(f) where {
    extern prfun __assert (f: !cloptr0_t >> cloptr1_t): void
  } // end of [val] // HX: this is a safe cast
  prval pfu = unit_v ()
  val nxs = iforeach_vcloptr<xs><x> {unit_v} (pfu | xs, f)
  prval unit_v () = pfu
  prval () = __assert(f) where {
    extern prfun __assert (f: !cloptr1_t >> cloptr0_t): void
  } // end of [val] // HX: this is a safe cast
in
  nxs
end // end of [iforeach_cloptr]
implement
{xs}{x}
iforeach_vcloptr
  {v} {fe:eff} (pf | xs, f) = let
  viewtypedef cloptr_t = (!v | int, x) -<cloptr,fe> void
  fn app (pf: !v | i: int, x: x, f: !cloptr_t):<fe> void = f (pf | i, x)
in
  iforeach_funenv<xs><x> {v} {cloptr_t} (pf | xs, app, f)
end // end of [iforeach_vcloptr]

(* ****** ****** *)

implement
{xs}{x}
iforeach_cloref
  {fe:eff} (xs, f) = let
  typedef cloref_t = (int, x) -<cloref,fe> void
  fn app (pf: !unit_v | i: int, x: x, f: !cloref_t):<fe> void = f (i, x)
  prval pfu = unit_v ()
  val nxs = iforeach_funenv<xs><x> {unit_v} {cloref_t} (pfu | xs, app, f)
  prval unit_v () = pfu
in
  nxs
end // end of [foreach_cloref]

(* ****** ****** *)

(* end of [fcontainer_foreach.dats] *)
