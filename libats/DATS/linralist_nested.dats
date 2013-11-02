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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.funralist_nested"
#define
ATS_DYNLOADFLAG 0 // no dynamic loading at run-time

(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "libats/SATS/linralist_nested.sats"

(* ****** ****** *)
//
// HX-2013-01:
//
// this data structure is essentially based on
// Chris Okasaki's random-access list (formulated
// as a nested datatype). However, unlike Okasaki's
// formulation, [ralist] is *not* a nested datatype.
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
ralist_vtype
  (a:vt0p, n:int) = myralist (a, 0, n)
// end of [ralist_vtype]

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

implement{}
linralist_nil{a} () = RAnil{a}{0}((*void*))
implement{}
linralist_make_nil{a} () = RAnil{a}{0}((*void*))

(* ****** ****** *)

local

extern
fun cons
  {a:vt0p}{d:nat}{n:nat}
(
  x0: node (a, d), xs: myralist (a, d, n)
) :<> myralist (a, d, n+1)
implement
cons{a}{d}{n} (x0, xs) = let
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
  cons{a} (N1{a}(x), xs)
end // end of [linralist_cons]

end // end of [local]

(* ****** ****** *)

implement{}
linralist_is_nil (xs) =
  case+ xs of RAnil () => true | _ =>> false
// end of [linralist_is_nil]

implement{}
linralist_is_cons (xs) =
  case+ xs of RAnil () => false | _ =>> true
// end of [linralist_is_cons]

(* ****** ****** *)

local

extern
fun length
  {a:vt0p}{d:nat}{n:nat}
  (xs: !myralist (a, d, n)):<> int (n)
implement
length{a}{d}{n} (xs) = let
in
//
case+ xs of
| RAevn (xxs) =>
    let val n2 = length (xxs) in 2 * n2 end
  // end of [RAevn]
| RAodd (_, xxs) =>
    let val n2 = length (xxs) in 2 * n2 + 1 end
  // end of [RAodd]
| RAnil ((*void*)) => (0)
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
  val _(*hd*) = linralist_uncons (xs1)
} // end of [linralist_tail]

(* ****** ****** *)

local

extern fun
uncons{a:vt0p}{d:nat}{n:pos}
(
  xs: myralist (a, d, n), x: &ptr? >> node (a, d)
) :<!wrt> myralist (a, d, n-1)
implement
uncons{a}{d}{n} (xs, x) = let
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

extern fun
getref_at {a:vt0p}{d:nat}{n:nat}
(
  xs: !myralist (a, d, n), i: natLt n
) :<> Ptr1 // end of [getref_at]
implement
getref_at
  {a}{d}{n} (xs, i) = let
//
extern praxi __vfree : node (a,d+1) -<prf> void
//
in
//
case+ xs of
| RAevn (xxs) => let
    val p_x01 = getref_at (xxs, half i)
    val x01 = $UN.ptr1_get<node(a,d+1)>(p_x01)
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
      val x01 = $UN.ptr1_get<node(a,d+1)>(p_x01)
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
linralist_getref_at (xs, i) = let
  val p_i = getref_at {a} (xs, i) in $UN.cast{cPtr1(a)}(p_i)
end // end of [linralist_getref_at]

end // end of [local]

(* ****** ****** *)

implement{a}
linralist_get_at
  (xs, i) = let
  val p = linralist_getref_at (xs, i) in $UN.cptr_get<a> (p)
end // end of [linralist_get_at]

implement{a}
linralist_set_at
  (xs, i, x) = let
  val p = linralist_getref_at (xs, i) in $UN.cptr_set<a> (p, x)
end // end of [linralist_set_at]

(* ****** ****** *)

(* end of [linralist_nested.dats] *)
