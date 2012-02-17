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
#print "Loading [fcontainer.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload "fiterator.sats" // HX: preloaded
staload "fcontainer.sats" // HX: preloaded

(* ****** ****** *)

implement{xs}{x}
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

(* ****** ****** *)

implement{xs}{x}
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

implement{xs}{x}
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

(* ****** ****** *)

implement{xs}{x}
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
implement{xs}{x}
foreach_vcloptr
  {v} {fe:eff} (pf | xs, f) = let
  viewtypedef cloptr_t = (!v | x) -<cloptr,fe> void
  fn app (pf: !v | x: x, f: !cloptr_t):<fe> void = f (pf | x)
in
  foreach_funenv<xs><x> {v} {cloptr_t} (pf | xs, app, f)
end // end of [foreach_vcloptr]

(* ****** ****** *)

implement{xs}{x}
foreach_cloref
  {fe:eff} (xs, f) = let
  typedef cloref_t = (x) -<cloref,fe> void
  fn app (pf: !unit_v | x: x, f: !cloref_t):<fe> void = f (x)
  prval pfu = unit_v ()
  val () = foreach_funenv<xs><x> {unit_v} {cloref_t} (pfu | xs, app, f)
  prval unit_v () = pfu
in
  (*empty*)
end // end of [list_foreach_cloref]

(* ****** ****** *)
//
// HX-2012-02:
// this implementation makes use
// of the (local) exception mechanism
//
implement{xs}{x}
exists_funenv
  {v}{vt}{fe:eff}
  (pfv | xs, p, env) = let
  exception Found of ()
  fn f (
    pfv: !v | x: x, env: !vt
  ) :<fe,!exn> void =
    if p (pfv | x, env) then $raise (Found) else ()
  // end of [f]
  val ptr = __cast (env) where {
    extern castfn __cast (env: !vt):<> ptr
  } // end of [val]
in try let
  val env = __encode (ptr) where {
    extern castfn __encode (x: ptr):<> vt
  } // end of [val]
  prval (pfv, fpfv) = __assert () where {
    extern praxi __assert (): (v, v -<lin,prf> void)
  } // end of [prval]
  val () = $effmask_exn (foreach_funenv<xs><x> (pfv | xs, f, env))
  prval () = fpfv (pfv)
  val ptr = __decode (env) where {
    extern castfn __decode (x: vt):<> ptr
  } // end of [val]
in
  true (* element satifying [p] is found *)
end with
  ~Found () => false
// end of [try]
end // end of [exists_funenv]

(* ****** ****** *)

implement{xs}{x}
rlistize (xs) = let
  var res
    : List_vt (x) = list_vt_nil ()
  viewdef v = List_vt (x) @ res
  var !p_clo = @lam
    (pf: !v | x: x): void =<clo> res := list_vt_cons (x, res)
  val () = foreach_vclo {v} (view@ (res) | xs, !p_clo)
in
  res
end // end of [rlistize]

implement
{xs}{x}{y}
rlistize_funenv
  {v}{vt}{fe}
  (pfv | xs, f, env) = let
  var res
    : List_vt (y) = list_vt_nil ()
  viewdef v2 = @(v, List_vt (y) @ res)
  val ptr =
    $UN.castvwtp1 {ptr}{vt} (env)
  // end of [val]
  var !p_clo = @lam
    (pf: !v2 | x: x): void =<clo,fe> let
    extern castfn __encode (x: ptr):<> vt
    extern castfn __decode (x: vt):<> ptr
    val env = __encode (ptr)
    val y = f (pf.0 | x, env)
    val ptr = __decode (env)
    prval pfat = pf.1
    val () = res := list_vt_cons (y, res)
    prval () = pf.1 := pfat
  in
    (*nothing*)
  end // end of [var]
  prval pf = (pfv, view@ (res))
  val () = foreach_vclo {v2} (pf | xs, !p_clo)
  prval () = pfv := pf.0
  prval () = view@ (res) := pf.1
in
  res
end // end of [rlistize_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer.sats] *)
