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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: May, 2011
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
typedef lstord (a:type) = $UT.lstord (a)

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
typedef label = $LAB.label

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef loc_t = $LOC.location
typedef location = $LOC.location

(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = $SYM.symbolopt

(* ****** ****** *)
//
staload
SYN = "./pats_syntax.sats"
//
typedef i0de = $SYN.i0de
typedef i0delst = $SYN.i0delst
//
typedef i0nt = $SYN.i0nt
typedef c0har = $SYN.c0har
typedef f0loat = $SYN.f0loat
typedef s0tring = $SYN.s0tring
//
typedef l0ab = $SYN.l0ab
typedef dl0abeled (a:type) = $SYN.dl0abeled (a)
//
typedef dcstextdef = $SYN.dcstextdef
typedef macsynkind = $SYN.macsynkind
//
(* ****** ****** *)
//
staload
S1E = "./pats_staexp1.sats"
staload
D1E = "./pats_dynexp1.sats"
//
typedef e1xp = $S1E.e1xp
typedef e1xplst = $S1E.e1xplst
typedef s1exp = $S1E.s1exp
typedef d1exp = $D1E.d1exp
//
(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)
//
// A place holder for [hisexp]
//
abstype dynexp2_hisexp_type
typedef hisexp = dynexp2_hisexp_type
typedef hisexpopt = Option (hisexp)
//
// A place holder for [funlab]
//
abstype dynexp2_funlab_type
typedef funlab = dynexp2_funlab_type
typedef funlabopt = Option (funlab)
//
(* ****** ****** *)
//
// HX: assumed in [pats_dynexp2_dcst.dats]
//
abstype d2cst_type
typedef d2cst = d2cst_type
typedef d2cstlst = List (d2cst)
typedef d2cstopt = Option (d2cst)
//
vtypedef d2cstlst_vt = List_vt (d2cst)
vtypedef d2cstopt_vt = Option_vt (d2cst)
//
abstype d2cstset_type
typedef d2cstset = d2cstset_type
//
absvtype d2cstset_vtype
vtypedef d2cstset_vt = d2cstset_vtype
//
abstype d2cstmap_type(a:type)
typedef d2cstmap(a:type) = d2cstmap_type(a)
//
(* ****** ****** *)
//
abstype d2var_type
typedef d2var = d2var_type
typedef d2varlst = List (d2var)
typedef d2varopt = Option (d2var)
//
vtypedef d2varlst_vt = List_vt (d2var)
vtypedef d2varopt_vt = Option_vt (d2var)
//
abstype d2varset_type // assumed in [pats_dynexp2_dvar.dats]
typedef d2varset = d2varset_type
absvtype d2varset_vtype // assumed in [pats_dynexp2_dvar.dats]
vtypedef d2varset_vt = d2varset_vtype
//
abstype
d2varmap_type (a:type) // assumed in [pats_dynexp2_dvar.dats]
typedef d2varmap (a:type) = d2varmap_type (a)
absvtype
d2varmap_vtype (a:type) // assumed in [pats_dynexp2_dvar.dats]
vtypedef d2varmap_vt (a:type) = d2varmap_vtype (a)
//
absvtype
d2varmaplst_vtype (a:type) // assumed in [pats_dynexp2_dvar.dats]
vtypedef d2varmaplst_vt (a:type) = d2varmaplst_vtype (a)
//
(* ****** ****** *)

abstype d2mac_type
typedef d2mac = d2mac_type
typedef d2maclst = List (d2mac)

(* ****** ****** *)

datatype d2itm =
  | D2ITMcst of d2cst
  | D2ITMvar of d2var
  | D2ITMcon of d2conlst
  | D2ITMe1xp of (e1xp)
  | D2ITMsymdef of (symbol, d2pitmlst) (* overloaded symbol *)
  | D2ITMmacdef of d2mac
  | D2ITMmacvar of d2var
// end of [d2itm]

and d2pitm = D2PITM of (int(*pval*), d2itm)

where
d2itmlst = List (d2itm)
and
d2pitmlst = List (d2pitm)

typedef d2itmopt = Option (d2itm)
vtypedef d2itmopt_vt = Option_vt (d2itm)

(* ****** ****** *)
//
typedef
d2sym = '{
  d2sym_loc= loc_t
, d2sym_qua= $SYN.d0ynq, d2sym_sym= symbol
, d2sym_pitmlst= d2pitmlst
} (* end of [d2sym] *)
//
(* ****** ****** *)
//
typedef d2symlst = List(d2sym)
vtypedef d2symlst_vt = List_vt(d2sym)
typedef d2symopt = Option(d2sym)
//
absvtype d2symset_vtype
vtypedef d2symset_vt = d2symset_vtype
//
(* ****** ****** *)

fun
d2cst_make
(
  id: symbol
, loc: loc_t // location of declaration
, fil: filename // filename of declaration
, dck: dcstkind
, decarg: s2qualst
, artylst: List int
, s2e: s2exp // HX: there is no s2Var in it
, extdef: dcstextdef
) : d2cst // end of [d2cst_make]

(* ****** ****** *)
//
// HX: implemented in [pats_dynexp2_dcst.dats]
//
fun print_d2cst (x: d2cst): void
fun prerr_d2cst (x: d2cst): void
overload print with print_d2cst
overload prerr with prerr_d2cst
fun fprint_d2cst : fprint_type (d2cst)
fun fprint_d2cstlst : fprint_type (d2cstlst)
overload fprint with fprint_d2cst
overload fprint with fprint_d2cstlst

(* ****** ****** *)

fun d2cst_get_loc (x: d2cst): loc_t
fun d2cst_get_sym (x: d2cst): symbol
fun d2cst_get_fil (x: d2cst): filename
//
fun d2cst_get_name (x: d2cst): string
fun d2cst_get_kind (x: d2cst): dcstkind
//
fun d2cst_get_decarg (x: d2cst): s2qualst
fun d2cst_set_decarg (x: d2cst, s2qs: s2qualst): void
//
fun d2cst_get_artylst (x: d2cst): List (int)
//
fun d2cst_get_type (x: d2cst): s2exp
//
fun d2cst_get_hisexp (x: d2cst): hisexpopt
fun d2cst_set_hisexp (x: d2cst, opt: hisexpopt): void
//
fun d2cst_get_funlab (x: d2cst): funlabopt
fun d2cst_set_funlab (x: d2cst, opt: funlabopt): void
//
fun d2cst_get_pack (x: d2cst): Stropt
fun d2cst_get_extdef (x: d2cst): dcstextdef
//
fun d2cst_get_stamp (x: d2cst): stamp

(* ****** ****** *)
//
fun d2cst_is_prf (d2c: d2cst): bool // a proof
fun d2cst_is_nonprf (d2c: d2cst): bool // a nonproof
//
fun d2cst_is_mac (d2c: d2cst): bool // function
fun d2cst_is_fun (d2c: d2cst): bool // function
//
fun d2cst_is_static (d2c: d2cst): bool // static
//
fun d2cst_is_fundec (d2c: d2cst): bool // fun declaration
fun d2cst_is_valdec (d2c: d2cst): bool // val declaration
fun d2cst_is_castfn (d2c: d2cst): bool // castfn declaration
//
fun d2cst_is_tmpcst (d2c: d2cst): bool // template?
//
fun d2cst_is_mainats (d2c: d2cst): bool // a [mainats] fun
//
(* ****** ****** *)

fun lt_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
and lte_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
overload < with lt_d2cst_d2cst
overload <= with lte_d2cst_d2cst

fun eq_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
and neq_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
overload = with eq_d2cst_d2cst
overload <> with neq_d2cst_d2cst
overload != with neq_d2cst_d2cst

fun compare_d2cst_d2cst (x1: d2cst, x2: d2cst):<> Sgn
overload compare with compare_d2cst_d2cst

