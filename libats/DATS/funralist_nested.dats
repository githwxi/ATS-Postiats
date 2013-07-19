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
//
// HX-2013-01:
//
// this data structure is essentially due to Chris Okasaki
// However, unlike Okasaki's formulation, [ralist] is *not*
// a nested datatype!
//
(* ****** ****** *)

datatype node
  (a:t@ype+, int(*d*)) =
  | N1 (a, 0) of (a) // singleton
  | {d:nat}
    N2 (a, d+1) of (node (a, d), node (a, d))
// end of [node]

datatype myralist
  (a:t@ype+, int(*d*), int(*n*)) =
  | {d:nat}
    RAnil (a, d, 0) of ()
  | {d:nat}{n:pos}
    RAevn (a, d, n+n) of myralist (a, d+1, n)
  | {d:nat}{n:nat}
    RAodd (a, d, n+n+1) of (node (a, d), myralist (a, d+1, n))
// end of [myralist]

(* ****** ****** *)

assume
ralist_type (a:t0p, n:int) = myralist (a, 0, n)

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
funralist_nil () = RAnil{a}{0} ()

(* ****** ****** *)

local

fun cons
  {a:t0p}{d:nat}{n:nat} .<n>. (
  x0: node (a, d), xs: myralist (a, d, n)
) :<> myralist (a, d, n+1) = let
in
//
case+ xs of
| RAevn (xxs) => RAodd (x0, xxs)
| RAodd (x1, xxs) => let
    val x0x1 = N2 (x0, x1) in RAevn (cons (x0x1, xxs))
  end // end of [RAodd]
| RAnil () => RAodd (x0, RAnil)
//
end // end of [cons]

in (* in of [local] *)

implement{a}
funralist_cons
  (x, xs) = let
//
prval () = lemma_ralist_param (xs)
//
in
  cons{a} (N1(x), xs)
end // end of [funralist_cons]

end // end of [local]

(* ****** ****** *)

implement{}
funralist_is_nil (xs) =
  case+ xs of RAnil () => true | _ =>> false
// end of [funralist_is_nil]

implement{}
funralist_is_cons (xs) =
  case+ xs of RAnil () => false | _ =>> true
// end of [funralist_is_cons]

(* ****** ****** *)

local

