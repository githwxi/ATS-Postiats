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
#print "Loading [iterator.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "prelude/SATS/iterator.sats"

(* ****** ****** *)

implement
{knd}{x}
fprint_iterator_sep
  {kpm}{f,r}
  (out, itr, sep) = let
//
val () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  out: FILEref
, itr: !iter (f, r) >> iter (f+r, 0)
, sep: string
, notbeg: bool
) : void = let
  val test = iter_isnot_atend (itr)
in
  if test then let
    val (fpf | x) = iter_vttake_inc (itr)
    val () = if notbeg then fprint_string (out, sep)
    val () = fprint_val<x> (out, x)
    prval () = fpf (x)
  in
    loop (out, itr, sep, true)
  end else ()
end // end of [loop]
//
in
  loop (out, itr, sep, false(*notbeg*))
end // end of [fprint_iterator_sep]

(* ****** ****** *)

implement
{knd}{x}
iter_isnot_atbeg (itr) = let
  prval () = lemma_iterator_param (itr) in ~iter_is_atbeg (itr)
end // end of [iter_isnot_atbeg]

implement
{knd}{x}
iter_isnot_atend (itr) = let
  prval () = lemma_iterator_param (itr) in ~iter_is_atend (itr)
end // end of [iter_isnot_atend]

(* ****** ****** *)

implement
{knd}{x}
iter_vttake (itr) = let
  val p =
    iter_getref<knd><x> (itr)
  prval (
    pf, fpf
  ) = $UN.ptr_vtake {x} (p)
  val res = $UN.vttakeout_void {x} (!p)
  prval () = fpf (pf)
in
  res
end // end of [iter_vttake]

implement
{knd}{x}
iter_get (itr) = x where {
  val (fpf | x) = iter_vttake<knd><x> (itr); prval () = fpf (x)
} // end of [iter_get]

implement
{knd}{x}
iter_set (itr, x) =
  $UN.ptr_set<x> (iter_getref<knd><x> (itr), x)
// end of [iter_set]

(* ****** ****** *)

implement
{knd}{x}
iter_getref_inc (itr) = let
  val p = iter_getref<knd><x> (itr) in iter_inc<knd><x> (itr); p
end // end of [iter_getref_inc]

implement
{knd}{x}
iter_vttake_inc (itr) = let
  val p =
    iter_getref_inc<knd><x> (itr)
  prval (
    pf, fpf
  ) = $UN.ptr_vtake {x} (p)
  val res = $UN.vttakeout_void {x} (!p)
  prval () = fpf (pf)
in
  res
end // end of [iter_vttake_inc]

implement
{knd}{x}
iter_get_inc
  (itr) = x where {
  val (fpf | x) =
    iter_vttake_inc<knd><x> (itr)
  prval () = fpf (x)
} // end of [iter_get_inc]
implement
{knd}{x}
iter_set_inc (itr, x) =
  $UN.ptr_set<x> (iter_getref_inc<knd><x> (itr), x)
// end of [iter_set_inc]
implement
{knd}{x}
iter_exch_inc (itr, x) =
  $UN.ptr_exch<x> (iter_getref_inc<knd><x> (itr), x)
// end of [iter_exch_inc]

(* ****** ****** *)

implement
{knd}{x}
iter_dec_getref (itr) = let
  prval () =
    lemma_iterator_param (itr)
  val () = iter_dec<knd><x> (itr)
in
  iter_getref<knd><x> (itr)
end // end of [iter_dec_getref]

implement
{knd}{x}
iter_dec_vttake (itr) = let
  val p =
    iter_dec_getref<knd><x> (itr)
  prval (
    pf, fpf
  ) = $UN.ptr_vtake {x} (p)
  val res = $UN.vttakeout_void {x} (!p)
  prval () = fpf (pf)
in
  res
end // end of [iter_dec_vttake]

