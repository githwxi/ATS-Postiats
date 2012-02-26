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

staload "pats_lintprgm.sats"

(* ****** ****** *)

implement
myintvec0_free
  {a}{n} (xs, n) = let
  viewtypedef vt = myint(a)
  val (pfgc, pf | p) = __cast (xs) where {
    extern castfn __cast
      (x: myintvec0 (a, n))
      :<> [l:addr] (free_gc_v (vt?, n, l), array_v(vt?, n, l) | ptr l)
  } // end of [val]
in
  array_ptr_free (pfgc, pf | p)
end // end of [myintvec0_free]

(* ****** ****** *)

implement{a}
myintveclst_free (ivs, n) =
  case+ ivs of
  | ~list_vt_cons (iv, ivs) =>
      (myintvec_free (iv, n); myintveclst_free (ivs, n))
  | ~list_vt_nil () => ()
// end of [myintveclst_free]

(* ****** ****** *)

implement{a}
icnstr_free (x, n) =
  case+ x of
  | ~ICvec (knd, obj) => myintvec_free<a> (obj, n)
  | ~ICveclst (knd, xs) => icnstrlst_free<a> (xs, n)
// end of [icnstr_free]

implement{a}
icnstrlst_free (xs, n) =
  case+ xs of
  | ~list_vt_cons (x, xs) =>
      (icnstr_free<a> (x, n); icnstrlst_free<a> (xs, n))
  | ~list_vt_nil () => ()
// end of [icnstrlst_free]

(* ****** ****** *)

#define UNDECIDED 0
#define TAUTOLOGY 1
#define CONTRADICTION ~1

implement{a}
myintvec_inspect
  {n} (knd, iv, n) = let
  viewtypedef vt = myint(a)
  fun loop {n:nat} {l:addr} .<n>. (
    pf: !array_v (vt, n, l) | p: ptr l, n: int n
  ) : bool(*cffs=0*) =
    if n > 0 then let
      prval (pf1, pf2) = array_v_uncons {vt} (pf)
    in
      if !p = 0 then let
        val ans = loop (pf2 | p + sizeof<vt>, n-1)
        prval () = pf := array_v_cons {vt} (pf1, pf2)
      in
        ans
      end else let
        prval () = pf := array_v_cons {vt} (pf1, pf2)
      in
        false
      end // end of [if]
    end else true // end of [if]
  // end of [loop]
  val (pf | p) = myintvec_takeout (iv)
  prval (pf1, pf2) = array_v_uncons {vt} (pf)
  val cffsAllZero = loop (pf2 | p+sizeof<vt>, n-1)
  val ans = (
    if cffsAllZero then (
      case+ knd of
      |  1 => if !p = 0 then TAUTOLOGY else CONTRADICTION
      |  2 => if !p >= 0 then TAUTOLOGY else CONTRADICTION
      | ~1 => if !p != 0 then TAUTOLOGY else CONTRADICTION
      | ~2 => if !p < 0 then TAUTOLOGY else CONTRADICTION
      |  _ => UNDECIDED // HX: this should not happen
    ) else UNDECIDED // end of [if]
  ) : int // end of [val]
  prval () = pf := array_v_cons {vt} (pf1, pf2)
  prval () = myintvecout_addback (pf | iv)
in
  ans
end // end of [myintvec_inspect]

implement{a}
myintvec_inspect_eq
  (iv, n) = myintvec_inspect (1(*eq*), iv, n)
// end of [myintvec_inspect_eq]
implement{a}
myintvec_inspect_gte
  (iv, n) = myintvec_inspect (2(*gte*), iv, n)
// end of [myintvec_inspect_gte]

(* ****** ****** *)

implement{a}
myintveclst_inspect_gte
  {n} (ivs, n) = let
  viewtypedef vt = myintvec (a,n)
