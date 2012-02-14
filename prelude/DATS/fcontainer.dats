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

(*
staload "fcontainer.sats" // HX: preloaded
*)

(* ****** ****** *)

implement{xs}{x}
foreach_fun
  {f:eff} (xs, f) = let
  val f = coerce (f) where { extern castfn
    coerce (f: (x) -<f> void):<> (!unit_v | x, !ptr) -<f> void
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
  {f:eff}
  (xs, f) = let
  typedef clo_t = (x) -<clo,f> void
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v = clo_t @ lf
  fn app (pf: !v | x: x, lf: !ptr lf):<f> void = !lf (x)
in
  foreach_funenv<xs><x> {v}{ptr lf} (view@ f | xs, app, lf)
end // end of [foreach_clo]

implement{xs}{x}
foreach_vclo
  {v} {f:eff}
  (pfv | xs, f) = let
  typedef clo_t = (!v | x) -<clo,f> void
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v2 = (v, clo_t @ lf)
  fn app (pf: !v2 | x: x, lf: !ptr lf):<f> void = () where {
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
  {f:eff} (xs, f) = let
  viewtypedef cloptr0_t = (x) -<cloptr,f> void
  viewtypedef cloptr1_t = (!unit_v | x) -<cloptr,f> void
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
  {v} {f:eff} (pf | xs, f) = let
  viewtypedef cloptr_t = (!v | x) -<cloptr,f> void
  fn app (pf: !v | x: x, f: !cloptr_t):<f> void = f (pf | x)
in
  foreach_funenv<xs><x> {v} {cloptr_t} (pf | xs, app, f)
end // end of [foreach_vcloptr]

(* ****** ****** *)

implement{xs}{x}
foreach_cloref
  {f:eff} (xs, f) = let
  typedef cloref_t = (x) -<cloref,f> void
  fn app (pf: !unit_v | x: x, f: !cloref_t):<f> void = f (x)
  prval pfu = unit_v ()
  val () = foreach_funenv<xs><x> {unit_v} {cloref_t} (pfu | xs, app, f)
  prval unit_v () = pfu
in
  (*empty*)
end // end of [list_foreach_cloref]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer.sats] *)