(* ****** ****** *)

fun d2cstset_nil ():<> d2cstset
fun d2cstset_add (xs: d2cstset, x: d2cst):<> d2cstset
fun d2cstset_ismem (xs: d2cstset, x: d2cst):<> bool

(* ****** ****** *)

fun d2cstset_vt_nil ():<> d2cstset_vt
fun d2cstset_vt_add (xs: d2cstset_vt, x: d2cst):<> d2cstset_vt
fun d2cstset_vt_listize_free (xs: d2cstset_vt):<> d2cstlst_vt

(* ****** ****** *)
//
fun
d2cstmap_nil{a:type} ():<> d2cstmap (a)
fun
d2cstmap_search
  {a:type}(map: d2cstmap(a), d2v: d2cst): Option_vt (a)
fun
d2cstmap_insert
  {a:type}(map: &d2cstmap(a), d2v: d2cst, x: a): bool(*found*)
//
(* ****** ****** *)
//
fun d2var_make
  (loc: loc_t, id: symbol): d2var
fun d2var_make_any (loc: loc_t): d2var
//
fun d2var_ptr_viewat_make
  (ptr: d2var, opt: d2varopt): d2var
fun d2var_ptr_viewat_make_none (ptr: d2var): d2var
//
(* ****** ****** *)

fun print_d2var (x: d2var): void
and prerr_d2var (x: d2var): void
overload print with print_d2var
overload prerr with prerr_d2var
fun fprint_d2var : fprint_type (d2var)
overload fprint with fprint_d2var
fun fprint_d2varlst : fprint_type (d2varlst)
overload fprint with fprint_d2varlst

(* ****** ****** *)

datatype d2vfin =
  | D2VFINnone of ()
  | D2VFINsome of (s2exp)
  | D2VFINsome_lvar of (s2exp) // for local vars
  | D2VFINsome_vbox of (s2exp) // for vboxed proofs
  | D2VFINdone of (d2vfin) // funarg_d2vfin_checked
// end of [d2vfin]

fun print_d2vfin (x: d2vfin): void
fun prerr_d2vfin (x: d2vfin): void
fun fprint_d2vfin : fprint_type (d2vfin)

(* ****** ****** *)

fun d2var_get_loc (x: d2var):<> loc_t

fun d2var_get_sym (x: d2var):<> symbol

fun d2var_get_isfix (x: d2var):<> bool
fun d2var_set_isfix (x: d2var, isfix: bool): void

fun d2var_get_isprf (x: d2var):<> bool
fun d2var_set_isprf (x: d2var, isprf: bool): void

fun d2var_get_level (x: d2var):<> int
fun d2var_set_level (x: d2var, level: int): void

fun d2var_get_linval (x: d2var):<> int
fun d2var_set_linval (x: d2var, linval: int): void
fun d2var_inc_linval (x: d2var): void

fun d2var_get_decarg (x: d2var):<> s2qualst
fun d2var_set_decarg (x: d2var, decarg: s2qualst): void

fun d2var_get_addr (x: d2var):<> s2expopt
fun d2var_set_addr (x: d2var, opt: s2expopt): void

fun d2var_get_view (x: d2var):<> d2varopt
fun d2var_set_view (x: d2var, d2vopt: d2varopt): void

fun d2var_get_finknd (_: d2var):<> d2vfin
fun d2var_set_finknd (_: d2var, knd: d2vfin): void

fun d2var_get_type (x: d2var):<> s2expopt
fun d2var_set_type (x: d2var, opt: s2expopt): void
//
fun d2var_get_mastype (x: d2var):<> s2expopt
fun d2var_set_mastype (x: d2var, opt: s2expopt): void
//
fun d2var_get_hisexp (x: d2var):<> hisexpopt
fun d2var_set_hisexp (x: d2var, opt: hisexpopt): void
//
fun d2var_exch_type (x: d2var, opt: s2expopt): s2expopt 
//
fun d2var_get_utimes (x: d2var):<> int
fun d2var_set_utimes (x: d2var, nused: int):<> void
fun d2var_inc_utimes (x: d2var):<> void
//
fun d2var_get_stamp (x: d2var):<> stamp

(* ****** ****** *)

(*
** HX: [d2v] is linear if its linval is nonneg
*)
fun d2var_is_linear (d2v: d2var): bool
(*
** HX: [d2v] is mutable if it contains some view
*)
fun d2var_is_mutabl (d2v: d2var): bool

(* ****** ****** *)

fun eq_d2var_d2var (x1: d2var, x2: d2var):<> bool
fun neq_d2var_d2var (x1: d2var, x2: d2var):<> bool
overload = with eq_d2var_d2var
overload != with neq_d2var_d2var
overload <> with neq_d2var_d2var

fun compare_d2var_d2var (x1: d2var, x2: d2var):<> Sgn
overload compare with compare_d2var_d2var
fun compare_d2vsym_d2vsym (x1: d2var, x2: d2var):<> Sgn

(* ****** ****** *)

fun d2varset_nil ():<> d2varset
fun d2varset_ismem (xs: d2varset, x: d2var):<> bool
fun d2varset_add (xs: d2varset, x: d2var):<> d2varset
fun d2varset_listize (xs: !d2varset):<> List_vt (d2var)

fun fprint_d2varset : fprint_type (d2varset)

(* ****** ****** *)

fun d2varset_vt_nil ():<> d2varset_vt
fun d2varset_vt_free (xs: d2varset_vt):<> void
fun d2varset_vt_ismem (xs: !d2varset_vt, x: d2var):<> bool
fun d2varset_vt_add (xs: d2varset_vt, x: d2var):<> d2varset_vt
fun d2varset_vt_listize (xs: !d2varset_vt):<> d2varlst_vt
fun d2varset_vt_listize_free (xs: d2varset_vt):<> d2varlst_vt

(* ****** ****** *)

fun d2varmap_nil {a:type} ():<> d2varmap (a)
fun d2varmap_search
  {a:type} (map: d2varmap(a), d2v: d2var):<> Option_vt (a)
fun d2varmap_insert
  {a:type} (map: &d2varmap(a), d2v: d2var, x: a):<> bool(*found*)

fun d2varmap_listize
  {a:type} (map: d2varmap(a)):<> List_vt @(d2var, a)

(* ****** ****** *)
//
fun d2varmap_vt_nil {a:type} ():<> d2varmap_vt (a)
fun d2varmap_vt_free {a:type} (map: d2varmap_vt(a)):<> void
//
fun d2varmap_vt_search
  {a:type} (map: !d2varmap_vt(a), d2v: d2var):<> Option_vt(a)
fun d2varmap_vt_insert
  {a:type} (map: &d2varmap_vt(a), d2v: d2var, x: a):<> bool(*found*)
fun d2varmap_vt_remove
  {a:type} (map: &d2varmap_vt(a), d2v: d2var):<> bool(*found*)
//
fun d2varmap_vt_listize
  {a:type} (map: !d2varmap_vt(a)):<> List_vt @(d2var, a)
//
(* ****** ****** *)
//
fun d2varmaplst_vt_nil {a:type} ():<> d2varmaplst_vt (a)
fun d2varmaplst_vt_free {a:type} (map: d2varmaplst_vt(a)):<> void
//
fun d2varmaplst_vt_search
  {a:type} (map: !d2varmaplst_vt(a), d2v: d2var):<> Option_vt(a)
fun d2varmaplst_vt_insert
  {a:type} (map: &d2varmaplst_vt(a), d2v: d2var, x: a):<> bool(*found*)
fun d2varmaplst_vt_remove
  {a:type} (map: &d2varmaplst_vt(a), d2v: d2var):<> bool(*found*)
//
(* ****** ****** *)

datatype m2acarg =
  | M2ACARGsta of s2varlst
  | M2ACARGdyn of d2varlst
// end of [m2acarg]