in
//
case+ ivs of
| list_vt_cons
    (!p_iv, !p_ivs) => let
    val ans =
      myintvec_inspect_gte (!p_iv, n)
    // end of [val]
  in
    if ans != 0 then let
      val ivs1 = !p_ivs
      val () = myintvec_free<a> (!p_iv, n)
      val () = free@ {vt}{0} (ivs)
      val () = ivs := ivs1
    in
      if ans > 0 then // TAUTOLOGY
        myintveclst_inspect_gte (ivs, n) else ~1(*CONTRADICTION*)
      // end of [if]
    end else let
      val fans =
        myintveclst_inspect_gte (!p_ivs, n)
      prval () = fold@ (ivs)
    in
      fans // the final answers
    end // end of [if]
  end (* end of [list_vt_cons] *)
| list_vt_nil () => let
    prval () = fold@ (ivs) in 0(*UNDECIDED*)
  end // end of [list_vt_nil]
//
end // end of [myintveclst_inspect_gte]

(* ****** ****** *)

local

exception Finished

fun{a:t@ype}
myintvec_cffgcd_main
  {n:pos}{l:addr} (
  pf: !myint(a) @ l
| iv: !myintvec (a, n), n: int n, p_res: ptr l
) : void = let
//
macdef gcd = gcd_myint_myint
//
viewtypedef x = myint(a)
viewdef v = x @ l
var !p_clo = @lam
  (pf: !v | x: &x): void =<1>
  if x != 0 then (
    if x != 1 then (
      !p_res := gcd (!p_res, x)
    ) else let
      val () = myint_free (!p_res)
      val () = !p_res := myint_make_int<a> (1)
    in
      $raise (Finished)
    end // end of [if]
  ) // end of [if]
// end of [var]
val n = size1_of_int1 (n)
//
val (pfarr | p_arr) = myintvec_takeout (iv)
prval (pf1at, pf2arr) = array_v_uncons {myint(a)} (pfarr)
val p2_arr = p_arr + sizeof<myint(a)>
val () = array_ptr_foreach_vclo {v} (pf | !p2_arr, !p_clo, n-1)
prval () = pfarr := array_v_cons {myint(a)} (pf1at, pf2arr)
prval () = myintvecout_addback (pfarr | iv)
//
in
  (*nothing*)
end // end of [myintvec_gcd_main]

in // in of [local]

implement{a}
myintvec_cffgcd {n} (iv, n) = let
//
var res
  : myint(a) = myint_make_int (0)
val p_res = &res
val ivp = __cast (iv) where {
  extern castfn __cast (iv: !myintvec (a, n)): ptr
} // end of [val]
viewdef v = myint(a)@res
//
// HX-2012-02-25:
// this is so awkward! should try* be introduced?
//
val () = try let
  val iv = __cast (ivp) where {
    extern castfn __cast (p: ptr): myintvec (a, n)
  }
  prval (pf, fpf) = __assert () where {
    extern praxi __assert (): (v, v -<lin,prf> void)
  } // end of [prval]
  val () = myintvec_cffgcd_main (pf | iv, n, &res)
  prval () = fpf (pf)
  prval () = __free (iv) where {
    extern praxi __free (iv1: myintvec (a, n)): void
  } // end of [prval]
in
  // nothing
end with
  | ~Finished () => ()
// end of [try]
in
  res
end // end of [myintvec_gcd]

end // end of [local]

(* ****** ****** *)

implement{a}
myintvec_normalize
  {n} (knd, iv, n) = let
macdef sub = sub_myint_myint
macdef div = div_myint_myint
macdef ediv = ediv_myint_myint
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l:addr} .<n>. (
  pf: !array_v (vt, n, l) | gcd: !vt, p: ptr l, n: int n
) :<> void =
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons {vt} (pf)
    val () = !p := (!p \ediv gcd)
    val tsz = sizeof<vt>
    val () = loop (pf2 | gcd, p+tsz, n-1)
    prval () = pf := array_v_cons {vt} (pf1, pf2)
  in
    // nothing
  end // end of [if]
