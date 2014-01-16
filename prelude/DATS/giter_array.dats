(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
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

staload "prelude/SATS/giterator.sats"

(* ****** ****** *)

sortdef t0p = t@ype
stadef itrknd = giter_array_kind
stadef itrkpm = giter_array_param

(* ****** ****** *)

dataviewtype
iterk (
  a:viewt@ype+, l:addr, int(*f*), int(*r*)
) = {f,r:int}
  ITR (a, l, f, r) of (
    array_v (a, l, f+r) | ptr l(*beg*), ptr(*end*), ptr(*cur*)
  ) // end of [ITR]

(* ****** ****** *)

extern
castfn iterk2giter
  {x:vt0p}{l:addr}{n:int}
  (xs: iterk (x, l, 0, n)):<> giter (itrknd, itrkpm(l), x, 0, n)
// end of [iterk2giter]

extern
castfn giter2iterk
  {x:vt0p}{l:addr}{f,r:int}
  (itr: giter (itrknd, itrkpm(l), x, f, r)):<> iterk (x, l, f, r)
// end of [giter2iterk]

(* ****** ****** *)

implement{x}
giter_make_array (pf | p, n) =
  iterk2giter (ITR (pf | p, ptr0_add_guint<x> (p, n), p))
// end of [giter_make_array]

implement
giter_free_array (itr) = let
  val+ ~ITR (pf | _, _, _) = giter2iterk (itr) in (pf | ())
end // end of [giter_free_array]

(* ****** ****** *)

extern
praxi encode
  {kpm:tk}{x:vt0p}{l:addr}{f,r:int}
  (xs: !iterk (x, l, f, r) >> giter (itrknd, kpm, x, f, r)): void
// end of [encode]

extern
praxi decode
  {kpm:tk}{x:vt0p}{l:addr}{f,r:int}
  (itr: !giter (itrknd, kpm, x, f, r) >> iterk (x, l, f, r)): void
// end of [decode]

(* ****** ****** *)

implement(x)
giter_is_atbeg<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  val res = g1ofg0_bool (p_beg = pi)
  extern praxi __assert {b:bool} (b: bool b): [b==(f==0)] void
  prval () = __assert (res)
in
  res
end // end of [giter_is_atbeg]

implement(x)
giter_isnot_atbeg<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  extern castfn __cast {b:bool} (b: bool b):<> [b==(f>0)] bool (b)
in
  if p_beg < pi then __cast(true) else __cast(false)
end // end of [giter_isnot_atbeg]

(* ****** ****** *)

implement(x)
giter_is_atend<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  val res = g1ofg0_bool (pi = p_end)
  extern praxi __assert {b:bool} (b: bool b): [b==(r==0)] void
  prval () = __assert (res)
in
  res
end // end of [giter_is_atend]

implement(x)
giter_isnot_atend<itrknd><x>
  {kpm}{f,r} (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | p_beg, p_end, pi) = itr
  prval () = encode (itr)
  extern castfn __cast {b:bool} (b: bool b):<> [b==(r>0)] bool (b)
in
  if pi < p_end then __cast(true) else __cast(false)
end // end of [giter_isnot_atend]

(* ****** ****** *)

implement(x)
giter_getref<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ ITR (_ | _, _, pi) = itr
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (pi)
end // end of [giter_getref]

(* ****** ****** *)

implement(x)
giter_inc<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_succ<x> (rpi)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [giter_inc]

implement(x)
giter_dec<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_pred<x> (rpi)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [giter_dec]

(* ****** ****** *)

implement(x)
giter_getref_inc<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val pi = rpi
  val () = rpi := ptr0_succ<x> (pi)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (pi)
end // end of [giter_getref_inc]

implement(x)
giter_dec_getref<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val pi = ptr0_pred<x> (rpi)
  val () = rpi := pi
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (pi)
end // end of [giter_getref_dec]

(* ****** ****** *)

implement(x)
giter_fjmp<itrknd><x>
  (itr, i) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_add_guint<x> (rpi, i)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [giter_fjmp]

(* ****** ****** *)

implement(x)
giter_fgetref_at<itrknd><x>
  (itr, i) = let
  prval () = decode (itr)
  val+ ITR (_ | _, _, pi) = itr
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (ptr0_add_guint<x> (pi, i))
end // end of [giter_fgetref_at]

(* ****** ****** *)

implement(x)
giter_fbjmp<itrknd><x> (itr, i) = let
  prval () = decode (itr)
  val+ @ITR (_ | _, _, rpi) = itr
  val () = rpi := ptr0_add_gint<x> (rpi, i)
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [giter_fbjmp]

implement(x)
giter_fbgetref_at<itrknd><x>
  (itr, i) = let
  prval () = decode (itr)
  val+ ITR (_ | _, _, pi) = itr
  prval () = encode (itr)
in
  $UN.cast2Ptr1 (ptr0_add_gint<x> (pi, i))
end // end of [giter_fbget_at]

(* ****** ****** *)

(* end of [giter_array.dats] *)
