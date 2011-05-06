(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: May, 2011
//
(* ****** ****** *)

staload CNTR = "pats_counter.sats"

(* ****** ****** *)

staload "pats_stamp.sats"

(* ****** ****** *)

assume stamp_t0ype = $CNTR.count

(* ****** ****** *)

implement
lt_stamp_stamp (x1, x2) = $CNTR.lt_count_count (x1, x2)
implement
lte_stamp_stamp (x1, x2) = $CNTR.lte_count_count (x1, x2)

implement
eq_stamp_stamp (x1, x2) = $CNTR.eq_count_count (x1, x2)
implement
neq_stamp_stamp (x1, x2) = $CNTR.neq_count_count (x1, x2)

implement
compare_stamp_stamp (x1, x2) = $CNTR.compare_count_count (x1, x2)

(* ****** ****** *)

implement fprint_stamp (out, x) = $CNTR.fprint_count (out, x)

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement s2rtdat_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement s2cst_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement s2var_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement s2Var_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement d2con_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement d2cst_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement d2mac_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

local
//
val cntr = $CNTR.counter_make ()
//
in
//
implement d2var_stamp_make () = $CNTR.counter_getinc (cntr)
//
end // end of [local]

(* ****** ****** *)

(* end of [pats_stamp.dats] *)
