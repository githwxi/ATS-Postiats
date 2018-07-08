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
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./pats_utils.sats"

(* ****** ****** *)

staload "./pats_lintprgm.sats"

(* ****** ****** *)

implement{a}
lt_myint_int (x, i) = (compare_myint_int (x, i) < 0)
implement{a}
lte_myint_int (x, i) = (compare_myint_int (x, i) <= 0)

implement{a}
gt_myint_int (x, i) = (compare_myint_int (x, i) > 0)
implement{a}
gte_myint_int (x, i) = (compare_myint_int (x, i) >= 0)

implement{a}
eq_myint_int (x, i) = (compare_myint_int (x, i) = 0)
implement{a}
neq_myint_int (x, i) = (compare_myint_int (x, i) != 0)

(* ****** ****** *)

implement{a}
lt_myint_myint (x1, x2) = (compare_myint_myint (x1, x2) < 0)
implement{a}
lte_myint_myint (x1, x2) = (compare_myint_myint (x1, x2) <= 0)

implement{a}
gt_myint_myint (x1, x2) = (compare_myint_myint (x1, x2) > 0)
implement{a}
gte_myint_myint (x1, x2) = (compare_myint_myint (x1, x2) >= 0)

(* ****** ****** *)

implement{a}
myintvec_get_at
  (iv, i) = x where {
  val (pf | p) = myintvec_takeout (iv)
  val i = size1_of_int1 (i)
  val (pfat, fpf | p_i) = array_ptr_takeout (pf | p, i)
  val x = myint_copy (!p_i)
  prval () = pf := fpf (pfat)
  prval () = myintvecout_addback (pf | iv)
} // end of [myintvec_get_at]

(* ****** ****** *)

implement{a}
myintvec_compare_at
  (iv, i, x) = sgn where {
  val (pf | p) = myintvec_takeout (iv)
  val i = size1_of_int1 (i)
  val (pfat, fpf | p_i) = array_ptr_takeout (pf | p, i)
  val sgn = compare_myint_int (!p_i, x)
  prval () = pf := fpf (pfat)
  prval () = myintvecout_addback (pf | iv)
} // end of [myintvec_compare_at]

(* ****** ****** *)

implement{a}
myintvec_add_int
  (iv, i) = let
  vtypedef x = myint(a)
  val (pf | p) = myintvec_takeout {a} (iv)
  prval (pf1, pf2) = array_v_uncons {x} (pf)
  val () = !p := add_myint_int (!p, i)
  prval () = pf := array_v_cons {x} (pf1, pf2)
  prval () = myintvecout_addback (pf | iv)
in
  // nothing
end // end of [myintvec_add_int]

(* ****** ****** *)

implement
myintvec0_free
  {a}{n} (xs, n) = let
  vtypedef vt = myint(a)
  val (pfgc, pf | p) = __cast (xs) where {
    extern castfn __cast
      (x: myintvec0 (a, n))
      :<> [l:addr] (free_gc_v (vt?, n, l), array_v(vt?, n, l) | ptr l)
  } // end of [val]
in
  array_ptr_free (pfgc, pf | p)
end // end of [myintvec0_free]

implement{a}
myintvec_free (iv, n) = let
  vtypedef x = myint(a)
  prval () = lemma_myintvec_params (iv)
  val (pfarr | p) = myintvec_takeout (iv)
  val asz = size1_of_int1 (n)
  val () = array_ptr_clear_fun<x> (!p, asz, lam (x) =<0> myint_free<a> (x))
  prval () = myintvecout0_addback {a} (pfarr | iv)
in
  myintvec0_free (iv, n)
end // end of [myintvec_free]

(* ****** ****** *)

implement{a}
icnstr_copy (ic, n) =
  case+ ic of
  | ICvec (knd, !p_iv) => let
      val iv_new = myintvec_copy<a> (!p_iv, n)
    in
      fold@ (ic); ICvec (knd, iv_new)
    end // end of [ICvec]
  | ICveclst (knd, !p_ics) => let
      val ics_new = icnstrlst_copy (!p_ics, n)
    in
      fold@ (ic); ICveclst (knd, ics_new)
    end // end of [ICveclst]
  | ICerr (loc, s3e) => (fold@ (ic); ICerr (loc, s3e))