implement
{knd}{x}
iter_dec_get
  (itr) = x where {
  val (fpf | x) =
    iter_dec_vttake<knd><x> (itr)
  prval () = fpf (x)
} // end of [iter_dec_get]
implement
{knd}{x}
iter_dec_set (itr, x) =
  $UN.ptr_set<x> (iter_dec_getref<knd><x> (itr), x)
// end of [iter_dec_set]
implement
{knd}{x}
iter_dec_exch (itr, x) =
  $UN.ptr_exch<x> (iter_dec_getref<knd><x> (itr), x)
// end of [iter_dec_exch]

(* ****** ****** *)
(*
** HX: forward-get, set and exchange
*)
implement
{knd}{x}
iter_fget_at (itr, i) =
  $UN.ptr_get<x> (iter_fgetref_at<knd><x> (itr, i))
// end of [iter_fget_at]
implement
{knd}{x}
iter_fset_at (itr, i, x) =
  $UN.ptr_set<x> (iter_fgetref_at<knd><x> (itr, i), x)
// end of [iter_fset_at]
implement
{knd}{x}
iter_fexch_at (itr, i, x) =
  $UN.ptr_exch<x> (iter_fgetref_at<knd><x> (itr, i), x)
// end of [iter_fexch_at]

(* ****** ****** *)
(*
** HX: forward/backward-get, set and exchange
*)
implement
{knd}{x}
iter_fbget_at (itr, i) =
  $UN.ptr_get<x> (iter_fbgetref_at<knd><x> (itr, i))
// end of [iter_fbget_at]
implement
{knd}{x}
iter_fbset_at (itr, i, x) =
  $UN.ptr_set<x> (iter_fbgetref_at<knd><x> (itr, i), x)
// end of [iter_fbset_at]
implement
{knd}{x}
iter_fbexch_at (itr, i, x) =
  $UN.ptr_exch<x> (iter_fbgetref_at<knd><x> (itr, i), x)
// end of [iter_fbexch_at]

(* ****** ****** *)

implement
{knd}{x}
iter_fgetlst {kpm} (itr, i) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} {i:nat} .<r>. (
  itr: !iter (f, r) >> iter (f+i1, r-i1)
, i: &int(i) >> int(i-i1)
, res: &ptr? >> list_vt (x, i1)
) : #[i1:int | i1 == min(i,r)] void = let
in
//
if i > 0 then let
  val test = iter_isnot_atend (itr)
in
  if test then let
    val () = i := i - 1
    val x = iter_get_inc (itr)
    val () = res :=
      list_vt_cons {x}{0} (x, _)
    val+ list_vt_cons (x, res1) = res
    val () = loop (itr, i, res1)
    prval () = fold@ (res)
  in
    // nothing
  end else (res := list_vt_nil)
end else (res := list_vt_nil) // endif
//
end // end of [loop]
//
var res: ptr
val () = loop (itr, i, res)
//
in
  res
end // end of [iter_fgetlst]

(* ****** ****** *)

implement
{knd}{x}
iter_bgetlst {kpm} (itr, i) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | f >= 0} {i:nat} .<f>. (
  itr: !iter (f, r) >> iter (f-i1, r+i1)
, i: &int(i) >> int(i-i1)
, res: &ptr? >> list_vt (x, i1)
) : #[i1:int | i1 == min(i,f)] void = let
in
//
if i > 0 then let
  val test = iter_isnot_atbeg (itr)
in
  if test then let
    val () = i := i - 1
    val x = iter_dec_get (itr)
    val () = res :=
      list_vt_cons {x}{0} (x, _)
    val+ list_vt_cons (x, res1) = res
    val () = loop (itr, i, res1)
    prval () = fold@ (res)
  in
    // nothing
  end else (res := list_vt_nil)
end else (res := list_vt_nil) // endif
//
end // end of [loop]
//
var res: ptr
val () = loop (itr, i, res)
//
in
  res
end // end of [iter_bgetlst]

(* ****** ****** *)

implement
{knd}{x}
iter_ins_inc (itr, x) = let
  prval () = lemma_iterator_param (itr)
  val () = iter_ins (itr, x) in iter_inc (itr)
end // end of [iter_ins_inc]

