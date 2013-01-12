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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload
CNTR = "./pats_counter.sats"
staload STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
overload compare with $STMP.compare_stamp_stamp
staload SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

typedef
d2con_struct = @{
  d2con_loc= location // location
, d2con_fil= filename // filename
, d2con_sym= symbol // the name
, d2con_scst= s2cst // datatype
, d2con_npf= int // pfarity
, d2con_vwtp= int // viewtype constructor
, d2con_qua= s2qualst // quantifiers
, d2con_arg= s2explst // views or viewtypes
, d2con_arity_full= int // full arity
, d2con_arity_real= int // real arity after erasure
, d2con_ind= s2explstopt // indexes
, d2con_type= s2exp // type for dynamic constructor
, d2con_tag= int // tag for dynamic constructor
, d2con_stamp= stamp // uniqueness
} // end of [d2con_struct]

(* ****** ****** *)

local

assume d2con_type = ref (d2con_struct)

in // in of [local]

(* ****** ****** *)

implement
d2con_make (
  loc, fil, id, s2c, vwtp, qua, npf, arg, ind
) = let
//
val stamp =
  $STMP.d2con_stamp_make ()
// end of [val]
val arity_full = list_length (arg)
val arity_real = let
  fun aux1 (
    i: int, s2es: s2explst
  ) : s2explst = case+ s2es of
    | list_cons (_, s2es1) => if i > 0 then aux1 (i-1, s2es1) else s2es
    | list_nil () => list_nil ()
  // end of [aux1]
  fun aux2 (
    i: int, s2es: s2explst
  ) : int = case+ s2es of
    | list_cons (s2e, s2es1) =>
        if s2rt_is_prf (s2e.s2exp_srt) then aux2 (i, s2es1) else aux2 (i+1, s2es1)
      // end of [list_cons]
    | list_nil () => i // end of [list_nil]
  // end of [aux2]
in
  aux2 (0, aux1 (npf, arg))
end // end of [val]
//
val d2c_type = let
  fun aux (s2f: s2exp, s2qs: s2qualst): s2exp =
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val s2f = aux (s2f, s2qs)
        val s2f_uni =
          s2exp_uni (s2q.s2qua_svs, s2q.s2qua_sps, s2f)
        // end of [val]
      in
        s2f_uni
      end // end of [list_cons]
    | list_nil () => s2f
  // end of [aux]
  val s2e_res = (case+ ind of
    | Some s2es => s2exp_cstapp (s2c, s2es) | None () => s2exp_cst (s2c)
  ) : s2exp // end of [val]
  val s2f = s2exp_confun (npf, arg, s2e_res)
in
  aux (s2f, qua)
end : s2exp // end of [val]
//
val (pf_gc, pfat | p) = ptr_alloc<d2con_struct> ()
prval () = free_gc_elim (pf_gc)
//
val () = p->d2con_loc := loc
val () = p->d2con_fil := fil
val () = p->d2con_sym := id
val () = p->d2con_scst := s2c
val () = p->d2con_npf := npf
val () = p->d2con_vwtp := vwtp
val () = p->d2con_qua := qua
val () = p->d2con_arg := arg
val () = p->d2con_arity_full := arity_full
val () = p->d2con_arity_real := arity_real
val () = p->d2con_ind := ind
val () = p->d2con_type := d2c_type
val () = p->d2con_tag := ~1
val () = p->d2con_stamp := stamp
//
in
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2con_make]

(* ****** ****** *)

implement
d2con_get_fil (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_fil
end // end of [d2con_get_fil]

implement
d2con_get_sym (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_sym
end // end of [d2con_get_sym]

implement
d2con_get_scst (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_scst
end // end of [d2con_get_scst]

implement
d2con_get_npf (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_npf
end // end of [d2con_get_npf]

implement
d2con_get_vwtp (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_vwtp
end // end of [d2con_get_vwtp]

(* ****** ****** *)

implement
d2con_get_qua (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_qua
end // end of [d2con_get_qua]

implement
d2con_get_arg (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_arg
end // end of [d2con_get_arg]

implement
d2con_get_arity_full (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_arity_full
end // end of [d2con_get_arity_full]

implement
d2con_get_arity_real (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_arity_real
end // end of [d2con_get_arity_real]

implement
d2con_get_ind (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_ind
end // end of [d2con_get_ind]

implement
d2con_get_type (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_type
end // end of [d2con_get_type]

(* ****** ****** *)

implement
d2con_get_tag (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_tag
end // end of [d2con_get_tag]
implement
d2con_set_tag (d2c, tag) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_tag := tag
end // end of [d2con_set_tag]

(* ****** ****** *)

implement
d2con_get_stamp (d2c) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2con_stamp
end // end of [d2con_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
eq_d2con_d2con
  (x1, x2) = (compare (x1, x2) = 0)
// end of [eq_d2con_d2con]

implement
neq_d2con_d2con
  (x1, x2) = (compare (x1, x2) != 0)
// end of [neq_d2con_d2con]

implement
compare_d2con_d2con (x1, x2) =
  (compare (d2con_get_stamp (x1), d2con_get_stamp (x2)))
// end of [compare_d2con_d2con]

(* ****** ****** *)

#define D2CON_TAG_EXN ~1
#define D2CON_TAG_MSG ~2

implement
d2con_is_exn (d2c) = let
  val tag = d2con_get_tag (d2c) in tag = D2CON_TAG_EXN
end // end of [d2con_is_exn]

implement d2con_is_msg (d2c) = let
  val tag = d2con_get_tag (d2c) in tag = D2CON_TAG_MSG
end // end of [d2con_is_msg]

(* ****** ****** *)

implement
fprint_d2con (out, x) = let
  val sym = d2con_get_sym (x) in $SYM.fprint_symbol (out, sym)
end // end of [fprint_d2con]

implement
print_d2con (x) = fprint_d2con (stdout_ref, x)
implement
prerr_d2con (x) = fprint_d2con (stderr_ref, x)

(* ****** ****** *)

implement
fprint_d2conlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d2con)
// end of [fprint_d2conlst]

implement print_d2conlst (xs) = fprint_d2conlst (stdout_ref, xs)
implement prerr_d2conlst (xs) = fprint_d2conlst (stderr_ref, xs)

(* ****** ****** *)

(* end of [pats_staexp2_dcon.dats] *)
