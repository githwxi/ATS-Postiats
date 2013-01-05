(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linralist_nested.sats"

(* ****** ****** *)
//
// HX-2013-01:
//
// this data structure is essentially due to Chris Okasaki
// However, unlike Okasaki's formulation, [ralist] is *not*
// a nested datatype!
//
(* ****** ****** *)

datavtype node
  (a:vt@ype+, int(*d*)) =
  | N1 (a, 0) of (a) // singleton
  | {d:nat}
    N2 (a, d+1) of (node (a, d), node (a, d))
// end of [node]

datavtype myralist
  (a:vt@ype+, int(*d*), int(*n*)) =
  | {d:nat}
    RAnil (a, d, 0) of ()
  | {d:nat}{n:pos}
    RAevn (a, d, n+n) of myralist (a, d+1, n)
  | {d:nat}{n:nat}
    RAodd (a, d, n+n+1) of (node (a, d), myralist (a, d+1, n))
// end of [myralist]

(* ****** ****** *)

assume
ralist_vt0ype_int_vtype (a:vt0p, n:int) = myralist (a, 0, n)

(* ****** ****** *)

primplmnt
lemma_ralist_param (xs) = let
in
//
case+ xs of
| RAevn _ => () | RAodd _ => () | RAnil () => ()
//
end // end of [lemma_ralist_param]

(* ****** ****** *)

implement{a}
linralist_nil () = RAnil{a}{0} ()

(* ****** ****** *)

local

fun cons
  {a:vt0p}{d:nat}{n:nat} .<n>. (
  x0: node (a, d), xs: myralist (a, d, n)
) :<> myralist (a, d, n+1) = let
in
//
case+ xs of
| ~RAevn (xxs) => RAodd (x0, xxs)
| ~RAodd (x1, xxs) => let
    val x0x1 = N2 (x0, x1) in RAevn (cons (x0x1, xxs))
  end // end of [RAodd]
| ~RAnil () => RAodd (x0, RAnil)
//
end // end of [cons]

in (* in of [local] *)

implement{a}
linralist_cons
  (x, xs) = let
//
prval () = lemma_ralist_param (xs)
//
in
  cons{a} (N1(x), xs)
end // end of [linralist_cons]

end // end of [local]

(* ****** ****** *)

implement{a}
linralist_is_nil (xs) =
  case+ xs of RAnil () => true | _ =>> false
// end of [linralist_is_nil]

implement{a}
linralist_is_cons (xs) =
  case+ xs of RAnil () => false | _ =>> true
// end of [linralist_is_cons]

(* ****** ****** *)

local

fun
length
  {a:vt0p}
  {d:nat}
  {n:nat} .<n>. (
  xs: !myralist (a, d, n)
) :<> int (n) = let
in
//
case+ xs of
| RAevn (xxs) => let
    val n2 = length (xxs) in 2 * n2
  end // end of [RAevn]
| RAodd (_, xxs) => let
    val n2 = length (xxs) in 2 * n2 + 1
  end // end of [RAodd]
| RAnil () => 0
//
end // end of [length]

in (* in of [local] *)

implement
linralist_length {a} (xs) = let
//
prval () = lemma_ralist_param (xs)
//
in
  length{a} (xs)
end // end of [linralist_length]

end // end of [local]

(* ****** ****** *)

implement{a}
linralist_head (xs) = linralist_get_at (xs, 0)

(* ****** ****** *)

implement{a}
linralist_tail
  (xs) = xs1 where {
  var xs1 = xs
  val _(*hd*) = $effmask_wrt (linralist_uncons<a> (xs1))
} // end of [linralist_tail]

(* ****** ****** *)

local

fun
uncons{
a:vt0p}{d:nat}{n:pos
} .<n>. (
  xs: myralist (a, d, n), x: &ptr? >> node (a, d)
) :<!wrt> myralist (a, d, n-1) = let
in
//
case+ xs of
| ~RAevn
    (xxs) => let
    var nxx: ptr
    val xxs =
      uncons (xxs, nxx)
    // end of [val]
    val+ ~N2 (x0, x1) = nxx
    val () = x := x0
  in
    RAodd (x1, xxs)
  end // end of [RAevn]
| ~RAodd
    (x0, xxs) => let
    val () = x := x0
  in
    case+ xxs of ~RAnil () => RAnil () | _ =>> RAevn (xxs)
  end // end of [RAodd]
//
end // end of [uncons]

in (* in of [local] *)

implement{a}
linralist_uncons
  (xs) = let
//
var nx: ptr // unintialized
val () = (xs := uncons{a} (xs, nx))
val+ ~N1 (x0) = nx
//
in
  x0
end // end of [linralist_uncons]

end // end of [local]

(* ****** ****** *)

local

fun getref_at
  {a:vt0p}{d:nat}{n:nat} .<n>. (
  xs: !myralist (a, d, n), i: natLt n
) :<> Ptr1 = let
  extern praxi __vfree : node (a,d+1) -<prf> void
in
//
case+ xs of
| RAevn (xxs) => let
    val p_x01 = getref_at (xxs, half i)
    val x01 = $UN.ptr_get<node(a,d+1)>(p_x01)
  in
    if i mod 2 = 0 then let
      val+ @N2 (x0, _) = x01
      val p_x0 = addr@ (x0)
      prval () = fold@ (x01)
      prval () = __vfree (x01)
    in
      p_x0
    end else let
      val+ @N2 (_, x1) = x01
      val p_x1 = addr@ (x1)
      prval () = fold@ (x01)
      prval () = __vfree (x01)
    in
      p_x1
    end // end of [if]
  end // end of [RAevn]
| @RAodd (x, xxs) => (
    if i = 0 then let
      val p_x = addr@ (x)
      prval () = fold@ (xs)
    in
      p_x
    end else let
      val i1 = i - 1
      val p_x01 = getref_at (xxs, half i1)
      prval () = fold@ (xs)
      val x01 = $UN.ptr_get<node(a,d+1)>(p_x01)
    in
      if i mod 2 = 0 then let
        val+ @N2 (_, x1) = x01
        val p_x1 = addr@ (x1)
        prval () = fold@ (x01)
        prval () = __vfree (x01)
      in
        p_x1
      end else let
        val+ @N2 (x0, _) = x01
        val p_x0 = addr@ (x0)
        prval () = fold@ (x01)
        prval () = __vfree (x01)
      in
        p_x0
      end // end of [if]
    end // end of [if]
  ) // end of [RAodd]
//
end // end of [getref_at]

in (* in of [local] *)

implement{a}
linralist_getref_at (xs, i) = getref_at {a} (xs, i)

end // end of [funralist_getref_at]

(* ****** ****** *)

implement{a}
linralist_get_at
  (xs, i) = let
  val p = linralist_getref_at<a> (xs, i) in $UN.ptr_get<a> (p)
end // end of [linralist_get_at]

implement{a}
linralist_set_at
  (xs, i, x) = let
  val p = linralist_getref_at<a> (xs, i) in $UN.ptr_set<a> (p, x)
end // end of [linralist_set_at]

(* ****** ****** *)

(* end of [linralist_nested.dats] *)