typedef m2acarglst = List (m2acarg)

fun fprint_m2acarg : fprint_type (m2acarg)
fun fprint_m2acarglst : fprint_type (m2acarglst)

(* ****** ****** *)

fun d2mac_get_loc (x: d2mac): loc_t

fun d2mac_get_sym (x: d2mac): symbol

fun d2mac_get_kind
  (x: d2mac): int (* 1/0: long/short form *)

fun d2mac_get_stamp (x: d2mac): stamp

fun d2mac_get_arglst (x: d2mac): m2acarglst

(* ****** ****** *)

fun print_d2mac (x: d2mac): void
fun prerr_d2mac (x: d2mac): void
fun fprint_d2mac : fprint_type (d2mac)
//
overload print with print_d2mac
overload prerr with prerr_d2mac
overload fprint with fprint_d2mac
//
(* ****** ****** *)
//
fun print_d2itm (x: d2itm): void
fun prerr_d2itm (x: d2itm): void
//
fun fprint_d2itm : fprint_type (d2itm)
fun fprint_d2itmlst : fprint_type (d2itmlst)
//
overload print with print_d2itm
overload prerr with prerr_d2itm
overload fprint with fprint_d2itm
overload fprint with fprint_d2itmlst
//
(* ****** ****** *)

fun fprint_d2pitm : fprint_type (d2pitm)
fun fprint_d2pitmlst : fprint_type (d2pitmlst)

(* ****** ****** *)
//
fun
d2sym_make
(
  loc: loc_t
, dq0: $SYN.d0ynq, id0: symbol, d2pis: d2pitmlst
) : d2sym // end of [d2sym_make]
//
(* ****** ****** *)
//
fun print_d2sym (d2s: d2sym): void
fun prerr_d2sym (d2s: d2sym): void
fun fprint_d2sym : fprint_type (d2sym)
//
overload print with print_d2sym
overload prerr with prerr_d2sym
overload fprint with fprint_d2sym
//
(* ****** ****** *)

fun d2symset_vt_nil ():<> d2symset_vt
fun d2symset_vt_add (xs: d2symset_vt, x: d2sym):<> d2symset_vt
fun d2symset_vt_listize_free (xs: d2symset_vt):<> d2symlst_vt

(* ****** ****** *)

datatype pckind =
  | PCKcon of () // 0 // nonlin
  | PCKlincon of () // 1 // lincon
  | PCKfree of () // 2 // freeing
  | PCKunfold of () // 3 // folding
// end of [pckind]

typedef pckindopt = Option (pckind)

(* ****** ****** *)
//
fun print_pckind (x: pckind): void
fun prerr_pckind (x: pckind): void
fun fprint_pckind : fprint_type (pckind)
//
overload print with print_pckind
overload prerr with prerr_pckind
overload fprint with fprint_pckind
//
(* ****** ****** *)

fun fprint_pckindopt : fprint_type (pckindopt)

(* ****** ****** *)

fun eq_pckind_pckind (x1: pckind, x2: pckind): bool
overload = with eq_pckind_pckind

(* ****** ****** *)

datatype
p2at_node =
//
  | P2Tany of () // wildcard
  | P2Tvar of d2var // mutability determined by the context
//
// constructor pattern
//
  | P2Tcon of (
      pckind, d2con, s2qualst, s2exp(*con*), int(*npf*), p2atlst
    ) (* end of [P2Tcon] *)
//
  | P2Tint of int
  | P2Tintrep of string
//
  | P2Tbool of bool
  | P2Tchar of char
  | P2Tfloat of string(*rep*)
  | P2Tstring of string
//
  | P2Ti0nt of i0nt
  | P2Tf0loat of f0loat
//
  | P2Tempty of ()
//
  | P2Tlst of (int(*lin*), p2atlst) // pattern list
  | P2Trec of (int(*knd*), int(*npf*), labp2atlst)
//
  | P2Trefas of (d2var, p2at)
//
  | P2Texist of (s2varlst, p2at) // existential opening
//
  | P2Tvbox of d2var // vbox pattern for handling references
//
  | P2Tann of (p2at, s2exp) // no s2Var in the ascribed type
//
  | P2Tlist of (int(*npf*), p2atlst)
//
  | P2Terrpat of () // HX: placeholder for indicating an error
// end of [p2at_node]

and labp2at =
  | LABP2ATomit of (loc_t) // for [...]
  | LABP2ATnorm of (l0ab, p2at) // for lab=pat
// end of [labp2at]

where
p2at = '{
  p2at_loc= loc_t
, p2at_svs= lstord(s2var)
, p2at_dvs= lstord(d2var)
, p2at_type= s2expopt // ref@ (s2expopt)
, p2at_node= p2at_node
} (* end of [p2at] *)

and p2atlst = List (p2at)
and p2atopt = Option (p2at)

and labp2atlst = List (labp2at)

(* ****** ****** *)

fun p2at_set_type
(
  p2t: p2at, opt: s2expopt
) : void = "ext#patsopt_p2at_set_type"

(* ****** ****** *)

fun p2atlst_svs_union (p2ts: p2atlst): lstord (s2var)
fun p2atlst_dvs_union (p2ts: p2atlst): lstord (d2var)

(* ****** ****** *)

fun
p2at_make_node
(
  loc: loc_t
, svs: lstord(s2var), dvs: lstord(d2var)
, node: p2at_node
) : p2at // end of [p2at_make_node]

fun p2at_any (loc: loc_t): p2at

fun p2at_var (loc: loc_t, d2v: d2var): p2at

fun
p2at_con
(
  loc: loc_t
, pck: pckind
, d2c: d2con
, s2qs: s2qualst
, s2f_con: s2exp
, npf: int
, darg: p2atlst
) : p2at // end of ...

(* ****** ****** *)
//
fun
p2at_int(loc: loc_t, i: int): p2at
fun
p2at_intrep(loc: loc_t, rep: string): p2at
//
fun p2at_bool(loc: loc_t, b: bool): p2at
fun p2at_char(loc: loc_t, c: char): p2at
fun p2at_float(loc: loc_t, rep: string): p2at
fun p2at_string(loc: loc_t, str: string): p2at
//
fun p2at_i0nt(loc: loc_t, x: i0nt): p2at
fun p2at_f0loat(loc: loc_t, x: f0loat): p2at
//
(* ****** ****** *)

fun p2at_empty(loc: loc_t): p2at

(* ****** ****** *)

fun
p2at_list // HX: flat tuple
  (loc: loc_t, npf: int, p2ts: p2atlst): p2at
// end of [p2at_list]

(* ****** ****** *)

fun
p2at_lst
(loc: loc_t, lin: int, p2ts: p2atlst): p2at
// end of [p2at_lst]
fun
p2at_rec
( loc: loc_t
, knd: int(*boxity*), npf: int, lp2ts: labp2atlst
) : p2at // end of [p2at_tup]

(* ****** ****** *)

fun p2at_refas
  (loc: loc_t, d2v: d2var, p2t: p2at): p2at
// end of [p2at_refas]

fun p2at_exist
  (loc: loc_t, s2vs: s2varlst, p2t: p2at): p2at
// end of [p2at_exist]

fun p2at_vbox(loc: loc_t, d2v: d2var): p2at

(* ****** ****** *)
//
fun
p2at_ann
  (loc: loc_t, p2t: p2at, ann: s2exp): p2at
// end of [p2at_ann]
//
(* ****** ****** *)

fun p2at_errpat (loc: loc_t): p2at // end-of-fun

