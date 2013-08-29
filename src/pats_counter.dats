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
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_counter.sats"

(* ****** ****** *)

assume count_t0ype = int
assume counter_type = ref (count)

(* ****** ****** *)

implement count_get_int (x) = x

(* ****** ****** *)

implement
lt_count_count (x1, x2) = lt_int_int (x1, x2)
implement
lte_count_count (x1, x2) = lte_int_int (x1, x2)

implement
gt_count_count (x1, x2) = gt_int_int (x1, x2)
implement
gte_count_count (x1, x2) = gte_int_int (x1, x2)

implement
eq_count_count (x1, x2) = eq_int_int (x1, x2)
implement
neq_count_count (x1, x2) = neq_int_int (x1, x2)

implement
compare_count_count (x1, x2) = compare_int_int (x1, x2)

(* ****** ****** *)

implement
fprint_count (out, x) = fprint_int (out, x)

(* ****** ****** *)

implement
tostring_count (cnt) = let
  val str = sprintf ("%i", @(cnt)) in string_of_strptr (str)
end // end of [tostring_count]

implement
tostring_prefix_count (pre, cnt) = let
  val str = sprintf ("%s%i", @(pre,cnt)) in string_of_strptr (str)
end // end of [tostring_prefix_count]

(* ****** ****** *)
//
implement
counter_make () = ref_make_elt<count> (0)
//
implement
counter_inc (cntr) = !cntr := !cntr + 1
implement counter_get (cntr) = !cntr
implement counter_set (cntr, cnt) = !cntr := cnt
implement counter_reset (cntr) = !cntr := 0
//
implement
counter_getinc
  (cntr) = n where {
  val n = !cntr ; val () = !cntr := n + 1
} // end of [counter_getinc]
//
implement
counter_incget
  (cntr) = n1 where {
  val n1 = !cntr + 1; val () = !cntr := n1
} // end of [counter_incget]
//
(* ****** ****** *)

(* end of [pats_counter.dats] *)
