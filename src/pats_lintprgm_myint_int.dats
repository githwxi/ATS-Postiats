(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Anairiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: February 2012
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload "pats_lintprgm.sats"

(* ****** ****** *)

extern castfn myint2int (x: !myint(int)):<> int
extern castfn int2myint (x: int):<> myint(int)
macdef i2mi = int2myint
macdef mi2i = myint2int

(* ****** ****** *)

extern
praxi myint_int_free (x: myint(int)): void
extern
castfn myint_int_copy (x: !myint(int)):<> myint(int)

(* ****** ****** *)

implement
myint_free<int> (x) = let
  prval () = myint_int_free (x) in (*nothing*)
end // end of [myint_free]

implement myint_copy<int> (x) = myint_int_copy (x)

(* ****** ****** *)

implement
add_myint_myint<int>
  (x, y) = i2mi(res) where {
  val res = (mi2i)x + (mi2i)y
  prval () = myint_int_free (x)
} // end of [add_myint_myint<int>]

implement
sub_myint_myint<int>
  (x, y) = (i2mi)res where {
  val res = (mi2i)x - (mi2i)y
  prval () = myint_int_free (x)
} // end of [sub_myint_myint<int>]

(* ****** ****** *)

implement
div_myint_myint<int>
  (x, y) = (i2mi)res where {
  val res = (mi2i)x / (mi2i)y
  prval () = myint_int_free (x)
} // end of [div_myint_myint<int>]

implement
ediv_myint_myint<int>
  (x, y) = (i2mi)res where {
  val res = (mi2i)x / (mi2i)y
  prval () = myint_int_free (x)
} // end of [ediv_myint_myint<int>]

(* ****** ****** *)

implement
mul1_myint_myint<int> (x, y) = i2mi((mi2i)x * (mi2i)y)
implement
div1_myint_myint<int> (x, y) = i2mi((mi2i)x / (mi2i)y)
implement
mod1_myint_myint<int> (x, y) = i2mi((mi2i)x mod (mi2i)y)

(* ****** ****** *)

implement
mod_myint_myint<int>
  (x, y) = (i2mi)res where {
  val res = op mod ((mi2i)x, (mi2i)y)
  prval () = myint_int_free (x)
} // end of [mod_myint_myint<int>]

implement
gcd_myint_myint<int>
  (x, y) = (i2mi)res where {
  val res = op gcd ((mi2i)x, (mi2i)y)
  prval () = myint_int_free (x)
} // end of [gcd_myint_myint<int>]

(* ****** ****** *)

implement lt_myint_int<int> (x, y) = (mi2i)x < y
implement lte_myint_int<int> (x, y) = (mi2i)x <= y
implement gt_myint_int<int> (x, y) = (mi2i)x > y
implement gte_myint_int<int> (x, y) = (mi2i)x >= y
implement eq_myint_int<int> (x, y) = (mi2i)x = y
implement neq_myint_int<int> (x, y) = (mi2i)x != y

implement lt_myint_myint<int> (x, y) = ((mi2i)x < (mi2i)y)
implement lte_myint_myint<int> (x, y) = ((mi2i)x <= (mi2i)y)
implement gt_myint_myint<int> (x, y) = ((mi2i)x > (mi2i)y)
implement gte_myint_myint<int> (x, y) = ((mi2i)x >= (mi2i)y)

(* ****** ****** *)

implement
myintvec_free<int>
  {n} (xs, n) = let
//
// HX: myint(int) is actually a  type
//
  viewtypedef vt = myint(int)
  val (pfgc, pf | p) = __cast (xs) where {
    extern castfn __cast
      (x: myintvec (int, n))
      :<> [l:addr] (free_gc_v (vt?, n, l), array_v(vt?, n, l) | ptr l)
  } // end of [val]
in
  array_ptr_free (pfgc, pf | p)
end // end of [myintvec_free]

(* ****** ****** *)

(* end of [pats_lintprgm_myint_int.dats] *)
