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
** A linear set implementation based on ordered lists
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: February 17, 2012
**
*)

(* ****** ****** *)
//
// HX-2014-01-17: Porting to ATS2
//
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0 // no dynloading

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"libats/ATS1/SATS/linset_listord.sats"
//
(* ****** ****** *)
//
implement{a}
compare_elt_elt (x1, x2, cmp) = cmp (x1, x2)
//
(* ****** ****** *)

assume
set_t0ype_vtype (a:t0p) = List0_vt (a)

(* ****** ****** *)
//
// HX:
// a set is represented as a sorted list in descending order;
// note that descending order is chosen to faciliate set comparison
//
(* ****** ****** *)

implement{}
linset_nil () = list_vt_nil ()
implement{}
linset_make_nil () = list_vt_nil ()

(* ****** ****** *)

implement{a}
linset_make_sing (x) = list_make_sing<a> (x)

(* ****** ****** *)

implement{a}
linset_size (xs) = i2sz(list_vt_length (xs))

(* ****** ****** *)

implement{a}
linset_is_member
  (xs, x0, cmp) = let
//
fun loop
  {n:nat} .<n>. (
  xs: !list_vt (a, n)
) :<cloref> bool =
(
  case+ xs of
  | list_vt_cons
      (x, xs1) => let
      val sgn =
        compare_elt_elt<a> (x0, x, cmp)
      // end of [val]
    in
      if sgn > 0
        then false else (if sgn < 0 then loop (xs1) else true)
      // end of [if]
    end // end of [list_vt_cons]
  | list_vt_nil () => false
) (* end of [loop] *)
//
in
  loop (xs)
end // end of [linset_is_member]

(* ****** ****** *)

implement{a}
linset_isnot_member
  (xs, x0, cmp) = ~linset_is_member<a> (xs, x0, cmp)
// end of [linset_isnot_member]

(* ****** ****** *)

implement{a}
linset_is_subset
  (xs1, xs2, cmp) = let
//
fun loop
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> bool =
(
  case+ xs1 of
  | list_cons
      (x1, xs11) => (
    case+ xs2 of
    | list_cons
        (x2, xs21) => let
        val sgn =
          compare_elt_elt<a> (x1, x2, cmp)
        // end of [val]
      in
        if sgn > 0 then false
        else if sgn < 0 then loop (xs1, xs21)
        else loop (xs11, xs21)
      end
    | list_nil ((*void*)) => false
    ) // end of [list_cons]
  | list_nil ((*void*)) => true
) (* end of [loop] *)
//
in
  loop ($UN.list_vt2t(xs1), $UN.list_vt2t(xs2))
end // end of [linset_is_subset]

(* ****** ****** *)

implement{a}
linset_is_supset
  (xs1, xs2, cmp) = linset_is_subset<a> (xs2, xs1, cmp)
// end of [linset_is_supset]

(* ****** ****** *)

implement{a}
linset_is_equal
  (xs1, xs2, cmp) = let
//
fun loop
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> bool =
(
  case+ xs1 of
  | list_cons
      (x1, xs11) => (
    case+ xs2 of
    | list_cons
        (x2, xs21) => let
        val sgn =
          compare_elt_elt<a> (x1, x2, cmp)
        // end of [val]
      in
        if sgn = 0 then loop (xs11, xs21) else false
      end // end of [list_cons]
    | list_nil ((*void*)) => false
    ) // end of [list_cons]
  | list_nil ((*void*)) =>
    (
      case+ xs2 of list_cons _ => false | list_nil () => true
    ) (* end of [list_nil] *)
) (* end of [loop] *)
//
in
  loop ($UN.list_vt2t(xs1), $UN.list_vt2t(xs2))
end // end of [linset_is_equal]

(* ****** ****** *)
//
implement{a} linset_copy (xs) = list_vt_copy<a> (xs)
//
implement{a} linset_free (xs) = list_vt_free<a> (xs)
//
(* ****** ****** *)

implement{a}
linset_insert
  (xs, x0, cmp) = let
//
fun ins{n:nat} .<n>. ( // tail-recursive
  xs: &list_vt (a, n) >> list_vt (a, n1)
) :<!wrt> #[n1:nat | n <= n1; n1 <= n+1] bool =
(
  case+ xs of
  | @list_vt_cons
      (x, xs1) => let
      val sgn =
        compare_elt_elt<a> (x0, x, cmp)
      // end of [val]
    in
      if sgn > 0 then let
        prval () = fold@ (xs)
        val () = xs := list_vt_cons{a}(x0, xs)
      in
        false
      end else if sgn < 0 then let
        val res = ins (xs1); prval () = fold@ (xs) in res
      end else let // x0 = x
        prval () = fold@ (xs) in true // [x0] is already in [xs]
      end // end of [if]
    end (* end of [list_vt_cons] *)
  | ~list_vt_nil () => let
      val () = xs := list_make_sing<a> (x0) in false
    end // end of [list_vt_nil]
) (* end of [ins] *)
//
in
  ins (xs)  
end // end of [linset_insert]

(* ****** ****** *)

implement{a}
linset_remove
  (xs, x0, cmp) = let