(* ****** ****** *)
//
fun p2atlst_tupize (p2ts: p2atlst): labp2atlst
//
(* ****** ****** *)
//
fun print_p2at (x: p2at): void
fun prerr_p2at (x: p2at): void
fun fprint_p2at : fprint_type (p2at)
//
overload print with print_p2at
overload prerr with prerr_p2at
overload fprint with fprint_p2at
//
(* ****** ****** *)
//
fun print_p2atlst (xs: p2atlst): void
fun prerr_p2atlst (xs: p2atlst): void
fun fprint_p2atlst : fprint_type (p2atlst)
//
overload print with print_p2atlst
overload prerr with prerr_p2atlst
overload fprint with fprint_p2atlst
//
(* ****** ****** *)

fun fprint_labp2at : fprint_type (labp2at)
fun fprint_labp2atlst : fprint_type (labp2atlst)

(* ****** ****** *)

datatype
d2ecl_node =
//
  | D2Cnone of () // for something already erased
  | D2Clist of d2eclist // for list of declarations
//
  | D2Csymintr of (i0delst)
  | D2Csymelim of (i0delst) // for temporary use
  | D2Coverload of // symbol overloading
      (i0de, int(*pval*), d2itmopt) // [None] indicates error
    // end of [D2Coverload]
//
  | D2Cpragma of (e1xplst) // HX: #pragma ...
  | D2Ccodegen of (int(*knd*), e1xplst) // HX: #codegen ...
//
  | D2Cstacsts of s2cstlst // for [stacst] declarations
  | D2Cstacons of
      (int(*knd*), s2cstlst) // for [stacon] declarations
    // end of [D2Cstacons]
//
(*
  | D2Cstavars of s2tavarlst // for [stavar] declarations
*)
//
  | D2Csaspdec of s2aspdec (* for static assumption *)
  | D2Creassume of s2cst(*abstype*) // for static re-assumption
//
  | D2Cextype of (string(*name*), s2exp(*def*))
  | D2Cextvar of (string(*name*), d2exp(*def*))
  | D2Cextcode of (int(*knd*), int(*pos*), string(*code*))
//
  | D2Cdatdecs of
      (int(*knd*), s2cstlst) // datatype declarations
  | D2Cexndecs of (d2conlst) // exception constructor declarations
//
  | D2Cdcstdecs of (int(*0/1:sta/ext*), dcstkind, d2cstlst) // dyncst
//
  | D2Cimpdec of (int(*knd*), i2mpdec) // knd=0/1 : implement/primplmnt
//
  | D2Cfundecs of (funkind, s2qualst, f2undeclst)
  | D2Cvaldecs of
      (valkind, v2aldeclst) // (nonrec) value declarations
    // end of [D2Cvaldecs]
  | D2Cvaldecs_rec of
      (valkind, v2aldeclst) // (recursive) value declarations
    // end of [D2Cvaldecs_rec]
//
  | D2Cvardecs of (v2ardeclst) // variable declarations
  | D2Cprvardecs of (prv2ardeclst) // proof variable declarations
//
  | D2Cinclude of (int(*knd*), d2eclist) (* file inclusion *)
//
  | D2Cstaload of
    (
      symbolopt, filename, int(*loadflag*), filenv, int(*loaded*)
    ) (* end of [D2staload] *)
//
  | D2Cstaloadloc of (filename(*pfil*), symbol(*nspace*), filenv)
//
  | D2Cdynload of (filename) (* dynamic load for initialization *)
//
  | D2Clocal of (d2eclist(*head*), d2eclist(*body*)) // local declaration
//
  | D2Cerrdec of ((*void*)) // HX: indication of erroneous declaration
// end of [d2ecl_node]

and d2exp_node =
//
  | D2Ecst of d2cst (* dynamic constants *)
  | D2Evar of d2var (* dynamic variables *)
//
  | D2Eint of int
  | D2Eintrep of string(*rep*)
  | D2Ebool of bool
  | D2Echar of char
  | D2Efloat of string(*rep*)
  | D2Estring of string
//
  | D2Ei0nt of i0nt
  | D2Ec0har of c0har
  | D2Ef0loat of f0loat
  | D2Es0tring of s0tring
//
  | D2Etop of () // a placeholder of unspecified type
  | D2Etop2 of (s2exp) // a placeholder of specified type
  | D2Eempty of () // the void-value (of unspecified size)
//
  | D2Ecstsp of $SYN.cstsp // special constants
//
  | D2Etyrep of (s2exp) // $tyrep(...)
  | D2Eliteral of (d2exp) // $literal: int, float, string
//
  | D2Eextval of (s2exp(*type*), string(*name*))
  | D2Eextfcall of
    (
      s2exp(*res*), string(*fun*), d2explst(*arg*)
    ) (* end of [D2Eextfcall] *)
  | D2Eextmcall of
    (
      s2exp(*res*), d2exp(*obj*), string(*method*), d2explst(*arg*)
    ) (* end of [D2Eextmcall] *)
//
// HX: data-constructor
//
  | D2Econ of (
      d2con, loc_t(*fun*)
    , s2exparglst(*sarg*), int(*npf*), loc_t(*arg*), d2explst(*darg*)
    ) (* end of [D2Econ] *)
//
  | D2Esym of d2sym // overloaded dynamic symbol
//
  | D2Efoldat of (* folding at a given address *)
      (s2exparglst, d2exp)
  | D2Efreeat of (* freeing at a given address *)
      (s2exparglst, d2exp)
//
  | D2Etmpid of
      (d2exp(*id*), t2mpmarglst) // tmpcst/tmpvar instantiation
    // end of [D2Etmpid]
//
  | D2Elet of (d2eclist, d2exp) // let-expression
  | D2Ewhere of (d2exp, d2eclist) // where-expression
//
  | D2Eapplst of (d2exp, d2exparglst)
//
  | D2Eifhead of // dynamic conditional
      (i2nvresstate, d2exp, d2exp, d2expopt)
  | D2Esifhead of // static conditional
      (i2nvresstate, s2exp, d2exp, d2exp(*else*))
//
  | D2Eifcasehd of
      (int(*else:0/1*), i2nvresstate, i2fclist)
//
  | D2Ecasehead of
    ( // dynamic case-expression
      caskind, i2nvresstate, d2explst, c2laulst
    ) // end of [D2Ecaseof]
  | D2Escasehead of
    (
      i2nvresstate, s2exp, sc2laulst // static case-expression
    ) // end of [D2Escaseof]
//
  | D2Esing of (d2exp) // singleton
  | D2Elist of (int(*pfarity*), d2explst) // temporary
//
  | D2Elst of (int(*lin*), s2expopt, d2explst) // list
  | D2Etup of (int(*knd*), int(*npf*), d2explst) // tuple
  | D2Erec of (int (*knd*), int (*npf*), labd2explst) // record
  | D2Eseq of d2explst // sequence-expressions // sequencing
//
  | D2Eselab of (d2exp, d2lablst) // record/tuple field selection
//
  | D2Eptrof of (d2exp) // taking the address of
  | D2Eviewat of (d2exp) // taking view at a given address
//
  | D2Ederef of (d2sym, d2exp) // dereference
//
  | D2Eassgn of (d2exp(*left*), d2exp(*right*))
  | D2Exchng of (d2exp(*left*), d2exp(*right*))
//
  | D2Earrsub of (* array subscription *)
      (d2sym, d2exp, loc_t(*ind*), d2explst(*ind*))
  | D2Earrpsz of (* $arrpsz expression *)
      (s2expopt(*eltype*), d2explst(*elements*))
  | D2Earrinit of (* array initialization *)
      (s2exp(*elt*), d2expopt(*asz*), d2explst(*ini*))
//
  | D2Eraise of (d2exp) // raised exception
//
  | D2Eeffmask of (s2eff, d2exp) // $effmask (s2eff, d2exp)
//
  | D2Evararg of (d2explst) // $vararg: variadicity
//
  | D2Evcopyenv of (int(*knd*), d2exp) // $vcopyenv_v/$vcopyenv_vt
//
  | D2Eshowtype of (d2exp) // $showtype: for debugging
