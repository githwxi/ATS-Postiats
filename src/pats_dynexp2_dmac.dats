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

staload "pats_dynexp2.sats"

(* ****** ****** *)

typedef
d2mac_struct = @{
  d2mac_loc= location
, d2mac_sym= symbol
, d2mac_kind= int // short/long: 0/1
, d2mac_narg= int // argument
, d2mac_arglst= macarglst // argument
, d2mac_def= d2exp // definition
, d2mac_stamp= stamp // uniqueness stamp
} // end of [d2mac_struct]

(* ****** ****** *)

local

assume d2mac_type = ref (d2mac_struct)

in // in of [local]

implement
d2mac_make (
  loc, name, knd, xs, def
) = let
//
val n = list_length (xs)
//
val stamp = $STP.d2mac_stamp_make ()
val (pfgc, pfat | p) = ptr_alloc<d2mac_struct> ()
prval () = free_gc_elim {d2mac_struct} (pfgc)
//
val () = p->d2mac_loc := loc
val () = p->d2mac_sym := name
val () = p->d2mac_kind := knd
val () = p->d2mac_narg := n
val () = p->d2mac_arglst := xs
val () = p->d2mac_def := def
val () = p->d2mac_stamp := stamp
//
in // in of [let]
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2mac_make]

implement
d2mac_get_loc (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_loc
end // end of [d2cst_get_loc]

implement
d2mac_get_sym (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_sym
end // end of [d2mac_get_sym]

implement
d2mac_get_kind (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_kind
end // end of [d2mac_get_kind]

implement
d2mac_get_narg (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_narg
end // end of [d2mac_get_narg]

implement
d2mac_get_arglst (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_arglst
end // end of [d2mac_get_arglst]

implement
d2mac_get_def (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_def
end // end of [d2mac_get_def]
implement
d2mac_set_def (d2m, def) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_def := def
end // end of [d2mac_set_def]

implement
d2mac_get_stamp (d2m) = let
  val (vbox pf | p) = ref_get_view_ptr (d2m) in p->d2mac_stamp
end // end of [d2mac_get_stamp]

end // end of [local

(* ****** ****** *)

implement
fprint_d2mac (out, x) =
  $SYM.fprint_symbol (out, d2mac_get_sym (x))
// end of [fprint_d2mac]

implement print_d2mac (x) = fprint_d2mac (stdout_ref, x)
implement prerr_d2mac (x) = fprint_d2mac (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_dynexp2_dmac.dats] *)
