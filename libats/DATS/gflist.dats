(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: October, 2010
//
(* ****** ****** *)
//
// HX: generic functional lists (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-28: ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats"

(* ****** ****** *)

staload "libats/SATS/gflist.sats"
staload "libats/SATS/gflist_vt.sats"

(* ****** ****** *)

implement{a}
gflist_length (xs) = let
//
val (
  pf | xs
) = gflist2list (xs) // castfn
//
in
  (pf | list_length<a> (xs))
end // end of [gflist_length]

(* ****** ****** *)

implement{a}
gflist_copy (xs) = let
//
fun loop
  {xs:ilist} .<xs>. (
  xs: gflist (a, xs), res: &ptr? >> gflist_vt (a, xs)
) :<!wrt> void = let
in
//
case+ xs of
| gflist_cons
    (x, xs1) => let
    val x = stamped_t2vt (x)
    val () =
      res := gflist_vt_cons (x, _)
    // end of [val]
    val+ gflist_vt_cons (_, res1) = res
    val () = loop (xs1, res1)
    prval () = fold@ (res)
  in
    // nothing
  end // end of [gflist_vt_cons]
| gflist_nil () => (res := gflist_vt_nil ())
end // end of [loop]
//
var res: ptr // uninitialized
val () = $effmask_wrt (loop (xs, res))
//
in
  res
end // end of [gflist_copy]

(* ****** ****** *)

implement{a}
gflist_append
  (xs1, xs2) = let
//
fun loop
  {xs1:ilist}
  {xs2:ilist} .<xs1>. (
  xs1: gflist (a, xs1), xs2: gflist (a, xs2), res: &ptr? >> gflist (a, ys)
) :<!wrt> #[ys:ilist] (APPEND (xs1, xs2, ys) | void) = let
in
//
case+ xs1 of
| gflist_cons
    (x1, xs1) => let
    val () = res := gflist_cons (x1, _)
    val+ gflist_cons (_, res1) = res
    val (pf | ()) = loop (xs1, xs2, res1)
    prval () = fold@ (res)
  in
    (APPENDcons (pf) | ())
  end // end of [gflist_cons]
| gflist_nil () => let
    val () = res := xs2 in (APPENDnil () | ())
  end // end of [gflist_nil]
//
end // end of [loop]
//
var res: ptr // uninitialized
//
val (pf | ()) = $effmask_wrt (loop (xs1, xs2, res))
//
in
  (pf | res)
end // end of [gflist_append]

(* ****** ****** *)

implement{a}
gflist_revapp
  (xs1, xs2) = let
//
fun loop
  {xs1,xs2:ilist} .<xs1>. (
  xs1: gflist (INV(a), xs1), xs2: gflist (a, xs2)
) :<> [res:ilist]
  (REVAPP (xs1, xs2, res) | gflist (a, res)) = let
in
//
case+ xs1 of
| gflist_cons
    (x1, xs1) => let
    val (pf | res) = loop (xs1, gflist_cons (x1, xs2))
  in
    (REVAPPcons (pf) | res)
  end // end of [gflist_cons]
| gflist_nil () => (REVAPPnil () | xs2)
//
end // end of [loop]
//
in
  loop (xs1, xs2)
end // end of [gflist_revapp]

(* ****** ****** *)

implement{a}
gflist_revapp1_vt
  (xs1, xs2) = let
//
val xs2 =
  __cast (xs2) where {
  extern
  castfn __cast {xs2:ilist}
    (xs2: gflist (a, xs2)):<> gflist_vt (a, xs2)
  // end of [castfn]
} // end of [val]
val (pf | ys) = gflist_vt_revapp<a> (xs1, xs2)
//
in
  (pf | gflist_vt2t (ys))
end // end of [gflist_revapp1_vt]

(* ****** ****** *)

implement{a}
gflist_revapp2_vt
  (xs1, xs2) = let
//
fun loop
  {xs1,xs2:ilist} .<xs1>. (
  xs1: gflist (INV(a), xs1), xs2: gflist_vt (a, xs2)
) :<> [res:ilist]
  (REVAPP (xs1, xs2, res) | gflist_vt (a, res)) = let
in
//
case+ xs1 of
| gflist_cons
    (x1, xs1) => let
    val x1 = stamped_t2vt (x1)
    val (pf | res) = loop (xs1, gflist_vt_cons (x1, xs2))
  in
    (REVAPPcons (pf) | res)
  end // end of [gflist_cons]
| gflist_nil () => (REVAPPnil () | xs2)
//
end // end of [loop]
//
in
  loop (xs1, xs2)
end // end of [gflist_revapp2_vt]

(* ****** ****** *)

implement{a}
gflist_reverse (xs) =
  $effmask_wrt (gflist_revapp2_vt<a> (xs, gflist_vt_nil))
// end of [gflist_reverse]

(* ****** ****** *)

implement{a}
gflist_mergesort
  (xs) = let
//
val xs = gflist_copy (xs)
//
implement
gflist_vt_mergesort$cmp<a> (x1, x2) =
  gflist_mergesort$cmp<a> (stamped_vt2t (x1), stamped_vt2t (x2))
//
in
  gflist_vt_mergesort<a> (xs)
end // end of [gflist_mergesort]

(* ****** ****** *)

(* end of [gflist.dats] *)