// end of [icnstr_copy]

implement{a}
icnstrlst_copy (ics, n) =
  case+ ics of
  | list_vt_cons
      (!p_ic, !p_ics1) => let
      val ic = icnstr_copy<a> (!p_ic, n)
      val ics1 = icnstrlst_copy<a> (!p_ics1, n)
      prval () = fold@ (ics)
    in
      list_vt_cons (ic, ics1)
    end // end of [list_vt_cons]
  | list_vt_nil () => let
      prval () = fold@ (ics) in list_vt_nil ()
    end // end of [list_vt_nil]
// end of [icnstrlst_copy]

(* ****** ****** *)

implement{a}
icnstr_negate (ic) =
  case+ ic of
  | ICvec (!p_knd, _) => (
      !p_knd := ~(!p_knd); fold@ (ic); ic
    ) // end of [ICvec]
  | ICveclst (!p_knd, !p_ics) => (
      !p_knd := 1-(!p_knd); !p_ics := icnstrlst_negate (!p_ics); fold@ ic; ic
    ) // end of [ICveclst]
  | ICerr _ => (fold@ (ic); ic)
// end of [icnstr_negate]

implement{a}
icnstrlst_negate (ics) =
  case+ ics of
  | list_vt_cons (!p_ic, !p_ics) => let
      val () = !p_ic := icnstr_negate (!p_ic)
      val () = !p_ics := icnstrlst_negate (!p_ics)
    in
      fold@ (ics); ics
    end // end of [list_vt_cons]
  | list_vt_nil () => (fold@ (ics); ics)
// end of [icnstrlst_negate]

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
  | ~ICerr (loc, s3e) => ()
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

(* ****** ****** *)

extern
fun{a:t@ype}
myintvec_normalize // knd=2/1:gte/eq
  {n:pos} (knd: int, vec: !myintvec (a, n), n: int n): Ans2(*~1/0*)
// end of [myintvec_normalize]

(* ****** ****** *)

implement{a}
myintvec_inspect
  {n}(knd, iv, n) = let
//
vtypedef vt = myint(a)
//
fun
loop
{n:nat}
{l:addr} .<n>.
(
  pf: !array_v (vt, n, l) | p: ptr l, n: int n
) : bool(*cffs=0*) = let
in
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
end // end of [loop]
//
val (pf | p) = myintvec_takeout (iv)
prval (pf1, pf2) = array_v_uncons {vt} (pf)
val cffsZero = loop (pf2 | p+sizeof<vt>, n-1)
var ans3: Ans3 = UNDECIDED
val () = (
//
if cffsZero then (
  case+ knd of
  |  2 => (
      if !p >= 0 then ans3 := TAUTOLOGY else ans3 := CONTRADICTION
    ) // end of [gte]
  | ~2 => (
      if !p  <  0 then ans3 := TAUTOLOGY else ans3 := CONTRADICTION
    ) // end of [gte]
  |  1 => (
      if !p  =  0 then ans3 := TAUTOLOGY else ans3 := CONTRADICTION
    ) // end of [eq]
  | ~1 => (
      if !p != 0 then ans3 := TAUTOLOGY else ans3 := CONTRADICTION
    ) // end of [eq]
  |  _ => () // HX: this should not happen
) // end of [if]
//
) : void // end of [val]
//
prval () =
  pf := array_v_cons {vt} (pf1, pf2)
prval () = myintvecout_addback (pf | iv)
//
in
  ans3(*~1/0/1*)
end // end of [myintvec_inspect]

implement{a}
myintvec_inspect_lt
  (iv, n) = myintvec_inspect (~2(*lt*), iv, n)
// end of [myintvec_inspect_gte]

