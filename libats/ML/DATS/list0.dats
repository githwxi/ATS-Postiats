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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: June, 2012 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_make_sing (x) =
  list0_cons{a}(x, list0_nil)
implement
{a}(*tmp*)
list0_make_pair (x1, x2) =
  list0_cons{a}(x1, list0_cons{a}(x2, list0_nil))
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_make_elt
  (n, x) = let
//
val n = g1ofg0(n)
//
in
//
if
n >= 0
then let
  val xs =
    $effmask_wrt (list_make_elt (n, x))
  // end of [val]
in
  list0_of_list_vt (xs)
end // end of [then]
else let
in
  $raise (IllegalArgExn"list0_make_elt:n")
end // end of [else]
//
end // end of [list0_make_elt]

(* ****** ****** *)

implement
{}(*tmp*)
list0_make_intrange_lr
  (l, r) = let
  val d = (
    if l <= r then 1 else ~1
  ) : int // end of [val]
in
  $effmask_exn (list0_make_intrange_lrd (l, r, d))
end // end of [list0_make_intrange_lr]

(* ****** ****** *)

implement
{}(*tmp*)
list0_make_intrange_lrd
  (l, r, d) = let
//
typedef res = list0 (int)
//
fun loop1 // d > 0
(
  l: int, r: int
, d: int, res: &ptr? >> res
) : void = let
in
//
if l < r then let
  val () =
  (
    res := list0_cons{int}(l, _)
  )
  val+list0_cons (_, res1) = res
  val () = loop1 (l+d, r, d, res1)
  prval () = fold@ (res)
in
  // nothing
end else (res := list0_nil)
//
end // end of [loop1]
//
fun loop2 // d < 0
(
  l: int, r: int
, d: int, res: &ptr? >> res
) : void = let
in
//
if l > r then let
  val () =
  (
    res := list0_cons{int}(l, _)
  )
  val+ list0_cons (_, res1) = res
  val () = loop2 (l+d, r, d, res1)
  prval () = fold@ (res)
in
  // nothing
end else (res := list0_nil)
//
end // end of [loop2]
//
in
//
$effmask_all
(
if d > 0 then (
  if l < r then let
    var res: ptr? // uninitialized
    val () = loop1 (l, r, d, res) in res
  end else list0_nil ()
) else if d < 0 then (
  if l > r then let
    var res: ptr? // uninitialized
    val () = loop2 (l, r, d, res) in res
  end else list0_nil ()
) else (
  $raise
  IllegalArgExn("list0_make_intrange_lrd:d")
) // end of [if]
) (* end of [$effmask_all] *)
//
end // end of [list0_make_intrange_lrd]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_make_arrpsz
  (psz) =
  list0_of_list_vt(list_make_arrpsz(psz))
// end of [list0_make_arrpsz]

(* ****** ****** *)
//
implement
{a}(*tmp*)
print_list0
  (xs) = fprint_list0<a> (stdout_ref, xs)
implement
{a}(*tmp*)
prerr_list0
  (xs) = fprint_list0<a> (stderr_ref, xs)
//
implement
{a}(*tmp*)
fprint_list0
  (out, xs) = fprint_list<a> (out, g1ofg0(xs))
//
implement
{a}(*tmp*)
fprint_list0_sep
  (out, xs, sep) =
(
  fprint_list_sep<a> (out, g1ofg0(xs), sep)
) (* end of [fprint_list0_sep] *)
//
implement
{a}(*tmp*)
fprint_listlist0_sep
  (out, xss, sep1, sep2) =
(
  fprint_listlist_sep<a>
    (out, $UN.cast{List(List(a))}(xss), sep1, sep2)
) (* end of [fprint_listlist0_sep] *)
//
(* ****** ****** *)
//
(*
//
// HX: these have been declared as macros:
//
implement
{a}(*tmp*)
list0_sing (x) = list0_cons{a}(x, list0_nil)
implement
{a}(*tmp*)
list0_pair (x1, x2) =
  list0_cons{a}(x1, list0_cons{a}(x2, list0_nil))
//
*)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_is_nil(xs) = (
//
case+ xs of
| list0_cons _ => false | list0_nil() => true
//
) (* end of [list0_is_nil] *)

