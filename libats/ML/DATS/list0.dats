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
    $effmask_wrt(list_make_elt<a>(n, x))
  // end of [val]
in
  list0_of_list_vt{a}(xs)
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
  $effmask_exn(list0_make_intrange_lrd(l, r, d))
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
//
implement
{a}(*tmp*)
list0_make_arrpsz
  (psz) =
  list0_of_list_vt{a}(list_make_arrpsz(psz))
// end of [list0_make_arrpsz]
//
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
| list_cons _ => list_last<a>(xs)
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
| list_nil() => None_vt()
| list_cons _ => Some_vt{a}(list_last(xs))
//
end // end of [list0_last_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_init_exn
  (xs) = let
//
fun
aux
{n:nat} .<n>.
(
  x0: a, xs: list(a, n)
) :<> list(a, n) =
(
case+ xs of
| list_nil() =>
  list_nil()
| list_cons(x, xs) =>
  list_cons(x0, aux(x, xs))
)
//
in
  case+ xs of
  | list0_cons
      (x, xs) =>
    (
      g0ofg1(aux(x, g1ofg0(xs)))
    ) (* end of [list0_cons] *)
  | list0_nil() => $raise ListSubscriptExn()
end // end of [list0_init_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_init_opt
  (xs) = let
//
fun
aux
{n:nat} .<n>.
(
  x0: a, xs: list(a, n)
) :<> list(a, n) =
(
case+ xs of
| list_nil() =>
  list_nil()
| list_cons(x, xs) =>
  list_cons(x0, aux(x, xs))
)
//
in
//
case+ xs of
| list0_nil() =>
  None_vt(*void*)
| list0_cons(x, xs) =>
  Some_vt(g0ofg1(aux(x, g1ofg0(xs))))
//
end // end of [list0_init_opt]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_nth_exn
  (xs, i0) = let
//
fun
loop
{i:nat} .<i>.
(
  xs: list0(a), i: int i
) :<!exn> (a) =
(
//
case+ xs of
| list0_cons
    (x, xs) =>
  (
    if i > 0 then loop(xs, i-1) else x
  ) // end of [list0_cons]
| list0_nil() => $raise ListSubscriptExn()
//
) (* end of [loop] *)
//
val i0 = g1ofg0_int(i0)
//
in
//
if i0 >= 0
  then loop(xs, i0) else $raise ListSubscriptExn()
