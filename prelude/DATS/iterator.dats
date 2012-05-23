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
** HX: default implementation
*)

implement
{knd}{x}
iter_get (itr) =
  $UN.ptr_get<x> (iter_getref<knd><x> (itr))
// end of [iter_get]

implement
{knd}{x}
iter_get_inc (itr) =
  $UN.ptr_get<x> (iter_getref_inc<knd><x> (itr))
// end of [iter_get_inc]
implement
{knd}{x}
iter_get_dec (itr) =
  $UN.ptr_get<x> (iter_getref_dec<knd><x> (itr))
// end of [iter_get_dec]

implement
{knd}{x}
iter_getref_inc (itr) = let
  val p = iter_getref<knd><x> (itr) in iter_inc<knd><x> (itr); p
end // end of [iter_getref_inc]
implement
{knd}{x}
iter_getref_dec (itr) = let
  val p = iter_getref<knd><x> (itr) in iter_dec<knd><x> (itr); p
end // end of [iter_getref_dec]

implement
{knd}{x}
iter_fget_at (itr, x) =
  $UN.ptr_get<x> (iter_fgetref_at<knd><x> (itr, x))
// end of [iter_fget_inc]

implement
{knd}{x}
iter_fbget_at (itr, x) =
  $UN.ptr_get<x> (iter_fbgetref_at<knd><x> (itr, x))
// end of [iter_fbget_inc]

(* ****** ****** *)

implement
{knd}{x}
iter_foreach_funenv
  {kpm}{v}{vt}{f,r}{fe}
  (pfv | itr, fwork, env) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  pfv: !v
| itr: !iter (f, r) >> iter (f+r, 0)
, fwork: (!v | &x, !vt) -<fun,fe> void, env: !vt
) :<fe> void = let
  val isatend =
    iter_isnot_atend<knd><x> (itr)
in
  if isatend then let
    val p =
      iter_getref_inc<knd><x> (itr)
    prval (pf, fpf) = $UN.ptr_vget (p)
    val () = fwork (pfv | !p, env)
    prval () = fpf (pf)
  in
    loop (pfv | itr, fwork, env)
  end else ((*void*)) // end of [if]
end // end of [loop]
//
in
  loop (pfv | itr, fwork, env)
end // end of [iter_foreach_funenv]

(* ****** ****** *)

implement
{knd}{x}
iter_exists_funenv
  {kpm}{v}{vt}{f,r}{fe}
  (pfv | itr, pred, env) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  pfv: !v
| itr: !iter (f, r) >> iter (f1, r1)
, pred: (!v | &x, !vt) -<fun,fe> bool, env: !vt
) :<fe> #[
  f1,r1:int | f1>=f; f+r==f1+r1
] bool (r1 > 0)= let
  val hasnext = iter_isnot_atend<knd><x> (itr)
in
  if hasnext then let
    val p = iter_getref<knd><x> (itr)
    prval (pf, fpf) = $UN.ptr_vget (p)
    val found = pred (pfv | !p, env)
    prval () = fpf (pf)
  in
    if found then true else let
      val () = iter_inc (itr) in loop (pfv | itr, pred, env)
    end // end of [let] // end of [if]
  end else false // end of [if]
end // end of [loop]
//
in
  loop (pfv | itr, pred, env)
end // end of [iter_exists_funenv]

(* ****** ****** *)

implement
{knd}{x}
iter_bsearch_funenv
  {kpm}{vt} (
  itr, pord, env, ra
) = let
//
prval () = g1uint_param_lemma (ra)
prval () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:nat}
  {ra:nat | ra <= r} .<ra>. (
  itr: !iter (f, r) >> iter (f1, r1)
, pord: (&x, !vt) -<fun> int, env: !vt
, ra: size_t (ra)
) :<> #[
  f1,r1:int | f1>=f;f+ra>=f1;f+r==f1+r1
] void = (
  if ra > 0 then let
    val ra2 = half (ra)
    val p =
      iter_fgetref_at (itr, ra2)
    prval (pf, fpf) = $UN.ptr_vget (p)
    val sgn = pord (!p, env)
    prval () = fpf (pf)
  in
    if sgn <= 0 then
      loop (itr, pord, env, ra2)
    else let
      val ra21 = succ(ra2)
      val () = iter_fjmp (itr, ra21)
    in
      loop (itr, pord, env, ra-ra21)
    end // end of [if]
  end else () // end of [if]
) (* end of [loop] *)
//
in
  loop (itr, pord, env, ra)
end // end of [iter_bsearch_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [iterator.dats] *)
