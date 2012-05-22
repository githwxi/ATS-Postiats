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

implement
{xs}{x}
iter_foreach_funenv
  {v}{vt}{f,r}{fe}
  (pfv | iter, fwork, env) = let
//
prval () = lemma_iterator_param (iter)
//
stadef iter
  (f:int, r:int) = fiterator (xs, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  pfv: !v
| iter: !iter (f, r) >> iter (f+r, 0)
, fwork: (!v | x, !vt) -<fun,fe> void, env: !vt
) :<fe> void =
  if iter_isnot_atend<xs><x> (iter) then let
    val x = iter_getinc_at<xs><x> (iter); val () = fwork (pfv | x, env)
  in
    loop (pfv | iter, fwork, env)
  end // end of [if]
// end of [loop]
//
in
  loop (pfv | iter, fwork, env)
end // end of [iter_foreach_funenv]

(* ****** ****** *)

implement
{xs}{x}
iter_exists_funenv
  {v}{vt}{f,r}{fe}
  (pfv | iter, pred, env) = let
//
prval () = lemma_iterator_param (iter)
//
stadef iter
  (f:int, r:int) = fiterator (xs, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  pfv: !v
| iter: !iter (f, r) >> iter (f1, r1)
, pred: (!v | x, !vt) -<fun,fe> bool, env: !vt
) :<fe> #[
  f1,r1:int | f1>=f; f+r==f1+r1
] bool (r1 > 0)= let
  val hasnext = iter_isnot_atend<xs><x> (iter)
in
  if hasnext then let
    val x = iter_get_at<xs><x> (iter)
  in
    if pred (pfv | x, env) then true else let
      val () = iter_inc (iter) in loop (pfv | iter, pred, env)
    end // end of [if]
  end else false // end of [if]
end // end of [loop]
//
in
  loop (pfv | iter, pred, env)
end // end of [iter_exists_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fiterator.dats] *)