implement{a}
myintvec_inspect_gte
  (iv, n) = myintvec_inspect (2(*gte*), iv, n)
// end of [myintvec_inspect_gte]

implement{a}
myintvec_inspect_eq
  (iv, n) = let
  val knd = 1(*eq*)
  val ans2 = myintvec_inspect (knd, iv, n)
in
  if ans2 = 0 then
    myintvec_normalize (knd, iv, n) else ans2
  // end of [if]
end // end of [myintvec_inspect_eq]

implement{a}
myintvec_inspect_neq
  (iv, n) = myintvec_inspect (~1(*neq*), iv, n)
// end of [myintvec_inspect_neq]

(* ****** ****** *)

implement{a}
myintveclst_inspect_gte
  {n} (ivs, n) = let
//
vtypedef vt = myintvec (a,n)
//
in
//
case+ ivs of
| list_vt_cons
    (!p_iv, !p_ivs) => let
    val ans3 =
      myintvec_inspect_gte (!p_iv, n)
    // end of [val]
  in
    if ans3 != 0 then let
      val ivs1 = !p_ivs
      val () = myintvec_free<a> (!p_iv, n)
      val () = free@ {vt}{0} (ivs)
      val () = ivs := ivs1
    in
      if ans3 > 0 then // TAUTOLOGY
        myintveclst_inspect_gte (ivs, n) else ~1(*CONTRADICTION*)
      // end of [if]
    end else let
      val ans =
        myintveclst_inspect_gte (!p_ivs, n)
      prval () = fold@ (ivs)
    in
      ans // the final answers
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

fun
{a:t0p}
myintvec_cffgcd_main
  {n:pos}
  {l:addr} (
  pf: !myint(a) @ l
| iv: !myintvec (a, n), n: int n, p_res: ptr l
) : void = let
//
macdef
gcd = gcd01_myint_myint
//
(*
//
stadef v = myint(a) @ l
//
var
!p_clo =
@lam (
  pf: !v | x: &myint(a)
) : void =<1>
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
//
val n1 = size1_of_int1(n-1)
//
val (pfarr | p_arr) = myintvec_takeout (iv)
prval (pf1at, pf2arr) = array_v_uncons {myint(a)} (pfarr)
val p2_arr = p_arr + sizeof<myint(a)>
val () = array_ptr_foreach_vclo {v} (pf | !p2_arr, !p_clo, n1)
prval () = pfarr := array_v_cons {myint(a)} (pf1at, pf2arr)
prval () = myintvecout_addback (pfarr | iv)
*)
//
fun
loop
(
  pf: !myint(a) @ l | p: ptr, i: int
) :<cloref1> void =
(
if
i < n
then let
  val x = $UN.ptr0_get<myint(a)>(p)
  extern praxi __vfree(x: myint(a)): void
in
//
if
x != 0
then (
//
if x != 1
  then let
    val () =
      !p_res := gcd (!p_res, x)
    // end of [val]
    prval ((*void*)) = __vfree(x)
  in
    loop (pf | p+sizeof<myint(a)>, i+1)
  end // end of [then]
  else let
    val () = myint_free (!p_res)
    val () = !p_res := myint_make_int<a> (1)
    prval ((*void*)) = __vfree(x)
  in
    // nothing
  end // end of [else]
//
) (* end of [then] *)
else let
  prval ((*void*)) = __vfree(x)
in
  loop (pf | p+sizeof<myint(a)>, i+1)
end // end of [else]
//
end // end of [then]
//
) (* end of [loop] *)
//
val
(pfarr | p_arr) = myintvec_takeout (iv)
val () = loop (pf | p_arr+sizeof<myint(a)>, 1)
prval ((*void*)) = myintvecout_addback (pfarr | iv)
//
in
  // nothing
end // end of [myintvec_cffgcd_main]

in (* in of [local] *)

implement{a}
myintvec_cffgcd
  {n}(iv, n) = let
//
var res
  : myint(a) = myint_make_int<a> (0)
