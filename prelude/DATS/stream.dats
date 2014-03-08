(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: July, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [stream.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement{a}
stream2list (xs) = let
//
fun loop
(
  xs: stream (a), res: &ptr? >> List0_vt (a)
) : void = let
in
  case+ !xs of
  | stream_cons
      (x, xs) => let
      val () =
      res := list_vt_cons{a}{0}(x, _)
      val+list_vt_cons (_, res1) = res
      val ((*void*)) = loop (xs, res1)
    in
      fold@ (res)
    end // end of [stream_cons]
  | stream_nil () => res := list_vt_nil ()
end // end of [loop]
var res: ptr // uninitialized
val () = $effmask_all (loop (xs, res))
//
in
  res
end // end of [stream2list]

(* ****** ****** *)

implement{a}
stream_nth_exn
  (xs, n) = let
in
  case+ !xs of
  | stream_cons
      (x, xs) =>
    (
      if n > 0
        then stream_nth_exn<a> (xs, pred(n)) else (x)
      // end of [if]
    )
  | stream_nil () => $raise StreamSubscriptExn()
end // end of [stream_nth_exn]

implement{a}
stream_nth_opt
  (xs, n) = let
in
  try Some_vt(stream_nth_exn<a> (xs, n)) with ~StreamSubscriptExn() => None_vt()
end // end of [stream_nth_opt]

(* ****** ****** *)

implement{a}
stream_take_exn
  (xs, n) = let
//
fun loop{n:nat}
(
  xs: stream a, res: &ptr? >> list_vt (a, n-k), n: int n
) : #[k:nat | k <= n] int k =
  if n > 0 then (
    case+ !xs of
    | stream_cons
        (x, xs) => let
        val () =
        res := list_vt_cons{a}{0}(x, _)
        val+list_vt_cons (_, res1) = res
        val k = loop (xs, res1, pred(n))
        prval () = fold@ (res)
      in
        k
      end // end of [stream_cons]
    | stream_nil () => let
        val () = res := list_vt_nil () in n
      end // end of [stream_nil]
  ) else let
    val () = res := list_vt_nil () in n
  end // end of [if]
//
var res: ptr // uninitialized
val k = $effmask_all (loop (xs, res, n))
//
in
//
$effmask_all (
if k = 0 then res else let
  val () = list_vt_free (res) in $raise StreamSubscriptExn()
end // end of [if]
) // end of [$effmask_all]
//
end // end of [stream_take_exn]

(* ****** ****** *)

implement{a}
stream_drop_exn
  (xs, n) = let
in
//
if n > 0 then
(
  case+ !xs of
  | stream_cons
      (_, xs) => stream_drop_exn (xs, pred(n))
  | stream_nil () => $raise StreamSubscriptExn()
) else (xs) // end of [if]
//
end // end of [stream_drop_exn]

(* ****** ****** *)

local

fun{a:t0p}
stream_filter_con
  (xs: stream a): stream_con(a) = let
in
//
case+ !xs of
| stream_cons
    (x, xs) =>
  (
    if stream_filter$pred<a> (x)
      then stream_cons{a}(x, stream_filter<a> (xs)) else stream_filter_con<a> (xs)
    // end of [if]
  ) // end of [stream_cons]
| stream_nil () => stream_nil ()
//
end // end of [stream_filter_con]

in (* in of [local] *)

implement{a}
stream_filter (xs) =
  $delay (stream_filter_con<a> (xs))
// end of [stream_filter]

implement{a}
stream_filter_fun (xs, p) = let
//
implement{a2}
stream_filter$pred (x) = p($UN.cast{a}(x))
//
in
  stream_filter (xs)
end // end of [stream_filter_fun]

implement{a}
stream_filter_cloref (xs, p) = let
//
implement{a2}
stream_filter$pred (x) = p($UN.cast{a}(x))
//
in
  stream_filter (xs)
end // end of [stream_filter_cloref]

end // end of [local]

(* ****** ****** *)

implement
{a}{b}
stream_map
  (xs) = $delay (
(
case+ !xs of
| stream_cons
    (x, xs) => let
    val y = stream_map$fopr<a><b> (x)
  in
    stream_cons{b}(y, stream_map<a><b> (xs))
  end // end of [stream_cons]
| stream_nil () => stream_nil ()
) : stream_con (b)
) // end of [stream_map]

implement
{a}{b}
stream_map_fun
  (xs, f) = let
//
implement
{a2}{b2}
stream_map$fopr (x) = $UN.cast{b2}(f($UN.cast{a}(x)))
//
in
  stream_map<a><b> (xs)
end // end of [stream_map_fun]

implement
{a}{b}
stream_map_cloref
  (xs, f) = let
//
implement
{a2}{b2}
stream_map$fopr (x) = $UN.cast{b2}(f($UN.cast{a}(x)))
//
in
  stream_map<a><b> (xs)
end // end of [stream_map_cloref]

(* ****** ****** *)

local

#define :: stream_cons

in (* in of [local] *)

implement
{a1,a2}{b}
stream_map2
(
  xs1, xs2
) = $delay (
(
case+ !xs1 of
| x1 :: xs1 => (
  case+ !xs2 of
  | x2 :: xs2 => let
      val y =
        stream_map2$fopr<a1,a2><b> (x1, x2)
      // end of [val]
    in
      stream_cons{b}(y, stream_map2<a1,a2><b> (xs1, xs2))
    end // end of [::]
  | stream_nil () => stream_nil ()
  ) // end of [::]
| stream_nil () => stream_nil ()
) : stream_con (b)
) // end of [stream_map2]

end // end of [local]

implement
{a1,a2}{b}
stream_map2_fun
  (xs1, xs2, f) = let
//
implement
{a12,a22}{b2}
stream_map2$fopr (x1, x2) =
  $UN.cast{b2}(f($UN.cast{a1}(x1), $UN.cast{a2}(x2)))
//
in
  stream_map2<a1,a2><b> (xs1, xs2)
end // end of [stream_map2_fun]

implement
{a1,a2}{b}
stream_map2_cloref
  (xs1, xs2, f) = let
//
implement
{a12,a22}{b2}
stream_map2$fopr (x1, x2) =
  $UN.cast{b2}(f($UN.cast{a1}(x1), $UN.cast{a2}(x2)))
//
in
  stream_map2<a1,a2><b> (xs1, xs2)
end // end of [stream_map2_cloref]

(* ****** ****** *)

implement{a}
stream_merge$cmp (x1, x2) = gcompare_val<a> (x1, x2)

(* ****** ****** *)

local

#define :: stream_cons

in (* in of [local] *)

implement{a}
stream_merge
  (xs10, xs20) = $delay
(
(
case+ !xs10 of
| x1 :: xs1 => (
  case+ !xs20 of
  | x2 :: xs2 => let
      val sgn =
        stream_merge$cmp<a> (x1, x2)
      // end of [val]
    in
      if sgn <= 0 then
        stream_cons{a}(x1, stream_merge (xs1, xs20))
      else
        stream_cons{a}(x2, stream_merge (xs10, xs2))
      // end of [if]
    end // end of [::]
  | stream_nil () => stream_cons{a}(x1, xs1)
  ) (* end of [::] *)
| stream_nil () => !xs20
) : stream_con (a)
) // end of [stream_merge]

end // end of [local]

implement{a}
stream_merge_fun
  (xs1, xs2, cmp) = let
//
implement{a2}
stream_merge$cmp (x1, x2) =
  cmp ($UN.cast{a}(x1), $UN.cast{a}(x2))
//
in
  stream_merge (xs1, xs2)
end // end of [stream_merge_fun]

implement{a}
stream_merge_cloref
  (xs1, xs2, cmp) = let
//
implement{a2}
stream_merge$cmp (x1, x2) =
  cmp ($UN.cast{a}(x1), $UN.cast{a}(x2))
//
in
  stream_merge (xs1, xs2)
end // end of [stream_merge_cloref]

(* ****** ****** *)

implement{a}
stream_mergeq$cmp (x1, x2) = gcompare_val<a> (x1, x2)

(* ****** ****** *)

local

#define :: stream_cons

in (* in of [local] *)

implement{a}
stream_mergeq
  (xs10, xs20) = $delay
(
(
case+ !xs10 of
| x1 :: xs1 => (
  case+ !xs20 of
  | x2 :: xs2 => let
      val sgn =
        stream_mergeq$cmp<a> (x1, x2)
      // end of [val]
    in
      if sgn < 0 then
        stream_cons{a}(x1, stream_mergeq (xs1, xs20))
      else if sgn > 0 then
        stream_cons{a}(x2, stream_mergeq (xs10, xs2))
      else
        stream_cons{a}(x1(*=x2*), stream_mergeq (xs1, xs2))
      // end of [if]
    end // end of [::]
  | stream_nil () => stream_cons{a}(x1, xs1)
  ) (* end of [::] *)
| stream_nil () => !xs20
) : stream_con (a)
) // end of [stream_mergeq]

end // end of [local]

implement{a}
stream_mergeq_fun
  (xs1, xs2, cmp) = let
//
implement{a2}
stream_mergeq$cmp (x1, x2) =
  cmp ($UN.cast{a}(x1), $UN.cast{a}(x2))
//
in
  stream_mergeq (xs1, xs2)
end // end of [stream_mergeq_fun]

implement{a}
stream_mergeq_cloref
  (xs1, xs2, cmp) = let
//
implement{a2}
stream_mergeq$cmp (x1, x2) =
  cmp ($UN.cast{a}(x1), $UN.cast{a}(x2))
//
in
  stream_mergeq (xs1, xs2)
end // end of [stream_mergeq_cloref]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [stream.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [stream.dats] *)