implement
{knd}{x}
iter_dec_rmv (itr) = let
  prval () = lemma_iterator_param (itr)
  val () = iter_dec (itr) in iter_rmv (itr)
end // end of [iter_dec_rmv]

(* ****** ****** *)
//
// HX: some common generic functions on iterators
//
(* ****** ****** *)

implement
{knd}{x}
iter_listize_cpy {kpm} (itr) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  itr: !iter (f, r) >> iter (f+r, 0), res: &ptr? >> list_vt (x, r)
) : void = let
  val test = iter_isnot_atend (itr)
in
  if test then let
    val x = iter_get_inc (itr)
    val () = res :=
      list_vt_cons {x}{0} (x, _)
    val+ list_vt_cons (x, res1) = res
    val () = loop (itr, res1)
    prval () = fold@ (res)
  in
    // nothing
  end else (res := list_vt_nil)
end // end of [loop]
//
var res: ptr
val () = loop (itr, res)
//
in
  res
end // end of [iter_listize_cpy]

implement
{knd}{x}
iter_rlistize_cpy
  {kpm} (itr) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0}{r2:nat} .<r>. (
  itr: !iter (f, r) >> iter (f+r, 0), res: list_vt (x, r2)
) : list_vt (x, r+r2) = let
  val test = iter_isnot_atend (itr)
in
  if test then let
    val x = iter_get_inc (itr)
  in
    loop (itr, list_vt_cons (x, res))
  end else res // end of [if]
end // end of [loop]
//
in
  loop (itr, list_vt_nil)
end // end of [iter_listize_cpy]

(* ****** ****** *)

implement
{knd}{x}
iter_foreach (itr) = let
  var env: void = () in iter_foreach_env<knd><x><void> (itr, env)
end // end of [iter_foreach]

implement
{knd}{x}{env}
iter_foreach_env
  {kpm}{f,r} (itr, env) = let
//
prval () = lemma_iterator_param (itr)
//
stadef iter (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  itr: !iter (f, r) >> iter (f1, r1), env: &env
) : #[f1,r1:int | f <= f1 | f+r==f1+r1] void = let
  val isnotend =
    iter_isnot_atend<knd><x> (itr) 
  // end of [val]
in
  if isnotend then let
    val p =
      iter_getref_inc<knd><x> (itr)
    prval (pf, fpf) = $UN.ptr_vtake (p)
    val cont = iter_foreach__cont (!p, env)
  in
    if cont then let
      val () = iter_foreach__fwork (!p, env)
      prval () = fpf (pf)
    in
      loop (itr, env)
    end else let
      prval () = fpf (pf)
    in
      (*nothing*)
    end // end of [if]
  end else ((*void*)) // end of [if]
end // end of [loop]
//
in
  loop (itr, env)
end // end of [iter_foreach_env]

(* ****** ****** *)
(*
** HX-2012-05-23:
** this is a very exiciting example for myself :)
*)
implement
{knd}{x}
iter_bsearch
  {kpm} (itr, ra) = let
//
prval () = lemma_g1uint_param (ra)
prval () = lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:nat}
  {ra:nat | ra <= r} .<ra>. (
  itr: !iter (f, r) >> iter (f1, r1)
, ra: size_t (ra)
) : #[
  f1,r1:int | f1>=f;f+ra>=f1;f+r==f1+r1
] void = (
  if ra > 0 then let
    val ra2 = half (ra)
    val p =
      iter_fgetref_at (itr, ra2)
    prval
      (pf, fpf) = $UN.ptr_vtake (p)
    val sgn = iter_bsearch__ford (!p)
    prval () = fpf (pf)
  in
    if sgn <= 0 then
      loop (itr, ra2)
    else let
      val ra21 = succ(ra2)
      val () = iter_fjmp (itr, ra21)
    in
      loop (itr, ra-ra21)
    end // end of [if]
  end else () // end of [if]
) (* end of [loop] *)
//
in
  loop (itr, ra)
end // end of [iter_bsearch]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [iterator.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [iterator.dats] *)
