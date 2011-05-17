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
STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
overload compare with $STP.compare_stamp_stamp

staload
SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = $SYM.symbolopt

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

abstype hitypnul // HX: this is just a place holder
extern castfn hitypnul_none (x: ptr null): hitypnul

(* ****** ****** *)

typedef
d2cst_struct = @{
  d2cst_sym= symbol
, d2cst_loc= location
, d2cst_fil= filename
, d2cst_kind= dcstkind
, d2cst_decarg= s2qualstlst // template arg
, d2cst_arilst= List int // arity
, d2cst_typ= s2exp // assigned type
, d2cst_extdef= dcstextdef // external dcst definition
, d2cst_def= d2expopt // definition
, d2cst_stamp= stamp // unique stamp
, d2cst_hityp= hitypnul // type erasure
} // end of [d2cst_struct]

(* ****** ****** *)

local

assume d2cst_type = ref (d2cst_struct)

in // in of [local]

implement
d2cst_make (
  id
, loc
, fil
, dck
, decarg
, arilst
, typ
, extdef
) = let
//
val stamp = $STP.d2cst_stamp_make ()
val (pfgc, pfat | p) = ptr_alloc<d2cst_struct> ()
prval () = free_gc_elim {d2cst_struct} (pfgc)
//
val () = p->d2cst_sym := id
val () = p->d2cst_loc := loc
val () = p->d2cst_fil := fil
val () = p->d2cst_kind := dck
val () = p->d2cst_decarg := decarg
val () = p->d2cst_arilst := arilst
val () = p->d2cst_typ := typ
val () = p->d2cst_extdef := extdef
val () = p->d2cst_def := None ()
val () = p->d2cst_stamp := stamp
val () = p->d2cst_hityp := hitypnul_none (null)
//
in
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2cst_make]

implement
d2cst_get_sym (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_sym
end // end of [d2cst_get_sym]

end // end of [local]

(* ****** ****** *)

(* end of [pats_dynexp2_dcst.dats] *)
