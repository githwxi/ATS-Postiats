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

staload "./pats_stamp.sats"

(* ****** ****** *)

staload
CNTR = "./pats_counter.sats"
assume stamp_t0ype = $CNTR.count

(* ****** ****** *)

implement
stamp_get_int (x) = $CNTR.count_get_int (x)

(* ****** ****** *)
//
implement
lt_stamp_stamp
  (x1, x2) = $CNTR.lt_count_count (x1, x2)
implement
lte_stamp_stamp
  (x1, x2) = $CNTR.lte_count_count (x1, x2)
//
implement
eq_stamp_stamp
  (x1, x2) = $CNTR.eq_count_count (x1, x2)
implement
neq_stamp_stamp
  (x1, x2) = $CNTR.neq_count_count (x1, x2)
//
implement
compare_stamp_stamp
  (x1, x2) = $CNTR.compare_count_count (x1, x2)
//
(* ****** ****** *)
//
implement
tostring_stamp (x) = $CNTR.tostring_count (x)
implement
tostring_prefix_stamp
  (pre, x) = $CNTR.tostring_prefix_count (pre, x)
//
(* ****** ****** *)

implement
fprint_stamp (out, x) = $CNTR.fprint_count (out, x)

(* ****** ****** *)
//
// HX:
// Various stamp-gen functions
//
(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
s2rtdat_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
s2cst_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
s2var_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
s2Var_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
s2hole_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
d2con_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
d2cst_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
d2mac_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
d2var_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
hitype_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
tmplab_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
tmpvar_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement
funlab_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
staload
LS = "libats/SATS/linset_avltree.sats"
staload _ = "libats/DATS/linset_avltree.dats"
//
val
cmp = lam
(
  x1: stamp, x2: stamp
) : int =<cloref> compare_stamp_stamp (x1, x2)
//
assume stampset_viewtype = $LS.set (stamp)
//
in (* in-of-local *)

implement
stampset_vt_nil () = $LS.linset_make_nil ()

implement
stampset_vt_is_nil (xs) = $LS.linset_is_empty (xs)
implement
stampset_vt_isnot_nil (xs) = $LS.linset_isnot_empty (xs)

implement
stampset_vt_is_member
  (xs, x) = $LS.linset_is_member (xs, x, cmp)

implement
stampset_vt_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $LS.linset_insert (xs, x, cmp)
} // end of [stampset_vt_add]

implement
stampset_vt_free (xs) = $LS.linset_free (xs)

end // end of [local]

(* ****** ****** *)

(* end of [pats_stamp.dats] *)