val gcd = myintvec_cffgcd (iv, n)
//
in
//
if gcd > 1 then let
  val (pf | p) = myintvec_takeout {a} (iv)
  prval (pf1, pf2) = array_v_uncons {vt} (pf)
  var ans: int = 0
  val () = loop (pf2 | gcd, p+sizeof<vt>, n-1)
  val () = (
    case+ 0 of
    | _ when knd = 2 => (
        if !p >= 0 then
          !p := (!p \div gcd)
        else let // !p < 0
          val () = !p := (!p \sub gcd)
          val () = !p := succ_myint (!p)
        in
          !p := (!p \div gcd)
        end // end of [if]
      ) // end of [knd=2:gte]
    | _ when knd = 1 => let
        val rmd = mod1_myint_myint (!p, gcd)
        val () = // HX: a contradiction may be reached
          if rmd = 0 then (!p := (!p \ediv gcd)) else (ans := ~1)
        val () = myint_free (rmd)
      in
        (*nothing*)
      end // end of [knd=1:eq]
    | _ => let
        val () = assertloc (false) in ans := ~1
      end // end of [_]
  ) : void // end of [val]
  prval pf = array_v_cons {vt} (pf1, pf2)
  prval () = myintvecout_addback {a} (pf | iv)
  val () = myint_free (gcd)
in
  ans
end else let
  val () = myint_free (gcd) in 0(*normal*)
end // end of [if]
//
end // end of [myintvec_normalize]

implement{a}
myintvec_normalize_eq
  (iv, n) = myintvec_normalize (1(*eq*), iv, n)
// end of [myintvec_normalize_eq]
implement{a}
myintvec_normalize_gte
  (iv, n) = let
  val _(*0*) = myintvec_normalize (2(*gte*), iv, n)
in
  (*nothing*)
end // end of [myintvec_normalize_gte]

(* ****** ****** *)

implement{a}
myintvec_copy
  {n} (iv1, n) = let
//
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt?, n, l2) >> array_v (vt, n, l2)
| p1: ptr l1, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt?} (pf2)
    val () = !p2 := myint_copy (!p1)
    val tsz = sizeof<vt>
    val () = loop (pf12, pf22 | p1+tsz, p2+tsz, n-1)
    prval () = pf1 := array_v_cons {vt} (pf11, pf12)
    prval () = pf2 := array_v_cons {vt} (pf21, pf22)
  in
    // nothing
  end else let
    prval () = array_v_unnil (pf2) in pf2 := array_v_nil {vt} ()
  end // end of [if]
val iv2 = myintvec0_make (n)
val (pf1 | p1) = myintvec_takeout {a} (iv1)
val (pf2 | p2) = myintvec0_takeout {a} (iv2)
val () = loop (pf1, pf2 | p1, p2, n)
prval () = myintvecout_addback {a} (pf1 | iv1)
prval () = myintvecout_addback {a} (pf2 | iv2)
//
in
  iv2
end // end of [myintvec_copy]

(* ****** ****** *)

implement{a}
myintvec_copy_cff
  {n} (cff, iv1, n) = let
//
macdef mul1 = mul1_myint_myint
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt?, n, l2) >> array_v (vt, n, l2)
| cff: !vt, p1: ptr l1, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt?} (pf2)
    val () = !p2 := (cff \mul1 !p1)
    val tsz = sizeof<vt>
    val () = loop (pf12, pf22 | cff, p1+tsz, p2+tsz, n-1)
    prval () = pf1 := array_v_cons {vt} (pf11, pf12)
    prval () = pf2 := array_v_cons {vt} (pf21, pf22)
  in
    // nothing
  end else let
    prval () = array_v_unnil (pf2) in pf2 := array_v_nil {vt} ()
  end // end of [if]
val iv2 = myintvec0_make (n)
val (pf1 | p1) = myintvec_takeout {a} (iv1)
val (pf2 | p2) = myintvec0_takeout {a} (iv2)
val () = loop (pf1, pf2 | cff, p1, p2, n)
prval () = myintvecout_addback {a} (pf1 | iv1)
prval () = myintvecout_addback {a} (pf2 | iv2)
//
in
  iv2
end // end of [myintvec_copy_cff]