val p_res = &res
//
(*
//
// HX-2015-01-27:
// fixing a bug in (clang-3.5 -O2)
// HX-2015-01-28:
// this is no longer needed due to
// there being no longer use of exception
val ((*void*)) = ptr_as_volatile(p_res)
//
*)
//
val ivp =
__cast (iv) where {
  extern castfn __cast (iv: !myintvec(a, n)): ptr
} (* end of [val] *)
//
viewdef v = myint(a)@res
//
// HX-2012-02-25:
// this is so awkward! should try* be introduced?
//
val () = try let
  val iv =
  __cast (ivp) where {
    extern castfn __cast (p: ptr): myintvec (a, n)
  } (* end of [val] *)
  prval
  (pf, fpf) =
  __assert () where {
    extern praxi __assert (): (v, v -<lin,prf> void)
  } (* end of [prval] *)
  val () = myintvec_cffgcd_main (pf | iv, n, &res)
  prval () = fpf (pf)
  prval () =
  __free (iv) where {
    extern praxi __free (iv: myintvec (a, n)): void
  } (* end of [prval] *)
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
//
vtypedef vt = myint (a)
//
macdef sub = sub01_myint_myint
macdef div = div01_myint_myint
macdef ediv = ediv01_myint_myint
//
fun
loop
  {n:nat}
  {l:addr} .<n>.
(
  pf: !array_v (vt, n, l) | gcd: !vt, p: ptr l, n: int n
) :<> void =
  if n > 0 then let
    prval
    (pf1, pf2) =
      array_v_uncons {vt} (pf)
    // end of [prval]
    val () = !p := (!p \ediv gcd)
    val tsz = sizeof<vt>
    val () = loop (pf2 | gcd, p+tsz, n-1)
    prval () = pf := array_v_cons {vt} (pf1, pf2)
  in
    // nothing
  end // end of [if]
//
val gcd = myintvec_cffgcd (iv, n)
//
in
//
if gcd > 1 then let
  val (pf | p) = myintvec_takeout {a} (iv)
  prval (pf1, pf2) = array_v_uncons {vt} (pf)
  var ans2: Ans2 = 0
  val () = loop (pf2 | gcd, p+sizeof<vt>, n-1)
  val () = (
    case+ 0 of
    | _ when knd = 2 => (
        if !p >= 0 then
          !p := (!p \div gcd)
        else let // !p < 0
          val () = !p := (!p \sub gcd)
          val () = !p := add_myint_int (!p, 1)
        in
          !p := (!p \div gcd)
        end // end of [if]
      ) // end of [knd=2/gte]
    | _ when knd = 1 => let
        val rmd = mod11_myint_myint (!p, gcd)
        val () = // HX: a contradiction may be reached
          if rmd = 0 then (!p := (!p \ediv gcd)) else (ans2 := ~1)
        val () = myint_free (rmd)
      in
        (*nothing*)
      end // end of [knd=1/eq]
    | _ => let
        val () = assertloc (false) in ans2 := ~1
      end // end of [_]
  ) : void // end of [val]
  val ((*freed*)) = myint_free (gcd)
  prval pf = array_v_cons {vt} (pf1, pf2)
  prval () = myintvecout_addback {a} (pf | iv)
in
  ans2
end else let
  val ((*freed*)) = myint_free (gcd) in 0(*normal*)
end // end of [if]
//
end // end of [myintvec_normalize]

implement{a}
myintvec_normalize_gte
  (iv, n) = () where {
  val _(*0*) = myintvec_normalize<a> (2(*knd*), iv, n)
} // end of [myintvec_normalize_gte]

implement{a}
myintveclst_normalize_gte
  {n} (ivs, n) = let
//
vtypedef vt = myintvec (a,n)
//
in
//
case+ ivs of
| list_vt_cons
    (!p_iv, !p_ivs) => let
    val () = myintvec_normalize_gte (!p_iv, n)
    val () = myintveclst_normalize_gte (!p_ivs, n)
  in
    fold@ (ivs)
  end // end of [list_vt_cons]
