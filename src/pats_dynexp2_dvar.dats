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
//
// HX: this is just for handling type recursion
//
abstype d2varopt_t // = d2varopt
extern
castfn d2varopt_encode (x: d2varopt):<> d2varopt_t
extern
castfn d2varopt_decode (x: d2varopt_t):<> d2varopt
//
(* ****** ****** *)

typedef
d2var_struct = @{
  d2var_sym= symbol // name
, d2var_loc= location // first location
, d2var_level= int // toplevel: 0
, d2var_linval= int // nonlinear (-1) and linear (>=0)
, d2var_isfix= bool // is fix-variable?
, d2var_isprf= bool // is proof?
, d2var_decarg= s2qualst // template arg
, d2var_addr= s2hnfopt //
, d2var_view= d2varopt_t // 
, d2var_finknd= d2vfin // the status at the end of scope
, d2var_type= s2hnfopt // the (current) type of a variable
, d2var_mastype= s2hnfopt // the master type of a variable
, d2var_count= int //
, d2var_stamp= stamp // uniqueness stamp
} // end of [d2var_struct]

(* ****** ****** *)

local

assume d2var_type = ref (d2var_struct)

in // in of [local]

implement
d2var_make (loc, id) = let
//
val stamp = $STP.d2var_stamp_make ()
val (pfgc, pfat | p) = ptr_alloc<d2var_struct> ()
prval () = free_gc_elim {d2var_struct?} (pfgc)
//
val () = p->d2var_sym := id
val () = p->d2var_loc := loc
val () = p->d2var_level := ~1
val () = p->d2var_linval := ~1;
val () = p->d2var_isfix := false
val () = p->d2var_isprf := false
val () = p->d2var_decarg := list_nil ()
val () = p->d2var_addr := None ()
val () = p->d2var_view := d2varopt_encode (None)
val () = p->d2var_finknd := D2VFINnone ()
val () = p->d2var_type := None ()
val () = p->d2var_mastype := None ()
val () = p->d2var_count := 0
val () = p->d2var_stamp := stamp
//
in
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2var_make]

(* ****** ****** *)

implement
d2var_get_sym (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_sym
end // end of [d2var_get_sym]

implement
d2var_get_loc (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_loc
end // end of [d2var_get_loc]

implement
d2var_get_level (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_level
end // end of [d2var_get_level]
implement
d2var_set_level (d2v, lev) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_level := lev
end // end of [d2var_set_level]

implement
d2var_get_linval (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_linval
end // end of [d2var_get_linval]

implement
d2var_get_isfix (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isfix
end // end of [d2var_get_isfix]
implement
d2var_set_isfix (d2v, isfix) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isfix := isfix
end // end of [d2var_set_isfix]

implement
d2var_get_isprf (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isprf
end // end of [d2var_get_isprf]
implement
d2var_set_isprf (d2v, isprf) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isprf := isprf
end // end of [d2var_set_isprf]

implement
d2var_get_decarg (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_decarg
end // end of [d2var_get_decarg]
implement
d2var_set_decarg (d2v, decarg) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_decarg := decarg
end // end of [d2var_set_decarg]

implement
d2var_get_addr (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_addr
end // end of [d2var_get_addr]
implement
d2var_set_addr (d2v, s2fopt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_addr := s2fopt
end // end of [d2var_set_addr]

implement
d2var_get_view (d2v) = let
  val (vbox pf | p) =
    ref_get_view_ptr (d2v) in d2varopt_decode (p->d2var_view)
end // end of [d2var_get_view]
implement
d2var_set_view (d2v, d2vopt) = let
  val (vbox pf | p) =
    ref_get_view_ptr (d2v) in p->d2var_view := d2varopt_encode (d2vopt)
end // end of [d2var_set_view]

implement
d2var_get_finknd (d2v) = let
  val (vbox pf | p) =
    ref_get_view_ptr (d2v) in p->d2var_finknd
end // end of [d2var_get_finknd]
implement
d2var_set_finknd (d2v, knd) = let
  val (vbox pf | p) =
    ref_get_view_ptr (d2v) in p->d2var_finknd := knd
  // end of [val]
end // end of [d2var_set_finknd]

implement
d2var_get_type (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_type
end // end of [d2var_get_type]
implement
d2var_set_type (d2v, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_type := opt
end // end of [d2var_set_type]

implement
d2var_get_mastype (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_mastype
end // end of [d2var_get_mastype]
implement
d2var_set_mastype (d2v, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_mastype := opt
end // end of [d2var_set_mastype]

implement
d2var_get_stamp (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_stamp
end // end of [d2var_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
compare_d2var_d2var (x1, x2) =
  $effmask_all (compare (d2var_get_stamp (x1), d2var_get_stamp (x2)))
// end of [compare_d2var_d2var]

implement
compare_d2vsym_d2vsym
  (x1, x2) = $effmask_all (
  $SYM.compare_symbol_symbol (d2var_get_sym (x1), d2var_get_sym (x2))
) // end of [compare_d2vsym_d2vsym]

(* ****** ****** *)

implement
fprint_d2var (out, d2v) = let
  val () = $SYM.fprint_symbol (out, d2var_get_sym d2v)
// (*
  val () = fprint_string (out, "(")
  val () = $STP.fprint_stamp (out, d2var_get_stamp d2v)
  val () = fprint_string (out, ")")
// *)
in
  // nothing
end // end of [fprint_d2var]

implement print_d2var (x) = fprint_d2var (stdout_ref, x)
implement prerr_d2var (x) = fprint_d2var (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_dynexp2_dvar.dats] *)