//
  | D2Etempenver of (d2varlst) // $tempenver: for environvars
//
  | D2Eexist of (s2exparg, d2exp) // witness-carrying expression
//
  | D2Elam_dyn of (* boxed dynamic abstraction *)
      (int(*lin*), int(*npf*), p2atlst(*arg*), d2exp(*body*))
  | D2Elaminit_dyn of (* flat dynamic abstraction *)
      (int(*lin*), int(*npf*), p2atlst(*arg*), d2exp(*body*))
  | D2Elam_sta of
      (s2varlst, s2explst(*s2ps*), d2exp(*body*)) // static abstraction
  | D2Elam_met of
      (ref(d2varlst), s2explst(*met*), d2exp(*body*)) // termination metric
//
  | D2Efix of (
      int(*knd=0/1:flat/boxed*), d2var(*fixvar*), d2exp(*def*)
    ) (* end of [D2Efix] *)
//
  | D2Edelay of (d2exp(*eval*)) // $delay
  | D2Eldelay of (d2exp(*eval*), d2expopt(*free*)) // $ldelay
//
  | D2Efor of (
      loopi2nv, d2exp(*init*), d2exp(*test*), d2exp(*post*), d2exp(*body*)
    ) // end of [D2Efor]
  | D2Ewhile of (loopi2nv, d2exp(*test*), d2exp(*body*))
//
  | D2Eloopexn of int(*knd*)
//
  | D2Etrywith of (i2nvresstate, d2exp, c2laulst)
//
  | D2Eann_type of (d2exp, s2exp) // ascribled expression
  | D2Eann_seff of (d2exp, s2eff) // ascribed with effects
  | D2Eann_funclo of (d2exp, funclo) // ascribed with funtype
//
  | D2Emac of (d2mac) // macro-expression
  | D2Emacsyn of (macsynkind, d2exp) // backquote-comma-notation
  | D2Emacfun of (symbol(*name*), d2explst) // built-in macfun
//
  | D2Esolassert of (d2exp) // $solve_assert(d2e_prf)
  | D2Esolverify of (s2exp) // $solve_verify(s2e_prop)
//
  | D2Eerrexp of ((*void*)) // HX: placeholder for indicating an error
//
// end of [d2exp_node]

and d2exparg =
  | D2EXPARGsta of (loc_t(*arg*), s2exparglst)
  | D2EXPARGdyn of (int(*npf*), loc_t(*arg*), d2explst)
// end of [d2exparg]

and d2lab_node =
  | D2LABlab of (label) | D2LABind of (d2explst)
// end of [d2lab_node]

where
d2ecl = '{
  d2ecl_loc= loc_t, d2ecl_node= d2ecl_node
} // end of [d2ecl]

and d2eclist = List (d2ecl)

and
d2exp = '{
  d2exp_loc= loc_t
, d2exp_node= d2exp_node, d2exp_type= s2expopt
} (* end of [d2exp] *)

and d2explst = List (d2exp)
and d2expopt = Option (d2exp)

and labd2exp = dl0abeled (d2exp)
and labd2explst = List (labd2exp)

and d2exparglst = List (d2exparg)

(* ****** ****** *)

and
d2lab = '{
  d2lab_loc= loc_t
, d2lab_node= d2lab_node
, d2lab_overld= d2symopt
} // end of [d2lab]

and d2lablst = List d2lab

(* ****** ****** *)

and
i2nvarg = '{
  i2nvarg_var= d2var
, i2nvarg_type= s2expopt
} // end of [i2nvarg]

and i2nvarglst = List i2nvarg

and
i2nvresstate = '{
  i2nvresstate_svs= s2varlst
, i2nvresstate_gua= s2explst
, i2nvresstate_arg= i2nvarglst
, i2nvresstate_met= s2explstopt
} // end of [i2nvresstate]

and
loopi2nv = '{
  loopi2nv_loc= loc_t
, loopi2nv_svs= s2varlst
, loopi2nv_gua= s2explst
, loopi2nv_arg= i2nvarglst (* argument *)
, loopi2nv_met= s2explstopt (* metric *)
, loopi2nv_res= i2nvresstate (* result *)
} // end of [loopi2nv]

(* ****** ****** *)

and
i2fcl = '{
//
  i2fcl_loc= loc_t
, i2fcl_test= d2exp, i2fcl_body= d2exp
//
} (* end of [i2fcl] *)

and i2fclist = List(i2fcl)

(* ****** ****** *)

and
gm2at = '{
  gm2at_loc= loc_t
, gm2at_exp= d2exp, gm2at_pat= p2atopt
} // end of [gm2at]

and gm2atlst = List (gm2at)

(* ****** ****** *)

and
c2lau = '{
  c2lau_loc= loc_t
, c2lau_pat= p2atlst
, c2lau_gua= gm2atlst
, c2lau_seq= int, c2lau_neg= int
, c2lau_body= d2exp
} // end of [c2lau]

and c2laulst = List (c2lau)

and sc2lau = '{
  sc2lau_loc= loc_t
, sc2lau_pat= sp2at
, sc2lau_body= d2exp
} // end of [sc2lau]

and sc2laulst = List (sc2lau)

(* ****** ****** *)

and f2undec = '{
  f2undec_loc= loc_t
, f2undec_var= d2var
, f2undec_def= d2exp
, f2undec_ann= s2expopt
} // end of [f2undec]

and f2undeclst = List f2undec

(* ****** ****** *)

and v2aldec = '{
  v2aldec_loc= loc_t
, v2aldec_pat= p2at
, v2aldec_def= d2exp
, v2aldec_ann= s2expopt // [withtype] annotation
} (* end of [v2aldec] *)

and v2aldeclst = List (v2aldec)

(* ****** ****** *)

and v2ardec = '{
  v2ardec_loc= loc_t
, v2ardec_knd= int (* knd=0/1:var/ptr *)
, v2ardec_svar= s2var // static address
, v2ardec_dvar= d2var // dynamic variable
, v2ardec_pfat= d2varopt // proof of at-view
, v2ardec_type= s2expopt (* type annotation *)
, v2ardec_init= d2expopt // value for initialization
, v2ardec_dvaropt= d2varopt // address of variable
} (* end of [v2ardec] *)

and v2ardeclst = List (v2ardec)

(* ****** ****** *)

and prv2ardec = '{
  prv2ardec_loc= loc_t
, prv2ardec_dvar= d2var // dynamic address
, prv2ardec_type= s2expopt (* optional type anno *)
, prv2ardec_init= d2expopt // initial value (optional)
} // end of [prv2ardec]

and prv2ardeclst = List (prv2ardec)

(* ****** ****** *)

and i2mpdec = '{
  i2mpdec_loc= loc_t
, i2mpdec_locid= loc_t
, i2mpdec_cst= d2cst
, i2mpdec_imparg= s2varlst // static variables
, i2mpdec_tmparg= s2explstlst // static args
, i2mpdec_tmpgua= s2explstlst // static guards
, i2mpdec_def= d2exp
} // end of [i2mpdec]

(* ****** ****** *)

datatype
d2lval = // type for left-values
  | D2LVALderef of (* ptr/ref path selection *)
      (d2exp(*ptr/ref*), d2lablst)
  | D2LVALvar_lin of (d2var, d2lablst) // linear d2var
  | D2LVALvar_mut of (d2var, d2lablst) // mutable d2var
  | D2LVALarrsub of (* array subscription *)
      (d2sym(*brackets*), d2exp, loc_t(*ind*), d2explst)
  | D2LVALviewat of (d2exp(*lval*)) // [lval] is 'addresssed'
  | D2LVALnone of d2exp (* non-left-values *)
// end of [d2lval]