fun
length
  {a:t0p}
  {d:nat}
  {n:nat} .<n>. (
  xs: myralist (a, d, n)
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

implement{}
funralist_length {a} (xs) = let
//
prval () = lemma_ralist_param (xs)
//
in
  length{a} (xs)
end // end of [funralist_length]

end // end of [local]

(* ****** ****** *)

local

fun head
  {a:t0p}
  {d:nat}
  {n:pos} .<n>. (
  xs: myralist (a, d, n)
) :<> node (a, d) = let
in
//
case+ xs of
| RAevn (xxs) => let
    val+ N2 (x, _) = head (xxs) in x
  end // end of [RAevn]
| RAodd (x, _) => x
//
end // end of [head]

in (* in of [local] *)

implement{a}
funralist_head (xs) =
  let val+ N1 (x) = head{a} (xs) in x end
// end of [funralist_head]

end // end of [local]

(* ****** ****** *)

implement{a}
funralist_tail
  (xs) = xs1 where {
  var xs1 = xs
  val _(*hd*) = $effmask_wrt (funralist_uncons<a> (xs1))
} // end of [funralist_tail]

(* ****** ****** *)

local

fun uncons
  {a:t0p}{d:nat}{n:pos} .<n>. (
  xs: myralist (a, d, n), x: &ptr? >> node (a, d)
) :<!wrt> myralist (a, d, n-1) = let
in
//
case+ xs of
| RAevn
    (xxs) => let
    var nxx: ptr
    val xxs = uncons (xxs, nxx)
    val+ N2 (x0, x1) = nxx
    prval () = topize (nxx) // HX: this is not necessary
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
//
end // end of [uncons]

in (* in of [local] *)

implement{a}
funralist_uncons
  (xs) = let
//
var nx: ptr // unintialized
val () = (xs := uncons{a} (xs, nx))
val+ N1 (x0) = nx
prval () = topize (nx) // HX: this is not necessary
//
in
  x0
end // end of [funralist_uncons]

end // end of [local]

(* ****** ****** *)

local

fun get_at
  {a:t0p}{d:nat}{n:nat} .<n>. (
  xs: myralist (a, d, n), i: natLt n
) :<> node (a, d) = let
in
//
case+ xs of
| RAevn (xxs) => let
    val x01 = get_at (xxs, half i)
  in
    if i mod 2 = 0 then
      let val+ N2 (x0, _) = x01 in x0 end
    else
      let val+ N2 (_, x1) = x01 in x1 end
    // end of [if]
  end // end of [RAevn]
| RAodd (x, xxs) => (
    if i = 0 then x else let
      val x01 = get_at (xxs, half (i-1))
    in
      if i mod 2 = 0 then
        let val+ N2 (_, x1) = x01 in x1 end
      else
        let val+ N2 (x0, _) = x01 in x0 end
      // end of [if]
    end // end of [if]
  ) // end of [RAodd]
//
end // end of [get_at]

in (* in of [local] *)

implement{a}
funralist_get_at
  (xs, i) = let
//
val+ N1 (x) = get_at{a} (xs, i) in x (*return*)
//
end // end of [funralist_get_at]

implement{a} funralist_lookup = funralist_get_at

end // end of [local]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

local

extern
fun __free (p: ptr):<!wrt> void = "mac#ats_free_gc"
//
fun
fset_at
  {a:t0p}
  {d:nat}
  {n:nat} .<n,1>. (
  xs: myralist (a, d, n)
, i: natLt (n)
, f: node (a, d) -<cloref0> node (a, d)
) :<> myralist (a, d, n) = let
in
  case+ xs of
  | RAevn (xxs) => RAevn (fset2_at (xxs, i, f))
  | RAodd (x, xxs) =>
      if i = 0 then RAodd (f x, xxs) else RAodd (x, fset2_at (xxs, i-1, f))
end // end of [fset_at]
//
and
fset2_at
  {a:t0p}
  {d:nat}
  {n2:pos} .<2*n2,0>. (
  xxs: myralist (a, d+1, n2)
, i: natLt (2*n2)
, f: node (a, d) -<cloref0> node (a, d)
) :<> myralist (a, d+1, n2) = let
  typedef node = node (a, d+1)
in
  if i mod 2 = 0 then let
    val f1 = lam
      (xx: node): node =<cloref0>
      let val+ N2 (x0, x1) = xx in N2 (f x0, x1) end
    // end of [val]
    val xxs =
      fset_at (xxs, half(i), f1)
    val () = $effmask_wrt (__free ($UN.cast2ptr(f1)))
  in
    xxs
  end else let
    val f1 = lam
      (xx: node): node =<cloref0>
      let val+ N2 (x0, x1) = xx in N2 (x0, f x1) end
    // end of [val]
    val xxs =
      fset_at (xxs, half(i), f1)
    val () = $effmask_wrt (__free ($UN.cast2ptr(f1)))
  in
    xxs
  end // end of [if]
end // end of [fset2_at]

in (* in of [local] *)

implement{a}
funralist_set_at
  (xs, i, x0) = let
//
typedef node = node (a, 0)
val f = lam (_: node): node =<cloref0> N1 (x0)
val xs = fset_at{a} (xs, i, f)
val () = $effmask_wrt (__free ($UN.cast2ptr(f)))
//
in
  xs
end // end of [funralist_set_at]

implement{a} funralist_set_at = funralist_set_at

end // end of [local]

(* ****** ****** *)

implement{a}{env}
funralist_foreach$cont (x, env) = true

(* ****** ****** *)

local

extern
fun __free (p: ptr):<!wrt> void = "mac#ats_free_gc"

fnx foreach
  {a:t0p}
  {d:nat}{n:nat} .<n,1>. (
  xs: myralist (a, d, n), f: node (a, d) -<cloref0> void
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
  xxs: myralist (a, d+1, n2), f: node (a, d) -<cloref0> void
) :<> void = let
  typedef node = node (a, d+1)
  val f1 = lam
    (xx: node): void =<cloref0> let
    val+ N2 (x0, x1) = xx in f (x0); f (x1)
  end // end of [val]
  val () = foreach (xxs, f1)
  val () = $effmask_wrt (__free ($UN.cast2ptr(f1)))
in
  // nothing
end // end of [foreach2]

in // in of [local]

implement{a}
funralist_foreach (xs) = let
  var env: void = () in funralist_foreach_env (xs, env)
end // end of [funralist_foreach]

implement{a}{env}
funralist_foreach_env
  (xs, env) = let
//
exception DISCONT of ()
//
prval () = lemma_ralist_param (xs)
//
typedef node = node (a, 0)
//
val p_env = addr@ (env)
//
val f = lam
  (x: node): void =<cloref0> let
  val+ N1 (x) = x
  val (pf, fpf | p_env) = $UN.ptr_vtake{env}(p_env)
  val test =
    $effmask_all (funralist_foreach$cont<a> (x, !p_env))
  val () =
    $effmask_all (
    if test then funralist_foreach$fwork<a> (x, !p_env) else $raise DISCONT()
  ) : void // end of [val]
  prval () = fpf (pf)
in
  // nothing
end // end of [val]
//
val () =
  try foreach (xs, f) with ~DISCONT () => ()
// end of [val]
//
val () = $effmask_wrt (__free ($UN.cast2ptr(f)))
//
in
  // nothing
end // end of [funralist_foreach]

end // end of [local]

(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in // in of [local]

implement{a}
funralist_listize
  {n} (xs) = let
//
viewtypedef tenv = $Q.qstruct (a)
//
implement
funralist_foreach$cont<a><tenv> (x, env) = true
implement
funralist_foreach$fwork<a><tenv> (x, env) = $Q.qstruct_insert<a> (env, x)
//
var env: $Q.qstruct
val () = $Q.qstruct_initize {a} (env)
val () = $effmask_all (funralist_foreach_env (xs, env))
val res = $Q.qstruct_takeout_list (env)
val () = $Q.qstruct_uninitize {a} (env)
//
in
  $UN.castvwtp0{list_vt(a,n)}(res)
end // end of [funralist_listize]

end // end of [local]

(* ****** ****** *)

(* end of [funralist_nested.dats] *)
