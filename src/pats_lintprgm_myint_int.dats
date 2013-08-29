(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmhwxi AT gmail DOT com
// Time: February 2012
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

%{^
#include "pats_lintprgm_myint.cats"
%} // end of [%{^]

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_lintprgm.sats"

(* ****** ****** *)

viewtypedef myint = myint(intknd)

extern castfn myint2int0 (x: myint):<> int
//
// HX: it is okay to use a castfn here as [myint] contains
extern castfn myint2int1 (x: !myint):<> int // no resources
//
extern castfn int2myint (x: int):<> myint
//
macdef i2mi = int2myint
macdef mi2i0 = myint2int0
macdef mi2i1 = myint2int1

(* ****** ****** *)

extern
praxi myint_int_free (x: myint): void
extern
castfn myint_int_copy (x: !myint):<> myint

(* ****** ****** *)

implement
myint_make_int<intknd> (x) = int2myint (x)

implement
myint_make_intinf<intknd> (x) = let
  val x = $INTINF.intinf_get_int (x) in int2myint (x)
end // end of [myint_make_intinf<int>]

(* ****** ****** *)

implement
myint_free<intknd> (x) = let
  prval () = myint_int_free (x) in (*nothing*)
end // end of [myint_free]

implement myint_copy<intknd> (x) = myint_int_copy (x)

(* ****** ****** *)

implement
neg_myint<intknd> (x) = i2mi(~(mi2i0)x)
implement
neg1_myint<intknd> (x) = i2mi(~(mi2i1)x)

(* ****** ****** *)

implement
add_myint_int<intknd> (x, i) = i2mi((mi2i0)x + i)

(* ****** ****** *)

implement
add01_myint_myint<intknd>
  (x, y) = i2mi(res) where {
  val res = (mi2i0)x + (mi2i1)y
} // end of [add_myint_myint<intknd>]

implement
sub01_myint_myint<intknd>
  (x, y) = (i2mi)res where {
  val res = (mi2i0)x - (mi2i1)y
} // end of [sub_myint_myint<intknd>]

(* ****** ****** *)

implement
mul01_myint_myint<intknd> (x, y) = i2mi((mi2i0)x * (mi2i1)y)
implement
mul10_myint_myint<intknd> (x, y) = i2mi((mi2i1)x * (mi2i0)y)
implement
mul11_myint_myint<intknd> (x, y) = i2mi((mi2i1)x * (mi2i1)y)

(* ****** ****** *)

implement
div01_myint_myint<intknd>
  (x, y) = (i2mi)res where {
  val res = (mi2i0)x / (mi2i1)y
} // end of [div01_myint_myint<intknd>]

implement
div11_myint_myint<intknd> (x, y) = i2mi((mi2i1)x / (mi2i1)y)

implement
ediv01_myint_myint<intknd>
  (x, y) = (i2mi)res where {
  val res = (mi2i0)x / (mi2i1)y
} // end of [ediv_myint_myint<intknd>]

(* ****** ****** *)

implement
mod01_myint_myint<intknd>
  (x, y) = (i2mi)res where {
  val res = op mod ((mi2i0)x, (mi2i1)y)
} // end of [mod01_myint_myint<intknd>]

implement
mod11_myint_myint<intknd> (x, y) = i2mi((mi2i1)x mod (mi2i1)y)

(* ****** ****** *)

implement
gcd01_myint_myint<intknd>
  (x, y) = (i2mi)res where {
  val res = op gcd ((mi2i0)x, (mi2i1)y)
} // end of [gcd_myint_myint<intknd>]

(* ****** ****** *)

implement lt_myint_int<intknd> (x, y) = (mi2i1)x < y
implement lte_myint_int<intknd> (x, y) = (mi2i1)x <= y
implement gt_myint_int<intknd> (x, y) = (mi2i1)x > y
implement gte_myint_int<intknd> (x, y) = (mi2i1)x >= y
implement eq_myint_int<intknd> (x, y) = (mi2i1)x = y
implement neq_myint_int<intknd> (x, y) = (mi2i1)x != y
implement
compare_myint_int<intknd> (x, y) = compare ((mi2i1)x, y)

(* ****** ****** *)

implement lt_myint_myint<intknd> (x, y) = ((mi2i1)x < (mi2i1)y)
implement lte_myint_myint<intknd> (x, y) = ((mi2i1)x <= (mi2i1)y)
implement gt_myint_myint<intknd> (x, y) = ((mi2i1)x > (mi2i1)y)
implement gte_myint_myint<intknd> (x, y) = ((mi2i1)x >= (mi2i1)y)

(* ****** ****** *)

implement
fprint_myint<intknd> (out, x) = fprint_int (out, mi2i1(x))

(* ****** ****** *)

implement
myintvec_free<intknd>
  {n} (xs, n) = let
//
// HX: myint(int) is actually a type
//
  viewtypedef vt = myint
  val (pfgc, pf | p) = __cast (xs) where {
    extern castfn __cast
      (x: myintvec (intknd, n))
      :<> [l:addr] (free_gc_v (vt?, n, l), array_v(vt?, n, l) | ptr l)
  } // end of [val]
in
  array_ptr_free (pfgc, pf | p)
end // end of [myintvec_free]

(* ****** ****** *)

(* end of [pats_lintprgm_myint_int.dats] *)