implement
{a}(*tmp*)
list0_is_cons(xs) = (
//
case+ xs of
| list0_cons _ => true | list0_nil() => false
//
) (* end of [list0_is_cons] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_is_empty(xs) = list0_is_nil<a> (xs)
//
implement
{a}(*tmp*)
list0_isnot_empty(xs) = list0_is_cons<a> (xs)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_head_exn
  (xs) = let
in
//
case+ xs of
| list0_cons
    (x, _) => (x)
  // list0_cons
| list0_nil _ =>
    $raise ListSubscriptExn()
  // list0_nil
end // end of [list0_head_exn]

implement
{a}(*tmp*)
list0_head_opt
  (xs) = let
in
//
case+ xs of
| list0_nil() => None_vt()
| list0_cons(x, _) => Some_vt{a}(x)
//
end // end of [list0_head_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_tail_exn
  (xs) = let
in
//
case+ xs of
| list0_cons
    (_, xs) => (xs)
  // list0_cons
| list0_nil _ =>
    $raise ListSubscriptExn()
  // list0_nil
//
end // end of [list0_tail_exn]

implement
{a}(*tmp*)
list0_tail_opt
  (xs) = let
in
//
case+ xs of
| list0_nil() => None_vt()
| list0_cons(_, xs) => Some_vt{list0(a)}(xs)
//
end // end of [list0_tail_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_last_exn
  (xs) = let
//
val xs = g1ofg0_list(xs)
//
in
//
case+ xs of
| list_cons _ => list_last (xs)
| list_nil () => $raise ListSubscriptExn()
//
end // end of [list0_last_exn]

implement
{a}(*tmp*)
list0_last_opt
  (xs) = let
//
val xs = g1ofg0_list(xs)
//
in
//
case+ xs of
| list_nil () => None_vt()
| list_cons _ => Some_vt{a}(list_last(xs))
//
end // end of [list0_last_opt]

(* ****** ****** *)

local

fun{a:t0p}
loop{i:nat} .<i>.
(
  xs: list0 (a), i: int i
) :<!exn> a = let
in
//
case+ xs of
| list0_cons
    (x, xs) =>
  (
    if i > 0 then loop<a> (xs, i-1) else x
  ) // end of [list0_cons]
| list0_nil () => $raise ListSubscriptExn()
//
end // end of [loop]

in (* in of [local] *)

implement
{a}(*tmp*)
list0_nth_exn
  (xs, i) = let
//
val i = g1ofg0_int (i)
//
in
//
if
i >= 0
then loop<a> (xs, i)
else $raise ListSubscriptExn()
//
end // end of [list0_nth_exn]

implement
{a}(*tmp*)
list0_nth_opt
  (xs, i) = let
//
val i = g1ofg0(i)
//
in
//
if
i >= 0
then (
$effmask_exn
(
  try Some_vt{a}(loop<a>(xs, i)) with ~ListSubscriptExn() => None_vt()
) (* $effmask_exn *)
) else None_vt((*void*))
//
end // end of [list0_nth_opt]

end // end of [local]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_get_at_exn
  (xs, i) = list0_nth_exn (xs, i)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_insert_at_exn
  (xs, i, x0) = let
//
fun aux {i:nat} .<i>. (
  xs: list0 a, i: int i, x0: a
) :<!exn> list0 a = let
in
//
if
i > 0
then (
//
case+ xs of
| list0_cons
    (x, xs) =>
  (
    list0_cons{a}(x, aux (xs, i-1, x0))
  )
| list0_nil() => $raise ListSubscriptExn()
//
) else (
  list0_cons{a}(x0, xs)
) (* end of [if] *)
//
end // end of [aux]
//
val i = g1ofg0_int(i)
//
in
//
if
i >= 0
then aux (xs, i, x0)
else $raise IllegalArgExn("list0_insert_at_exn:i")
//
end // end of [list0_insert_at_exn]

(* ****** ****** *)

local

fun{
a:t0p
} auxlst {i:nat} .<i>.
(
  xs: list0 (a), i: int i, x0: &a? >> a
) :<!exnwrt> list0 a = let
//
extern praxi __assert : (&a? >> a) -<prf> void
//
in
//
case+ xs of
| list0_cons
    (x, xs) => let
  in
    if i > 0 then
      list0_cons{a}(x, auxlst<a> (xs, i-1, x0))
    else let
      val () = x0 := x in xs
    end (* end of [if] *)
  end // end of [list0_cons]
| list0_nil () => let
    prval () = __assert (x0) in $raise ListSubscriptExn()
  end // end of [list0_nil]
//
end // end of [auxlst]

in (* in of [local] *)

implement
{a}(*tmp*)
list0_remove_at_exn
  (xs, i) = let
//
var x0: a?
val i = g1ofg0_int (i)
//
in
$effmask_wrt
(
if
i >= 0
then
  auxlst<a> (xs, i, x0)
else (
  $raise IllegalArgExn("list0_remove_at_exn:i")
) (* end of [else] *)
)
end // end of [list0_remove_at_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_takeout_at_exn
  (xs, i, x0) = let
//
val i = g1ofg0_int (i)
//
extern
praxi __assert : (&a? >> a) -<prf> void
//
in
//
if i >= 0 then
  auxlst<a> (xs, i, x0)
else let
  prval () = __assert (x0)
in
  $raise IllegalArgExn("list0_takeout_at_exn:i")
end // end of [if]
//
end // end of [list0_takeout_at_exn]

end // end of [local]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_length(xs) =
  list_length<a> (g1ofg0(xs))
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_append(xs, ys) = let
  val xs = g1ofg0(xs)
  and ys = g1ofg0(ys)
in
  list0_of_list(list_append<a> (xs, ys))
end // end of [list0_append]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_extend(xs, x) = let
  val xs = g1ofg0(xs)
  val xs_x =
    $effmask_wrt(list_extend<a> (xs, x))
  // end of [val]
in
  list0_of_list_vt(xs_x)
end // end of [list0_extend]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_reverse(xs) =
  list0_reverse_append<a> (xs, list0_nil)
// end of [list0_reverse]

implement
{a}(*tmp*)
list0_reverse_append
  (xs, ys) = let
  val xs = g1ofg0(xs)
  and ys = g1ofg0(ys)
in
  list0_of_list (list_reverse_append<a> (xs, ys))
end // end of [list0_reverse_append]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_concat
  (xss) = let
  typedef xss = List(List(a))
  val ys =
    $effmask_wrt (list_concat<a> ($UN.cast{xss}(xss)))
  // end of [val]
in
  list0_of_list_vt (ys)
end // end of [list0_concat]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_take_exn
  (xs, i) = let
//
val i = g1ofg0_int (i)
val xs = g1ofg0_list (xs)
//
in
  if i >= 0 then let
    val res =
      $effmask_wrt (list_take_exn (xs, i))
    // end of [val]
  in
    list0_of_list_vt (res)
  end else
    $raise (IllegalArgExn"list0_take_exn:i")
  // end of [if]
end // end of [list0_take_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_drop_exn
  (xs, i) = let
//
val i = g1ofg0_int (i)
val xs = g1ofg0_list (xs)
//
in
  if i >= 0 then
    list0_of_list (list_drop_exn (xs, i))
  else
    $raise (IllegalArgExn"list0_drop_exn:i")
  // end of [if]
end // end of [list0_drop_exn]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_app
  (xs, f) = list0_foreach (xs, f)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_foreach (xs, f) = let
in
  case+ xs of
  | list0_cons (x, xs) =>
      (f (x); list0_foreach (xs, f))
  | list0_nil () => ()
end // end of [list0_foreach]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_iforeach
  (xs, f) = let
  fun loop (
    i: int, xs: list0 (a), f: cfun2 (int, a, void)
  ) : int =
    case+ xs of
    | list0_cons (x, xs) =>
        (f (i, x); loop (i+1, xs, f))
    | list0_nil () => i
  // end of [loop]
in
  loop (0, xs, f)
end // end of [list0_iforeach]

(* ****** ****** *)

implement
{a1,a2}
list0_foreach2
  (xs1, xs2, f) = let
  var sgn: int // uninitialized
in
  list0_foreach2_eq (xs1, xs2, f, sgn)
end // end of [list0_foreach2]

implement
{a1,a2}
list0_foreach2_eq
  (xs1, xs2, f, sgn) = let
in
  case+ xs1 of
  | list0_cons (x1, xs1) => (
    case+ xs2 of
    | list0_cons (x2, xs2) =>
        (f (x1, x2); list0_foreach2_eq (xs1, xs2, f, sgn))
    | list0_nil () => (sgn := 1)
    )
  | list0_nil () => (
    case+ xs2 of
    | list0_cons _ => (sgn := ~1) | list0_nil () => (sgn := 0)
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

implement
{a}(*tmp*)
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

implement
{a}(*tmp*)
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
  var sgn: int // uninitialized
in
  list0_forall2_eq (xs1, xs2, p, sgn)
end // end of [list0_forall2]

implement
{a1,a2}
list0_forall2_eq
  (xs1, xs2, p, sgn) = let
in
  case+ xs1 of
  | list0_cons (x1, xs1) => (
    case+ xs2 of
    | list0_cons (x2, xs2) =>
        if p (x1, x2) then
          list0_forall2_eq (xs1, xs2, p, sgn) else (sgn := 0; false)
        // end of [if]
    | list0_nil () => (sgn := 1; true)
    )
  | list0_nil () => (
    case+ xs2 of
    | list0_cons _ => (sgn := ~1; true) | list0_nil () => (sgn := 0; true)
    )
end // end of [list0_forall2_eq]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_equal
  (xs1, xs2, eqfn) =
  case+ (xs1, xs2) of
  | (list0_cons (x1, xs1),
     list0_cons (x2, xs2)) =>
      if eqfn (x1, x2) then list0_equal (xs1, xs2, eqfn) else false
  | (list0_nil (), list0_nil ()) => true
  | (_, _) => false
// end of [list0_equal]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_find_exn
  (xs, p) = let
in
//
case+ xs of
| list0_cons
    (x, xs) =>
    if p (x) then x else list0_find_exn (xs, p)
| list0_nil ((*void*)) => $raise NotFoundExn()
//
end // end of [list0_find_exn]

implement
{a}(*tmp*)
list0_find_opt
  (xs, p) = let
in
//
case+ xs of
| list0_cons (x, xs) =>
  (
    if p (x) then Some_vt{a}(x) else list0_find_opt (xs, p)
  ) (* end of [list_cons] *)
| list0_nil ((*void*)) => None_vt ()
//
end // end of [list0_find_opt]

(* ****** ****** *)

implement
{a,b}(*tmp*)
list0_assoc_exn
  (xys, x0, eq) = let
in
//
case+ xys of
| list0_cons
    (xy, xys) =>
    if eq (x0, xy.0)
      then xy.1 else list0_assoc_exn<a,b> (xys, x0, eq)
    // end of [if]
| list0_nil ((*void*)) => $raise NotFoundExn()
//
end // end of [list0_assoc_exn]

implement
{a,b}(*tmp*)
list0_assoc_opt
  (xys, x0, eq) = let
in
//
case+ xys of
| list0_cons (xy, xys) =>
  (
    if eq (x0, xy.0)
      then Some_vt{b}(xy.1) else list0_assoc_opt<a,b> (xys, x0, eq)
    // end of [if]
  ) (* end of [list_cons] *)
| list0_nil ((*void*)) => None_vt ()
//
end // end of [list0_assoc_opt]

(* ****** ****** *)

(*
implement
{a}{b}
list0_map (xs, f) = let
  viewdef v = unit_v
  viewtypedef vt = cfun (a, b)
  fun app .<>.
    (pfu: !unit_v | x: a, f: !vt): b = f (x)
  // end of [fun]
  prval pfu = unit_v ()
  var f = f
  val ys = list_map_funenv<a><b> {v}{vt} (pfu | g1ofg0(xs), app, f)
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
implement
{a2}{b2}
list_map$fopr (x) =
  $UN.castvwtp0{b2}(f($UN.cast{a}(x)))
//
val ys = list_map<a><b> (g1ofg0_list(xs))
//
in
  list0_of_list_vt (ys)
end // end of [list0_map]

(* ****** ****** *)

implement
{a}{b}
list0_mapopt
  (xs, f) = res where
{
//
fun loop
(
  xs: list0 (a)
, res: &ptr? >> List0_vt (b)
) : void = let
in
//
case+ xs of
| list0_cons
    (x, xs) => (
  case+ f(x) of
  | ~Some_vt y => let
      val () =
      (
      res :=
      list_vt_cons{b}{0}(y, _)
      )
      val+list_vt_cons (_, res1) = res
      val () = loop (xs, res1)
      prval () = fold@ (res)
    in
      // nothing
    end // end of [Some0]
  | ~None_vt () => loop (xs, res)
  ) (* end of [list0_cons] *)
| list0_nil () => (
    res := list_vt_nil ()
  ) (* end of [list0_nil] *)
//
end // end of [loop]
//
var res: ptr
val () = loop (xs, res)
val res = list0_of_list_vt (res)
//
} // end of [list0_mapopt]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_mapcons
  (x0, xss) = let
//
implement
list_map$fopr<list0(a)><list0(a)> (xs) = list0_cons(x0, xs)
//
val xss = g1ofg0 (xss)
val res = list_map<list0(a)><list0(a)> (xss)
//
in
  list0_of_list_vt (res)
end // end of [list0_mapcons]

(* ****** ****** *)

implement
{a}{b}
list0_imap (xs, f) = let
//
implement
{a2}{b2}
list_imap$fopr (i, x) =
  $UN.castvwtp0{b2}(f (i, $UN.cast{a}(x)))
val ys = list_imap<a><b> (g1ofg0_list(xs))
//
in
  list0_of_list_vt (ys)
end // end of [list0_imap]

(* ****** ****** *)

(*
implement
{a1,a2}{b}
list0_map2
  (xs1, xs2, f) = let
  viewdef v = unit_v
  viewtypedef vt = cfun2 (a1, a2, b)
  val xs1 = g1ofg0_list(xs1)
  val xs2 = g1ofg0_list(xs2)
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
list0_map2
  (xs1, xs2, f) = let
//
implement
{a11,a12}{b2}
list_map2$fopr (x1, x2) =
$UN.castvwtp0{b2}(f($UN.cast{a1}(x1), $UN.cast{a2}(x2)))
//
in
  list0_of_list_vt(list_map2<a1,a2><b> (g1ofg0(xs1), g1ofg0(xs2)))
end // end of [list0_map2]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_filter
  (xs, p) = let
//
implement{a2}
list_filter$pred
  (x) = p ($UN.cast{a}(x))
val ys = list_filter<a> (g1ofg0(xs))
//
in
  list0_of_list_vt (ys)
end // end of [list0_filter]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_tabulate
  (n, f) = let
//
implement{a2}
list_tabulate$fopr
  (i) = $UN.castvwtp0{a2}(f(i))
//
val n = g1ofg0_int (n)
//
in
  if n >= 0 then
    list0_of_list_vt (list_tabulate<a> (n))
  else
    $raise IllegalArgExn("list0_tabulate:n")
  // end of [if]
end // end of [list0_tabulate]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_tabulate_opt
  (n, f) = res where
{
//
fun loop
(
  i: int
, res: &ptr? >> List0_vt (a)
) : void = let
in
//
if n > i then
(
case+ f(i) of
| ~Some_vt x => let
    val () =
    (
    res :=
    list_vt_cons{a}{0}(x, _)
    )
    val+list_vt_cons (_, res1) = res
    val () = loop (i+1, res1)
    prval () = fold@ (res)
  in
    // nothing
  end // end of [Some0]
| ~None_vt () => loop (i+1, res)
) else (
  res := list_vt_nil ()
) (* end of [if] *)
//
end // end of [loop]
//
var res: ptr
val () = loop (0, res)
val res = list0_of_list_vt (res)
//
} // end of [list0_tabulate_opt]

(* ****** ****** *)

implement
{x,y}
list0_zip (xs, ys) = let
  val xs = g1ofg0(xs) and ys = g1ofg0(ys)
  val xys = $effmask_wrt (list_zip<x,y> (xs, ys))
in
  list0_of_list_vt (xys)
end // end of [list0_zip]

(* ****** ****** *)

implement
{x,y}
list0_cross (xs, ys) = let
  val xs = g1ofg0(xs) and ys = g1ofg0(ys)
  val xys = $effmask_wrt (list_cross<x,y> (xs, ys))
in
  list0_of_list_vt (xys)
end // end of [list0_cross]

(* ****** ****** *)

implement
{x,y}{z}
list0_crosswith
  (xs, ys, f) = let
//
implement
{x2,y2}{z2}
list_crosswith$fopr(x, y) =
  $UN.castvwtp0{z2}(f($UN.cast{x}(x), $UN.cast{y}(y)))
//
val xs = g1ofg0(xs) and ys = g1ofg0(ys)
val zs = $effmask_wrt (list_crosswith<x,y><z> (xs, ys))
//
in
  list0_of_list_vt (zs)
end // end of [list0_crosswith]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_quicksort (xs, cmp) = let
//
implement
list_quicksort$cmp<a> (x, y) = cmp (x, y)
//
val ys = $effmask_wrt (list_quicksort<a> (g1ofg0(xs)))
//
in
  list0_of_list_vt (ys)
end // end of [list0_quicksort]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_mergesort (xs, cmp) = let
//
implement
list_mergesort$cmp<a> (x, y) = cmp (x, y)
//
val ys = $effmask_wrt (list_mergesort<a> (g1ofg0(xs)))
//
in
  list0_of_list_vt (ys)
end // end of [list0_mergesort]

(* ****** ****** *)

implement(a)
fprint_val<list0(a)> = fprint_list0

(* ****** ****** *)

(* end of [list0.dats] *)