(* ****** ****** *)
//
fun print_d2exp (x: d2exp): void
fun prerr_d2exp (x: d2exp): void
fun fprint_d2exp : fprint_type (d2exp)
fun fprint_d2explst : fprint_type (d2explst)
fun fprint_d2expopt : fprint_type (d2expopt)
//
overload print with print_d2exp
overload prerr with prerr_d2exp
overload fprint with fprint_d2exp
overload fprint with fprint_d2explst
overload fprint with fprint_d2expopt
//
(* ****** ****** *)

fun fprint_labd2exp : fprint_type (labd2exp)
fun fprint_labd2explst : fprint_type (labd2explst)
overload fprint with fprint_labd2explst

(* ****** ****** *)

fun fprint_d2exparg : fprint_type (d2exparg)
fun fprint_d2exparglst : fprint_type (d2exparglst)
overload fprint with fprint_d2exparglst

(* ****** ****** *)

fun fprint_d2lab : fprint_type (d2lab)
fun fprint_d2lablst : fprint_type (d2lablst)
overload fprint with fprint_d2lablst

(* ****** ****** *)

fun fprint_loopi2nv : fprint_type (loopi2nv)
fun fprint_i2nvarglst : fprint_type (i2nvarglst)
fun fprint_i2nvresstate : fprint_type (i2nvresstate)

