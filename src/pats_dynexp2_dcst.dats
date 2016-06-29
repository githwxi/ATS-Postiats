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

staload "./pats_basics.sats"

(* ****** ****** *)

staload
GLOB = "./pats_global.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
overload compare with $STMP.compare_stamp_stamp

(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = $SYM.symbolopt
overload fprint with $SYM.fprint_symbol

(* ****** ****** *)

staload
SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

typedef
d2cst_struct = @{
  d2cst_sym= symbol
//
, d2cst_loc= location
//
, d2cst_fil= filename
//
, d2cst_kind= dcstkind
//
, d2cst_decarg= s2qualst // template arg
//
, d2cst_artylst= List(int) // arity
//
, d2cst_type= s2exp // HX: assigned type
//
, d2cst_hisexp= hisexpopt // type erasure
, d2cst_funlab= funlabopt // function label
//
(*
, d2cst_skexp= s2kexp // skeleton of the assigned type
*)
, d2cst_def= d2expopt // definition
//
, d2cst_pack= Stropt  // for ATS_PACKNAME
//
, d2cst_stamp= stamp  // stamp for unicity
//
, d2cst_extdef= dcstextdef // external dcst definition
//
} (* end of [d2cst_struct] *)

(* ****** ****** *)

local

assume d2cst_type = ref (d2cst_struct)

in (* in of [local] *)

implement
d2cst_make
(
  id, loc, fil
, dck, decarg, artylst, typ, extdef
) = let
//
(*
val out = stdout_ref
val () = fprintln! (out, "d2cst_make: id = ", id)
*)
//
val pack = $GLOB.the_PACKNAME_get ()
//
val stamp = $STMP.d2cst_stamp_make ()
//
val (pfgc, pfat | p) = ptr_alloc<d2cst_struct> ()
prval ((*freed*)) = free_gc_elim {d2cst_struct?} (pfgc)
//
val () = p->d2cst_sym := id
val () = p->d2cst_loc := loc
val () = p->d2cst_fil := fil
val () = p->d2cst_kind := dck
val () = p->d2cst_decarg := decarg
val () = p->d2cst_artylst := artylst
val () = p->d2cst_type := typ
//
val () = p->d2cst_hisexp := None(*void*)
val () = p->d2cst_funlab := None(*void*)
//
(*
val () = p->d2cst_skexp := s2kexp_make_s2exp (typ)
*)
val () = p->d2cst_def := None
val () = p->d2cst_pack := pack
val () = p->d2cst_stamp := stamp
//
val () = p->d2cst_extdef := extdef
//
in (* in of [let] *)
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2cst_make]

