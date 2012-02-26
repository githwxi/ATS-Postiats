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
//
// HX: this one is based on [incable iter]
//
implement{xs}{x}
foreach_funenv
  {v}{vt}{fe:eff}
  (pfv | xs, f, env) = let
//
stadef iter (f:int, r:int) = fiterator (xs, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  pfv: !v
| iter: &iter (f, r) >> iter (f+r, 0)
, f: (!v | x, !vt) -<fun,fe> void, env: !vt
) :<fe> void =
  if iter_isnot_atend<xs><x> (iter) then let
    val x = iter_getinc_at<xs><x> (iter); val () = f (pfv | x, env)
  in
    loop (pfv | iter, f, env)
  end // end of [if]
// end of [loop]
var iter = iter_make<xs><x> (xs)
val () = loop (pfv | iter, f, env)
val () = iter_free<xs><x> (iter)
//
in
  (*nothing*)
end // end of [foreach_funenv]

(* ****** ****** *)
//
// HX: this one is based on [incable iter]
//
implement{xs}{x}
exists_funenv
  {v}{vt}{fe:eff}
  (pfv | xs, f, env) = let
//
stadef iter (f:int, r:int) = fiterator (xs, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  pfv: !v
| iter: &iter (f, r) >> iter (f1, r1)
, p: (!v | x, !vt) -<fun,fe> bool, env: !vt
) :<fe> #[
  f1,r1:int | f+r==f1+r1
] bool = let
  val hasnext = iter_isnot_atend<xs><x> (iter)
in
  if hasnext then let
    val x = iter_getinc_at<xs><x> (iter) in
    if p (pfv | x, env) then true else loop (pfv | iter, f, env)
  end else false // end of [if]
end // end of [loop]
//
var itr = iter_make<xs><x> (xs)
val res = loop (pfv | itr, f, env)
val () = iter_free<xs><x> (itr)
//
in
  res(*boolean*)
end // end of [exists_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer_iter.sats] *)
