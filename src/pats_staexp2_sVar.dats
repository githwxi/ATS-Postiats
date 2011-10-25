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

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
overload compare with $STP.compare_stamp_stamp

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

typedef
s2Var_struct = @{
  s2Var_sym= symbol // the name
, s2Var_srt= s2rt  // the sort
, s2Var_link= s2hnfopt // solution
, s2Var_sVarset= s2Varset // existential Variable occurrences
, s2Var_varknd= int // default=0; co: 1; contra: 2; in: 3
, s2Var_stamp= stamp // uniqueness
} // end of [s2Var_struct]

(* ****** ****** *)

local

assume s2Var_type = ref (s2Var_struct)

in // in of [local]

implement
s2Var_get_sym (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_sym
end // end of [s2Var_get_sym]

implement
s2Var_get_srt (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_srt
end // end of [s2Var_get_srt]

implement
s2Var_get_link (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_link
end // end of [s2Var_get_link]
implement
s2Var_set_link (s2V, link) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_link := link
end // end of [s2Var_set_link]

implement
s2Var_get_varknd (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_varknd
end // end of [s2Var_get_varknd]
implement
s2Var_set_varknd (s2V, knd) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_varknd := knd
end // end of [s2Var_set_varknd]

implement
s2Var_get_stamp (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_stamp
end // end of [s2Var_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
lt_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) < 0)
// end of [lt_s2Var_s2Var]

implement
lte_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) <= 0)
// end of [lte_s2Var_s2Var]

implement
eq_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) = 0)
// end of [eq_s2Var_s2Var]

implement
neq_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) != 0)
// end of [neq_s2Var_s2Var]

implement
compare_s2Var_s2Var (x1, x2) =
  compare (s2Var_get_stamp (x1), s2Var_get_stamp (x2))
// end of [compare_s2Var_s2Var]

(* ****** ****** *)

implement
fprint_s2Var (out, s2V) = let
  val () = $SYM.fprint_symbol (out, s2Var_get_sym s2V)
// (*
  val () = fprint_string (out, "(")
  val () = $STP.fprint_stamp (out, s2Var_get_stamp s2V)
  val () = fprint_string (out, ")")
// *)
in
  // empty
end // end of [fprint_s2Var]

(* ****** ****** *)

local

staload SET = "libats/SATS/funset_avltree.sats"
staload _(*anon*) = "libats/DATS/funset_avltree.dats"

assume s2Varset_type = $SET.set (s2Var)

in // in of [local]

implement s2Varset_make_nil () = $SET.funset_make_nil ()

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_sVar.dats] *)
