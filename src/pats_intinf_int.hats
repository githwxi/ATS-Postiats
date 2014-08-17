(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: May, 2014
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_intinf.sats"

(* ****** ****** *)

datatype
intinf = INTINF of (llint)

(* ****** ****** *)
//
fun un .<>.
(
  intinf: intinf
) :<> llint =
  let val+INTINF(i) = intinf in i end
//
(* ****** ****** *)

assume intinf_type = intinf

(* ****** ****** *)

implement
intinf_make_int (i) = INTINF ($UN.cast{llint}(i))
implement
intinf_make_size (sz) = INTINF ($UN.cast{llint}(sz))

(* ****** ****** *)
//
(*
** HX: [rep] is unsigned!
*)
implement
intinf_make_string (rep) = let
  val i = $UT.llint_make_string (rep) in INTINF (i)
end // end of [intinf_make_string]
//
(* ****** ****** *)

local

staload
STDLIB = "libc/SATS/stdlib.sats"

in (* in-of-local *)

implement
intinf_make_base_string_ofs
  (base, rep, ofs) = let
//
  val rep =
    __cast (rep) where {
    extern castfn __cast (x: string): ptr
  }
  val rep_ofs =
    __cast (rep + ofs) where {
    extern castfn __cast (x: ptr): string
  }
//
val x =
  $STDLIB.strtoll_errnul (rep_ofs, base)
//
in
  INTINF (x)
end // end of [intinf_make_base_string_ofs]

end // end of [local]

(* ****** ****** *)

implement
fprint_intinf (out, x) = fprint_llint (out, un(x))

(* ****** ****** *)

implement intinf_get_int (x) = $UN.cast2int (un(x))

(* ****** ****** *)

implement
lt_intinf_int (x1, x2) = compare_intinf_int (x1, x2) < 0
implement
lte_intinf_int (x1, x2) = compare_intinf_int (x1, x2) <= 0
implement
gt_intinf_int (x1, x2) = compare_intinf_int (x1, x2) > 0
implement
gte_intinf_int (x1, x2) = compare_intinf_int (x1, x2) >= 0

(* ****** ****** *)

implement
eq_intinf_int (x1, x2) = compare_intinf_int (x1, x2) = 0
implement
eq_int_intinf (x1, x2) = compare_intinf_int (x2, x1) = 0
implement
eq_intinf_intinf (x1, x2) = compare_intinf_intinf (x1, x2) = 0

(* ****** ****** *)

implement
neq_intinf_int (x1, x2) = compare_intinf_int (x1, x2) != 0
implement
neq_int_intinf (x1, x2) = compare_intinf_int (x2, x1) != 0
implement
neq_intinf_intinf (x1, x2) = compare_intinf_intinf (x1, x2) != 0

(* ****** ****** *)
//
implement
compare_intinf_int
  (x1, x2) = let
  val i1 = un (x1)
  val i2 = llint_of_int (x2)
in
  compare_llint_llint (i1, i2)
end // end of [compare_intinf_int]
//
implement
compare_intinf_intinf
  (x1, x2) = compare_llint_llint (un(x1), un(x2))
//
(* ****** ****** *)
//
implement neg_intinf (x) = INTINF (~(un(x)))
//
(* ****** ****** *)
//
implement
add_intinf_int
  (x1, x2) = INTINF (un(x1) + llint_of_int (x2))
implement
add_int_intinf
  (x1, x2) = INTINF (llint_of_int (x1) + un(x2))
//
implement
add_intinf_intinf (x1, x2) = INTINF (un(x1) + un(x2))
//
(* ****** ****** *)

implement
sub_intinf_intinf (x1, x2) = INTINF (un(x1) - un(x2))

(* ****** ****** *)
//
implement
mul_intinf_int
  (x1, x2) = INTINF (un(x1) * llint_of_int (x2))
implement
mul_int_intinf
  (x1, x2) = INTINF (llint_of_int (x1) * un(x2))
//
implement
mul_intinf_intinf (x1, x2) = INTINF (un(x1) * un(x2))
//
(* ****** ****** *)

local
//
staload
"libats/SATS/funset_listord.sats"
staload _(*anon*) =
"libats/DATS/funset_listord.dats"
//
fn cmp (
  x1: intinf, x2: intinf
) :<cloref> int =
  compare_intinf_intinf (x1, x2)
//
assume intinfset_type = set (intinf)
//
in (*in-of-local*)

implement
intinfset_sing (x) = funset_make_sing (x)

implement
intinfset_is_member
  (xs, x) = funset_is_member (xs, x, cmp)
// end of [val]

implement
intinfset_add
  (xs, x) = xs where
{
  var xs = xs
  val _(*exist*) = funset_insert (xs, x, cmp)
} (* end of [val] *)

implement
intinfset_listize (xs) = funset_listize (xs)

end // end of [local]

(* ****** ****** *)

implement
fprint_intinfset
  (out, xs) = {
  val xs = intinfset_listize (xs)
  val () = $UT.fprintlst
    (out, $UN.castvwtp1{intinflst}(xs), ", ", fprint_intinf)
  val () = list_vt_free (xs)
} (* end of [fprint_intinfset] *)

(* ****** ****** *)

(* end of [pats_intinf_int.hats] *)
