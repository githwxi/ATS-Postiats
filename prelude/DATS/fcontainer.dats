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
staload "prelude/SATS/fiterator.sats" // HX: preloaded
staload "prelude/SATS/fcontainer.sats" // HX: preloaded

(* ****** ****** *)

#include "prelude/DATS/fcontainer_foreach.dats"

(* ****** ****** *)

implement
{xs}{x}{init}
foldleft_funenv
  {v}{vt}{fe:eff}
  (pfv | f, init, xs, env) = let
//
var res: init = init
viewtypedef pvt = (ptr(res), vt)
//
val env1 = __cast (env) where {
  extern castfn __cast (env: !vt >> vt?):<> vt
} // end of [val]
//
var penv: pvt = (&res, env1)
viewdef v1 = (v, init@res, pvt @ penv)
fn f1 (
  pf: !v1 | x: x, penv: !ptr(penv)
) :<fe> void = let
  prval (pfv, pf1, pf2) = pf
  val p = penv->0
  val () = !p := f (pfv | !p, x, penv->1)
  prval () = pf := (pfv, pf1, pf2)
in
  (*nothing*)
end // end of [f1]
//
prval pfv1 = (pfv, view@(res), view@(penv))
val () = foreach_funenv{v1}{ptr(penv)} (pfv1 | xs, f1, &penv)
prval () = pfv := pfv1.0
prval () = view@(res) := pfv1.1
prval () = view@(penv) := pfv1.2
//
prval () = __free (env, penv.1) where {
  extern praxi __free (env: !vt? >> vt, env1: vt): void
} // end of [prval]
//
in
  res
end // end of [foldleft_funenv]

implement
{xs}{x}{init}
foldleft_clo
  {fe:eff}(f, init, xs) = let
  typedef clo_t =
    (init, x) -<clo,fe> init
  // end of [typedef]
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v = clo_t @ lf
  fn app (
    pf: !v | init: init, x: x, lf: !ptr(lf)
  ) :<fe> init = !lf (init, x)
in
  foldleft_funenv<xs><x> {v}{ptr(lf)} (view@ f | app, init, xs, lf)
end // end of [foldleft_clo]
implement
{xs}{x}{init}
foldleft_vclo
  {v} {fe:eff}
  (pfv | f, init, xs) = let
  typedef clo_t =
    (!v | init, x) -<clo,fe> init
  // end of [typedef]
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v2 = (v, clo_t @ lf)
  fn app (
    pf: !v2 | init: init, x: x, lf: !ptr lf
  ) :<fe> init = res where {
    prval (pf1, pf2) = pf
    val res = !lf (pf1 | init, x)
    prval () = pf := (pf1, pf2)
  } // end of [val]
  prval pf = (pfv, view@ f)
  val res = foldleft_funenv<xs><x> {v2} {ptr(lf)} (pf | app, init, xs, lf)
  prval () = pfv := pf.0 and () = view@ (f) := pf.1
in
  res(*init*)
end // end of [foldleft_vclo]

implement
{xs}{x}{init}
foldleft_cloref
  {fe:eff} (f, init, xs) = let
  typedef cloref_t = (init, x) -<cloref,fe> init
  fn app (
    pf: !unit_v | init: init, x: x, f: !cloref_t 
  ) :<fe> init = f (init, x)
  prval pfu = unit_v ()
  val res = foldleft_funenv<xs><x> {unit_v} {cloref_t} (pfu | app, init, xs, f)
  prval unit_v () = pfu
in
  res(*init*)
end // end of [foldleft_cloref]

(* ****** ****** *)

implement
{xs}{x}{sink}
foldright_funenv
  {v}{vt}{fe:eff}
  (pfv | f, xs, sink, env) = let
  typedef tfun = (!v | x, sink, !vt) -<fun,fe> sink
  fun loop {n:nat} .<n>. (
    pfv: !v
  | f: tfun, xs: list_vt (x, n), sink: sink, env: !vt
  ) :<fe> sink = (
    case+ xs of
    | ~list_vt_cons (x, xs) =>
        loop (pfv | f, xs, f (pfv | x, sink, env), env)
    | ~list_vt_nil () => sink
  ) // end of [loop]
in
  loop (pfv | f, rlistize (xs), sink, env)
end // end of [foldright_funenv]

implement
{xs}{x}{sink}
foldright_clo
  {fe:eff}(f, xs, sink) = let
  typedef clo_t =
    (x, sink) -<clo,fe> sink
  // end of [typedef]
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v = clo_t @ lf
  fn app (
    pf: !v | x: x, sink: sink, lf: !ptr(lf)
  ) :<fe> sink = !lf (x, sink)
in
  foldright_funenv<xs><x> {v}{ptr(lf)} (view@ f | app, xs, sink, lf)
end // end of [foldright_clo]
implement
{xs}{x}{sink}
foldright_vclo
  {v} {fe:eff}
  (pfv | f, xs, sink) = let
  typedef clo_t =
    (!v | x, sink) -<clo,fe> sink
  // end of [typedef]
  stavar lf: addr; val lf: ptr lf = &f
  viewdef v2 = (v, clo_t @ lf)
  fn app (
    pf: !v2 | x: x, sink: sink, lf: !ptr lf
  ) :<fe> sink = res where {
    prval (pf1, pf2) = pf
    val res = !lf (pf1 | x, sink)
    prval () = pf := (pf1, pf2)
  } // end of [val]
  prval pf = (pfv, view@ f)
  val res = foldright_funenv<xs><x> {v2} {ptr(lf)} (pf | app, xs, sink, lf)
  prval () = pfv := pf.0 and () = view@ (f) := pf.1
in
  res(*sink*)
end // end of [foldright_vclo]

implement
{xs}{x}{sink}
foldright_cloref
  {fe:eff} (f, xs, sink) = let
  typedef cloref_t = (x, sink) -<cloref,fe> sink
  fn app (
    pf: !unit_v | x: x, sink: sink, f: !cloref_t 
  ) :<fe> sink = f (x, sink)
  prval pfu = unit_v ()
  val res = foldright_funenv<xs><x> {unit_v} {cloref_t} (pfu | app, xs, sink, f)
  prval unit_v () = pfu
in
  res(*sink*)
end // end of [foldright_cloref]
////
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

implement{xs}{x}
forall_funenv
  {v}{vt}{fe:eff}
  (pfv | xs, p, env) = let
  fn np (pfv: !v | x: x, env: !vt):<fe> bool = ~p (pfv | x, env)
in
  ~(exists_funenv<xs><x> (pfv | xs, np, env))
end // end of [forall_funenv]

(* ****** ****** *)

implement{xs}{x}
ismember_fun
  {fe} (xs, x0, eq) = let
  var !p_clo = lam@ (x: x) =<fe> eq (x0, x)
in
  exists_clo<xs><x> (xs, !p_clo)
end // end of [ismemer_fun]

(* ****** ****** *)

implement{xs}{x}
rlistize (xs) = res where {
  var res
    : List_vt (x) = list_vt_nil ()
  viewdef v = List_vt (x) @ res
  var !p_clo = lam@
    (pf: !v | x: x): void =<clo> res := list_vt_cons (x, res)
  val () = foreach_vclo {v} (view@ (res) | xs, !p_clo)
} // end of [rlistize]

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
  var !p_clo = lam@
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

(* end of [fcontainer.dats] *)