// end of [if]
//
end // end of [list0_nth_exn]
//
implement
{a}(*tmp*)
list0_nth_opt
(
  xs, i0
) =
$effmask_exn
(
try
Some_vt{a}
(
  list0_nth_exn<a>(xs, i0)
)
with ~ListSubscriptExn((*void*)) => None_vt()
) (* $effmask_exn *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_get_at_exn
  (xs, i0) = list0_nth_exn (xs, i0)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_fset_at_exn
  (xs, i0, x0) = let
//
fun
loop
{i:nat} .<i>.
(
  xs: list0(a), i: int i
) :<!exn> list0(a) =
(
//
case+ xs of
| list0_cons
    (x, xs) =>
  (
    if i > 0
      then cons0(x, loop(xs, i-1)) else cons0(x0, xs)
    // end of [if]
  ) // end of [list0_cons]
| list0_nil() => $raise ListSubscriptExn()
//
) (* end of [loop] *)
//
val i0 = g1ofg0(i0)
//
in
//
if i0 >= 0
  then loop(xs, i0) else $raise ListSubscriptExn()
//
end // end of [list0_fset_at_exn]
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_fset_at_opt
(
  xs, i0, x0
) =
$effmask_exn
(
try
Some_vt{list0(a)}
(
  list0_fset_at_exn<a>(xs, i0, x0)
)
with ~ListSubscriptExn((*void*)) => None_vt()
) (* $effmask_exn *)

(* ****** ****** *)

implement
{a}(*tmp*)
list0_insert_at_exn
  (xs, i, x0) = let
//
fun
aux {i:nat} .<i>.
(
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
  $raise
  IllegalArgExn("list0_remove_at_exn:i")
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
list0_length
  (xs) =
  list_length<a>(g1ofg0(xs))
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_append
  (xs, ys) = let
  val xs = g1ofg0(xs)
  and ys = g1ofg0(ys)
in
//
list0_of_list(list_append<a>(xs, ys))
//
end // end of [list0_append]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_extend
  (xs, x) = let
//
val xs = g1ofg0(xs)
//
in
//
$effmask_wrt
(
list0_of_list_vt(list_extend<a>(xs, x))
) (* $effmask_wrt *)
//
end // end of [list0_extend]

(* ****** ****** *)
//
implement
{a}(*tmp*)
mul_int_list0
  (m, xs) =
$effmask_wrt
(
list0_of_list_vt
  (mul_int_list<a>(m, g1ofg0(xs)))
) (* end of [mul_int_list0] *)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_reverse(xs) =
  list0_reverse_append<a>(xs, list0_nil)
// end of [list0_reverse]

implement
{a}(*tmp*)
list0_reverse_append
  (xs, ys) = let
  val xs = g1ofg0(xs)
  and ys = g1ofg0(ys)
in
  list0_of_list(list_reverse_append<a>(xs, ys))
end // end of [list0_reverse_append]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_concat
  (xss) = let
//
typedef xss = List(List(a))
//
in
//
$effmask_wrt
(
list0_of_list_vt{a}
  (list_concat<a>($UN.cast{xss}(xss)))
) (* $effmask_wrt *)
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
      $effmask_wrt (list_take_exn<a>(xs, i))
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
    list0_of_list (list_drop_exn<a>(xs, i))
  else
    $raise (IllegalArgExn"list0_drop_exn:i")
  // end of [if]
end // end of [list0_drop_exn]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_app
  (xs, fopr) = list0_foreach<a>(xs, fopr)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_foreach
(
  xs, fwork
) = loop(xs) where
{
//
fun
loop(xs: list0(a)): void =
(
  case+ xs of
  | list0_nil() => ()
  | list0_cons(x, xs) => (fwork(x); loop(xs))
)
//
} (* end of [list0_foreach] *)
//
implement
{a}(*tmp*)
list0_foreach_method
  (xs) = lam(fwork) => list0_foreach<a>(xs, fwork)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_rforeach
(
  xs, fwork
) = aux0(xs) where
{
//
fun
aux0(xs: list0(a)): void =
(
  case+ xs of
  | list0_nil() => ()
  | list0_cons(x, xs) => (aux0(xs); fwork(x))
)
//
} (* end of [list0_rforeach] *)
//
implement
{a}(*tmp*)
list0_rforeach_method
  (xs) = lam(fwork) => list0_rforeach<a>(xs, fwork)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_iforeach
  (xs, fwork) = let
//
fun
loop
(
  i0: intGte(0), xs: list0(a)
) : intGte(0) =
(
  case+ xs of
  | list0_nil() => i0
  | list0_cons(x, xs) =>
      (fwork(i0, x); loop (i0+1, xs))
    // end of [list0_cons]
) (* end of [loop] *)
//
in
  loop (0, xs)
end // end of [list0_iforeach]
//
implement
{a}(*tmp*)
list0_iforeach_method
  (xs) =
  lam(fwork) => list0_iforeach<a>(xs, fwork)
//
(* ****** ****** *)

implement
{a1,a2}
list0_foreach2
  (xs1, xs2, fwork) = let
  var sgn: int // uninitialized
in
  list0_foreach2_eq (xs1, xs2, fwork, sgn)
end // end of [list0_foreach2]

implement
{a1,a2}
list0_foreach2_eq
(
  xs1, xs2, fwork, sgn
) = loop(xs1, xs2, sgn) where
{
//
fun
loop
(
  xs1: list0(a1)
, xs2: list0(a2)
, sgn: &int? >> int
) : void =
(
  case+ xs1 of
  | list0_nil() => (
    case+ xs2 of
    | list0_nil() => (sgn := 0)
    | list0_cons _ => (sgn := ~1)
    )
  | list0_cons(x1, xs1) => (
    case+ xs2 of
    | list0_nil () => (sgn := 1)
    | list0_cons(x2, xs2) =>
        (fwork(x1, x2); loop(xs1, xs2, sgn))
    )
)
//
} (* end of [list0_foreach2_eq] *)

(* ****** ****** *)

implement
{res}{a}
list0_foldleft
  (xs, ini, fopr) = let
//
fun
loop
(
  xs: list0(a), res: res
) : res =
(
  case+ xs of
  | list0_nil () => res
  | list0_cons(x, xs) => loop(xs, fopr(res, x))
)
in
  loop(xs, ini)
end // end of [list0_foldleft]
//
implement
{res}{a}
list0_foldleft_method(xs, _) =
  lam(ini, fopr) =>list0_foldleft<res><a>(xs, ini, fopr)
//
(* ****** ****** *)

implement
{res}{a}
list0_ifoldleft
  (xs, ini, fopr) = let
//
fun
loop
(
  i: int, xs: list0 (a), res: res
) : res =
(
  case+ xs of
  | list0_nil () => res
  | list0_cons(x, xs) => loop(i+1, xs, fopr(res, i, x))
) (* end of [loop] *)
in
  loop (0, xs, ini)
end // end of [list0_ifoldleft]
//
implement
{res}{a}
list0_ifoldleft_method(xs, _) =
(
  lam(ini, fopr) =>
    list0_ifoldleft<res><a>(xs, ini, fopr)
  // end of [lam
)
//
(* ****** ****** *)

implement
{res}{a1,a2}
list0_foldleft2
(
  xs1, xs2, ini, fopr
) = loop(xs1, xs2, ini) where
{
//
fun
loop
(
  xs1: list0(a1)
, xs2: list0(a2), res: res
) : res =
(
  case+ xs1 of
  | list0_nil() => res
  | list0_cons(x1, xs1) => (
    case+ xs2 of
    | list0_nil() => res
    | list0_cons (x2, xs2) =>
      (
        loop(xs1, xs2, fopr(res, x1, x2))
      ) // end of [list0_cons]
    )
) (* end of [loop] *)
//
} (* end of [list0_foldleft2] *)

(* ****** ****** *)

implement
{a}{res}
list0_foldright
(
  xs, fopr, snk
) = loop(xs) where
{
//
fun
loop(xs: list0(a)): res =
  case+ xs of
  | list0_nil() => snk
  | list0_cons (x, xs) => fopr(x, loop(xs))
//
} (* end of [list0_foldright] *)
//
implement
{a}{res}
list0_foldright_method(xs, _) =
  lam(f, snk) => list0_foldright<a><res>(xs, f, snk)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_exists
(
  xs, pred
) = loop(xs) where
{
//
fun
loop(xs: list0(a)): bool =
(
case+ xs of
| list0_nil() => false
| list0_cons (x, xs) =>
    if pred(x) then true else loop(xs)
  // list0_cons
) (* end of [loop] *)
//
} (* end of [list0_exists] *)
//
implement
{a}(*tmp*)
list0_exists_method(xs) =
  lam(p) => list0_exists<a>(xs, p)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_iexists
(
  xs, pred
) = loop(0, xs) where
{
//
fun
loop(i: intGte(0), xs: list0(a)): bool =
(
  case+ xs of
  | list0_nil() => false
  | list0_cons(x, xs) =>
      if pred(i, x) then true else loop(i+1, xs)
    // list0_cons
) (* end of [loop] *)
//
} (* end of [list0_iexists] *)
//
implement
{a}(*tmp*)
list0_iexists_method(xs) =
  lam(p) => list0_iexists<a> (xs, p)
//
(* ****** ****** *)

implement
{a1,a2}
list0_exists2
(
  xs1, xs2, pred
) = let
//
fun
loop
(
  xs1: list0(a1)
, xs2: list0(a2)
) : bool =
(
  case+ xs1 of
  | list0_nil() => false
  | list0_cons(x1, xs1) => (
    case+ xs2 of
    | list0_nil() => false
    | list0_cons(x2, xs2) =>
        if pred(x1, x2) then true else loop(xs1, xs2)
      // end of [list_cons]
    )
) (* end of [loop] *)
//
in
  loop(xs1, xs2)
end // end of [list0_exists2]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_forall
(
  xs, pred
) = loop(xs) where
{
//
fun
loop(xs: list0(a)): bool =
(
  case+ xs of
  | list0_nil() => true
  | list0_cons(x, xs) =>
      if pred(x) then loop(xs) else false
    // list0_cons
) (* end of [loop] *)
//
} (* end of [list0_forall] *)
//
implement
{a}(*tmp*)
list0_forall_method(xs) =
  lam(p) => list0_forall<a> (xs, p)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_iforall
(
  xs, pred
) = loop(0, xs) where
{
//
fun
loop(i: intGte(0), xs: list0(a)): bool =
(
  case+ xs of
  | list0_nil() => true
  | list0_cons(x, xs) =>
      if pred(i, x) then loop(i+1, xs) else false
    // list0_cons
) (* end of [loop] *)
//
} (* end of [list0_iforall] *)
//
implement
{a}(*tmp*)
list0_iforall_method(xs) =
  lam(p) => list0_iforall<a> (xs, p)
//
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
(
  xs1, xs2, pred, sgn
) = loop(xs1, xs2, sgn) where
{
//
fun
loop
(
  xs1: list0(a1)
, xs2: list0(a2)
, sgn: &int? >> _
) : bool =
(
  case+ xs1 of
  | list0_nil() => (
    case+ xs2 of
    | list0_nil() => (sgn := 0; true)
    | list0_cons _ => (sgn := ~1; true)
    )
  | list0_cons(x1, xs1) => (
    case+ xs2 of
    | list0_nil() => (sgn := 1; true)
    | list0_cons (x2, xs2) =>
      (
        if pred (x1, x2)
          then loop(xs1, xs2, sgn) else (sgn := 0; false)
        // end of [if]
      ) (* end of [list0_cons] *)
    )
)
} (* end of [list0_forall2_eq] *)

(* ****** ****** *)

implement
{a}(*tmp*)
list0_equal
(
  xs1, xs2, eqfn
) = loop(xs1, xs2) where
{
//
fun
loop
(
  xs1: list0(a), xs2: list0(a)
) : bool =
(
  case+ xs1 of
  | list0_nil() => (
    case+ xs2 of
    | list0_nil() => true
    | list0_cons _ => false
    )
  | list0_cons(x1, xs1) => (
    case+ xs2 of
    | list0_nil() => false
    | list0_cons(x2, xs2) =>
        if eqfn (x1, x2) then loop(xs1, xs2) else false
      // end of [list0_cons]
    )
) (* end of [loop] *)
//
} (* end of [list0_equal] *)

(* ****** ****** *)

implement
{a}(*tmp*)
list0_find_exn
(
  xs, pred
) = loop(xs) where
{
//
fun
loop(xs: list0(a)): a =
(
case+ xs of
| list0_nil() =>
    $raise NotFoundExn()
  // list0_nil
| list0_cons(x, xs) =>
    if pred(x) then x else loop(xs)
  // list0_cons
)
//
} (* end of [list0_find_exn] *)

(* ****** ****** *)

implement
{a}(*tmp*)
list0_find_opt
(
  xs, pred
) = loop(xs) where
{
//
fun
loop
(
  xs: list0(a)
) : Option_vt(a) =
//
case+ xs of
| list0_nil() =>
    None_vt(*void*)
  // list0_nil
| list0_cons(x, xs) =>
  (
    if pred(x) then Some_vt{a}(x) else loop(xs)
  ) (* end of [list_cons] *)
//
} (* end of [list0_find_opt] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_find_exn_method
  (xs) = lam(pred) => list0_find_exn<a>(xs, pred)
//
implement
{a}(*tmp*)
list0_find_opt_method
  (xs) = lam(pred) => list0_find_opt<a>(xs, pred)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_find_index
(
  xs, pred
) = loop(xs, 0) where
{
//
fun
loop
(
  xs: list0(a), i: intGte(0)
) : intGte(~1) =
//
case+ xs of
| list0_nil() => (~1)
| list0_cons(x, xs) =>
  (
    if pred(x) then (i) else loop(xs, i+1)
  ) (* end of [list0_cons] *)
//
} (* end of [list0_find_index] *)

(* ****** ****** *)

implement
{a,b}(*tmp*)
list0_assoc_exn
(
  xys, x0, eq
) = loop(xys, x0, eq) where
{
//
fun
loop:
$d2ctype (
list0_assoc_exn<a,b>
) = lam(xys, x0, eq) =>
//
case+ xys of
| list0_nil() => $raise NotFoundExn()
| list0_cons(xy, xys) =>
    if eq (x0, xy.0) then xy.1 else loop(xys, x0, eq)
  // end of [list0_cons]
//
} (* end of [list0_assoc_exn] *)

(* ****** ****** *)

implement
{a,b}(*tmp*)
list0_assoc_opt
(
  xys, x0, eq
) = loop(xys, x0, eq) where
{
fun
loop:
$d2ctype(
list0_assoc_opt<a,b>
) = lam(xys, x0, eq) =>
//
case+ xys of
| list0_nil() =>
    None_vt(*void*)
  // list0_nil
| list0_cons(xy, xys) =>
  (
    if eq (x0, xy.0)
      then Some_vt{b}(xy.1) else loop(xys, x0, eq)
    // end of [if]
  ) (* end of [list_cons] *)
//
} (* end of [list0_assoc_opt] *)

(* ****** ****** *)
//
(*
implement
{a}{b}
list0_map
  (xs, fopr) = let
  viewdef v = unit_v
  viewtypedef fun_vt = cfun (a, b)
  fun app .<>.
    (pfu: !unit_v | x: a, fopr: !fun_vt): b = fopr (x)
  // end of [fun]
  prval pfu = unit_v ()
  var
  fopr = fopr
  val ys =
  list_map_funenv<a><b> {v}{vt} (pfu | g1ofg0(xs), app, fopr)
  prval () = topize(fopr)
  prval unit_v((*void*)) = pfu
in
  list0_of_list_vt (ys)
end // end of [list0_map]
*)
//
implement
{a}{b}
list0_map(xs, fopr) = let
//
implement
{a2}{b2}
list_map$fopr(x) =
$UN.castvwtp0{b2}(fopr($UN.cast{a}(x)))
//
val ys = list_map<a><b>(g1ofg0_list(xs))
//
in
  list0_of_list_vt{b}(ys)
end // end of [list0_map]

(* ****** ****** *)

implement
{a}{b}
list0_mapopt
  (xs, fopr) = res where
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
    (x, xs) =>
  (
  case+ fopr(x) of
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
//
implement
{a}{b}
list0_map_method
  (xs, _) =
  lam(fopr) => list0_map<a><b>(xs, fopr)
implement
{a}{b}
list0_mapopt_method
  (xs, _) =
  lam(fopr) => list0_mapopt<a><b>(xs, fopr)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_mapcons
  (x0, xss) = let
//
implement
list_map$fopr<list0(a)><list0(a)>
  (xs) = list0_cons(x0, xs)
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
list0_imap
  (xs, fopr) = let
//
implement
{a2}{b2}
list_imap$fopr(i, x) =
let
  val x = $UN.cast{a}(x)
in
  $UN.castvwtp0{b2}(fopr(i, x))
end // end of [list_imap$fopr]
//
val ys = list_imap<a><b>(g1ofg0_list(xs))
//
in
  list0_of_list_vt{b}(ys)
end // end of [list0_imap]

(* ****** ****** *)
//
implement
{a}{b}
list0_imap_method
  (xs, _(*TYPE*)) =
  lam(fopr) => list0_imap<a><b>(xs, fopr)
//
(* ****** ****** *)
//
(*
implement
{a1,a2}{b}
list0_map2
  (xs1, xs2, fopr) = let
  viewdef v0 = unit_v
  viewtypedef fun_vt = cfun2 (a1, a2, b)
  val xs1 = g1ofg0_list(xs1)
  val xs2 = g1ofg0_list(xs2)
  fun app .<>.
    (pfu: !v0 | x1: a1, x2: a2, f: !fun_vt): b = fopr(x1, x2)
  // end of [fun]
  prval pfu = unit_v ()
  var
  fopr = fopr
  val ys =
  list_map2_funenv<a1,a2><b> {v0}{vt} (pfu | xs1, xs2, app, fopr)
  prval () = topize(fopr)
  prval unit_v((*void*)) = pfu
in
  list0_of_list_vt (ys)
end // end of [list0_map2]
*)
//
implement
{a1,a2}{b}
list0_map2
  (xs1, xs2, fopr) = let
//
implement
{a11,a12}{b2}
list_map2$fopr
  (x1, x2) =
$UN.castvwtp0{b2}
  (fopr($UN.cast{a1}(x1), $UN.cast{a2}(x2)))
//
in
  list0_of_list_vt{b}(list_map2<a1,a2><b>(g1ofg0(xs1), g1ofg0(xs2)))
end // end of [list0_map2]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_filter
  (xs, pred) = let
//
implement{a2}
list_filter$pred
  (x) = pred($UN.cast{a}(x))
//
val ys = list_filter<a>(g1ofg0(xs))
//
in
  list0_of_list_vt (ys)
end // end of [list0_filter]
//
implement
{a}(*tmp*)
list0_filter_method
  (xs) = lam(pred) => list0_filter<a>(xs, pred)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_tabulate
  {n}(n, fopr) = let
//
implement{a2}
list_tabulate$fopr
  (i) = let
  val i =
  $UN.cast{natLt(n)}(i)
in
  $UN.castvwtp0{a2}(fopr(i))
end // list_tabulate$fopr
//
val n = g1ofg0_int(n)
//
in
//
if
(n >= 0)
then
list0_of_list_vt(list_tabulate<a>(n))
else
$raise IllegalArgExn("list0_tabulate:n")
// end of [if]
end // end of [list0_tabulate]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_tabulate_opt
  (n, fopr) = res where
{
//
fun loop
(
  i: Nat
, res: &ptr? >> List0_vt(a)
) : void = let
in
//
if
(n > i)
then (
case+ fopr(i) of
| ~None_vt() =>
    loop(i+1, res)
  // end of [None_vt]
| ~Some_vt(x) => let
//
    val () =
    (
      res :=
      list_vt_cons{a}{0}(x, _)
    ) (* end of [val] *)
//
    val+list_vt_cons(_, res1) = res
//
    val () = loop (i+1, res1)
//
    prval ((*folded*)) = fold@ (res)
  in
    // nothing
  end // end of [Some0]
) else
(
  res := list_vt_nil((*void*))
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
list0_zip
  (xs, ys) = let
//
  val xs = g1ofg0(xs)
  and ys = g1ofg0(ys)
  val xys = $effmask_wrt(list_zip<x,y> (xs, ys))
//
in
  list0_of_list_vt{(x,y)}(xys)
end // end of [list0_zip]

(* ****** ****** *)

implement
{x,y}
list0_cross
  (xs, ys) = let
//
  val xs = g1ofg0(xs)
  and ys = g1ofg0(ys)
  val xys = $effmask_wrt(list_cross<x,y> (xs, ys))
//
in
  list0_of_list_vt{(x,y)}(xys)
end // end of [list0_cross]

(* ****** ****** *)

implement
{x,y}{z}
list0_crosswith
  (xs, ys, fopr) = let
//
implement
{x2,y2}{z2}
list_crosswith$fopr(x, y) =
$UN.castvwtp0{z2}
  (fopr($UN.cast{x}(x), $UN.cast{y}(y)))
//
val xs = g1ofg0(xs) and ys = g1ofg0(ys)
val zs = $effmask_wrt(list_crosswith<x,y><z> (xs, ys))
//
in
  list0_of_list_vt{z}(zs)
end // end of [list0_crosswith]

(* ****** ****** *)

implement
{x}(*tmp*)
list0_foreach_choose2
(
  xs, fwork
) = loop(xs) where
{
//
fnx
loop(xs: list0(x)): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons
    (x, xs) => loop2(x, xs, xs)
  // end of [list0_cons]
)
and
loop2
(
  x0: x, xs: list0(x), ys: list0(x)
) : void =
(
case+ ys of
| list0_nil
    () => loop(xs)
| list0_cons
    (y, ys) => let
    val () = fwork(x0, y) in loop2(x0, xs, ys)
  end // end of [list_cons]
)
//
} (* end of [list0_foreach_choose2] *)
//
implement
{x}(*tmp*)
list0_foreach_choose2_method(xs) =
  lam(fwork) => list0_foreach_choose2<x>(xs, fwork)
//
(* ****** ****** *)

implement
{x,y}(*tmp*)
list0_foreach_xprod2
(
  xs0, ys0, fwork
) = loop(xs0) where
{
//
fnx
loop(xs: list0(x)): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => loop2(x, xs, ys0)
)
and
loop2
(
  x0: x, xs: list0(x), ys: list0(y)
) : void =
(
case+ ys of
| list0_nil() => loop(xs)
| list0_cons(y, ys) => (fwork(x0, y); loop2(x0, xs, ys))
)
//
} (* end of [list0_foreach_xprod2] *)
//
implement
{x,y}(*tmp*)
list0_foreach_xprod2_method
  (xs, ys) =
  lam(fwork) => list0_foreach_xprod2<x,y>(xs, ys, fwork)
//
(* ****** ****** *)

implement
{x,y}(*tmp*)
list0_iforeach_xprod2
(
  xs0, ys0, fwork
) = loop(0, xs0) where
{
//
typedef int = intGte(0)
//
fnx
loop
(
  i: int, xs: list0(x)
) : void =
(
case+ xs of
| list0_nil() => ()
| list0_cons
    (x, xs) => loop2(i, x, xs, 0, ys0)
  // end of [list_cons]
)
and
loop2
(
  i0: int, x0: x, xs: list0(x), j: int, ys: list0(y)
) : void =
(
case+ ys of
| list0_nil() => loop(i0+1, xs)
| list0_cons(y, ys) =>
    (fwork(i0, x0, j, y); loop2(i0, x0, xs, j+1, ys))
  // end of [list0_cons]
)
//
} (* end of [list0_iforeach_xprod2] *)
//
implement
{x,y}(*tmp*)
list0_iforeach_xprod2_method
  (xs, ys) =
(
lam(fwork) => list0_iforeach_xprod2<x,y>(xs, ys, fwork)
) (* list0_iforeach_xprod2_method *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
streamize_list0_elt
  (xs) = streamize_list_elt<a>(g1ofg0(xs))
implement
{a}(*tmp*)
streamize_list0_choose2
  (xs) = streamize_list_choose2<a>(g1ofg0(xs))
//
(* ****** ****** *)

implement
{a}(*tmp*)
streamize_list0_nchoose
  (xs, n) = let  
//
fun
auxmain
(
  xs: list0(a), n: intGte(0)
) : stream_vt(list0(a)) = $ldelay
(
//
if
(n > 0)
then
(
case+ xs of
| list0_nil() =>
  stream_vt_nil()
| list0_cons(x0, xs1) => let
    val res1 =
      auxmain(xs1, n-1)
    // end of [val]
    val res2 = auxmain(xs1, n)
  in
    !(stream_vt_append
      (
        stream_vt_map_cloptr<list0(a)><list0(a)>(res1, lam(ys) => list0_cons(x0, ys)), res2
      ) // stream_vt_append
     )
  end // end of [list0_cons]
) (* end of [then] *)
else
(
  stream_vt_cons(list0_nil, stream_vt_make_nil())
) (* end of [else] *)
//
) : stream_vt_con(list0(a)) // auxmain
//
in
  $effmask_all(auxmain(xs, n))
end // end of [streamize_list0_nchoose]

(* ****** ****** *)
//
implement
{a,b}(*tmp*)
streamize_list0_zip
  (xs, ys) =
  streamize_list_zip<a,b>(g1ofg0(xs), g1ofg0(ys))
//
implement
{a,b}(*tmp*)
streamize_list0_cross
  (xs, ys) =
  streamize_list_cross<a,b>(g1ofg0(xs), g1ofg0(ys))
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_is_ordered
  (xs, cmp) = let
//
implement
gcompare_val_val<a>(x, y) = cmp(x, y)
//
in
  list_is_ordered<a>(g1ofg0_list{a}(xs))
end // end of [list0_is_ordered]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_mergesort(xs, cmp) = let
//
implement
list_mergesort$cmp<a>(x, y) = cmp(x, y)
//
val ys = $effmask_wrt(list_mergesort<a>(g1ofg0(xs)))
//
in
  list0_of_list_vt (ys)
end // end of [list0_mergesort]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_quicksort(xs, cmp) = let
//
implement
list_quicksort$cmp<a>(x, y) = cmp(x, y)
//
val ys = $effmask_wrt(list_quicksort<a>(g1ofg0(xs)))
//
in
  list0_of_list_vt (ys)
end // end of [list0_quicksort]

(* ****** ****** *)
//
// HX: some common generic functions
//
(* ****** ****** *)
//
implement
(a)(*tmp*)
fprint_val<list0(a)> = fprint_list0<a>
//
(* ****** ****** *)

implement
(a)(*tmp*)
gcompare_val_val<list0(a)>
  (xs, ys) = let
//
fun
auxlst
(
  xs: list0(a), ys: list0(a)
) : int =
(
case+ xs of
| list0_nil() =>
  (
    case+ ys of
    | list0_nil() => 0
    | list0_cons _ => ~1
  ) (* list0_nil *)
| list0_cons(x, xs) =>
  (
    case+ ys of
    | list0_nil() => 1
    | list0_cons(y, ys) => let
        val sgn =
          gcompare_val_val<a>(x, y)
        // end of [val]
      in
        if sgn != 0 then sgn else auxlst(xs, ys)
      end // end of [list0_cons]
  ) (* list0_cons *)
) (* end of [auxlst] *)
//
in
  $effmask_all(auxlst(xs, ys))
end (* end of [gcompare_val_val] *)

(* ****** ****** *)

(* end of [list0.dats] *)
