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

(* ****** ****** *)

(*
staload "prelude/SATS/fiterator.sats" // HX: preloaded
staload "prelude/SATS/fcontainer.sats" // HX: preloaded
*)

(* ****** ****** *)
//
// HX: this one is based on [incable iter]
//
implement
{xs}{x}
foreach_funenv
  {v}{vt}{fe:eff}
  (pfv | xs, fwork, env) = let
//
val iter =
  iter_make<xs><x> (xs)
val () = iter_foreach_funenv (pfv | iter, fwork, env)
val () = iter_free<xs><x> (iter)
//
in
  (*nothing*)
end // end of [foreach_funenv]

(* ****** ****** *)
//
// HX: this one is based on [incable iter]
//
implement
{xs}{x}
exists_funenv
  {v}{vt}{fe:eff}
  (pfv | xs, pred, env) = let
//
stadef iter
  (f:int, r:int) = fiterator (xs, x, f, r)
//
val iter =
  iter_make<xs><x> (xs)
val res = iter_exists_funenv (pfv | iter, pred, env)
val () = iter_free<xs><x> (iter)
//
in
  res(*boolean*)
end // end of [exists_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer_iter.dats] *)
