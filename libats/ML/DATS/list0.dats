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
(* Start time: June, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

implement{a}
list0_head_exn
  (xs) = let
in
  case+ xs of
  | list0_cons (x, _) => x
  | list0_nil _ => $raise ListSubscriptExn()
end // end of [list0_head_exn]

implement{a}
list0_head_opt (xs) = (
  case+ xs of
  | list0_cons (x, _) => Some0 (x) | list0_nil _ => None0 ()
) // end of [list0_head_opt]

(* ****** ****** *)

implement{a}
list0_tail_exn
  (xs) = let
in
  case+ xs of
  | list0_cons (_, xs) => xs
  | list0_nil _ => $raise ListSubscriptExn()
end // end of [list0_tail_exn]

implement{a}
list0_tail_opt (xs) = (
  case+ xs of
  | list0_cons (_, xs) => Some0 (xs) | list0_nil _ => None0 ()
) // end of [list0_tail_opt]

(* ****** ****** *)

implement{a}
list0_make_elt (n, x) = let
  val xs = list_make_elt<a> (n, x) in list0_of_list_vt (xs)
end // end of [list0_make_elt]

(* ****** ****** *)

local

fun{a:t0p}
loop
  {i:nat} .<i>. (
  xs: list0 (a), i: int i
) :<!exn> a = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      if i > 0 then loop (xs, i-1) else x
  | list0_nil () => $raise ListSubscriptExn()
end // end of [loop]

in // in of [local]

implement{a}
list0_nth_exn
  (xs, i) = let
  val i = g1ofg0_int (i)
in
  if i >= 0 then
    loop<a> (xs, i) else $raise ListSubscriptExn()
  // end of [if]
end // end of [list0_nth_exn]

implement{a}
list0_nth_opt
  (xs, i) = let
  val i = g1ofg0_int (i)
in
//
$effmask_exn (
  if i >= 0 then (
    try
      Some0 (loop<a> (xs, i))
    with
      ~ListSubscriptExn () => None0 ()
    // end of [try]
  ) else None0 () // end of [if]
) // end of [$effmask_exn]
//
end // end of [list0_nth_opt]

end // end of [local]

(* ****** ****** *)

implement{a}
list0_append (xs, ys) = let
  val xs = list_of_list0 (xs) and ys = list_of_list0 (ys)
in
  list0_of_list (list_append<a> (xs, ys))
end // end of [list0_append]

(* ****** ****** *)

implement{a}
list0_reverse (xs) =
  list0_reverse_append<a> (xs, list0_nil)
// end of [list0_reverse]

implement{a}
list0_reverse_append (xs, ys) = let
  val xs = list_of_list0 (xs) and ys = list_of_list0 (ys)
in
  list0_of_list (list_reverse_append<a> (xs, ys))
end // end of [list0_reverse_append]

(* ****** ****** *)

implement{a}
list0_concat
  (xss) = let
  typedef xss = List(List(a))
  val xss =
    $UN.cast {xss} (xss)
  val ys = list_concat<a> (xss)
in
  list0_of_list_vt (ys)
end // end of [list0_concat]

(* ****** ****** *)

implement{a}
list0_app (xs, f) = list0_foreach (xs, f)

(* ****** ****** *)

implement{a}
list0_foreach (xs, f) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      (f (x); list0_foreach (xs, f))
  | list0_nil () => ()
end // end of [list0_foreach]

implement{a}
list0_iforeach
  (xs, f) = let
  fun loop (
    i: int, xs: list0 (a), f: cfun2 (int, a, void)
  ) : void =
    case+ xs of
    | list0_cons (x, xs) =>
        (f (i, x); loop (i+1, xs, f))
    | list0_nil () => ()
  // end of [loop]
in
  loop (0, xs, f)
end // end of [list0_iforeach]

(* ****** ****** *)

implement
{a1,a2}
list0_foreach2
  (xs1, xs2, f) = let
  var eq: int // uninitialized
in
  list0_foreach2_eq (xs1, xs2, f, eq)
end // end of [list0_foreach2]

implement
{a1,a2}
list0_foreach2_eq
  (xs1, xs2, f, eq) = let
in
  case+ xs1 of
  | list0_cons (x1, xs1) => (
    case+ xs2 of
    | list0_cons (x2, xs2) =>
        (f (x1, x2); list0_foreach2_eq (xs1, xs2, f, eq))
    | list0_nil () => (eq := 1)
    )
  | list0_nil () => (
    case+ xs2 of
    | list0_cons _ => (eq := ~1) | list0_nil () => (eq := 0)
    )
end // end of [list0_foreach2_eq]

(* ****** ****** *)

implement
{a}{res}
list0_foldleft (xs, ini, f) = let
in
  case+ xs of
  | list0_cons (x, xs) => let
      val ini = f (ini, x) in list0_foldleft (xs, ini, f)
    end // end of [list0_cons]
  | list0_nil () => ini
end // end of [list0_foldleft]

implement
{a}{res}
list0_ifoldleft
  (xs, ini, f) = let
  fun loop (
    i: int, xs: list0 (a), ini: res, f: cfun3 (res, int, a, res)
  ) : res =
    case+ xs of
    | list0_cons (x, xs) => let
        val init = f (ini, i, x) in loop (i+1, xs, ini, f)
      end // end of [list0_cons]
    | list0_nil () => ini
  // end of [loop]
in
  loop (0, xs, ini, f)
end // end of [list0_ifoldleft]

(* ****** ****** *)

implement
{a1,a2}{res}
list0_foldleft2
  (xs1, xs2, ini, f) = let
in
  case+ xs1 of
  | list0_cons (x1, xs1) => (
    case+ xs2 of
    | list0_cons (x2, xs2) => let
        val init = f (ini, x1, x2) in list0_foldleft2 (xs1, xs2, ini, f)
      end // end of [list0_cons]
    | list0_nil () => ini
    )
  | list0_nil () => ini
end // end of [list0_foldleft2]

(* ****** ****** *)

implement
{a}{res}
list0_foldright
  (xs, f, snk) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      f (x, list0_foldright (xs, f, snk))
  | list0_nil () => snk
end // end of [list0_foldright]

(* ****** ****** *)

implement{a}
list0_exists (xs, p) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      if p (x) then true else list0_exists (xs, p)
  | list0_nil () => false
end // end of [list0_exists]

implement
{a1,a2}
list0_exists2
  (xs1, xs2, p) = let
in
  case+ xs1 of
  | list0_cons (x1, xs1) => (
    case+ xs2 of
    | list0_cons (x2, xs2) =>
        if p (x1, x2) then true else list0_exists2 (xs1, xs2, p)
    | list0_nil () => false
    )
  | list0_nil () => false
end // end of [list0_exists2]

(* ****** ****** *)

implement{a}
list0_forall (xs, p) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      if p (x) then list0_forall (xs, p) else false
  | list0_nil () => true
end // end of [list0_forall]

(* ****** ****** *)

implement
{a1,a2}
list0_forall2
  (xs1, xs2, p) = let
  var eq: int // uninitialized
in
  list0_forall2_eq (xs1, xs2, p, eq)
end // end of [list0_forall2]

implement
{a1,a2}
list0_forall2_eq
  (xs1, xs2, p, eq) = let
in
  case+ xs1 of
  | list0_cons (x1, xs1) => (
    case+ xs2 of
    | list0_cons (x2, xs2) =>
        if p (x1, x2) then
          list0_forall2_eq (xs1, xs2, p, eq) else (eq := 0; false)
        // end of [if]
    | list0_nil () => (eq := 1; true)
    )
  | list0_nil () => (
    case+ xs2 of
    | list0_cons _ => (eq := ~1; true) | list0_nil () => (eq := 0; true)
    )
end // end of [list0_forall2_eq]

(* ****** ****** *)

implement{a}
list0_find_exn (xs, p) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      if p (x) then x else list0_find_exn (xs, p)
  | list0_nil () => $raise NotFoundExn()
end // end of [list0_find_exn]

implement{a}
list0_find_opt (xs, p) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      if p (x) then Some0 (x) else list0_find_opt (xs, p)
  | list0_nil () => None0 ()
end // end of [list0_find_opt]

(* ****** ****** *)

(*
implement
{a}{b}
list0_map (xs, f) = let
  viewdef v = unit_v
  viewtypedef vt = cfun (a, b)
  val xs = list_of_list0 (xs)
  fun app .<>.
    (pfu: !unit_v | x: a, f: !vt): b = f (x)
  // end of [fun]
  prval pfu = unit_v ()
  var f = f
  val ys = list_map_funenv<a><b> {v}{vt} (pfu | xs, app, f)
  prval () = topize (f)
  prval unit_v () = pfu
in
  list0_of_list_vt (ys)
end // end of [list0_map]
*)
implement
{a}{b}
list0_map (xs, f) = let
//
val xs = list_of_list0 (xs)
implement list_map__fwork<a><b> (x) = f (x)
val ys = list_map<a><b> (xs)
//
in
  list0_of_list_vt (ys)
end // end of [list0_map]

implement
{a}{b}
list0_imap (xs, f) = let
//
val xs = list_of_list0 (xs)
implement list_imap__fwork<a><b> (i, x) = f (i, x)
val ys = list_imap<a><b> (xs)
//
in
  list0_of_list_vt (ys)
end // end of [list0_imap]

(*
implement
{a1,a2}{b}
list0_map2
  (xs1, xs2, f) = let
  viewdef v = unit_v
  viewtypedef vt = cfun2 (a1, a2, b)
  val xs1 = list_of_list0 (xs1)
  val xs2 = list_of_list0 (xs2)
  fun app .<>.
    (pfu: !unit_v | x1: a1, x2: a2, f: !vt): b = f (x1, x2)
  // end of [fun]
  prval pfu = unit_v ()
  var f = f
  val ys = list_map2_funenv<a1,a2><b> {v}{vt} (pfu | xs1, xs2, app, f)
  prval () = topize (f)
  prval unit_v () = pfu
in
  list0_of_list_vt (ys)
end // end of [list0_map2]
*)
implement
{a1,a2}{b}
list0_map2 (xs1, xs2, f) = let
//
val xs1 = list_of_list0 (xs1)
val xs2 = list_of_list0 (xs2)
implement list_map2__fwork<a1,a2><b> (x1, x2) = f (x1, x2)
val ys = list_map2<a1,a2><b> (xs1, xs2)
//
in
  list0_of_list_vt (ys)
end // end of [list0_map2]

(* ****** ****** *)

implement{a}
list0_filter (xs, p) = let
  viewdef v = unit_v
  viewtypedef vt = cfun (a, bool)
  val xs = list_of_list0 (xs)
  fun app .<>.
    (pfu: !unit_v | x: a, p: !vt): bool = p (x)
  // end of [fun]
  prval pfu = unit_v ()
  var p = p
  val ys = list_filter_funenv<a> {v}{vt} (pfu | xs, app, p)
  prval () = topize (p)
  prval unit_v () = pfu
in
  list0_of_list_vt (ys)
end // end of [list0_filter]

(* ****** ****** *)

implement
{x,y}
list0_zip (xs, ys) = let
  val xs = list_of_list0 (xs)
  val ys = list_of_list0 (ys)
  val xys = list_zip<x,y> (xs, ys)
in
  list0_of_list_vt (xys)
end // end of [list0_zip]

(* ****** ****** *)

(* end of [list0.dats] *)
