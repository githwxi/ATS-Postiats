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
#print "Loading [stream_vt.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement{a}
stream_vt_free (xs) = ~(xs)

(* ****** ****** *)

implement{a}
stream_vt_drop
  (xs, n) = let
in
//
if n > 0 then
(
case+ !xs of
| ~stream_vt_cons
    (_, xs) => stream_vt_drop (xs, n-1)
| ~stream_vt_nil ((*void*)) => None_vt ()
) else (
  Some_vt{stream_vt(a)}(xs)
) (* end of [if] *)
//
end // end of [stream_vt_drop]

(* ****** ****** *)

implement{a}
stream_vt_foreach
  (xs) = let
  var env: void = ()
in
  stream_vt_foreach_env<a><void> (xs, env)
end // end of [stream_vt_foreach]

implement{a}{env}
stream_vt_foreach_env
  (xs, env) = let
  val xs_con = !xs
in
//
case+ xs_con of
| @stream_vt_cons
    (x, xs1) => let
    val xs1 = xs1
    val () = stream_vt_foreach$fwork<a> (x, env)
    val () = free@ {a} (xs_con)
  in
    stream_vt_foreach<a> (xs1)
  end // end of [stream_vt_cons]
| ~stream_vt_nil () => ()
//
end // end of [stream_vt_foreach_env]

(* ****** ****** *)
//
// HX-2012: casting stream_cons to list_cons
//
extern
castfn stream2list_vt_cons
  {l0,l1,l2:addr}
  (x: stream_vt_cons_unfold (l0, l1, l2)):<> list_vt_cons_unfold (l0, l1, l2)
// end of [stream2list_vt_cons]

implement{a}
stream2list_vt (xs) = let
//
fun loop (
  xs: stream_vt a
) :<!laz> List0_vt (a) = let
  val xs_con = !xs
in
  case+ xs_con of
  | @stream_vt_cons (x, xs1) => let
      val xs1_val = xs1
      val () = xs1 := loop (xs1_val)
      val xs_con = stream2list_vt_cons (xs_con)
    in
      fold@ (xs_con); xs_con
    end // end of [stream_cons]
  | ~stream_vt_nil () => list_vt_nil ()
end // end of [loop]
//
in
  loop (xs)
end // end of [stream2list_vt]

(* ****** ****** *)

local

fun{a:t0p}
stream_vt_filter_con
(
  xs: stream_vt (a)
) : stream_vt_con (a) = let
  val xs = !xs
in
//
case+ xs of
| @stream_vt_cons
    (x, xs1) => let
    val test =
      stream_vt_filter$pred<a> (x)
    // end of [val]
  in
    if test then let
      val () =
      xs1 := stream_vt_filter (xs1)
    in
      fold@{a}(xs); xs
    end else let
      val xs1 = xs1
      val ((*void*)) = free@{a}(xs)
    in
      stream_vt_filter_con<a> (xs1)
    end // end of [if]
  end // end of [cons]
| ~stream_vt_nil((*void*)) => stream_vt_nil()
//
end (* end of [stream_vt_filter_con] *)

in (* in of [local] *)

implement{a}
stream_vt_filter (xs) =
  $ldelay (stream_vt_filter_con<a> (xs), ~xs)
// end of [stream_vt_filter]

implement{a}
stream_vt_filter_fun
  (xs, pred) = let
//
implement{a2}
stream_vt_filter$pred (x) = let
//
val p = addr@(x)
val (pf, fpf | p) = $UN.ptr0_vtake{a}(p)
val test = pred (!p)
prval ((*void*)) = fpf (pf)
//
in
  test
end // end of [stream_vt_filter$pred]
//
in
  stream_vt_filter (xs)
end // end of [stream_vt_filter_fun]

end // end of [local]

(* ****** ****** *)

local

fun{}
auxfree{a:t0p} (
  pred: (&a) -<cloptr> bool
) : void = cloptr_free ($UN.castvwtp0{cloptr0}(pred))

fun{a:t0p}
stream_vt_filter_cloptr_con
(
  xs: stream_vt (a), pred: (&a) -<cloptr> bool
) : stream_vt_con (a) = let
  val xs = !xs
in
//
case+ xs of
| @stream_vt_cons
    (x, xs1) => let
    val test = pred (x)
  in
    if test then let
      val () = xs1 :=
      stream_vt_filter_cloptr (xs1, pred)
    in
      fold@{a}(xs); xs
    end else let
      val xs1 = xs1
      val ((*void*)) = free@{a}(xs)
    in
      stream_vt_filter_cloptr_con<a> (xs1, pred)
    end // end of [if]
  end // end of [cons]
