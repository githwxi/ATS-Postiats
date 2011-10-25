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

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

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

staload "pats_staexp2.sats"

(* ****** ****** *)

abstype s2cstlst_t // = s2cstlst
extern
castfn s2cstlst_encode (x: s2cstlst):<> s2cstlst_t
extern
castfn s2cstlst_decode (x: s2cstlst_t):<> s2cstlst

abstype s2cstopt_t // = s2cstopt
extern
castfn s2cstopt_encode (x: s2cstopt):<> s2cstopt_t
extern
castfn s2cstopt_decode (x: s2cstopt_t):<> s2cstopt

(* ****** ****** *)

typedef
s2cst_struct = @{ (* builtin or abstract *)
  s2cst_sym= symbol // the name
, s2cst_loc= location // the location of declaration
, s2cst_srt= s2rt // the sort
//
, s2cst_def= s2expopt // definition
//
, s2cst_isabs= Option (s2expopt) // is abstract?
, s2cst_iscon= bool // constructor?
, s2cst_isrec= bool // is it recursive?
, s2cst_isasp= bool // already assumed?
, s2cst_iscpy= s2cstopt_t // is it a copy?
//
// HX: is list-like?
//
, s2cst_islst= Option @(d2con(*nil*), d2con(*cons*))
, s2cst_arylst= List int // arity list
// 
// HX: -1/0/1: contravarint/invariant/covarint
//
, s2cst_argvar= List (syms2rtlst)
//
// HX: the associated dynamic constructors
//
, s2cst_conlst= Option (d2conlst)
//
, s2cst_sup= s2cstlst_t // parents if any
, s2cst_supcls= s2explst // superclasses if any
//
, s2cst_sVarset= s2Varset // for occurrence checks
//
, s2cst_stamp= stamp // unique stamp
//
, s2cst_tag= int // tag >= 0 if associated with a datasort
} // end of [s2cst_struct]

(* ****** ****** *)

local

fun s2rt_get_arylst
  (s2t: s2rt): List int =
  case+ s2t of
  | S2RTfun (s2ts, s2t) => 
      list_cons (list_length s2ts, s2rt_get_arylst (s2t))
    // end of [S2RTfun]
  | _ => list_nil () // end of [_]
// end of [s2rt_get_arylst]

assume s2cst_type = ref (s2cst_struct)

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
val () = p->s2cst_def := def
val () = p->s2cst_isabs := isabs
val () = p->s2cst_iscon := iscon
val () = p->s2cst_isrec := isrec
val () = p->s2cst_isasp := isasp
val () = p->s2cst_iscpy := s2cstopt_encode (None)
val () = p->s2cst_islst := islst
val () = p->s2cst_arylst := s2rt_get_arylst (s2t)
val () = p->s2cst_argvar := argvar
val () = p->s2cst_conlst := None ()
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
s2cst_get_def (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_def
end // end of [s2cst_def_get]

implement
s2cst_get_isabs (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_isabs
end // end of [s2cst_get_isabs]

implement
s2cst_get_iscon (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_iscon
end // end of [s2cst_get_iscon]

implement
s2cst_get_isrec (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_isrec
end // end of [s2cst_get_isrec]

implement
s2cst_get_argvar (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_argvar
end // end of [s2cst_get_argvar]

implement
s2cst_get_islst (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_islst
end // end of [s2cst_get_islst]
implement
s2cst_set_islst (s2c, islst) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_islst := islst
end // end of [s2cst_set_islst]

implement
s2cst_get_conlst (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_conlst
end // end of [s2cst_get_conlst]
implement
s2cst_set_conlst (s2c, d2cs) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_conlst := d2cs
end // end of [s2cst_set_conlst]

implement
s2cst_get_sup (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c)
in
  s2cstlst_decode (p->s2cst_sup)
end // end of [s2cst_sup_get]
implement
s2cst_add_sup (s2c, sup) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c)
  val sups = s2cstlst_decode (p->s2cst_sup)
  val sups = s2cstlst_encode (list_cons (sup, sups))
in
  p->s2cst_sup := sups
end // end of [s2cst_sup_add]

implement
s2cst_get_supcls (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_supcls
end // end of [s2cst_get_supcls]
implement
s2cst_add_supcls (s2c, sup) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c)
in
  p->s2cst_supcls := list_cons (sup, p->s2cst_supcls)
end // end of [s2cst_supcls_add]

implement
s2cst_get_tag (s2c) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_tag
end // end of [s2cst_get_tag]
implement
s2cst_set_tag (s2c, tag) = let
  val (vbox pf | p) = ref_get_view_ptr (s2c) in p->s2cst_tag := tag
end // end of [s2cst_set_tag]

implement
s2cst_get_stamp (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2cst_stamp
end // end of [s2cst_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
s2cst_make_dat (
  id, loc, s2tss_arg, s2t_res, argvar
) = let
  val s2t_fun =
    aux (s2tss_arg, s2t_res) where {
    fun aux (xs: s2rtlstlst, s2t: s2rt): s2rt =
      case+ xs of
      | list_cons (x, xs) => s2rt_fun (x, aux (xs, s2t))
      | list_nil () => s2t
    // end of [aux]
  } // end of [val]
in
  s2cst_make (
    id // name
  , loc // the location of declaration
  , s2t_fun // sort
  , None () // isabs
  , true // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , argvar // argumnet variance
  , None () // definition
  ) // end of [s2cst_make]
end // end of [s2cst_make_dat]

(* ****** ****** *)

implement
lt_s2cst_s2cst
  (x1, x2) = (compare (x1, x2) < 0)
// end of [lt_s2cst_s2cst]

implement
lte_s2cst_s2cst
  (x1, x2) = (compare (x1, x2) <= 0)
// end of [lte_s2cst_s2cst]

implement
eq_s2cst_s2cst
  (x1, x2) = (compare (x1, x2) = 0)
// end of [eq_s2cst_s2cst]

implement
neq_s2cst_s2cst
  (x1, x2) = (compare (x1, x2) != 0)
// end of [neq_s2cst_s2cst]

implement
compare_s2cst_s2cst (x1, x2) =
  $effmask_all (compare (s2cst_get_stamp (x1), s2cst_get_stamp (x2)))
// end of [compare_s2cst_s2cst]

(* ****** ****** *)

implement
s2cst_is_abstract (x) =
  case+ s2cst_get_isabs (x) of Some _ => true | None _ => false
// end of [s2cst_is_abstract]

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