implement
d2cst_get_sym (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_sym
end // end of [d2cst_get_sym]

(* ****** ****** *)

implement
d2cst_get_loc (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_loc
end // end of [d2cst_get_loc]

(* ****** ****** *)

implement
d2cst_get_fil (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_fil
end // end of [d2cst_get_fil]

(* ****** ****** *)

implement
d2cst_get_kind (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_kind
end // end of [d2cst_get_kind]

(* ****** ****** *)

implement
d2cst_get_decarg (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_decarg
end // end of [d2cst_get_decarg]

(* ****** ****** *)

implement
d2cst_get_artylst (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_artylst
end // end of [d2cst_get_artylst]

(* ****** ****** *)

implement
d2cst_get_type (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_type
end // end of [d2cst_get_type]

(* ****** ****** *)

implement
d2cst_get_hisexp (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_hisexp
end // end of [d2cst_get_hisexp]
implement
d2cst_set_hisexp (d2c, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_hisexp := opt
end // end of [d2cst_set_hisexp]

(* ****** ****** *)

implement
d2cst_get_funlab (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_funlab
end // end of [d2cst_get_funlab]
implement
d2cst_set_funlab (d2c, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_funlab := opt
end // end of [d2cst_set_funlab]

(* ****** ****** *)

implement
d2cst_get_def (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_def
end // end of [d2cst_get_def]
implement
d2cst_set_def (d2c, def) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_def := def
end // end of [d2cst_set_def]

(* ****** ****** *)

implement
d2cst_get_pack (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_pack
end // end of [d2cst_get_pack]

(* ****** ****** *)

implement
d2cst_get_extdef (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_extdef
end // end of [d2cst_get_extdef]

(* ****** ****** *)

implement
d2cst_get_stamp (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_stamp
end // end of [d2cst_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
d2cst_get_name (d2c) = 
  $SYM.symbol_get_name (d2cst_get_sym (d2c))
// end of [d2cst_get_name]

(* ****** ****** *)

implement
print_d2cst (x) = fprint_d2cst (stdout_ref, x)
implement
prerr_d2cst (x) = fprint_d2cst (stderr_ref, x)

implement
fprint_d2cst (out, x) =
  $SYM.fprint_symbol (out, d2cst_get_sym (x))
implement
fprint_d2cstlst (out, xs) = let
//
fun loop (
  out: FILEref
, xs: d2cstlst, sep: string, i: int
) : void = let
in
  case+ xs of
  | list_cons
      (x, xs) => let
      val () =
        if i > 0 then fprint_string (out, sep)
      val () = fprint_d2cst (out, x)
    in
      loop (out, xs, sep, i+1)
    end // end of [list_cons]
  | list_nil () => ()
//
end // end of [loop]
//
val sep = ", "
//
in
  loop (out, xs, sep, 0)
end // end of [fprint_d2cstlst]

(* ****** ****** *)

implement
d2cst_is_prf (d2c) = let
  val s2e = d2cst_get_type (d2c) in s2exp_is_prf (s2e)
end // end of [d2cst_is_prf]
implement
d2cst_is_nonprf (d2c) = let
  val s2e = d2cst_get_type (d2c) in s2exp_is_nonprf (s2e)
end // end of [d2cst_is_nonprf]

(* ****** ****** *)

implement
d2cst_is_mac (d2c) =
  $SYN.dcstextdef_is_mac (d2cst_get_extdef (d2c))
// end of [d2cst_is_mac]

(* ****** ****** *)

implement
d2cst_is_static (d2c) = let
  val extdef = d2cst_get_extdef (d2c)
in
  case+ extdef of
  | $SYN.DCSTEXTDEFnone(0) => true
  | $SYN.DCSTEXTDEFsome_sta _ => true
  | _ => false
end // end of [d2cst_is_static]

(* ****** ****** *)

implement
d2cst_is_fundec (d2c) =
  dcstkind_is_fun(d2cst_get_kind(d2c))
// end of [d2cst_is_fundec]
implement
d2cst_is_valdec (d2c) =
  dcstkind_is_val(d2cst_get_kind(d2c))
// end of [d2cst_is_valdec]
implement
d2cst_is_castfn (d2c) =
  dcstkind_is_castfn(d2cst_get_kind(d2c))
// end of [d2cst_is_castfn]

(* ****** ****** *)
//
implement
d2cst_is_tmpcst (d2c) =
  list_is_cons(d2cst_get_decarg(d2c))
//
(* ****** ****** *)

implement
d2cst_is_mainats (d2c) =
  $SYN.dcstextdef_is_mainats (d2cst_get_extdef (d2c))
// end of [d2cst_is_mainats]

(* ****** ****** *)

implement
lt_d2cst_d2cst
  (x1, x2) = (compare (x1, x2) < 0)
// end of [lt_d2cst_d2cst]

implement
lte_d2cst_d2cst
  (x1, x2) = (compare (x1, x2) <= 0)
// end of [lte_d2cst_d2cst]

implement
eq_d2cst_d2cst
  (x1, x2) = (compare (x1, x2) = 0)
// end of [eq_d2cst_d2cst]

implement
neq_d2cst_d2cst
  (x1, x2) = (compare (x1, x2) != 0)
// end of [neq_d2cst_d2cst]

implement
compare_d2cst_d2cst (x1, x2) =
  $effmask_all (compare (d2cst_get_stamp (x1), d2cst_get_stamp (x2)))
// end of [compare_d2cst_d2cst]

(* ****** ****** *)

local
//
staload
FS = "libats/SATS/funset_avltree.sats"
staload _ = "libats/DATS/funset_avltree.dats"
staload
LS = "libats/SATS/linset_avltree.sats"
staload _ = "libats/DATS/linset_avltree.dats"
//
val cmp = lam
(
  d2c1: d2cst, d2c2: d2cst
) : int =<cloref>
  compare_d2cst_d2cst (d2c1, d2c2)
// end of [val]
//
assume d2cstset_type = $FS.set (d2cst)
assume d2cstset_vtype = $LS.set (d2cst)
//
in (* in of [local] *)

implement
d2cstset_nil () = $FS.funset_make_nil ()

implement
d2cstset_ismem
  (xs, x) = $FS.funset_is_member (xs, x, cmp)
// end of [d2cstset_ismem]

implement
d2cstset_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $FS.funset_insert (xs, x, cmp)
} // end of [d2cstset_add]

(* ****** ****** *)

implement
d2cstset_vt_nil () = $LS.linset_make_nil ()

implement
d2cstset_vt_add
  (xs, x) = xs where {
  var xs = xs
  val _(*rplced*) = $LS.linset_insert (xs, x, cmp)
} // end of [d2cstset_vt_add]

implement
d2cstset_vt_listize_free (xs) = $LS.linset_listize_free (xs)

end // end of [local]

(* ****** ****** *)

local

staload
FM = "libats/SATS/funmap_avltree.sats"
staload _ = "libats/DATS/funmap_avltree.dats"

val cmp = lam
(
  d2c1: d2cst, d2c2: d2cst
) : int =<cloref>
  compare_d2cst_d2cst (d2c1, d2c2)
// end of [val]

assume
d2cstmap_type (a:type) = $FM.map (d2cst, a)

in (* in of [local] *)

implement
d2cstmap_nil () = $FM.funmap_make_nil ()

implement
d2cstmap_search
  {a} (map, d2c) =
  $FM.funmap_search_opt (map, d2c, cmp)
// end of [d2cstmap_search]

implement
d2cstmap_insert
  {a} (map, d2c, x) =
  $FM.funmap_insert (map, d2c, x, cmp)
// end of [d2cstmap_insert]

end // end of [local]

(* ****** ****** *)

(* end of [pats_dynexp2_dcst.dats] *)
