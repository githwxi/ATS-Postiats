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

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload
CNTR = "pats_counter.sats"
staload STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
overload compare with $STP.compare_stamp_stamp
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

typedef
s2var_struct = @{
  s2var_sym= symbol // the name
, s2var_srt= s2rt  // the sort
, s2var_tmplev= int // the template level
, s2var_sVarset= s2Varset // existential variable occurrences
, s2var_stamp= stamp // uniqueness
} // end of [s2var_struct]

(* ****** ****** *)

val the_s2var_name_counter = $CNTR.counter_make ()

fn s2var_name_make
  (): symbol = let
  val n = $CNTR.counter_getinc (the_s2var_name_counter)
in
  $SYM.symbol_make_string ($CNTR.tostring_prefix_count ("$", n))
end // end of [s2var_name_make]

fn s2var_name_make_prefix
  (pre: string): symbol = let
  val n = $CNTR.counter_getinc (the_s2var_name_counter)
in
  $SYM.symbol_make_string (pre + $CNTR.tostring_prefix_count ("$", n))
end // end of [s2var_name_make_prefix]

(* ****** ****** *)

local

assume s2var_type = ref (s2var_struct)

in // in of [local]

implement
s2var_make_id_srt (id, s2t) = let
  val stamp = $STP.s2var_stamp_make ()
  val (pfgc, pfat | p) = ptr_alloc<s2var_struct> ()
  prval () = free_gc_elim {s2var_struct} (pfgc)
//
  val () = p->s2var_sym := id
  val () = p->s2var_srt := s2t
  val () = p->s2var_tmplev := 0
  val () = p->s2var_sVarset := s2Varset_make_nil ()
  val () = p->s2var_stamp := stamp
//
in
  ref_make_view_ptr (pfat | p)
end // end of [s2var_make_id_srt]

implement
s2var_get_sym (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_sym
end // end of [s2var_get_sym]

implement
s2var_get_srt (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_srt
end // end of [s2var_get_srt]

implement
s2var_get_tmplev (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_tmplev
end // end of [s2var_get_tmplev]
implement
s2var_set_tmplev (s2v, lev) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_tmplev := lev
end // end of [s2var_set_tmplev]

implement
s2var_get_sVarset (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_sVarset
end // end of [s2var_get_sVarset]
implement
s2var_set_sVarset (s2v, xs) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_sVarset := xs
end // end of [s2var_set_sVarset]

implement
s2var_get_stamp (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_stamp
end // end of [s2var_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
s2var_make_srt (s2t) = let
  val id = s2var_name_make () in s2var_make_id_srt (id, s2t)
end // end of [s2var_make_srt]

implement
s2var_copy (s2v0) = let
  val id0 = s2var_get_sym s2v0
  val s2t0 = s2var_get_srt s2v0
  val id_new = s2var_name_make_prefix ($SYM.symbol_get_name id0)
in
  s2var_make_id_srt (id_new, s2t0)
end // end of [s2var_copy]

(* ****** ****** *)

implement
lt_s2var_s2var
  (x1, x2) = (compare (x1, x2) < 0)
// end of [lt_s2var_s2var]

implement
lte_s2var_s2var
  (x1, x2) = (compare (x1, x2) <= 0)
// end of [lte_s2var_s2var]

implement
compare_s2var_s2var (x1, x2) =
  compare (s2var_get_stamp (x1), s2var_get_stamp (x2))
// end of [compare_s2var_s2var]

(* ****** ****** *)

implement
fprint_s2var (out, s2v) = let
  val () = $SYM.fprint_symbol (out, s2var_get_sym s2v)
// (*
  val () = fprint_string (out, "(")
  val () = $STP.fprint_stamp (out, s2var_get_stamp s2v)
  val () = fprint_string (out, ")")
// *)
in
  // empty
end // end of [fprint_s2var]

implement
fprint_s2varlst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_s2var)
// end of [fprint_s2varlst]

(* ****** ****** *)

(* end of [pats_staexp2_svar.dats] *)