//
fun rem {n:nat} .<n>. ( // tail-recursive
  xs: &list_vt (a, n) >> list_vt (a, n1)
) :<!wrt> #[n1:nat | n1 <= n; n <= n1+1] bool =
(
  case+ xs of
  | @list_vt_cons
      (x, xs1) => let
      val sgn =
         compare_elt_elt<a> (x0, x, cmp)
      // end of [val]
    in
      if sgn > 0 then let
        prval () = fold@{a}(xs) in false
      end else if sgn < 0 then let
        val res = rem (xs1); prval () = fold@{a}(xs) in res
      end else let // x0 = x
        val xs1_ = xs1
        val () = free@{a}{0}(xs)
        val () = xs := xs1_
      in
        true // [x0] is removed from [xs]
      end // end of [if]
    end (* end of [list_vt_cons] *)
  | list_vt_nil ((*void*)) => false
) (* end of [rem] *)
//
in
  rem (xs)  
end // end of [linset_remove]

(* ****** ****** *)

(*
** By Brandon Barker
*)
implement
{a}(*tmp*)
linset_choose
  (xs, x0) = let
in
//
case+ xs of
| list_vt_cons
    (x, xs1) => let
    val () = x0 := x
    prval () = opt_some{a}(x0)
  in
    true
  end // end of [list_vt_cons]
| list_vt_nil () => let
    prval () = opt_none{a}(x0)
  in
    false
  end // end of [list_vt_nil]
//
end // end of [linset_choose]

(* ****** ****** *)

implement{a}
linset_choose_opt
  (xs) = let
//
var x0: a?
val ans = linset_choose<a> (xs, x0)
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [linset_choose_opt]

(* ****** ****** *)

implement{a}
linset_chooseout
  (xs0, x0) = let
in
//
case+ xs0 of
| ~list_vt_cons
    (x, xs) => let
    val () = x0 := x
    prval () = opt_some{a}(x0)
    val () = xs0 := xs
  in
    true
  end // end of [list_vt_cons]
| list_vt_nil () => let
    prval () = opt_none{a}(x0)
  in
    false
  end // end of [list_vt_nil]
//
end // end of [linset_chooseout]

(* ****** ****** *)

implement{a}
linset_chooseout_opt
  (xs) = let
//
var x0: a?
val ans = linset_chooseout<a> (xs, x0)
//
in
//
if ans then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt(*void*)
end (* end of [if] *)
//
end // end of [linset_chooseout_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
linset_union
  (xs1, xs2, cmp) = let
//
vtypedef res = List0_vt (a)
//
fun loop
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list_vt (a, n1)
, xs2: list_vt (a, n2), res: &res? >> res
) :<!wrt> void =
(
  case+ xs1 of
  | @list_vt_cons
      (x1, xs11) => (
    case+ xs2 of
    | @list_vt_cons
        (x2, xs21) => let
        val sgn =
          compare_elt_elt<a> (x1, x2, cmp)
        // end of [val]
      in
        if sgn > 0 then let
          val xs11_ = xs11
          prval () = fold@{a}(xs2)
          val () = loop (xs11_, xs2, xs11)
          prval () = fold@{a}(xs1)
        in
          res := xs1
        end else if sgn < 0 then let
          prval () = fold@{a}(xs1)
          val xs21_ = xs21
          val () = loop (xs1, xs21_, xs21)
          prval () = fold@{a}(xs2)
        in
          res := xs2
        end else let // x1 = x2
          val xs11_ = xs11
          val xs21_ = xs21
          val () = free@{a}{0}(xs2)
          val () = loop (xs11_, xs21_, xs11)
          prval () = fold@{a}(xs1)
        in
          res := xs1
        end // end of [if]
      end // end of [list_vt_cons]
    | ~list_vt_nil ((*void*)) =>
        let prval () = fold@{a}(xs1) in res := xs1 end
    ) // end of [list_vt_cons]
  | ~list_vt_nil ((*void*)) => (res := xs2)
) (* end of [loop] *)
//
var res: res // uninitialized
val ((*void*)) = loop (xs1, xs2, res)
//
in
  res
end // end of [linset_union]

(* ****** ****** *)

implement{a}
fprint_linset_sep
  (out, xs, sep) = fprint_list_vt_sep (out, xs, sep)
// end of [fprint_linset_sep]

(* ****** ****** *)

implement{a}
linset_foreach_funenv
  {v}{vt}(pf | xs, f, env) = let
//
fun loop
(
  pf: !v
| xs: !set(INV(a))
, f: (!v | a, !vt) -> void, env: !vt
) : void = (
//
case+ xs of
| list_vt_cons (x, xs) =>
    (f (pf | x, env); loop (pf | xs, f, env))
| list_vt_nil ((*void*)) => ()
//
) (* end of [loop] *)
//
in
  loop (pf | xs, f, env)
end (* end of [linset_foreach_funenv] *)

(* ****** ****** *)

implement{a} linset_listize (xs) = xs

(* ****** ****** *)

implement{a}
linset_listize1 (xs) = list_vt_copy<a> (xs)

(* ****** ****** *)

(* end of [linset_listord.dats] *)
