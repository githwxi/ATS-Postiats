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

staload "libats/SATS/funralist_nested.sats"

(* ****** ****** *)

datatype node
  (a:t@ype+, int(*d*)) =
  | N1 (a, 0) of (a) // singleton
  | {d:nat}
    N2 (a, d+1) of (node (a, d), node (a, d))
// end of [node]

datatype ralist
  (a:t@ype+, int(*d*), int(*n*)) =
  | {d:nat}
    RAnil (a, d, 0) of ()
  | {d:nat}{n:pos}
    RAevn (a, d, n+n) of ralist (a, d+1, n)
  | {d:nat}{n:nat}
    RAodd (a, d, n+n+1) of (node (a, d), ralist (a, d+1, n))
// end of [ralist]

(* ****** ****** *)

typedef ra0list
  (a:t@ype, n:int) = ralist (a, 0, n)
assume ralist_t0ype_int_type = ra0list

(* ****** ****** *)

implement{}
funralist_nil{a} () = RAnil{a}{0} ()

(* ****** ****** *)

local

fun
length{a:t0p}
  {d:nat}{n:nat} .<n>.
  (xs: ralist (a, d, n)):<> int (n) =
  case+ xs of
  | RAevn (xxs) => let
      val n2 = length (xxs) in 2 * n2
    end // end of [RAevn]
  | RAodd (_, xxs) => let
      val n2 = length (xxs) in 2 * n2 + 1
    end // end of [RAodd]
  | RAnil () => 0
// end of [length]

in // in of [local]

implement
funralist_length {a} (xs) = let
//
prval () = lemma_ralist_param (xs)
//
in
  length (xs)
end // end of [funralist_length]

end // end of [local]

(* ****** ****** *)

local

fun
cons{a:t0p}
  {d:nat}{n:nat} .<n>. (
  x0: node (a, d), xs: ralist (a, d, n)
) :<> ralist (a, d, n+1) =
  case+ xs of
  | RAevn (xxs) => RAodd (x0, xxs)
  | RAodd (x1, xxs) => let
      val x0x1 = N2 (x0, x1) in RAevn (cons (x0x1, xxs))
    end // end of [RAodd]
  | RAnil () => RAodd (x0, RAnil)
// end of [cons]

in // in of [local]

implement{a}
funralist_cons (x, xs) = let
//
prval () = lemma_ralist_param (xs)
//
in
  cons (N1(x), xs)
end // end of [funralist]

end // end of [local]

(* ****** ****** *)

local

fun
uncons{a:t0p}
  {d:nat}{n:pos} .<n>. (
  xs: ralist (a, d, n), x: &ptr? >> node (a, d)
) :<!wrt> ralist (a, d, n-1) =
  case+ xs of
  | RAevn (xxs) => let
      var xx: ptr
      val xxs = uncons (xxs, xx)
      val+ N2 (x0, x1) = xx; prval () = topize (xx)
      val () = x := x0
    in
      RAodd (x1, xxs)
    end // end of [RAevn]
  | RAodd
      (x0, xxs) => let
      val () = x := x0
    in
      case+ xxs of
      | RAnil () => RAnil () | _ =>> RAevn (xxs)
    end // end of [RAodd]
// end of [uncons]

in // in of [local]

implement{a}
funralist_uncons
  (xs, x) = let
  var nx: ptr // unintialized
  val xs = uncons (xs, nx)
  val+ N1 (x0) = nx; prval () = topize (nx)
  val () = x := x0
in
  xs
end // end of [funralist_uncons]

end // end of [local]

(* ****** ****** *)

implement{a}
funralist_head
  (xs) = x where {
  var x: a
  val _ = $effmask_wrt (funralist_uncons<a> (xs, x))
} // end of [funralist_head]

implement{a}
funralist_tail
  (xs) = xs where {
  var _x: a
  val xs = $effmask_wrt (funralist_uncons<a> (xs, _x))
} // end of [funralist_tail]

(* ****** ****** *)

local

fun
lookup{a:t0p}
  {d:nat}{n:nat} .<n>. (
  xs: ralist (a, d, n), i: natLt n
) :<> node (a, d) =
  case+ xs of
  | RAevn xxs => let
      val x01 = lookup (xxs, half i)
    in
      if i mod 2 = 0 then
        let val+ N2 (x0, _) = x01 in x0 end
      else
        let val+ N2 (_, x1) = x01 in x1 end
      // end of [if]
    end // end of [RAevn]
  | RAodd (x, xxs) =>
      if i = 0 then x else let
        val x01 = lookup (xxs, half (i-1))
      in
        if i mod 2 = 0 then
          let val+ N2 (_, x1) = x01 in x1 end
        else
          let val+ N2 (x0, _) = x01 in x0 end
        // end of [if]
      end // end of [if]
    // end of [RAodd]
