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

staload "libc/SATS/gmp.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"

(* ****** ****** *)

viewtypedef
lintinf (l:addr) = //
  (free_gc_v (mpz_vt?, l), mpz_vt @ l | ptr l)
viewtypedef lintinf = [l:addr] lintinf (l)

(* ****** ****** *)

staload "./pats_lintprgm.sats"

(* ****** ****** *)

viewtypedef myint = myint (intinfknd)

extern castfn myint2int (x: myint):<> lintinf
macdef mi2i = myint2int
extern castfn int2myint (x: lintinf):<> myint
macdef i2mi = int2myint

extern praxi myintenc (x: !lintinf >> myint): void
macdef mienc = myintenc
extern praxi myintdec (x: !myint >> lintinf): void
macdef midec = myintdec

(* ****** ****** *)

implement
fprint_myint<intinfknd>
  (out, x) = let
  prval () = midec (x)
  prval pfat_x = x.1  
  val () = fprint0_mpz (out, !(x.2))
  prval () = x.1 := pfat_x
  prval () = mienc (x)
in
  (*nothing*)
end // end of [fprint_myint<intinfknd>]

(* ****** ****** *)

implement
myint_make_int<intinfknd> (i) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  val () = mpz_init_set_int (!p, i)
in
  int2myint @(pfgc, pfat | p)
end // end of [intinf_make_int]

implement
myint_make_intinf<intinfknd> (i) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  val (pf, fpf | p_i) = $INTINF.intinf_takeout_mpz (i)
  val () = mpz_init_set_mpz (!p, !p_i)
  prval () = fpf (pf)
in
  int2myint @(pfgc, pfat | p)
end // end of [intinf_make_int]

(* ****** ****** *)

implement
myint_copy<intinfknd> (x) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = midec (x)
  prval pfat_x = x.1  
  val () = mpz_init_set_mpz (!p, !(x.2))
  prval () = x.1 := pfat_x
  prval () = mienc (x)
in
  i2mi @(pfgc, pfat | p)
end // end of [myint_copy<intinfknd>]

(* ****** ****** *)

implement
myint_free<intinfknd> (x) = let
  val x = mi2i (x)
  prval pfat_x = x.1
  val () = mpz_clear (!(x.2))
in
  ptr_free {mpz_vt?} (x.0, pfat_x | x.2)
end // end of [myint_free<intinfknd>]

(* ****** ****** *)

implement
neg_myint<intinfknd>
  (x) = i2mi(x) where {
  val x = mi2i (x)
  prval pfat_x = x.1
  val () = mpz_neg (!(x.2))
  prval () = x.1 := pfat_x
} // end of [neg_myint<intinfknd>]

(* ****** ****** *)

implement
neg1_myint<intinfknd>
  (x) = i2mi @(pfgc, pfat | p) where {
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  val () = mpz_init (!p)
  prval () = midec (x)
  prval pfat_x = x.1
  val () = mpz_neg (!p, !(x.2))
  prval () = x.1 := pfat_x
  prval () = mienc (x)
} // end of [neg1_myint<intinfknd>]

(* ****** ****** *)