(* ****** ****** *)

implement{a}
myintvec_negate
  {n} (iv, n) = let
//
macdef neg = neg_myint
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l:addr} .<n>. (
  pf: !array_v (vt, n, l) | p: ptr l, n: int n
) :<> void =
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons {vt} (pf)
    val () = !p := neg (!p)
    val tsz = sizeof<vt>
    val () = loop (pf2 | p+tsz, n-1)
    prval () = pf := array_v_cons {vt} (pf1, pf2)
  in
    // nothing
  end // end of [if]
val (pf | p) = myintvec_takeout {a} (iv)
val () = loop (pf | p, n)
prval () = myintvecout_addback {a} (pf | iv)
//
in
  // nothing
end // end of [myintvec_negate]

(* ****** ****** *)

implement{a}
myintvec_addby
  {n} (iv1, iv2, n) = let
//
macdef add = add_myint_myint
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt, n, l2)
| p1: ptr l1, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt} (pf2)
    val () = !p1 := (!p1 \add !p2)
    val tsz = sizeof<vt>
    val () = loop (pf12, pf22 | p1+tsz, p2+tsz, n-1)
    prval () = pf1 := array_v_cons {vt} (pf11, pf12)
    prval () = pf2 := array_v_cons {vt} (pf21, pf22)
  in
    // nothing
  end // end of [if]
val (pf1 | p1) = myintvec_takeout {a} (iv1)
val (pf2 | p2) = myintvec_takeout {a} (iv2)
val () = loop (pf1, pf2 | p1, p2, n)
prval () = myintvecout_addback {a} (pf1 | iv1)
prval () = myintvecout_addback {a} (pf2 | iv2)
//
in
  // nothing
end // end of [myintvec_addby]

(* ****** ****** *)

implement{a}
myintvec_subby
  {n} (iv1, iv2, n) = let
//
macdef sub = sub_myint_myint
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt, n, l2)
| p1: ptr l1, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt} (pf2)
    val () = !p1 := (!p1 \sub !p2)
    val tsz = sizeof<vt>
    val () = loop (pf12, pf22 | p1+tsz, p2+tsz, n-1)
    prval () = pf1 := array_v_cons {vt} (pf11, pf12)
    prval () = pf2 := array_v_cons {vt} (pf21, pf22)
  in
    // nothing
  end // end of [if]
val (pf1 | p1) = myintvec_takeout {a} (iv1)
val (pf2 | p2) = myintvec_takeout {a} (iv2)
val () = loop (pf1, pf2 | p1, p2, n)
prval () = myintvecout_addback {a} (pf1 | iv1)
prval () = myintvecout_addback {a} (pf2 | iv2)  
//
in
  // nothing
end // end of [myintvec_subby]

(* ****** ****** *)

implement{a}
myintvec_addby_cff
  {n} (iv1, cff, iv2, n) = let
//
macdef add = add_myint_myint
macdef mul1 = mul1_myint_myint
viewtypedef vt = myint (a)
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt, n, l2)
| p1: ptr l1, cff: !vt, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt} (pf2)
    val cx2 = cff \mul1 !p2
    val () = !p1 := (!p1 \add cx2)
    val () = myint_free (cx2)
    val tsz = sizeof<vt>
    val () = loop (pf12, pf22 | p1+tsz, cff, p2+tsz, n-1)
    prval () = pf1 := array_v_cons {vt} (pf11, pf12)
    prval () = pf2 := array_v_cons {vt} (pf21, pf22)
  in
    // nothing
  end // end of [if]
val (pf1 | p1) = myintvec_takeout {a} (iv1)
val (pf2 | p2) = myintvec_takeout {a} (iv2)
val () = loop (pf1, pf2 | p1, cff, p2, n)
prval () = myintvecout_addback {a} (pf1 | iv1)
prval () = myintvecout_addback {a} (pf2 | iv2)  
//
in
  // nothing
end // end of [myintvec_addby]

(* ****** ****** *)

(* end of [pats_lintprgm.dats] *)
