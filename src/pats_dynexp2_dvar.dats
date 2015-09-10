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

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
overload compare with $STMP.compare_stamp_stamp

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = $SYM.symbolopt

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)
//
// HX: this is for handling type recursion
//
abstype d2varopt2 // = d2varopt
extern
castfn d2varopt2_encode (x: d2varopt):<> d2varopt2
extern
castfn d2varopt2_decode (x: d2varopt2):<> d2varopt
//
(* ****** ****** *)

typedef
d2var_struct =
@{
  d2var_sym= symbol // name
, d2var_loc= location // first location
, d2var_level= int // toplevel: 0
, d2var_linval= int // nonlinear (-1) and linear (>=0)
, d2var_isfix= bool // is fix-variable?
, d2var_isprf= bool // is proof?
, d2var_decarg= s2qualst // nil/cons -> function/template
, d2var_addr= s2expopt //
, d2var_view= d2varopt2 // 
, d2var_finknd= d2vfin // the status at the end of scope
, d2var_type= s2expopt // the (current) type of a variable
, d2var_hisexp= hisexpopt // the type erasure of [d2var_type]
, d2var_mastype= s2expopt // the master type of a variable
, d2var_utimes= int //
, d2var_stamp= stamp // uniqueness stamp
} (* end of [d2var_struct] *)

(* ****** ****** *)

local

assume d2var_type = ref (d2var_struct)

in (* in of [local] *)

implement
d2var_make
  (loc, id) = let
//
val stamp = $STMP.d2var_stamp_make ()
//
val (pfgc, pfat | p) = ptr_alloc<d2var_struct> ()
prval ((*freed*)) = free_gc_elim {d2var_struct?} (pfgc)
//
val () = p->d2var_sym := id
val () = p->d2var_loc := loc
val () = p->d2var_level := ~1
val () = p->d2var_linval := ~1;
val () = p->d2var_isfix := false
val () = p->d2var_isprf := false
val () = p->d2var_decarg := list_nil ()
val () = p->d2var_addr := None ()
val () = p->d2var_view := d2varopt2_encode (None(*d2v*))
val () = p->d2var_finknd := D2VFINnone ()
val () = p->d2var_type := None ()
val () = p->d2var_hisexp := None ()
val () = p->d2var_mastype := None ()
val () = p->d2var_utimes := 0
val () = p->d2var_stamp := stamp
//
in
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2var_make]

(* ****** ****** *)

implement
d2var_make_any
  (loc) = d2var_make (loc, $SYM.symbol_UNDERSCORE)
// end of [d2var_make_any]

(* ****** ****** *)

implement
d2var_get_sym
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_sym
end // end of [d2var_get_sym]

implement
d2var_get_loc
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_loc
end // end of [d2var_get_loc]

implement
d2var_get_level
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_level
end // end of [d2var_get_level]
implement
d2var_set_level (d2v, lev) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_level := lev
end // end of [d2var_set_level]

implement
d2var_get_linval
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_linval
end // end of [d2var_get_linval]
implement
d2var_set_linval (d2v, lin) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_linval := lin
end // end of [d2var_set_linval]

implement
d2var_get_isfix
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isfix
end // end of [d2var_get_isfix]
implement
d2var_set_isfix (d2v, isfix) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isfix := isfix
end // end of [d2var_set_isfix]

implement
d2var_get_isprf
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isprf
end // end of [d2var_get_isprf]
implement
d2var_set_isprf (d2v, isprf) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_isprf := isprf
end // end of [d2var_set_isprf]

implement
d2var_get_decarg
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_decarg
end // end of [d2var_get_decarg]
implement
d2var_set_decarg (d2v, decarg) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_decarg := decarg
end // end of [d2var_set_decarg]

