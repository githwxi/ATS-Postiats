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
// Start Time: May, 2012
//
(* ****** ****** *)
//
// HX-2012-05: for array-based iterators
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "prelude/SATS/iterator.sats"

(* ****** ****** *)

sortdef t0p = t@ype
stadef itrknd = iter_array_kind
stadef itrkpm = iter_array_param

(* ****** ****** *)

dataviewtype
iterk (
  a:t@ype+, l:addr, int(*f*), int(*r*)
) = {f,r:int}
  ITR (a, l, f, r) of (
    array_v (a, l, f+r) | ptr l(*beg*), ptr(*end*), ptr(*cur*)
  ) // end of [ITR]

(* ****** ****** *)

extern
castfn iterk2iter
  {x:t0p}{l:addr}{n:int}
  (xs: iterk (x, l, 0, n)):<> iterator (itrknd, itrkpm(l), x, 0, n)
// end of [iterk2iter]

extern
castfn iter2iterk
  {x:t0p}{l:addr}{f,r:int}
  (itr: iterator (itrknd, itrkpm(l), x, f, r)):<> iterk (x, l, f, r)
// end of [iter2iterk]

(* ****** ****** *)

implement{x}
iter_make_array (pf | p, n) =
  iterk2iter (ITR (pf | p, ptr0_add_guint<x> (p, n), p))
// end of [iter_make_array]

implement
iter_free_array (itr) = let
  val+ ~ITR (pf | _, _, _) = iter2iterk (itr) in (pf | ())
end // end of [iter_free_array]

(* ****** ****** *)

extern
praxi encode
  {kpm:tk}{x:t0p}{l:addr}{f,r:int}
  (xs: !iterk (x, l, f, r) >> iterator (itrknd, kpm, x, f, r)): void
// end of [encode]

extern
praxi decode
  {kpm:tk}{x:t0p}{l:addr}{f,r:int}
  (itr: !iterator (itrknd, kpm, x, f, r) >> iterk (x, l, f, r)): void
// end of [decode]

(* ****** ****** *)

implement(x)
iter_is_atbeg<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  val res = bool1_of_bool0 (p_beg = pi)
  extern praxi __assert {b:bool} (b: bool b): [b==(f==0)] void
  prval () = __assert (res)
in
  res
end // end of [iter_is_atbeg]

implement(x)
iter_isnot_atbeg<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  extern castfn __cast {b:bool} (b: bool b):<> [b==(f>0)] bool (b)
in
  if p_beg < pi then __cast(true) else __cast(false)
end // end of [iter_isnot_atbeg]

(* ****** ****** *)

implement(x)
iter_is_atend<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  val res = bool1_of_bool0 (pi = p_end)
  extern praxi __assert {b:bool} (b: bool b): [b==(r==0)] void
  prval () = __assert (res)
in
  res
end // end of [iter_is_atend]

implement(x)
iter_isnot_atend<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  extern castfn __cast {b:bool} (b: bool b):<> [b==(r>0)] bool (b)
in
  if pi < p_end then __cast(true) else __cast(false)
end // end of [iter_isnot_atend]

(* ****** ****** *)

implement(x)
iter_getref<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | _, _, pi) = itr
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (pi)
end // end of [iter_getref]

(* ****** ****** *)

implement(x)
iter_inc<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_succ<x> (rpi)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [iter_inc]

implement(x)
iter_dec<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_pred<x> (rpi)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [iter_dec]

(* ****** ****** *)

implement(x)
iter_getref_inc<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val pi = rpi
  val () = rpi := ptr0_succ<x> (pi)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (pi)
end // end of [iter_getref_inc]

implement(x)
iter_dec_getref<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val pi = ptr0_pred<x> (rpi)
  val () = rpi := pi
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (pi)
end // end of [iter_getref_dec]

(* ****** ****** *)

implement(x)
iter_fjmp<itrknd><x>
  (itr, i) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_add_guint<x> (rpi, i)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [iter_fjmp]

(* ****** ****** *)

implement(x)
iter_fgetref_at<itrknd><x>
  (itr, i) = let
  prval () = decode (itr)
  val+ ITR (_ | _, _, pi) = itr
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (ptr0_add_guint<x> (pi, i))
end // end of [iter_fgetref_at]

(* ****** ****** *)

implement(x)
iter_fbjmp<itrknd><x> (itr, i) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_add_gint<x> (rpi, i)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [iter_fbjmp]

implement(x)
iter_fbgetref_at<itrknd><x>
  (itr, i) = let
  prval () = decode (itr)
  val+ ITR (_ | _, _, pi) = itr
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (ptr0_add_gint<x> (pi, i))
end // end of [iter_fbget_at]

(* ****** ****** *)

(* end of [iterator_array.dats] *)