implement
add01_myint_myint<intinfknd>
  (x, y) = i2mi(x) where {
  val x = mi2i (x); prval () = midec (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_add2_mpz (!(x.2), !(y.2))
  prval () = x.1 := pfat_x; prval () = y.1 := pfat_y
  prval () = mienc (y)
} // end of [add_myint_myint<intinfknd>]

(* ****** ****** *)

implement
sub01_myint_myint<intinfknd>
  (x, y) = i2mi(x) where {
  val x = mi2i (x); prval () = midec (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_sub2_mpz (!(x.2), !(y.2))
  prval () = x.1 := pfat_x; prval () = y.1 := pfat_y
  prval () = mienc (y)
} // end of [sub_myint_myint<intinfknd>]

(* ****** ****** *)

implement
add_myint_int<intinfknd>
  (x, i) = i2mi(x) where {
  val x = mi2i (x)
  prval pfat_x = x.1
  val () = mpz_add2_int (!(x.2), i)
  prval () = x.1 := pfat_x
} // end of [add_myint_int<intinfknd>]

(* ****** ****** *)

implement
mul01_myint_myint<intinfknd>
  (x, y) = i2mi(x) where {
  val x = mi2i (x); prval () = midec (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_mul2_mpz (!(x.2), !(y.2))
  prval () = x.1 := pfat_x
  prval () = y.1 := pfat_y
  prval () = mienc (y)
} // end of [mul01_myint_myint<intinfknd>]

implement
mul10_myint_myint<intinfknd>
  (x, y) = i2mi(y) where {
  prval () = midec (x); val y = mi2i (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val [l:addr] (
    pf_y, fpf_y | p_y
  ) = __cast (y.2) where {
    extern castfn __cast (p: ptr)
      :<> [l:addr] (mpz_vt@l, mpz_vt@l -<lin,prf> void | ptr l)
    // end of [extern]
  } // end of [val]
  val () = mpz_mul3_mpz (!(y.2), !(x.2), !p_y)
  prval () = fpf_y (pf_y)
  prval () = x.1 := pfat_x
  prval () = mienc (x)
  prval () = y.1 := pfat_y
} // end of [mul10_myint_myint<intinfknd>]

implement
mul11_myint_myint<intinfknd>
  (x, y) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  val () = mpz_init (!p)
  prval () = midec (x) and () = midec (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_mul3_mpz (!p, !(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = mienc (x) and () = mienc (y)
in
  i2mi @(pfgc, pfat | p)
end // end of [mul11_myint_myint<intinfknd>]

(* ****** ****** *)

implement
div01_myint_myint<intinfknd>
  (x, y) = i2mi (x) where {
  val x = mi2i (x); prval () = midec (y)
  val [l:addr] (
    pf_x, fpf_x | p_x
  ) = __cast (x.2) where {
    extern castfn __cast (p: ptr)
      :<> [l:addr] (mpz_vt@l, mpz_vt@l -<lin,prf> void | ptr l)
    // end of [extern]
  } // end of [val]
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_tdiv3_q_mpz (!p_x, !(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = fpf_x (pf_x)
  prval () = mienc (y)
} // end of [div01_myint_myint<intinfknd>]

(* ****** ****** *)

implement
ediv01_myint_myint<intinfknd>
  (x, y) = i2mi (x) where {
  val x = mi2i (x); prval () = midec (y)
  val [l:addr] (
    pf_x, fpf_x | p_x
  ) = __cast (x.2) where {
    extern castfn __cast (p: ptr)
      :<> [l:addr] (mpz_vt@l, mpz_vt@l -<lin,prf> void | ptr l)
    // end of [extern]
  } // end of [val]
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_divexact3 (!p_x, !(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = fpf_x (pf_x)
  prval () = mienc (y)
} // end of [ediv01_myint_myint<intinfknd>]

(* ****** ****** *)

implement
mod01_myint_myint<intinfknd>
  (x, y) = i2mi (x) where {
  val x = mi2i (x); prval () = midec (y)
  val [l:addr] (
    pf_x, fpf_x | p_x
  ) = __cast (x.2) where {
    extern castfn __cast (p: ptr)
      :<> [l:addr] (mpz_vt@l, mpz_vt@l -<lin,prf> void | ptr l)
    // end of [extern]
  } // end of [val]
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_mod3_mpz (!p_x, !(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = fpf_x (pf_x)
  prval () = mienc (y)
} // end of [mod01_myint_myint<intinfknd>]

implement
mod11_myint_myint<intinfknd>
  (x, y) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  val () = mpz_init (!p)
  prval () = midec (x) and () = midec (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_mod3_mpz (!p, !(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = mienc (x) and () = mienc (y)
in
  i2mi @(pfgc, pfat | p)
end // end of [mod11_myint_myint<intinfknd>]

(* ****** ****** *)

implement
gcd01_myint_myint<intinfknd>
  (x, y) = i2mi (x) where {
  val x = mi2i (x); prval () = midec (y)
  val [l:addr] (
    pf_x, fpf_x | p_x
  ) = __cast (x.2) where {
    extern castfn __cast (p: ptr)
      :<> [l:addr] (mpz_vt@l, mpz_vt@l -<lin,prf> void | ptr l)
    // end of [extern]
  } // end of [val]
  prval pfat_x = x.1; prval pfat_y = y.1
  val () = mpz_gcd3_mpz (!p_x, !(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = fpf_x (pf_x)
  prval () = mienc (y)
} // end of [gcd01_myint_myint<intinfknd>]

(* ****** ****** *)

implement
compare_myint_int<intinfknd>
  (x, i) = sgn where {
  prval () = midec (x)
  prval pfat_x = x.1  
  val sgn = mpz_cmp_int (!(x.2), i)
  prval () = x.1 := pfat_x
  prval () = mienc (x)
} // end of [compare_intinf_int]

(* ****** ****** *)

implement
compare_myint_myint<intinfknd>
  (x, y) = sgn where {
  prval () = midec (x) and () = midec (y)
  prval pfat_x = x.1; prval pfat_y = y.1
  val sgn = mpz_cmp_mpz (!(x.2), !(y.2))
  prval () = x.1 := pfat_x and () = y.1 := pfat_y
  prval () = mienc (x) and () = mienc (y)
} // end of [compare_intinf_int]

(* ****** ****** *)

(* end of [pats_lintprgm_myint_intinf.dats] *)