implement
d2var_get_addr
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_addr
end // end of [d2var_get_addr]
implement
d2var_set_addr (d2v, s2fopt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_addr := s2fopt
end // end of [d2var_set_addr]

implement
d2var_get_view
  (d2v) = $effmask_ref let
  val (
    vbox pf | p
  ) = ref_get_view_ptr (d2v) in d2varopt2_decode (p->d2var_view)
end // end of [d2var_get_view]
implement
d2var_set_view (d2v, opt) = let
  val (
    vbox pf | p
  ) = ref_get_view_ptr (d2v) in p->d2var_view := d2varopt2_encode (opt)
end // end of [d2var_set_view]

implement
d2var_get_finknd
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_finknd
end // end of [d2var_get_finknd]
implement
d2var_set_finknd (d2v, knd) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_finknd := knd
end // end of [d2var_set_finknd]

(* ****** ****** *)

implement
d2var_get_type (d2v) =
  $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_type
end // end of [d2var_get_type]
implement
d2var_set_type (d2v, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_type := opt
end // end of [d2var_set_type]

(* ****** ****** *)

implement
d2var_get_mastype
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_mastype
end // end of [d2var_get_mastype]
implement
d2var_set_mastype (d2v, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_mastype := opt
end // end of [d2var_set_mastype]

(* ****** ****** *)

implement
d2var_get_hisexp
  (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_hisexp
end // end of [d2var_get_hisexp]
implement
d2var_set_hisexp (d2v, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_hisexp := opt
end // end of [d2var_set_hisexp]

(* ****** ****** *)

implement
d2var_get_utimes (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_utimes
end // end of [d2var_get_utimes]
implement
d2var_set_utimes (d2v, nused) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_utimes := nused
end // end of [d2var_set_utimes]

implement
d2var_get_stamp (d2v) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (d2v) in p->d2var_stamp
end // end of [d2var_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
d2var_inc_linval (d2v) = let
  val lin = d2var_get_linval (d2v) in d2var_set_linval (d2v, lin+1)
end // end of [d2var_inc_linval]

implement
d2var_inc_utimes (d2v) = let
  val nused = d2var_get_utimes (d2v) in d2var_set_utimes (d2v, nused+1)
end // end of [d2var_inc_utimes]

(* ****** ****** *)

implement
d2var_is_linear (d2v) = (d2var_get_linval d2v >= 0)

implement
d2var_is_mutabl (d2v) =
  case+ d2var_get_view d2v of Some _ => true | None () => false
// end of [d2var_is_mutabl]

(* ****** ****** *)

implement
eq_d2var_d2var (x1, x2) = (compare_d2var_d2var (x1, x2) = 0)
implement
neq_d2var_d2var (x1, x2) = (compare_d2var_d2var (x1, x2) != 0)

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
d2var_exch_type
  (d2v, _new) = _old where {
  val _old =
    d2var_get_type (d2v)
  // end of [val]
  val () = d2var_set_type (d2v, _new)
} // end of [d2var_exch_type]

(* ****** ****** *)

implement
d2var_ptr_viewat_make
  (ptr, opt) = d2vw where {
  val loc = d2var_get_loc (ptr)
  and sym = d2var_get_sym (ptr)
  val d2vw = (
    case+ opt of
    | Some d2vw => d2vw
    | None () => let
       val nam = $SYM.symbol_get_name (sym)
       val sym1 = $SYM.symbol_make_string (nam + "$view")
     in
       d2var_make (loc, sym1)
     end // end of [None]
  ) : d2var // end of [val]
//
  val () = d2var_set_linval (d2vw, 0)
  val () = d2var_set_addr (d2vw, d2var_get_addr ptr)
//
} // end of [d2var_ptr_viewat_make]

implement
d2var_ptr_viewat_make_none
  (d2v_ptr) = d2var_ptr_viewat_make (d2v_ptr, None)
// end of [d2var_ptr_viewat_make_none]

(* ****** ****** *)

implement
print_d2var (d2v) = fprint_d2var (stdout_ref, d2v)
implement
prerr_d2var (d2v) = fprint_d2var (stderr_ref, d2v)

implement
fprint_d2var
  (out, d2v) = {
//
val () =
  $SYM.fprint_symbol (out, d2var_get_sym d2v)
//
val () = fprint_string (out, "$")
val () = $STMP.fprint_stamp (out, d2var_get_stamp d2v)
//
val () = fprint_string (out, "(")
val () = fprint_int (out, d2var_get_level d2v)
val () = fprint_string (out, ")")
//
} (* end of [fprint_d2var] *)

implement
fprint_d2varlst
  (out, d2vs) = $UT.fprintlst (out, d2vs, ", ", fprint_d2var)
// end of [fprint_d2varlst]

(* ****** ****** *)

implement
print_d2vfin (x) = fprint_d2vfin (stdout_ref, x)
implement
prerr_d2vfin (x) = fprint_d2vfin (stderr_ref, x)

implement
fprint_d2vfin
  (out, d2vfin) = let
//
macdef
prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ d2vfin of
| D2VFINnone () =>
    prstr "D2VFINnone()"
| D2VFINsome (s2e) => {
    val () = prstr "D2VFINsome("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  }
| D2VFINsome_lvar (s2e) => {
    val () = prstr "D2VFINsome_lvar("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  }
| D2VFINsome_vbox (s2e) => {
    val () = prstr "D2VFINsome_vbox("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  }
| D2VFINdone (d2vfin) => {
    val () = prstr "D2VFINdone("
    val () = fprint_d2vfin (out, d2vfin)
    val () = prstr ")"
  } (* end of [D2FINdone] *)
//
end // end of [fprint_d2vfin]

(* ****** ****** *)

local

staload
FS = "libats/SATS/funset_avltree.sats"
staload _ = "libats/DATS/funset_avltree.dats"

staload
LS = "libats/SATS/linset_avltree.sats"
staload _ = "libats/DATS/linset_avltree.dats"

val cmp = lam (
  d2v1: d2var, d2v2: d2var
) : int =<cloref>
  compare_d2var_d2var (d2v1, d2v2)
// end of [val]

assume d2varset_type = $FS.set (d2var)
assume d2varset_vtype = $LS.set (d2var)

in (* in of [local] *)

implement
d2varset_nil () = $FS.funset_make_nil ()

implement
d2varset_ismem
  (xs, x) = $FS.funset_is_member (xs, x, cmp)
// end of [d2varset_ismem]

implement
d2varset_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $FS.funset_insert (xs, x, cmp)
} // end of [d2varset_add]

implement
d2varset_listize (xs) = $FS.funset_listize (xs)

(* ****** ****** *)

implement
d2varset_vt_nil () = $LS.linset_make_nil ()

implement
d2varset_vt_free (xs) = $LS.linset_free (xs)

implement
d2varset_vt_ismem
  (xs, x) = $LS.linset_is_member (xs, x, cmp)
// end of [d2varset_vt_ismem]

implement
d2varset_vt_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $LS.linset_insert (xs, x, cmp)
} // end of [d2varset_vt_add]

implement
d2varset_vt_listize (xs) = $LS.linset_listize (xs)
implement
d2varset_vt_listize_free (xs) = $LS.linset_listize_free (xs)

end // end of [local]

(* ****** ****** *)

implement
fprint_d2varset
  (out, d2vset) = {
//
val xs =
  d2varset_listize (d2vset)
val () = $UT.fprintlst (out, $UN.linlst2lst(xs), ", ", fprint_d2var)
val () = list_vt_free (xs)
//
} // end of [fprint_d2varset]

(* ****** ****** *)

local

staload
FM = "libats/SATS/funmap_avltree.sats"
staload _ = "libats/DATS/funmap_avltree.dats"

staload
LM = "libats/SATS/linmap_avltree.sats"
staload _ = "libats/DATS/linmap_avltree.dats"

val cmp = lam (
  d2v1: d2var, d2v2: d2var
) : int =<cloref>
  compare_d2var_d2var (d2v1, d2v2)
// end of [val]

assume
d2varmap_type (a:type) = $FM.map (d2var, a)
assume
d2varmap_vtype (a:type) = $LM.map (d2var, a)
assume
d2varmaplst_vtype (a:type) = $LM.map (d2var, List_vt(a))

in (* in of [local] *)

implement
d2varmap_nil () = $FM.funmap_make_nil ()

implement
d2varmap_search
  {a} (map, d2v) =
  $FM.funmap_search_opt (map, d2v, cmp)
// end of [d2varmap_search]

implement
d2varmap_insert
  {a} (map, d2v, x) =
  $FM.funmap_insert (map, d2v, x, cmp)
// end of [d2varmap_insert]

implement
d2varmap_listize
  {a} (map) = $FM.funmap_listize (map)
// end of [d2varmap_listize]

(* ****** ****** *)

implement
d2varmap_vt_nil () = $LM.linmap_make_nil ()

implement
d2varmap_vt_free (map) = $LM.linmap_free (map)

implement
d2varmap_vt_search
  {a} (map, d2v) =
  $LM.linmap_search_opt (map, d2v, cmp)
// end of [d2varmap_vt_search]

implement
d2varmap_vt_insert
  {a} (map, d2v, x) = let
  var res: a? // uninitialized
  val ans = $LM.linmap_insert (map, d2v, x, cmp, res)
  prval () = opt_clear (res)
in
  ans
end // end of [d2varmap_vt_insert]

implement
d2varmap_vt_remove
  {a} (map, d2v) =
  $LM.linmap_remove (map, d2v, cmp)
// end of [d2varmap_vt_remove]

implement
d2varmap_vt_listize
  {a} (map) = $LM.linmap_listize (map)
// end of [d2varmap_vt_listize]

(* ****** ****** *)

implement
d2varmaplst_vt_nil () = $LM.linmap_make_nil ()

implement
d2varmaplst_vt_free
  {a} (map) = let
//
typedef key = d2var
vtypedef itm = List_vt (a)
//
fn f
(
  pfv: !unit_v | k: key, x: &itm >> itm?, env: !ptr
) :<> void = list_vt_free (x)
//
val env = null
prval pfv = unit_v ()
val ((*void*)) =
$effmask_all($LM.linmap_clear_funenv<key,itm> {unit_v}{ptr} (pfv | map, f, env))
prval unit_v () = pfv
//
in
  $LM.linmap_free<key,itm?> (map)
end // end of [d2varmaplst_vt_free]

implement
d2varmaplst_vt_search
  {a} (map, d2v) = let
//
typedef key = d2var
vtypedef itm = List_vt (a)
//
val p =
$LM.linmap_search_ref<key,itm> (map, d2v, cmp)
//
in
//
if (p > null)
  then let
    val xs = $UN.ptrget<List(a)> (p)
  in
    case+ xs of
      list_cons (x, _) => Some_vt (x) | _ => None_vt ()
    // end of [case]
  end // end of [then]
  else None_vt((*void*))
// end of [if]
//
end // end of [d2varmaplst_vt_search]

implement
d2varmaplst_vt_insert
  {a} (map, d2v, x0) = let
//
typedef key = d2var
vtypedef itm = List_vt (a)
//
val p =
$LM.linmap_search_ref<key,itm> (map, d2v, cmp)
//
in
//
if (p > null)
  then let
    val xs = $UN.ptrget<itm> (p)
    val () = $UN.ptrset<itm> (p, list_vt_cons{a}(x0, xs))
  in
    true
  end // end of [then]
  else let
    var res: itm
    val _(*false*) =
      $LM.linmap_insert<key,itm> (map, d2v, list_vt_sing(x0), cmp, res)
    val () = $UN.castvwtp0{void}(res)
  in
    false
  end // end of [else]
// end of [if]
//
end // end of [d2varmaplst_vt_search]

implement
d2varmaplst_vt_remove
  {a} (map, d2v) = let
//
typedef key = d2var
vtypedef itm = List_vt (a)
//
val p =
$LM.linmap_search_ref<key,itm> (map, d2v, cmp)
//
in
//
if (p > null)
  then let
    val xs = $UN.ptrget<itm> (p)
  in
    case+ xs of
    | ~list_vt_cons
        (_, xs) => let
        val () = (
          case+ xs of
          | list_vt_cons _ => let
              prval () = fold@(xs) in $UN.ptrset<itm> (p, xs)
            end // end of [list_vt_cons]
          | ~list_vt_nil () => let
              var res: itm
              val _(*true*) =
                $LM.linmap_takeout<key,itm> (map, d2v, cmp, res)
              // end of [val]
            in
              $UN.castvwtp0{void}(res)
            end // end of [list_vt_nil]
        ) : void // end of [val]
      in
        true
      end // end of [list_vt_cons]
    | ~list_vt_nil ((*void*)) => false
  end // end of [then]
  else false // end of [else]
// end of [if]
end // end of [d2varmaplst_vt_remove]

end // end of [local]

(* ****** ****** *)

(* end of [pats_dynexp2_dvar.dats] *)
