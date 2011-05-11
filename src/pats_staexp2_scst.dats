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

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload
CNTR = "pats_counter.sats"
staload STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
overload compare with $STP.compare_stamp_stamp
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = $SYM.symbolopt

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

abstype s2cstlst_t // = s2cstlst
extern
castfn s2cstlst_encode (x: s2cstlst): s2cstlst_t
extern
castfn s2cstlst_decode (x: s2cstlst_t): s2cstlst

abstype s2cstopt_t // = s2cstopt
extern
castfn s2cstopt_encode (x: s2cstopt): s2cstopt_t
extern
castfn s2cstopt_decode (x: s2cstopt_t): s2cstopt

(* ****** ****** *)

typedef
s2cst_struct = @{ (* builtin or abstract *)
  s2cst_sym= symbol // the name
, s2cst_loc= location // the location of declaration
, s2cst_srt= s2rt // the sort
, s2cst_isabs= Option (s2expopt) // is abstract?
, s2cst_iscon= bool // constructor?
, s2cst_isrec= bool // is it recursive?
, s2cst_isasp= bool // already assumed?
, s2cst_iscpy= s2cstopt_t // is it a copy?
//
// HX: is list-like?
//
, s2cst_islst= Option @(d2con(*nil*), d2con(*cons*))
, s2cst_arilst= List int // arity list
// 
// HX: -1/0/1: contravarint/invariant/covarint
//
, s2cst_argvar= List (syms2rtlst)
//
// HX: the associated dynamic constructors
//
, s2cst_conlst= Option (d2conlst)
, s2cst_def= s2expopt // definition
, s2cst_sup= s2cstlst_t // parents if any
, s2cst_supcls= s2explst // superclasses if any
, s2cst_sVarset= s2Varset // for occurrence checks
, s2cst_stamp= stamp // unique stamp
, s2cst_tag= int // tag >= 0 if associated with a datasort
} // end of [s2cst_struct]

(* ****** ****** *)

local

assume s2cst_type = ref (s2cst_struct)

fun s2rt_arity_list
  (s2t: s2rt): List int = case+ s2t of
  | S2RTfun (s2ts, s2t) => begin
      list_cons (list_length s2ts, s2rt_arity_list s2t)
    end // end of [S2RTfun]
  | _ => list_nil () // end of [_]
// end of [s2rt_arity_list]

in // in of [local]

implement
s2cst_make (
  id, loc
, s2t
, isabs
, iscon
, isrec
, isasp
, islst
, argvar
, def
) = let
//
val stamp = $STP.s2cst_stamp_make ()
val (pfgc, pfat | p) = ptr_alloc<s2cst_struct> ()
prval () = free_gc_elim {s2cst_struct} (pfgc)
//
val () = p->s2cst_sym := id
val () = p->s2cst_loc := loc
val () = p->s2cst_srt := s2t
val () = p->s2cst_isabs := isabs
val () = p->s2cst_iscon := iscon
val () = p->s2cst_isrec := isrec
val () = p->s2cst_isasp := isasp
val () = p->s2cst_iscpy := s2cstopt_encode (None)
val () = p->s2cst_islst := islst
val () = p->s2cst_arilst := s2rt_arity_list (s2t)
val () = p->s2cst_argvar := argvar
val () = p->s2cst_conlst := None ()
val () = p->s2cst_def := def
val () = p->s2cst_sup := s2cstlst_encode (list_nil)
val () = p->s2cst_supcls := list_nil ()
val () = p->s2cst_sVarset := s2Varset_make_nil ()
val () = p->s2cst_stamp := stamp
val () = p->s2cst_tag := (~1)
//
in // in of [let]
//
ref_make_view_ptr (pfat | p)
//
end // end of [s2cst_make]

implement
s2cst_get_sym (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_sym
end // end of [s2cst_get_sym]

implement
s2cst_get_srt (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_srt
end // end of [s2cst_get_srt]

implement
s2cst_get_tag (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_tag
end // end of [s2cst_get_tag]
implement
s2cst_set_tag (s2c, tag) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_tag := tag
end // end of [s2cst_set_tag]

end // end of [local]

(* ****** ****** *)

implement
fprint_s2cst (out, x) = let
  val sym = s2cst_get_sym (x) in $SYM.fprint_symbol (out, sym)
end // end of [fprint_s2cst]

implement print_s2cst (x) = fprint_s2cst (stdout_ref, x)
implement prerr_s2cst (x) = fprint_s2cst (stderr_ref, x)

implement
fprint_s2cstlst (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s2cst)

(* ****** ****** *)

(* end of [pats_staexp2_scst.dats] *)
