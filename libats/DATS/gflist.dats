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

#define ATS_STALOADFLAG 0 // no need for staloading at run-time

(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats"

(* ****** ****** *)

staload "libats/SATS/gflist.sats"

(* ****** ****** *)

implement{a}
gflist_length (xs) = let
//
fun loop
  {xs:ilist}{j:int} .<xs>. (
  xs: gflist (a, xs), j: int j
) :<> [i:nat]
  (LENGTH (xs, i) | int (i+j)) = let
in
//
case+ xs of
| gflist_cons
    (_, xs) => let
    val (pf | res) = loop (xs, j+1)
  in
    (LENGTHcons (pf) | res)
  end // end of [gflist_cons]
| gflist_nil () => (LENGTHnil () | j)
//
end // end of [loop]
//
in
  loop (xs, 0)
end // end of [gflist_length]

(* ****** ****** *)

implement{a}
gflist_append
  (xs, ys) = let
//
fun loop
  {xs:ilist}
  {ys:ilist} .<xs>. (
  xs: gflist (a, xs), ys: gflist (a, ys), res: &ptr? >> gflist (a, zs)
) :<!wrt> #[zs:ilist] (APPEND (xs, ys, zs) | void) = let
in
//
case+ xs of
| gflist_cons
    (x, xs) => let
    val () = res := gflist_cons (x, _)
    val+ gflist_cons (_, res1) = res
    val (pf | ()) = loop (xs, ys, res1)
    prval () = fold@ (res)
  in
    (APPENDcons (pf) | ())
  end // end of [gflist_cons]
| gflist_nil () => let
    val () = res := ys in (APPENDnil () | ())
  end // end of [gflist_nil]
//
end // end of [loop]
//
var res: ptr // uninitialized
//
val (pf | ()) = $effmask_wrt (loop (xs, ys, res))
//
in
  (pf | res)
end // end of [gflist_append]

(* ****** ****** *)

implement{a}
gflist_revapp
  (xs, ys) = let
in
//
case+ xs of
| gflist_cons
    (x, xs) => let
    val (pf | res) = gflist_revapp (xs, gflist_cons (x, ys))
  in
    (REVAPPcons (pf) | res)
  end // end of [gflist_cons]
| gflist_nil () => (REVAPPnil () | ys)
//
end // end of [gflist_append]

implement{a}
gflist_reverse (xs) = gflist_revapp (xs, gflist_nil)

(* ****** ****** *)

(* end of [gflist.dats] *)