| list_vt_nil () => fold@ (ivs)
//
end // end of [myintveclst_normalize_gte]

(* ****** ****** *)

implement{a}
myintvec0_make
  {n} (n) = let
  val n = size1_of_int1 (n)
  val (pfgc, pfarr | p) = array_ptr_alloc<myint(a)> (n)
in
  __cast (pfgc, pfarr | p) where {
    extern castfn
      __cast {v1,v2:view} (_:v1, _:v2 | p: ptr):<> myintvec0(a, n)
  } // end of [__cast]
end // end of [myintvec0_make]

(* ****** ****** *)

implement{a}
myintvec_make
  {n} (n) = let
//
vtypedef x = myint (a)
//
fun
loop
  {n:nat}
  {l:addr} .<n>.
(
  pf: !array_v (x?, n, l) >> array_v (x, n, l) | p: ptr l, n: int n
) :<> void =
  if n > 0 then let
    prval
    (pf1, pf2) =
      array_v_uncons{x?}(pf)
    // end of [prval]
    val () = !p := myint_make_int<a> (0)
    val () = loop (pf2 | p+sizeof<x>, n-1)
    prval () = pf := array_v_cons{x}(pf1, pf2)
  in
    // nothing
  end else let
    prval () = array_v_unnil (pf) in pf := array_v_nil {x} ()
  end // end of [if]
// end of [loop]
//
val iv = myintvec0_make<a> (n)
val (pf | p) = myintvec0_takeout (iv)
val () = loop (pf | p, n)
prval () = myintvecout_addback (pf | iv)
//
in
  iv(* initialized with zeros *)
end // end of [myintvec_make]

(* ****** ****** *)

implement{a}
myintvec_copy
  {n}(iv1, n) = let
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv1)
//
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
macdef
mul = mul11_myint_myint
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv1)
//
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt?, n, l2) >> array_v (vt, n, l2)
| cff: !vt, p1: ptr l1, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt?} (pf2)
    val () = !p2 := (cff \mul !p1)
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
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv)
//
fun
loop
  {n:nat}
  {l:addr} .<n>.
(
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
//
val
(pf | p) =
myintvec_takeout {a} (iv)
//
val () = loop (pf | p, n)
//
prval () = myintvecout_addback {a} (pf | iv)
//
in
  // nothing
end // end of [myintvec_negate]

(* ****** ****** *)

implement{a}
myintvec_scale
  {n} (cff, iv, n) = let
//
macdef
mul = mul10_myint_myint
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv)
//
fun loop
  {n:nat} {l:addr} .<n>. (
  pf: !array_v (vt, n, l)
| cff: !myint(a), p: ptr l, n: int n
) :<> void =
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons {vt} (pf)
    val () = !p := (cff \mul !p)
    val tsz = sizeof<vt>
    val () = loop (pf2 | cff, p+tsz, n-1)
    prval () = pf := array_v_cons {vt} (pf1, pf2)
  in
    // nothing
  end // end of [if]
val (pf | p) = myintvec_takeout {a} (iv)
val () = loop (pf | cff, p, n)
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
macdef
add = add01_myint_myint
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv1)
//
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
macdef
sub = sub01_myint_myint
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv1)
//
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
macdef
add = add01_myint_myint
macdef
mul = mul11_myint_myint
//
vtypedef vt = myint (a)
//
prval () = lemma_myintvec_params (iv1)
//
fun loop
  {n:nat} {l1,l2:addr} .<n>. (
  pf1: !array_v (vt, n, l1)
, pf2: !array_v (vt, n, l2)
| p1: ptr l1, cff: !vt, p2: ptr l2, n: int n
) :<> void =
  if n > 0 then let
    prval (pf11, pf12) = array_v_uncons {vt} (pf1)
    prval (pf21, pf22) = array_v_uncons {vt} (pf2)
    val cx2 = cff \mul !p2
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
