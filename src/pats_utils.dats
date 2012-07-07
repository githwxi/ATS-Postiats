(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "pats_utils.sats"

(* ****** ****** *)

implement
eqref_type
  {a} (x1, x2) = let
  extern castfn __cast (x: a):<> ptr
  val x1 = __cast (x1) and x2 = __cast (x2)
in
  eq_ptr_ptr (x1, x2)
end // end of [eqref_type]

(* ****** ****** *)
//
// HX-2011-11-17: unsafe implementation but ...
//
implement
strcasecmp (x1, x2) = let
  fun loop (p1: Ptr1, p2: Ptr1): int = let
    val c1 = char_toupper ($UN.ptrget<char> (p1))
    val c2 = char_toupper ($UN.ptrget<char> (p2))
  in
    if c1 < c2 then ~1
    else if c1 > c2 then 1
    else if c1 != '\000' then loop (p1+1, p2+1)
    else 0 // end of [if]
  end // end of [loop]
in
  loop ($UN.cast2Ptr1(x1), $UN.cast2Ptr1(x2))
end // end of [strcasecmp]

(* ****** ****** *)

local

staload STDLIB = "libc/SATS/stdlib.sats"

fun
llint_make_string_sgn
  {n,i:nat | i <= n} (
  sgn: int, rep: string (n), i: size_t i
) : llint =
  if string_isnot_atend (rep, i) then let
    val c0 = rep[i]
  in
    case+ c0 of
    | '0' => (
        if string_isnot_atend (rep, i+1) then let
          val i = i+1
          val c0 = rep[i]
        in
          if (c0 = 'X' orelse c0 = 'x') then
            llint_make_string_sgn_base (sgn, 16(*base*), rep, i+1)
          else
            llint_make_string_sgn_base (sgn, 8(*base*), rep, i)
          // end of [if]
        end else 0ll (* end of [if] *)
      ) // end of ['0']
    | _ => llint_make_string_sgn_base (sgn, 10(*base*), rep, i)
  end else 0ll (* end of [if] *)
// end of [llint_make_string_sgn]

and
llint_make_string_sgn_base
  {n,i:nat | i <= n} (
  sgn: int, base: intBtw (2,36+1), rep: string (n), i: size_t i
) : llint = let
//
extern fun substring
  {n,i:nat | i <= n}
  (x: string n, i: size_t i): string (n-i) = "mac#atspre_padd_int"
//
in
  (llint_of)sgn * $STDLIB.strtoll_errnul (substring (rep, i), base)
end // end of [llint_make_string_sgn_base]

in // in of [local]

implement
llint_make_string
  (rep) = let
  var sgn: int = 1
  val [n0:int] rep = string1_of_string (rep)
in
  if string_isnot_empty (rep) then let
    val c0 = rep[0]
  in
    case+ c0 of
    | '+' => llint_make_string_sgn ( 1(*sgn*), rep, 1)
    | '~' => llint_make_string_sgn (~1(*sgn*), rep, 1)
    | '-' => llint_make_string_sgn (~1(*sgn*), rep, 1)
    | _ => llint_make_string_sgn (1(*sgn*), rep, 0)
  end else 0ll // end of [if]
end // end of [llint_make_string]

end // end of [local]

(* ****** ****** *)

implement
intrep_get_base (rep) = let
  val rep = string1_of_string (rep)
in
  if string_isnot_atend (rep, 0) then let
    val c0 = rep[0]
  in
    if c0 = '0' then (
      if string_isnot_atend (rep, 1) then let
        val c1 = rep[1]
      in
        if (c1 = 'x' || c1 = 'X') then 16
        else (
          if char_isdigit (c1) then 8 else 10
        ) // end of [if]
      end else 10 // end of [if]
    ) else 10 // end of [if]
  end else 10 // end of [if]
end // end of [intrep_get_base]

implement
intrep_get_nsfx (rep) = let
//
macdef test (c) =
  string_contains ("lLuU", ,(c))
//
val [n:int] rep = string1_of_string (rep)
fun loop
  {i:nat | i <= n} .<i>. (
  rep: string n, i: size_t i, k: uint
) : uint =
  if i > 0 then let
    val i1 = i - 1
    val c = rep[i1]
  in
    if test (c) then loop (rep, i1, k+1u) else k
  end else k
// end of [loop]
val n = string_length (rep)
//
in
  loop (rep, n, 0u)
end // end of [intrep_get_nsfx]

(* ****** ****** *)

implement
float_get_nsfx (rep) = let
//
macdef test (c) =
  string_contains ("fFlL", ,(c))
//
val [n:int] rep = string1_of_string (rep)
fun loop
  {i:nat | i <= n} .<i>. (
  rep: string n, i: size_t i, k: uint
) : uint =
  if i > 0 then let
    val i1 = i - 1
    val c = rep[i1]
  in
    if test (c) then loop (rep, i1, k+1u) else k
  end else k
// end of [loop]
val n = string_length (rep)
//
in
  loop (rep, n, 0u)
end // end of [float_get_nsfx]

(* ****** ****** *)

local

assume lstord (a: type) = List (a)

in // in of [local]

implement
lstord_nil () = list_nil ()

implement
lstord_sing (x) = list_cons (x, list_nil ())

implement
lstord_insert{a}
  (xs, x0, cmp) = let
  fun aux {n:nat} .<n>.
    (xs: list (a, n)):<cloref> list (a, n+1) =
    case+ xs of
    | list_cons (x, xs1) =>
        if cmp (x0, x) <= 0 then
          list_cons (x0, xs) else list_cons (x, aux (xs1))
        // end of [if]
    | list_nil () => list_cons (x0, list_nil)
  // end of [aux]
in
  aux (xs)
end // end of [lstord_insert]

implement
lstord_union{a}
  (xs1, xs2, cmp) = let
  fun aux {n1,n2:nat} .<n1+n2>. (
    xs1: list (a, n1), xs2: list (a, n2)
  ) :<cloref> list (a, n1+n2) =
    case+ xs1 of
    | list_cons (x1, xs11) => (
      case+ xs2 of
      | list_cons (x2, xs21) =>
          if cmp (x1, x2) <= 0 then
            list_cons (x1, aux (xs11, xs2))
          else
            list_cons (x2, aux (xs1, xs21))
          // end of [if]
      | list_nil () => xs1
      ) // end of [list_cons]
    | list_nil () => xs2
  // end of [aux]
in
  aux (xs1, xs2)
end // end of [lstord_union]

implement
lstord_get_dups
  {a} (xs, cmp) = let
//
fun aux {n:nat} .<n>. (
  x0: a, xs: list (a, n), cnt: int
) :<cloref> List a =
  case+ xs of
  | list_cons (x, xs) =>
      if cmp (x, x0) = 0 then
        aux (x0, xs, cnt+1)
      else ( // HX: x0 < x holds
        if cnt > 0 then
          list_cons (x0, aux (x, xs, 0)) else aux (x, xs, 0)
        // end of [if]
      ) // end of [if]
  | list_nil () =>
      if cnt > 0 then list_cons (x0, list_nil) else list_nil
    // end of [list_nil]
(* end of [aux] *)
//
in
//
case+ xs of
| list_cons
    (x, xs) => aux (x, xs, 0)
| list_nil () => list_nil ()
//
end // end of [lstord_get_dups]

implement lstord2list (xs) = xs

end // end of [local]

(* ****** ****** *)

implement{a}
fprintlst (
  out, xs, sep, fprint
) = let
  fun aux (
    xs: List a, i: int
  ) :<cloref1> void =
    case+ xs of
    | list_cons (x, xs) => let
        val () = if i > 0 then fprint_string (out, sep)
        val () = fprint (out, x)
      in
         aux (xs, i+1)
      end // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [aux]
in
  aux (xs, 0)
end // end of [fprintlst]

(* ****** ****** *)

implement{a}
fprintopt (
  out, opt, fprint
) = case+ opt of
  | Some x => let
      val () = fprint_string (out, "Some(")
      val () = fprint (out, x)
      val () = fprint_string (out, ")")
    in
      // nothing
    end // end of [Some]
  | None () => fprint_string (out, "None()")
// end of [fprintopt]

(* ****** ****** *)

local
//
staload Q = "libats/SATS/linqueue_arr.sats"
//
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"
//
in (* in of [local] *)
//
implement
queue_get_strptr1
  (q, st, ln) = let
  val [l:addr]
    (pfgc, pfarr | p) = malloc_gc (ln+1)
  // end of [val]
  prval (pf1, fpf2) =
   __assert (pfarr) where {
   extern prfun __assert {k:nat} (
     pfarr: b0ytes(k+1) @ l
   ) : (
     @[uchar?][k] @ l, @[uchar][k] @ l -<lin,prf> bytes(k+1) @ l
   ) (* end of [_assert] *)
  } // end of [prval]
  val () = $Q.queue_copyout<uchar> (q, st, ln, !p)
  prval () = pfarr := fpf2 (pf1)
  val () = bytes_strbuf_trans (pfarr | p, ln)
in
  strptr_of_strbuf @(pfgc, pfarr | p)
end // end of [queue_get_strptr1]
//
end // end of [local]

(* ****** ****** *)

(* end of [pats_utils.dats] *)
