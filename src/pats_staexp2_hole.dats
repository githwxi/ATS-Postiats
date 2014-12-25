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
// Start Time: April, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
CNTR = "./pats_counter.sats"
staload STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

typedef
s2hole_struct = @{
  s2hole_srt= s2rt
, s2hole_stamp= stamp // uniqueness
} // end of [s2hole_struct]

(* ****** ****** *)

local

assume s2hole_type = ref (s2hole_struct)

in (* in of [local] *)

implement
s2hole_make_srt (s2t) = let
  val stamp = $STMP.s2hole_stamp_make ()
  val (pfgc, pfat | p) = ptr_alloc<s2hole_struct> ()
  prval () = free_gc_elim {s2hole_struct?} (pfgc)
//
  val () = p->s2hole_srt := s2t
  val () = p->s2hole_stamp := stamp
//
in
  ref_make_view_ptr (pfat | p)
end // end of [s2hole_make_srt]

implement
s2hole_get_srt (s2h) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2h) in p->s2hole_srt
end // end of [s2hole_get_srt]

implement
s2hole_get_stamp (s2h) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2h) in p->s2hole_stamp
end // end of [s2hole_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
fprint_s2hole
  (out, s2h) = let
  val stamp =
    s2hole_get_stamp (s2h)
  // end of [val]
in
  $STMP.fprint_stamp (out, stamp)
end // end of [fprint_s2hole]

(* ****** ****** *)

(* end of [pats_staexp2_hole.dats] *)