// end of [lookup]

in // in of [local]

implement{a}
funralist_lookup
  (xs, i) = let
  val+ N1 (x) = lookup (xs, i) in x
end // end of [funralist_lookup]

end // end of [local]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

local

extern fun __free (p: ptr):<> void = "mac#ats_free_gc"

fun
fupdate{a:t0p}
  {d:nat}
  {n:nat} .<n,1>. (
  xs: ralist (a, d, n)
, i: natLt (n)
, f: node (a, d) -<cloref> node (a, d)
) :<> ralist (a, d, n) = let
in
  case+ xs of
  | RAevn (xxs) => RAevn (fupdate2 (xxs, i, f))
  | RAodd (x, xxs) =>
      if i = 0 then RAodd (f x, xxs) else RAodd (x, fupdate2 (xxs, i-1, f))
end // end of [fupdate]

and
fupdate2{a:t0p}
  {d:nat}
  {n2:pos} .<2*n2,0>. (
  xxs: ralist (a, d+1, n2)
, i: natLt (2*n2)
, f: node (a, d) -<cloref> node (a, d)
) :<> ralist (a, d+1, n2) = let
  typedef node = node (a, d+1)
in
  if i mod 2 = 0 then let
    val f1 = lam
      (xx: node): node =<cloref>
      let val+ N2 (x0, x1) = xx in N2 (f x0, x1) end
    // end of [val]
    val xxs =
      fupdate (xxs, i / 2, f1)
    val () = __free ($UN.cast2ptr(f1))
  in
    xxs
  end else let
    val f1 = lam
      (xx: node): node =<cloref>
      let val+ N2 (x0, x1) = xx in N2 (x0, f x1) end
    // end of [val]
    val xxs =
      fupdate (xxs, i / 2, f1)
    val () = __free ($UN.cast2ptr(f1))
  in
    xxs
  end // end of [if]
end // end of [fupdate2]

in // in of [local]

implement{a}
funralist_update
  (xs, i, x) = xs where {
  typedef node = node (a, 0)
  val f = lam (_: node): node =<cloref> N1 (x)
  val xs = fupdate (xs, i, f)
  val () = __free ($UN.cast2ptr(f))
} // end of [funralist_update]

end // end of [local]

(* ****** ****** *)

local

extern fun __free (p: ptr):<> void = "mac#ats_free_gc"

fn* foreach
  {a:t0p}
  {d:nat}{n:nat} .<n,1>. (
  xs: ralist (a, d, n), f: node (a, d) -<cloref> void
) :<> void =
  case+ xs of
  | RAevn (xxs) =>
      foreach2 (xxs, f)
    // end of [RAevn]
  | RAodd (x, xxs) => let
      val () = f (x) in case+ xxs of
      | RAnil () => () | _ =>> foreach2 (xxs, f)
    end // end of [RAodd]
  | RAnil () => ()
// end of [foreach]

and foreach2
  {a:t0p}
  {d:nat}
  {n2:pos} .<2*n2,0>. (
  xxs: ralist (a, d+1, n2), f: node (a, d) -<cloref> void
) :<> void = let
  typedef node = node (a, d+1)
  val f1 = lam
    (xx: node): void =<cloref> let
    val+ N2 (x0, x1) = xx in f (x0); f (x1)
  end // end of [val]
  val () = foreach (xxs, f1)
  prval () = __free ($UN.cast2ptr(f1))
in
  // nothing
end // end of [foreach2]

in // in of [local]

implement{a}
funralist_foreach (xs) = let
//
  prval () = lemma_ralist_param (xs)
//
  typedef node = node (a, 0)
  val f = lam
    (x: node): void =<cloref> let
    val+ N1 (x) = x in $effmask_all (funralist_foreach__fwork<a> (x))
  end // end of [val]
  val () = foreach (xs, f)
  prval () = __free ($UN.cast2ptr(f))  
in
  // nothing
end // end of [funralist_foreach]

end // end of [local]

(* ****** ****** *)

(*
//
fun{a:t0p}
funralist_iforeach__fwork (i: size_t, x: a): void
fun{a:t0p}
funralist_iforeach (xs: ralist (a)): void
//
// HX-2012-05:
// this one seems much more involved in terms of compilation
//
implement{a}
funralist_iforeach
  {n} (xs) = let
//
implement
iforeach__fwork<a>
  (i, x) = funralist_iforeach__fwork (i, x)
//
implement
funralist_foreach__fwork<a> (x) = foreach__fwork<a> (x)
implemnet(a)
foreach<ralist(a,n)><a> (xs) = funralist_foreach<a> (xs)
//
in
  iforeach<ralist(a,n)><a> (xs)
end // end of [funralist_iforeach]
*)

(* ****** ****** *)

(* end of [funralist_nested.dats] *)