(* ****** ****** *)
//
fun print_d2ecl (x: d2ecl): void
fun prerr_d2ecl (x: d2ecl): void
fun fprint_d2ecl : fprint_type (d2ecl)
fun fprint_d2eclist : fprint_type (d2eclist)
//
overload print with print_d2ecl
overload prerr with prerr_d2ecl
overload fprint with fprint_d2ecl
overload fprint with fprint_d2eclist
//
(* ****** ****** *)
//
fun print_d2lval (x: d2lval): void
and prerr_d2lval (x: d2lval): void
fun fprint_d2lval : fprint_type (d2lval)
//
overload print with print_d2lval
overload prerr with prerr_d2lval
overload fprint with fprint_d2lval
//
(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

fun d2exp_set_type
(
  d2e: d2exp, opt: s2expopt
) : void = "ext#patsopt_d2exp_set_type"

(* ****** ****** *)

fun d2exp_make_node
  (loc: location, node: d2exp_node): d2exp
// end of [d2exp_make_node]

(* ****** ****** *)

fun d2exp_var (loc: location, d2v: d2var): d2exp

(* ****** ****** *)

fun d2exp_int (loc: location, i: int): d2exp
fun d2exp_intrep (loc: location, rep: string): d2exp
fun d2exp_bool (loc: location, b: bool): d2exp
fun d2exp_char (loc: location, c: char): d2exp
fun d2exp_float (loc: location, rep: string): d2exp
fun d2exp_string (loc: location, s: string): d2exp

(* ****** ****** *)

fun d2exp_i0nt (loc: location, x: i0nt): d2exp
fun d2exp_c0har (loc: location, x: c0har): d2exp
fun d2exp_f0loat (loc: location, x: f0loat): d2exp
fun d2exp_s0tring (loc: location, x: s0tring): d2exp

(* ****** ****** *)

fun d2exp_top (loc: location): d2exp
fun d2exp_top2 (loc: location, s2e: s2exp): d2exp

(* ****** ****** *)

fun d2exp_empty (loc: location): d2exp

(* ****** ****** *)
//
fun
d2exp_cstsp
(
  loc: location, cst: $SYN.cstsp
) : d2exp // end-of-function
//
(* ****** ****** *)
//
fun
d2exp_tyrep
  (loc: location, s2e: s2exp): d2exp
//
(* ****** ****** *)
//
fun
d2exp_literal
  (loc: location, d2e_lit: d2exp): d2exp
//
(* ****** ****** *)
//
fun
d2exp_extval
(
  loc: location, s2e: s2exp, name: string
) : d2exp // end of [d2exp_extval]
//
fun
d2exp_extfcall
(
  loc: location
, s2e: s2exp, _fun: string, _arg: d2explst
) : d2exp // end of [d2exp_extfcall]
//
fun
d2exp_extmcall
(
  loc: location
, s2e: s2exp, _obj: d2exp, _mtd: string, _arg: d2explst
) : d2exp // end of [d2exp_extmcall]
//
(* ****** ****** *)

fun d2exp_cst (loc: location, d2c: d2cst): d2exp

fun d2exp_con
(
  loc: location
, d2c: d2con
, locfun: location // HX: for d2c+sarg
, sarg: s2exparglst
, npf: int
, locarg: location
, darg: d2explst
) : d2exp // end of [d2exp_con]

fun d2exp_sym (loc: location, d2s: d2sym): d2exp

(* ****** ****** *)

fun d2exp_loopexn (loc: location, knd: int): d2exp

(* ****** ****** *)

fun d2exp_foldat (
  loc: location, s2as: s2exparglst, d2e: d2exp
) : d2exp // end of [d2exp_foldat]
fun d2exp_freeat (
  loc: location, s2as: s2exparglst, d2e: d2exp
) : d2exp // end of [d2exp_freeat]

(* ****** ****** *)

fun d2exp_tmpid (
  loc: location, d2e_id: d2exp, t2mas: t2mpmarglst
): d2exp // end of [d2exp_tmpid]

(* ****** ****** *)

fun d2exp_let
  (loc: location, d2cs: d2eclist, body: d2exp): d2exp
// end of [d2exp_let]
fun d2exp_where
  (loc: location, body: d2exp, d2cs: d2eclist): d2exp
// end of [d2exp_where]

(* ****** ****** *)

fun
d2exp_applst
(
  loc: location
, d2e_fun: d2exp, d2as: d2exparglst
) : d2exp // end of [d2exp_applst]
fun
d2exp_app_sta
(
  loc: location
, d2e_fun: d2exp
, locarg: location, sarg: s2exparglst
) : d2exp // end of [d2exp_app_sta]
fun
d2exp_app_dyn
(
  loc: location
, d2e_fun: d2exp
, npf: int, locarg: location, darg: d2explst
) : d2exp // end of [d2exp_app_dyn]
fun
d2exp_app_sta_dyn
(
  loc_dyn: location
, loc_sta: location
, d2e_fun: d2exp, sarg: s2exparglst
, locarg: location, npf: int, darg: d2explst
) : d2exp // end of [d2exp_app_sta_dyn]

(* ****** ****** *)

fun
d2exp_ifhead (
  loc: location
, res: i2nvresstate
, _cond: d2exp, _then: d2exp, _else: d2expopt
) : d2exp // end of [d2exp_ifhead]

fun
d2exp_sifhead (
  loc: location
, res: i2nvresstate, cond: s2exp, _then: d2exp, _else: d2exp
) : d2exp // end of [d2exp_sifhead]

(* ****** ****** *)
//
fun
d2exp_ifcasehd
  (loc: location, res: i2nvresstate, ifcls: i2fclist): d2exp
//
(* ****** ****** *)

fun
d2exp_casehead
(
  loc: location
, knd: caskind
, res: i2nvresstate
, d2es: d2explst
, c2ls: c2laulst
) : d2exp // end of [d2exp_casehead]

fun
d2exp_scasehead
(
  loc: location
, res: i2nvresstate, s2f: s2exp, sc2ls: sc2laulst
) : d2exp // end of [d2exp_scasehead]

(* ****** ****** *)
//
fun
d2exp_sing
  (loc: location, d2e: d2exp): d2exp
fun
d2exp_list
  (loc: location, npf: int, d2es: d2explst): d2exp
//
(* ****** ****** *)
//
fun
d2exp_lst
(
  loc: location
, lin: int, elt: s2expopt, d2es: d2explst
) : d2exp // end of [d2exp_lst]
//
fun
d2exp_tup
(
  loc: location
, knd: int, npf: int, d2es: d2explst
) : d2exp // end of [d2exp_tup]
fun
d2exp_tup_flt
(
  loc: location, npf: int, d2es: d2explst  
) : d2exp // end of [d2exp_tup_flt]
//
fun
d2exp_rec
(
  loc: location
, knd: int, npf: int, ld2es: labd2explst
) : d2exp // end of [d2exp_rec]
//
(* ****** ****** *)

fun d2exp_seq (loc: location, d2es: d2explst): d2exp
fun d2exp_seq2 (loc: location, d2es: d2explst): d2exp

(* ****** ****** *)
//
fun d2exp_deref
  (loc: location, d2s: d2sym, d2e_lval: d2exp): d2exp
//
fun d2exp_assgn
  (loc: location, _left: d2exp, _right: d2exp): d2exp
// end of [d2exp_assgn]
fun d2exp_xchng
  (loc: location, _left: d2exp, _right: d2exp): d2exp
// end of [d2exp_xchng]
//
(* ****** ****** *)

fun d2exp_arrsub
(
  loc: location
, d2s: d2sym, arr: d2exp, ind: location, ind: d2explst
) : d2exp // end of [d2exp_arrsub]

fun d2exp_arrpsz
(
  loc: location, elt: s2expopt, elts: d2explst
) : d2exp // end of [d2exp_arrpsz]

fun d2exp_arrinit
(
  loc: location
, elt: s2exp, asz: d2expopt, ini: d2explst
) : d2exp // end of [d2exp_arrinit]

(* ****** ****** *)

fun d2exp_ptrof (loc: location, d2e: d2exp): d2exp
fun d2exp_viewat (loc: location, d2e: d2exp): d2exp

(* ****** ****** *)
//
fun
d2exp_selab
(
  loc: location, _rec: d2exp, d2ls: d2lablst
) : d2exp // end of [d2exp_selab]
//
fun
d2exp_sel_dot // = d2exp_selab
(
  loc: location, _rec: d2exp, d2ls: d2lablst
) : d2exp // end of [d2exp_sel_dot]
//
fun
d2exp_sel_ptr
(
  loc: location, d2s: d2sym, d2rec: d2exp, d2l: d2lab
) : d2exp // end of [d2exp_sel_ptr]
//
(* ****** ****** *)
//
fun
d2exp_raise(loc: location, d2e: d2exp): d2exp
//
(* ****** ****** *)
//
fun
d2exp_effmask
  (loc: location, s2fe: s2eff, d2e: d2exp): d2exp
//
(* ****** ****** *)
//
fun
d2exp_vararg(loc: location, d2es: d2explst): d2exp
//
(* ****** ****** *)
//
fun
d2exp_vcopyenv
  (loc: location, knd(*v/vt*): int, d2e: d2exp): d2exp
//
(* ****** ****** *)
//
fun
d2exp_showtype (loc: location, d2e: d2exp): d2exp
//
fun
d2exp_tempenver (loc: location, d2vs: d2varlst): d2exp
//
(* ****** ****** *)

fun d2exp_exist
  (loc: location, s2a: s2exparg, d2e: d2exp): d2exp
// end of [d2exp_exist]

(* ****** ****** *)

fun
d2exp_lam_dyn
(
  loc: location
, lin: int, npf: int, arg: p2atlst, body: d2exp
) : d2exp // end of [d2exp_lam_dyn]
fun
d2exp_laminit_dyn
(
  loc: location, knd: int, npf: int, arg: p2atlst, body: d2exp
) : d2exp // end of [d2exp_laminit_dyn]

(* ****** ****** *)

fun
d2exp_lam_met
(
  loc: location
, r: ref(d2varlst), met: s2explst, body: d2exp
) : d2exp // end of [d2exp_lam_met]

fun
d2exp_lam_met_new
  (loc: location, met: s2explst, body: d2exp): d2exp
// end of [d2exp_lam_met_new]

(* ****** ****** *)

fun
d2exp_lam_sta
(
  loc: location
, s2vs: s2varlst, s2ps: s2explst, body: d2exp
) : d2exp // end of [d2exp_lam_sta]

(* ****** ****** *)
//
fun d2exp_fix
  (loc: location, knd: int, f: d2var, body: d2exp): d2exp
//
(* ****** ****** *)
//
fun d2exp_delay (loc: location, _eval: d2exp): d2exp
//
fun d2exp_ldelay
  (loc: location, _eval: d2exp, _free: d2expopt): d2exp
//
fun d2exp_ldelay_none (loc: location, _eval: d2exp): d2exp
//
(* ****** ****** *)

fun
d2exp_while
(
  loc: location
, i2nv: loopi2nv, test: d2exp, body: d2exp
) : d2exp // end of [d2exp_while]

fun d2exp_for (
  loc: location
, i2nv: loopi2nv
, init: d2exp, test: d2exp, post: d2exp, body: d2exp
) : d2exp // end of [d2exp_for]

(* ****** ****** *)

fun d2exp_trywith
(
  loc: location
, r2es: i2nvresstate, d2e: d2exp, c2ls: c2laulst
) : d2exp // end of [d2exp_trywith]

(* ****** ****** *)
//
fun
d2exp_ann_type
  (loc: location, d2e: d2exp, ann: s2exp): d2exp
//
fun
d2exp_ann_seff
  (loc: location, d2e: d2exp, s2fe: s2eff): d2exp
//
fun
d2exp_ann_funclo
  (loc: location, d2e: d2exp, funclo: funclo): d2exp
//
(* ****** ****** *)

fun d2exp_mac(loc: location, d2m: d2mac): d2exp

fun d2exp_macsyn
  (loc: location, knd: macsynkind, d2e: d2exp): d2exp
// end of [d2exp_macsyn]

fun d2exp_macfun
  (loc: location, name: symbol, d2es: d2explst): d2exp
// end of [d2exp_macfun]

(* ****** ****** *)
//
fun
d2exp_solassert
  (loc: location, d2e_prf: d2exp): d2exp
//
fun
d2exp_solverify
  (loc: location, s2e_prop: s2exp): d2exp
//
(* ****** ****** *)
//
fun
d2exp_errexp (loc: location): d2exp // HX: indicating error
//
(* ****** ****** *)

fun labd2exp_make (l: l0ab, d2e: d2exp): labd2exp

(* ****** ****** *)
//
fun d2lab_lab
  (loc: location, lab: label, opt: d2symopt): d2lab
fun d2lab_ind (loc: location, ind: d2explst): d2lab
//
fun fprint_d2lab : fprint_type (d2lab)
//
(* ****** ****** *)
//
fun
i2nvarg_make
  (d2v: d2var, s2f: s2expopt): i2nvarg
//
// HX-2012-06:
// let [d2v] be [arg.i2nvarg_var]; this function
// returns the proof of the atview of [d2v] if [d2v]
// it is mutable; otherwise, [d2v] itself is returned
//
fun i2nvarg_get_var (arg: i2nvarg): d2var
fun i2nvarg_get_type (arg: i2nvarg): s2expopt
//
val i2nvresstate_nil : i2nvresstate
//
fun
i2nvresstate_make
(
  s2vs: s2varlst, s2ps: s2explst, arg: i2nvarglst
) : i2nvresstate // end of [i2nvresstate_make]
//
fun
i2nvresstate_make_met
(
  s2vs: s2varlst
, s2ps: s2explst, arg: i2nvarglst, met: s2explstopt
) : i2nvresstate // end of [i2nvresstate_make_met]
//
(* ****** ****** *)

fun
loopi2nv_make
(
  loc: location
, svs: s2varlst
, gua: s2explst
, met: s2explstopt
, arg: i2nvarglst
, res: i2nvresstate
) : loopi2nv // end of [loopi2nv_make]

(* ****** ****** *)

fun
i2fcl_make
(
  loc: location, test: d2exp, body: d2exp
) : i2fcl // end of [i2fcl_make]

(* ****** ****** *)

fun
gm2at_make
(
  loc: location, d2e: d2exp, p2topt: p2atopt
) : gm2at // end of [gm2at_make]

fun
c2lau_make
(
  loc: location
, p2ts: p2atlst
, gua: gm2atlst
, seq: int, neg: int
, body: d2exp
) : c2lau // end of [c2lau_make]

fun sc2lau_make
  (loc: location, sp2t: sp2at, body: d2exp): sc2lau
// end of [sc2lau_make]

(* ****** ****** *)

fun d2cst_get_def (d2c: d2cst): d2expopt
fun d2cst_set_def (d2c: d2cst, def: d2expopt): void

(* ****** ****** *)

fun d2mac_make
(
  loc: location
, sym: symbol, knd: int, args: m2acarglst, def: d2exp
) : d2mac // end of [d2mac_make]

fun d2mac_get_def (x: d2mac): d2exp
fun d2mac_set_def (x: d2mac, def: d2exp): void

(* ****** ****** *)

fun i2mpdec_make
(
  loc: location
, locid: location
, d2c: d2cst
, imparg: s2varlst
, tmparg: s2explstlst
, tmpgua: s2explstlst
, def: d2exp
) : i2mpdec // end of [i2mpdec_make]

(* ****** ****** *)

fun f2undec_make
(
  loc: location, d2v: d2var, def: d2exp, ann: s2expopt
) : f2undec // end of [f2undec_make]

(* ****** ****** *)

fun v2aldec_make
(
  loc: location, p2t0: p2at, def: d2exp, ann: s2expopt
) : v2aldec // end of [v2aldec_make]

(* ****** ****** *)

fun v2ardec_make
(
  loc: location
, knd: int // knd=0/1:var/ptr
, s2v: s2var // static address
, d2v: d2var // dynamic variable
, pfat: d2varopt // proof of at-view
, type: s2expopt // type annotatio
, init: d2expopt // value for initialization
, d2vopt: d2varopt // address of variable
) : v2ardec // end of [v2ardec_make]

fun prv2ardec_make
(
  loc: location, d2v: d2var, type: s2expopt, init: d2expopt
) : prv2ardec // end of [prv2ardec_make]

(* ****** ****** *)
//
// HX: various declarations
//
(* ****** ****** *)

fun d2ecl_none(loc: location): d2ecl
fun d2ecl_list(loc: location, xs: d2eclist): d2ecl

(* ****** ****** *)
//
fun
d2ecl_symintr(loc: location, ids: i0delst): d2ecl
fun
d2ecl_symelim(loc: location, ids: i0delst): d2ecl
//
(* ****** ****** *)
//
fun
d2ecl_overload
(
  loc: location, id: i0de, pval: int, opt: d2itmopt
) : d2ecl // end of [d2ecl_overload]
//
(* ****** ****** *)
//
fun
d2ecl_pragma
  (loc: location, e1xps: e1xplst): d2ecl
fun
d2ecl_codegen
  (loc: location, knd: int, e1xps: e1xplst): d2ecl
//
(* ****** ****** *)
//
fun
d2ecl_stacsts
  (loc: location, s2cs: s2cstlst): d2ecl
//
fun
d2ecl_stacons
  (loc: location, knd: int, s2cs: s2cstlst): d2ecl
//
(*
fun d2ecl_stavars (loc: location, xs: s2tavarlst): d2ecl
*)
//
(* ****** ****** *)
//
fun
d2ecl_saspdec(loc: location, d0: s2aspdec): d2ecl
fun
d2ecl_reassume(loc: location, s2c_abs: s2cst): d2ecl
//
(* ****** ****** *)
//
fun
d2ecl_extype
  (loc: location, name: string, def: s2exp): d2ecl
//
fun
d2ecl_extvar
  (loc: location, name: string, def: d2exp): d2ecl
//
fun
d2ecl_extcode
  (loc: location, knd: int, pos: int, code: string): d2ecl
// end of [d2ecl_extcode]
//
(* ****** ****** *)
//
fun
d2ecl_datdecs
(
  loc: location, knd: int, s2cs: s2cstlst
) : d2ecl // end of [d2ecl_datdecs]
//
fun
d2ecl_exndecs (loc: location, d2cs: d2conlst): d2ecl
//
fun
d2ecl_dcstdecs
(
  loc: location, knd: int, dck: dcstkind, d2cs: d2cstlst
) : d2ecl // end of [d2ecl_dcstdecs]
//
(* ****** ****** *)
//
fun
d2ecl_fundecs
(
  loc: location, knd: funkind, decarg: s2qualst, f2ds: f2undeclst
) : d2ecl // end of [d2ecl_fundecs]
//
(* ****** ****** *)
//
fun
d2ecl_valdecs
(
  loc: location, knd: valkind, v2ds: v2aldeclst
) : d2ecl // end of [d2ecl_valdecs]
//
fun
d2ecl_valdecs_rec
(
  loc: location, knd: valkind, v2ds: v2aldeclst
) : d2ecl // end of [d2ecl_valdecs_rec]
//
(* ****** ****** *)
//
fun d2ecl_vardecs (loc: location, v2ds: v2ardeclst): d2ecl
fun d2ecl_prvardecs (loc: location, v2ds: prv2ardeclst): d2ecl
//
(* ****** ****** *)

fun d2ecl_impdec
  (loc: location, knd: int, d2c: i2mpdec): d2ecl
// end of [d2ecl_impdec]

(* ****** ****** *)

fun d2ecl_include
  (loc: location, knd: int, d2cs: d2eclist): d2ecl
// end of [d2ecl_include]

(* ****** ****** *)
//
fun
d2ecl_staload
(
  loc: location
, idopt: symbolopt, cfil: filename
, ldflag: int, fenv: filenv, loaded: int
) : d2ecl // end-of-fun
//
fun
d2ecl_staloadloc
(
  loc: location
, pfil: filename, nspace: symbol, fenv: filenv
) : d2ecl // end-of-fun
//
(* ****** ****** *)

fun
d2ecl_dynload (loc: location, fil: filename): d2ecl

(* ****** ****** *)
//
fun d2ecl_local
  (loc: location, ds1: d2eclist, ds2: d2eclist): d2ecl
//
(* ****** ****** *)

fun d2ecl_errdec (loc: location): d2ecl

(* ****** ****** *)
//
abstype dynexp2_d3eclist_type // placeholer for [d3eclist]
(*
abstype dynexp2_hideclist_type // placeholer for [hideclist]
*)
//
(* ****** ****** *)
//
abstype
dynexp2_tmpcstimpmap_type // placeholer for [tmpcstimpmap]
abstype
dynexp2_tmpvardecmap_type // placeholer for [tmpvardecmap]
//
(* ****** ****** *)
(*
** HX-2013-12:
** HX-2014-09:
** these functions are
** implemented in [pats_dynexp2_util.dats]
*)
//
fun d2exp_is_lam(d2e: d2exp): bool
//
fun
d2exp_is_varlamcst (d2e: d2exp): bool
//
fun
d2con_select_arity (d2cs: d2conlst, n: int): d2conlst
//
fun d2exp_lvalize (d2e: d2exp): d2lval
//
fun d2cst_match_def (d2c: d2cst, def: d1exp): bool
//
fun d2exp_get_seloverld (d2e0: d2exp): d2symopt
fun d2exp_get_seloverld_root (d2e0: d2exp): d2exp
//
(* ****** ****** *)
//
// HX-2014-12-11
//
(* ****** ****** *)
//
fun
d2eclist_mapgen_all
(
  d2cs: d2eclist
) : 
( s2cstset_vt // static
, s2varset_vt // static
, s2Varset_vt // static
, d2conset_vt // static
, d2cstset_vt // dynamic
, d2varset_vt // dynamic
) (* end of [d2eclist_mapgen_all] *)
//
(* ****** ****** *)

(* end of [pats_dynexp2.sats] *)
