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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

(*
staload "prelude/SATS/fiterator.sats" // HX: preloaded
*)

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)

dataviewtype
listptr (
  a:t@ype+, int(*f*), int(*r*)
) = {f,r:int} PTR (a, f, r) of list (a, r) // HX: [f] is spurious!

(* ****** ****** *)

extern
praxi encode
  {x:t0p}{f,r:int}
  (xs: !listptr (x, f, r) >> fiterator (list0(x), x, f, r)): void
// end of [listp2iter]

extern
praxi decode
  {x:t0p}{f,r:int}
  (itr: !fiterator (list0(x), x, f, r) >> listptr (x, f, r)): void
// end of [decode]

(* ****** ****** *)

extern
castfn listp2iter
  {x:t0p}{n:int}
  (xs: listptr (x, 0, n)):<> fiterator (list0(x), x, 0, n)
// end of [listp2iter]

extern
castfn iter2listp
  {x:t0p}{f,r:int}
  (itr: fiterator (list0(x), x, f, r)):<> listptr (x, f, r)
// end of [iter2listp]

(* ****** ****** *)

implement(x)
iter_make_list<x> (xs) = listp2iter (PTR (xs))

(* ****** ****** *)

implement(x)
iter_make<list0(x)><x> (xs) = let
  val xs = list_of_list0 (xs) in listp2iter (PTR (xs))
end // end of [iter_make]

implement(x)
iter_free<list0(x)><x> (itr) = let
  val+ ~PTR (xs) = iter2listp (itr) in (*nothing*)
end // end of [iter_free]

(* ****** ****** *)

implement(x)
iter_get<list0(x)><x> (itr) = let
  prval () = decode (itr)
  val+ @PTR (xs) = itr; val+ list_cons (x, _) = xs
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  x
end // end of [iter_get]

(* ****** ****** *)

implement(x)
iter_getinc<list0(x)><x> (itr) = let
  prval () = decode (itr)
  val+ @PTR (xs) = itr; val+ list_cons (x, xs1) = xs; val () = xs := xs1
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  x
end // end of [iter_getinc]

(* ****** ****** *)

implement(x)
iter_inc<list0(x)><x> (itr) = let
  prval () = decode (itr)
  val+ @PTR (xs) = itr; val+ list_cons (_, xs1) = xs; val () = xs := xs1
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [iter_inc]

(* ****** ****** *)

(* end of [fiterator_list.dats] *)
