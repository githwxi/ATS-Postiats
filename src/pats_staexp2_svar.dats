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
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)
//
staload
CNTR = "./pats_counter.sats"
//
staload SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol
//
staload STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
overload compare with $STMP.compare_stamp_stamp
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

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
s2var_make_id_srt
  (id, s2t) = let
//
  val stamp = $STMP.s2var_stamp_make ()
  val (pfgc, pfat | p) = ptr_alloc<s2var_struct> ()
  prval () = free_gc_elim {s2var_struct?} (pfgc)
//
  val () = p->s2var_sym := id
  val () = p->s2var_srt := s2t
  val () = p->s2var_tmplev := 0
  val () = p->s2var_sVarset := s2Varset_nil ()
  val () = p->s2var_stamp := stamp
//
in
  ref_make_view_ptr (pfat | p)
end // end of [s2var_make_id_srt]

implement
s2var_get_sym (s2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_sym
end // end of [s2var_get_sym]

implement
s2var_get_srt (s2v) = $effmask_ref let
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
s2varlst_set_sVarset
  (s2vs, xs) = case+ s2vs of
  | list_cons (s2v, s2vs) => (
      s2var_set_sVarset (s2v, xs); s2varlst_set_sVarset (s2vs, xs)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [s2varlst_set_sVarset]

implement
s2var_get_stamp (s2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2v) in p->s2var_stamp
end // end of [s2var_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
s2var_is_bool (s2v) = let
  val s2t = s2var_get_srt (s2v) in s2rt_is_bool (s2t)
end // end of [s2var_is_bool]

(* ****** ****** *)

implement
s2var_make_srt (s2t) = let
  val id = s2var_name_make () in s2var_make_id_srt (id, s2t)
end // end of [s2var_make_srt]

implement
s2var_dup (s2v0) = let
  val id0 = s2var_get_sym s2v0
  val s2t0 = s2var_get_srt s2v0
  val id_new = s2var_name_make_prefix ($SYM.symbol_get_name id0)
in
  s2var_make_id_srt (id_new, s2t0)
end // end of [s2var_dup]

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
eq_s2var_s2var
  (x1, x2) = (compare (x1, x2) = 0)
// end of [eq_s2var_s2var]

implement
neq_s2var_s2var
  (x1, x2) = (compare (x1, x2) != 0)
// end of [neq_s2var_s2var]

implement
compare_s2var_s2var (x1, x2) = let
(*
  val () = $effmask_all (
    print "compare_s2var_s2var: x1 = "; print_s2var x1; print_newline ();
    print "compare_s2var_s2var: x2 = "; print_s2var x2; print_newline ();
  ) // end of [val]
*)
in
  compare (s2var_get_stamp (x1), s2var_get_stamp (x2))
end // end of [compare_s2var_s2var]

implement
compare_s2vsym_s2vsym
  (x1, x2) = (
  $SYM.compare_symbol_symbol (s2var_get_sym (x1), s2var_get_sym (x2))
) // end of [compare_s2vsym_s2vsym]

(* ****** ****** *)

implement
fprint_s2var (out, s2v) = let
  val () = $SYM.fprint_symbol (out, s2var_get_sym s2v)
// (*
  val () = fprint_string (out, "(")
  val () = $STMP.fprint_stamp (out, s2var_get_stamp s2v)
  val () = fprint_string (out, ")")
// *)
in
  // empty
end // end of [fprint_s2var]

implement print_s2var (x) = fprint_s2var (stdout_ref, x)
implement prerr_s2var (x) = fprint_s2var (stderr_ref, x)

implement
fprint_s2varlst (out, xs) =
  $UT.fprintlst<s2var> (out, xs, ", ", fprint_s2var)
// end of [fprint_s2varlst]

implement print_s2varlst (xs) = fprint_s2varlst (stdout_ref, xs)
implement prerr_s2varlst (xs) = fprint_s2varlst (stderr_ref, xs)

(* ****** ****** *)

local
//
staload
FS = "libats/SATS/funset_avltree.sats"
staload
LS = "libats/SATS/linset_avltree.sats"
staload
_(*FS*) = "libats/DATS/funset_avltree.dats"
staload
_(*LS*) = "libats/DATS/linset_avltree.dats"
//
val
cmp =
lam (
  s2v1: s2var, s2v2: s2var
) : int =<cloref>
  compare_s2var_s2var (s2v1, s2v2)
// end of [val]
//
assume s2varset_type = $FS.set (s2var)
assume s2varset_vtype = $LS.set (s2var)
//
in (* in-of-local *)

implement
s2varset_nil
  ((*void*)) = $FS.funset_make_nil ()

implement
s2varset_add
  (xs, x) = xs where {
  var xs = xs
  val _(*rplced*) = $FS.funset_insert (xs, x, cmp)
} (* end of [s2varset_add] *)

implement
s2varset_del
  (xs, x) = xs where {
  var xs = xs
  val _(*removed*) = $FS.funset_remove (xs, x, cmp)
} (* end of [s2varset_del] *)

implement
s2varset_union
  (xs, ys) = $FS.funset_union (xs, ys, cmp)

implement
s2varset_listize (xs) = $FS.funset_listize (xs)

(* ****** ****** *)

implement
s2varset_vt_nil
  ((*void*)) = $LS.linset_make_nil ()

implement
s2varset_vt_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $LS.linset_insert (xs, x, cmp)
} // end of [s2varset_vt_add]

implement
s2varset_vt_del
  (xs, x) = xs where {
  var xs = xs
  val _(*removed*) = $LS.linset_remove (xs, x, cmp)
} // end of [s2varset_vt_del]

implement
s2varset_vt_delist
  (xs1, xs2) = let
  fun loop {n:nat} .<n>. (
    xs1: s2varset_vt, xs2: list (s2var, n)
  ) : s2varset_vt =
    case+ xs2 of
    | list_cons (x2, xs2) => loop (s2varset_vt_del (xs1, x2), xs2)
    | list_nil () => xs1
  // end of [loop]
in
  loop (xs1, xs2)
end // end of [s2varset_vt_delist]

implement
s2varset_vt_union (xs, ys) = $LS.linset_union (xs, ys, cmp)

implement
s2varset_vt_free (xs) = $LS.linset_free (xs)
implement
s2varset_vt_listize_free (xs) = $LS.linset_listize_free (xs)

end // end of [local]

(* ****** ****** *)

local

staload
MSET = "libats/SATS/funmset_listord.sats"
staload _ = "libats/DATS/funmset_listord.dats"

assume
s2varmset_type = $MSET.mset (s2var)

val
cmp =
lam (
  s2v1: s2var, s2v2: s2var
) : int =<cloref>
  compare_s2var_s2var (s2v2, s2v1) // first-in-first-occur
// end of [val]

in // in of [local]

implement
s2varmset_nil () = $MSET.funmset_make_nil ()
implement
s2varmset_sing (x) = $MSET.funmset_make_sing (x)
implement
s2varmset_pair
  (x1, x2) = $MSET.funmset_make_pair (x1, x2, cmp)
// end of [s2varmset_pair]

implement
s2varmset_gte
  (xs1, xs2) =
  $MSET.funmset_compare (xs1, xs2, cmp) >= 0
// end of [s2varmset_gte]

implement
s2varmset_is_equal
  (xs1, xs2) = $MSET.funmset_is_equal (xs1, xs2, cmp)
// end of [s2varmset_is_equal]

implement
s2varmset_add
  (xs, x) = xs where {
  var xs = xs
  val () = $MSET.funmset_insert (xs, x, cmp)
} // end of [s2varmset_add]

implement
s2varmset_del
  (xs, x) = xs where {
  var xs = xs
  val _(*removed*) = $MSET.funmset_remove (xs, x, cmp)
} // end of [s2varmset_del]

implement
s2varmset_union
  (xs1, xs2) = $MSET.funmset_union (xs1, xs2, cmp)
// end of [s2varmset_union]

implement
s2varmset_listize (xs) = $MSET.funmset_listize (xs)

implement
fprint_s2varmset
  (out, xs) = let
//
val xs = $MSET.funmset_mlistize(xs)
val () = fprint_s2varlst (out, $UN.castvwtp1 {s2varlst} (xs))
val ((*freed*)) = list_vt_free (xs)
//
in
end // end of [fprint_s2varmset]

end // end of [local]

(* ****** ****** *)

local

staload
MAP = "libats/SATS/linmap_avltree.sats"
staload _ = "libats/DATS/linmap_avltree.dats"

val
cmp =
lam (
  s2v1: s2var, s2v2: s2var
) : int =<cloref>
  compare_s2var_s2var (s2v1, s2v2)
// end of [val]

assume
s2varbindmap_vtype = $MAP.map (s2var, s2exp)

in // in of [local]
//
implement
s2varbindmap_make_nil
  ((*void*)) = $MAP.linmap_make_nil ()
//
implement
s2varbindmap_search
  (map, k) = let
(*
val () = (
  println! ("s2varbindmap_search: k = ", k)
) (* end of [val] *)
*)
//
var res: s2exp? // uninitized
val found =
  $MAP.linmap_search<s2var,s2exp> (map, k, cmp, res)
//
in
//
if
found
then let
  prval() = opt_unsome{s2exp}(res) in Some_vt(res)
end // end of [then]
else let
  prval() = opt_unnone{s2exp}(res) in None_vt(*void*)
end // end of [else]
//
end (* end of [s2varbindmap_search] *)
//
implement
s2varbindmap_insert
  (map, k, x) = let
(*
val () =
(
  println! ("s2varbindmap_insert: k = ", k);
  println! ("s2varbindmap_insert: x = ", x);
) (* end of [val] *)
*)
//
val x = s2hnf2exp (x)
var res: s2exp? // unintialized
//
val
replaced =
  $MAP.linmap_insert<s2var,s2exp> (map, k, x, cmp, res)
//
prval () = opt_clear (res)
//
in
  // nothing
end // end of [s2varbindmap_insert]
//
implement
s2varbindmap_remove
  (map, k) = let
  val _(*removed*) = $MAP.linmap_remove<s2var,s2exp> (map, k, cmp)
in
  (*nothing*)
end // end of [s2varbindmap_remove]
//
implement
s2varbindmap_listize (map) = $MAP.linmap_listize<s2var,s2exp> (map)
//
end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_svar.dats] *)
