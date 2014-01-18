(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2011 Hongwei Xi, Boston University
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

(*
**
** A functional heap implementation based on Braun trees
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: April, 2010 // based on a version done in November, 2008
**
*)

(* ****** ****** *)
//
// HX-2014-01-15: Porting to ATS2
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading

(* ****** ****** *)

staload "libats/ATS1/SATS/funheap_braun.sats"

(* ****** ****** *)
//
implement{a}
compare_elt_elt (x1, x2, cmp) = cmp (x1, x2)
//
(* ****** ****** *)

datatype
brauntree (a:t@ype+, int) =
  | {n1,n2:nat | n2 <= n1; n1 <= n2+1}
    B (a, n1+n2+1) of (a, brauntree (a, n1), brauntree (a, n2))
  | E (a, 0) of ((*void*))
// end of [brauntree]

stadef bt = brauntree // an abbreviation

(* ****** ****** *)

assume
heap_t0ype_type (a:t@ype) = [n:nat] brauntree (a, n)

(* ****** ****** *)

implement{} funheap_make_nil () = E ()

(* ****** ****** *)

implement{a}
funheap_size (hp) = size (hp) where {
//
// this algorithm is taken from a paper by Chris Okasaki
//
  fun diff
    {nl,nr:nat |
     nr <= nl && nl <= nr+1} .<nr>.
    (nr: size_t nr, t: bt (a, nl)):<> int (nl-nr) =
  (
    case+ t of
    | B (_, tl, tr) =>
      (
        if nr > 0 then let
          val nr2 = half (nr)
        in
          if nr > nr2 + nr2 then diff (nr2, tl) else diff (nr2-1, tr)
        end else begin
          1 // return value
        end // end of [if]
      ) (* end of [B] *)
    | E ((*void*)) => 0
  ) (* end of [diff] *)
//
  fun size {n:nat} .<n>.
    (t: bt (a, n)):<> size_t n = case+ t of
    | B (_, tl, tr) => let
        val nr = size tr; val d1 = diff (nr, tl) + 1
      in
        nr + nr + i2sz(d1)
      end // end of [B]
    | E ((*void*)) => i2sz(0)
  // end of [size]
} // end of [funheap_size]

(* ****** ****** *)

implement{a}
funheap_height (hp) =
  loop (hp, 0) where {
//
fun loop {n:nat} .<n>.
  (t: bt (a, n), res: intGte(0)):<> intGte(0) =
(
  case+ t of B (_, tl, _) => loop (tl, res + 1) | E () => res
) (* end of [loop] *)
//
} (* end of [funheap_height] *)

(* ****** ****** *)

implement{a}
funheap_insert
  (hp, x, cmp) = () where {
//
fun insert {n:nat} .<n>.
  (t: bt (a, n), x: a):<cloref> bt (a, n+1) =
  case+ t of
  | E () => B{a}(x, E (), E ())
  | B (x0, t1, t2) => let
      val sgn = compare_elt_elt<a> (x0, x, cmp)
    in
      if sgn >= 0 then
        B{a}(x, insert (t2, x0), t1) else B{a}(x0, insert (t2, x), t1)
      // end of [if]
    end // end of [B]
// end of [insert]
//
val () = hp := insert (hp, x)
//
} (* end of [funheap_insert] *)

(* ****** ****** *)

fun{a:t@ype}
brauntree_leftrem{n:pos} .<n>.
  (t: bt (a, n), x_r: &a? >> a):<!wrt> bt (a, n-1) = let
//
val+B (x, t1, t2) = t
//
in
//
case+ t1 of
| B _ => let
    val t1 = brauntree_leftrem (t1, x_r) in B{a}(x, t2, t1)
  end // end of [B]
| E () => (x_r := x; E ())
//
end // end of [brauntree_leftrem]

(* ****** ****** *)

fn{a:t@ype}
brauntree_siftdn
  {nl,nr:nat |
   nr <= nl; nl <= nr+1}
(
  x: a
, tl: bt (a, nl), tr: bt (a, nr)
, cmp: cmp a
) :<> bt (a, nl+nr+1) =
  siftdn (x, tl, tr) where {
//
fun siftdn
  {nl,nr:nat | nr <= nl; nl <= nr+1} .<nl+nr>.
  (x: a, tl: bt (a, nl), tr: bt (a, nr))
  :<cloref> bt (a, nl+nr+1) = case+ (tl, tr) of
  | (B (xl, tll, tlr), B (xr, trl, trr)) =>
    (
      if compare_elt_elt<a> (xl, x, cmp) >= 0 then begin // xl >= x
        if compare_elt_elt<a> (xr, x, cmp) >= 0
          then B{a}(x, tl, tr) else B{a}(xr, tl, siftdn (x, trl, trr))
        // end of [if]
      end else begin // xl < x
        if compare_elt_elt<a> (xr, x, cmp) >= 0 then B{a}(xl, siftdn (x, tll, tlr), tr)
        else begin // xr < x
          if compare_elt_elt<a> (xl, xr, cmp) >= 0
            then B{a}(xr, tl, siftdn (x, trl, trr)) else B{a}(xl, siftdn (x, tll, tlr), tr)
          // end of [if]
        end // end of [if]
      end (* end of [if] *)
    ) (* end of [B _, B _] *)
  | (_, _) =>> (
    case+ tl of
    | B (xl, _, _) =>
        if compare_elt_elt<a> (xl, x, cmp) >= 0 then B{a}(x, tl, E) else B{a}(xl, B{a}(x, E, E), E)
      // end of [B]
    | E ((*void*)) => B{a}(x, E (), E ())
    ) (* end of [_, _] *)
// end of [siftdn]
//
} (* end of [brauntree_siftdn] *)

(* ****** ****** *)

implement{a}
funheap_delmin
  (hp0, cmp, res) = let
//
fun delmin{n:pos} .<>.
(
  t: bt (a, n), res: &a? >> a
) :<!wrt> bt (a, n-1) = let
  val+B (x, t1, t2) = t; val () = res := x in
  case+ t1 of
  | B _ => let
      var x_lrm: a // uninitialized
      val t1 = brauntree_leftrem<a> (t1, x_lrm) in
      brauntree_siftdn<a> (x_lrm, t2, t1, cmp)
    end // end of [B]
  | E ((*void*)) => E ()
end // end of [demin]
//
in
//
case+ hp0 of
| B _ => let
    val () = hp0 := delmin (hp0, res)
    prval () = opt_some {a} (res) in true (*removed*)
  end // end of [B_]
| E _ => let
    prval () = opt_none {a} (res) in false(*notremoved*)
  end // end of [E]
//
end // end of [funheap_delmin]

(* ****** ****** *)

implement{a}
funheap_delmin_opt
  (hp0, cmp) = let
//
var res: a? // uninitized
val ans = funheap_delmin<a> (hp0, cmp, res)
//
in
//
if ans
  then let
    prval () = opt_unsome{a}(res) in Some_vt{a}(res)
  end // end of [then]
  else let
    prval () = opt_unnone{a}(res) in None_vt{a}(*void*)
  end // end of [else]
// end of [if]
//
end // end of [funheap_delmin_opt]

(* ****** ****** *)

(* end of [funheap_brauntree.dats] *)
