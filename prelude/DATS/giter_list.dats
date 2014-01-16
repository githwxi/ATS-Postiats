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
// HX-2012-05-22:
// this code itself is not particularly useful; however, it sets a concrete
// example demonstrating how iterators can be created.
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "prelude/SATS/giterator.sats"

(* ****** ****** *)

sortdef t0p = t@ype
stadef itrknd = giter_list_kind
stadef itrkpm = giter_list_param

(* ****** ****** *)

dataviewtype
iterk (
  a:t@ype+, int(*f*), int(*r*)
) = {f,r:int} ITR (a, f, r) of list (a, r) // HX: [f] is spurious!

(* ****** ****** *)

extern
castfn iterk2giter
  {x:t0p}{n:int}
  (xs: iterk (x, 0, n)):<> giter (itrknd, itrkpm(), x, 0, n)
// end of [iterk2giter]

extern
castfn giter2iterk
  {x:t0p}{f,r:int}
  (itr: giter (itrknd, itrkpm(), x, f, r)):<> iterk (x, f, r)
// end of [giter2iterk]

(* ****** ****** *)

implement{x}
giter_make_list
  (xs) = iterk2giter (ITR (xs))
implement
giter_free_list (itr) = let
  val+ ~ITR (xs) = giter2iterk (itr) in xs
end // end of [giter_free_list]

(* ****** ****** *)

extern
praxi encode
  {kpm:tk}{x:t0p}{f,r:int}
  (xs: !iterk (x, f, r) >> giter (itrknd, kpm, x, f, r)): void
// end of [encode]

extern
praxi decode
  {kpm:tk}{x:t0p}{f,r:int}
  (itr: !giter (itrknd, kpm, x, f, r) >> iterk (x, f, r)): void
// end of [decode]

(* ****** ****** *)

implement(x:t0p)
giter_is_atend<itrknd><x>
  (itr) = let
  prval () = decode (itr)
  val+ ITR (xs) = itr
  prval () = encode (itr)
in
  list_is_nil (xs)
end // end of [giter_is_atend]

(* ****** ****** *)

implement(x:t0p)
giter_vttake<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ ITR (xs) = itr; val+ list_cons (x, _) = xs
  prval () = encode (itr)
  var x = x
in
  $UN.vttakeout_void (x)
end // end of [giter_vttake]

(* ****** ****** *)

implement(x:t0p)
giter_inc<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (xs) = itr; val+ list_cons (_, xs1) = xs; val () = xs := xs1
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [giter_inc]

(* ****** ****** *)

implement(x:t0p)
giter_vttake_inc<itrknd><x> (itr) = let
  prval () = decode (itr)
  val+ @ITR (xs) = itr; val+ list_cons (x, xs1) = xs; val () = xs := xs1
  prval () = fold@ (itr)
  prval () = encode (itr)
  var x = x
in
  $UN.vttakeout_void (x)
end // end of [giter_vttake_inc]

(* ****** ****** *)

(* end of [giter_list.dats] *)