| ~stream_vt_nil () =>
    let val () = auxfree(pred) in stream_vt_nil(*void*) end
//
end (* end of [stream_vt_filter_cloptr_con] *)

in (* in of [local] *)

implement{a}
stream_vt_filter_cloptr
  (xs, pred) = $ldelay
(
  stream_vt_filter_cloptr_con<a> (xs, pred), (~xs; auxfree(pred))
) (* end of [stream_vt_filter_cloptr] *)

end // end of [local]

(* ****** ****** *)

local

fun{
a:vt0p}{b:vt0p
} stream_vt_map_con
(
  xs: stream_vt (a)
) : stream_vt_con (b) = let
  val xs_con = !xs
in
//
case+ xs_con of
| @stream_vt_cons (x, xs) => let
    val y = stream_vt_map$fopr<a><b> (x)
    val xs = xs
    val ((*void*)) = free@ (xs_con)
  in
    stream_vt_cons{b}(y, stream_vt_map<a><b> (xs))
  end (* end of [stream_vt_con] *)
| ~stream_vt_nil ((*void*)) => stream_vt_nil ()
//
end // end of [stream_vt_map_con]

in (* in of [local] *)

implement
{a}{b}(*tmp*)
stream_vt_map (xs) = $ldelay (stream_vt_map_con<a><b> (xs), ~xs)

end // end of [local]

(* ****** ****** *)

implement
{a}{b}(*tmp*)
stream_vt_map_fun
  (xs, f) = let
//
implement
{a2}{b2}
stream_vt_map$fopr (x) = let
  prval () = __assert (x) where
  {
    extern praxi __assert (x: &a2 >> a2?!): void
  }
  val (
    pf, fpf | p_x
  ) = $UN.ptr0_vtake{a}(addr@x)
  val res = $UN.castvwtp0{b2}(f(!p_x))
  prval () = $UN.castview0{void}(@(fpf, pf))
in
  res
end (* end of [stream_vt_map$fopr] *)
//
in
  stream_vt_map<a><b> (xs)
end // end of [stream_vt_map_fun]

(* ****** ****** *)

local

fun{
a1,a2:t0p}{b:vt0p
} stream_vt_map2_con
(
  xs1: stream_vt (a1)
, xs2: stream_vt (a2)
) : stream_vt_con (b) = let
  val xs1_con = !xs1
in
//
case+ xs1_con of
| @stream_vt_cons
    (x1, xs1) => let
    val xs2_con = !xs2
  in
    case+ xs2_con of
    | @stream_vt_cons
        (x2, xs2) => let
        val y = stream_vt_map2$fopr<a1,a2><b> (x1, x2)
        val xs1 = xs1
        and xs2 = xs2
        val () = free@ (xs1_con)
        and () = free@ (xs2_con)
      in
        stream_vt_cons{b}(y, stream_vt_map2<a1,a2><b> (xs1, xs2))
      end // end of [stream_vt_cons]
    | ~stream_vt_nil () => let
        val xs1 = xs1
        val () = free@ (xs1_con)
      in
        ~xs1; stream_vt_nil ()
      end // end of [stream_vt_nil]
  end // end of [stream_vt_cons]
| ~stream_vt_nil ((*void*)) => (~xs2; stream_vt_nil ())
//
end // end of [stream_vt_map_con]

in (* in of [local] *)

implement
{a1,a2}{b}
stream_vt_map2
  (xs1, xs2) = $ldelay
  (stream_vt_map2_con<a1,a2><b> (xs1, xs2), (~xs1; ~xs2))
// end of [stream_vt_map2]

implement
{a1,a2}{b}
stream_vt_map2_fun
  (xs1, xs2, f) = let
//
implement
{a12,a22}{b2}
stream_vt_map2$fopr
  (x1, x2) = let
  val (
    pf1, fpf1 | p_x1
  ) = $UN.ptr0_vtake{a1}(addr@x1)
  and (
    pf2, fpf2 | p_x2
  ) = $UN.ptr0_vtake{a2}(addr@x2)
  val res =
    $UN.castvwtp0{b2}(f(!p_x1, !p_x2))
  prval () = fpf1 (pf1) and () = fpf2 (pf2)
in
  res
end (* end of [stream_vt_map2$fopr] *)
//
in
  stream_vt_map2<a1,a2><b> (xs1, xs2)
end // end of [stream_vt_map2_fun]

end // end of [local]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [stream_vt.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [stream_vt.dats] *)
