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

staload _(*anon*) = "prelude/DATS/pointer.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload
CNTR = "pats_counter.sats"
staload STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
overload compare with $STP.compare_stamp_stamp
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload FIL = "pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

typedef
d2con_struct = @{
  d2con_loc= location // location
, d2con_fil= filename // filename
, d2con_sym= symbol // the name
, d2con_scst= s2cst // datatype
, d2con_vwtp= int //
, d2con_qua= List @(s2varlst, s2explst) // quantifiers
, d2con_npf= int // pfarity
, d2con_arg= s2explst // views or viewtypes
, d2con_arity_full= int // full arity
, d2con_arity_real= int // real arity after erasure
, d2con_ind= Option s2explst // indexes
, d2con_typ= s2exp // type for dynamic constructor
, d2con_tag= int // tag for dynamic constructor
, d2con_stamp= stamp // uniqueness
} // end of [d2con_struct]

(* ****** ****** *)

local

assume d2con_type = ref (d2con_struct)

in // in of [local]

implement
d2con_get_sym (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_sym
end // end of [d2con_get_sym]

end // end of [local]

(* ****** ****** *)

implement
fprint_d2con (out, x) = let
  val sym = d2con_get_sym (x) in $SYM.fprint_symbol (out, sym)
end // end of [fprint_d2con]

(* ****** ****** *)

(* end of [pats_staexp2_dcon.dats] *)
