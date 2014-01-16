(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer_foreach.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "prelude/SATS/fcontainer.sats"

(* ****** ****** *)

implement
{xs}{x}
foreach_fun
  {fe:eff} (xs, f) = let
  val f = coerce (f) where { extern castfn
    coerce (f: (x) -<fe> void):<> (!unit_v | x, !ptr) -<fe> void
  } // end of [val] // HX: this is a safe cast
  prval pfu = unit_v ()
  val () = foreach_funenv<xs><x> {unit_v} {ptr} (pfu | xs, f, the_null_ptr)
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
  val p_f = addr@(f)
  prval [f:addr] EQADDR () = ptr_get_index (p_f)  
  viewdef v = clo_t @ f
  fn app (pf: !v | x: x, p_f: !ptr f):<fe> void = !p_f (x)
in
  foreach_funenv<xs><x> {v}{ptr(f)} (view@ f | xs, app, p_f)
end // end of [foreach_clo]

implement
{xs}{x}
foreach_vclo
  {v} {fe:eff}
  (pfv | xs, f) = let
  typedef clo_t = (!v | x) -<clo,fe> void
  val p_f = addr@(f)
  prval [f:addr] EQADDR () = ptr_get_index (p_f)  
  viewdef v2 = (v, clo_t @ f)
  fn app (pf: !v2 | x: x, p_f: !ptr f):<fe> void = () where {
    val () = !p_f (pf.0 | x)
  } // end of [val]
  prval pf = (pfv, view@ f)
  val () = foreach_funenv<xs><x> {v2} {ptr(f)} (pf | xs, app, p_f)
  prval () = pfv := pf.0 and () = view@ (f) := pf.1
in
  (*nothing*)
end // end of [foreach_vclo]

implement
{xs}{x}
foreach_cloptr
  {fe:eff}
  (xs, f) = let
  viewdef uv = unit_v
  viewtypedef cloptr0_t = (x) -<cloptr,fe> void
  viewtypedef cloptr1_t = (!uv>>uv | x) -<cloptr,fe> void
  prval () = __assert(f) where {
    extern prfun __assert (f: !cloptr0_t >> cloptr1_t): void
  } // end of [val] // HX: this is a safe cast
  prval pfu = unit_v ()
  val () = foreach_vcloptr<xs><x> {uv} (pfu | xs, f)
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
  {fe:eff}
  (xs, f) = let
  viewdef uv = unit_v
  typedef cloref_t = (x) -<cloref,fe> void
  fn app (pf: !uv | x: x, f: !cloref_t):<fe> void = f (x)
  prval pfu = unit_v ()
  val () = foreach_funenv<xs><x> {uv} {cloref_t} (pfu | xs, app, f)
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
val p_i = addr@(i)
viewtypedef ivt = (ptr(i), vt)
//
val env1 = __cast (env) where {
  extern castfn __cast (env: !vt >> vt?):<> vt
} // end of [val]
//
var ienv
  : ivt = (p_i, env1)
val p_ienv = addr@(ienv)
viewdef v1 = (v, int@i, ivt@ienv)
fn f1 (
  pf: !v1 | x: x, p: !ptr(ienv)
) :<fe> void = let
  val i = !(p->0)
  val () = f (pf.0 | i, x, p->1)
in
  $effmask_wrt (!(p->0) := i + 1)
end // end of [f1]
//
prval pfv1 = (pfv, view@(i), view@(ienv))
val () = foreach_funenv{v1}{ptr(ienv)} (pfv1 | xs, f1, p_ienv)
prval () = pfv := pfv1.0
prval () = view@(i) := pfv1.1
prval () = view@(ienv) := pfv1.2
//
prval () =
  __xfree (env, ienv.1) where {
  extern praxi __xfree (env: !vt? >> vt, env1: vt): void
} // end of [where] // end of [prval]
//
in
  i // = the size of [xs]
end // end of [iforeach_funenv]

(* ****** ****** *)

implement
{xs}{x}
iforeach_clo
  {fe:eff}
  (xs, f) = let
  typedef clo_t = (int, x) -<clo,fe> void
  val p_f = addr@(f)
  prval [f:addr] EQADDR () = ptr_get_index (p_f)  
  viewdef v = clo_t @ f
  fn app (pf: !v | i: int, x: x, p_f: !ptr f):<fe> void = !p_f (i, x)
in
  iforeach_funenv<xs><x> {v}{ptr(f)} (view@ f | xs, app, p_f)
end // end of [iforeach_clo]

implement
{xs}{x}
iforeach_vclo
  {v} {fe:eff}
  (pfv | xs, f) = let
  typedef clo_t = (!v | int, x) -<clo,fe> void
  val p_f = addr@(f)
  prval [f:addr] EQADDR () = ptr_get_index (p_f)  
  viewdef v2 = (v, clo_t @ f)
  fn app (
    pf: !v2 | i: int, x: x, p_f: !ptr f
  ) :<fe> void = () where {
    val () = !p_f (pf.0 | i, x)
  } // end of [val]
  prval pf = (pfv, view@ f)
  val nxs = iforeach_funenv<xs><x> {v2} {ptr(f)} (pf | xs, app, p_f)
  prval () = pfv := pf.0 and () = view@ (f) := pf.1
in
  nxs
end // end of [iforeach_vclo]

(* ****** ****** *)

implement
{xs}{x}
iforeach_cloptr
  {fe:eff}
  (xs, f) = let
  viewdef uv = unit_v
  viewtypedef cloptr0_t = (int, x) -<cloptr,fe> void
  viewtypedef cloptr1_t = (!uv >> uv | int, x) -<cloptr,fe> void
  prval () = __assert(f) where {
    extern prfun __assert (f: !cloptr0_t >> cloptr1_t): void
  } // end of [val] // HX: this is a safe cast
  prval pfu = unit_v ()
  val nxs = iforeach_vcloptr<xs><x> {uv} (pfu | xs, f)
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
  {fe:eff}
  (xs, f) = let
  viewdef uv = unit_v
  typedef cloref_t = (int, x) -<cloref,fe> void
  fn app (pf: !uv | i: int, x: x, f: !cloref_t):<fe> void = f (i, x)
  prval pfu = unit_v ()
  val nxs = iforeach_funenv<xs><x> {uv} {cloref_t} (pfu | xs, app, f)
  prval unit_v () = pfu
in
  nxs
end // end of [foreach_cloref]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer_foreach.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer_foreach.dats] *)
