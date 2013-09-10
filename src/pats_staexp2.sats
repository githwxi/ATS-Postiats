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

staload
INT = "./pats_intinf.sats"
typedef intinf = $INT.intinf

staload
CNTR = "./pats_counter.sats"
typedef count = $CNTR.count
staload STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
typedef stampopt = $STMP.stampopt
staload SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload LAB = "./pats_label.sats"
typedef label = $LAB.label

staload LOC = "./pats_location.sats"
typedef location = $LOC.location

staload FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

staload SYN = "./pats_syntax.sats"
typedef c0har = $SYN.c0har
typedef sl0abeled (a:type) = $SYN.sl0abeled (a)

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_effect.sats"
staload "./pats_staexp1.sats"

(* ****** ****** *)
//
// HX: assumed in [pats_staexp2_scst.dats]
//
abstype s2cst_type
typedef s2cst = s2cst_type
typedef s2cstlst = List (s2cst)
typedef s2cstopt = Option (s2cst)
//
vtypedef s2cstlst_vt = List_vt (s2cst)
//
(* ****** ****** *)
//
// HX: assumed in [pats_staexp2_svar.dats]
//
abstype s2var_type
typedef s2var = s2var_type
typedef s2varlst = List (s2var)
vtypedef s2varlst_vt = List_vt (s2var)
typedef s2varopt = Option (s2var)
vtypedef s2varopt_vt = Option_vt (s2var)
typedef s2varlstlst = List (s2varlst)
//
abstype s2varset_type
typedef s2varset = s2varset_type
absvtype s2varset_vtype
vtypedef s2varset_vt = s2varset_vtype
//
abstype s2varmset_type
typedef s2varmset = s2varmset_type
//
absvtype s2varbindmap_vtype
vtypedef s2varbindmap = s2varbindmap_vtype
//
(* ****** ****** *)
//
// HX: assumed in [pats_staexp2_sVar.dats]
//
abstype s2Var_type
typedef s2Var = s2Var_type
typedef s2Varlst = List (s2Var)
typedef s2Varopt = Option (s2Var)
abstype s2Varset_type
typedef s2Varset = s2Varset_type
abstype s2VarBound_type
typedef s2VarBound = s2VarBound_type
typedef s2VarBoundlst = List (s2VarBound)

(* ****** ****** *)

abstype s2hole_type
typedef s2hole = s2hole_type

abstype s2ctxt_type
typedef s2ctxt = s2ctxt_type
typedef s2ctxtopt = Option (s2ctxt)
typedef s2ctxtopt_vt = Option (s2ctxt)

(* ****** ****** *)
//
// HX: assumed in [pats_staexp2_dcon.dats]
//
abstype d2con_type
typedef d2con = d2con_type
typedef d2conlst = List (d2con)
vtypedef d2conlst_vt = List_vt (d2con)
//
abstype d2conset_type
typedef d2conset = d2conset_type
//
(* ****** ****** *)

abstype s2rtdat_type
typedef s2rtdat = s2rtdat_type

fun s2rtdat_make (id: symbol): s2rtdat

fun s2rtdat_get_sym (s2td: s2rtdat): symbol
fun s2rtdat_get_sconlst (s2td: s2rtdat): s2cstlst
fun s2rtdat_set_sconlst (s2td: s2rtdat, s2cs: s2cstlst): void
fun s2rtdat_get_stamp (s2td: s2rtdat): stamp

fun eq_s2rtdat_s2rtdat (s2td1: s2rtdat, s2td2: s2rtdat): bool
overload = with eq_s2rtdat_s2rtdat

fun fprint_s2rtdat : fprint_type (s2rtdat)

(* ****** ****** *)

datatype s2rtbas =
  | S2RTBASpre of (symbol) // predicative: bool, char, int, ...
  | S2RTBASimp of (int(*knd*), symbol) // impredicative sorts
  | S2RTBASdef of (s2rtdat) // user-defined datasorts
// end of [s2rtbas]

fun fprint_s2rtbas : fprint_type (s2rtbas)

(* ****** ****** *)

abstype s2rtVar // ref (s2rt)

fun eq_s2rtVar_s2rtVar (x1: s2rtVar, x2: s2rtVar): bool
overload = with eq_s2rtVar_s2rtVar
fun compare_s2rtVar_s2rtVar (x1: s2rtVar, x2: s2rtVar): Sgn
overload compare with compare_s2rtVar_s2rtVar

fun s2rtVar_make (loc: location): s2rtVar

(* ****** ****** *)

datatype s2rt =
  | S2RTbas of s2rtbas (* base sort *)
  | S2RTfun of (s2rtlst, s2rt) // function sort
  | S2RTtup of s2rtlst (* tuple sort *)
  | S2RTVar of s2rtVar // HX: unification variable
  | S2RTerr of () // HX: indicating an error
// end of [s2rt]

where
s2rtlst = List (s2rt)
and s2rtopt = Option (s2rt)
and s2rtlstlst = List (s2rtlst)
and s2rtlstopt = Option (s2rtlst)

(* ****** ****** *)

fun print_s2rt (x: s2rt): void
overload print with print_s2rt
fun prerr_s2rt (x: s2rt): void
overload prerr with prerr_s2rt
fun fprint_s2rt : fprint_type (s2rt)
overload fprint with fprint_s2rt

fun print_s2rtlst (xs: s2rtlst): void
overload print with print_s2rtlst
fun prerr_s2rtlst (xs: s2rtlst): void
overload prerr with prerr_s2rtlst
fun fprint_s2rtlst : fprint_type (s2rtlst)

(* ****** ****** *)
//
// HX: pre-defined predicative sorts
//
val s2rt_int : s2rt
val s2rt_bool : s2rt
val s2rt_addr : s2rt
(*
val s2rt_char : s2rt
*)
//
val s2rt_cls : s2rt // nominal classes
//
val s2rt_eff : s2rt // sets of effects
//
val s2rt_tkind : s2rt // for template arguments
//
// HX: pre-defined predicative sorts
//
val s2rt_prop : s2rt
val s2rt_prop_pos : s2rt
val s2rt_prop_neg : s2rt
//
val s2rt_type : s2rt
val s2rt_type_pos : s2rt
val s2rt_type_neg : s2rt
//
val s2rt_t0ype : s2rt
val s2rt_t0ype_pos : s2rt
val s2rt_t0ype_neg : s2rt
//
val s2rt_view : s2rt
val s2rt_view_pos : s2rt
val s2rt_view_neg : s2rt
//
val s2rt_vtype : s2rt
val s2rt_vtype_pos : s2rt
val s2rt_vtype_neg : s2rt
//
val s2rt_vt0ype : s2rt
val s2rt_vt0ype_pos : s2rt
val s2rt_vt0ype_neg : s2rt
//
val s2rt_types : s2rt
//
(* ****** ****** *)

fun s2rt_impred (knd: int): s2rt // selecting impredicative sorts

fun s2rt_fun (_arg: s2rtlst, _res: s2rt): s2rt // forming function sorts
fun s2rt_tup (s2ts: s2rtlst): s2rt (* HX: tuple sorts are not yet supported *)

fun s2rt_err (): s2rt // HX: a placeholder indicating error

fun s2rt_is_int (x: s2rt): bool
fun s2rt_is_addr (x: s2rt): bool
fun s2rt_is_bool (x: s2rt): bool
fun s2rt_is_char (x: s2rt): bool
fun s2rt_is_dat (x: s2rt): bool

fun s2rt_is_fun (x: s2rt): bool
fun s2rt_is_prf (x: s2rt): bool // is proof?
fun s2rt_is_lin (x: s2rt): bool
fun s2rt_is_nonlin (x: s2rt): bool
fun s2rt_is_flat (x: s2rt): bool // is flat?
fun s2rt_is_boxed (x: s2rt): bool // is boxed?
fun s2rt_is_prgm (x: s2rt): bool // is program?
fun s2rt_is_impred (x: s2rt): bool // is impredicative?
fun s2rt_is_tkind (x: s2rt): bool // is tkind?

fun s2rt_is_boxed_fun (x: s2rt): bool // is (... ->) boxed?
fun s2rt_is_tkind_fun (x: s2rt): bool // is (... ->) tkind?

(* ****** ****** *)

fun s2rt_get_pol (x: s2rt): int // neg/neu/pos: -1/0/1

(* ****** ****** *)

fun s2rtVar_set_s2rt (V: s2rtVar, s2t: s2rt): void
fun s2rtVar_occurscheck (V: s2rtVar, s2t: s2rt): bool

fun s2rt_delink (x: s2rt): s2rt // HX: shallow removal
fun s2rt_delink_all (x: s2rt): s2rt // HX: perform deep removal

fun s2rt_ltmat0 (s2t1: s2rt, s2t2: s2rt): bool // HX: dry-run
fun s2rt_ltmat1 (s2t1: s2rt, s2t2: s2rt): bool // HX: real-run

(* ****** ****** *)
//
// HX-2011-05-02:
// [filenv] contains the following
// [s2rtenv], [s2expenv] and [d2expenv]
//
abstype filenv_type
typedef filenv = filenv_type

fun filenv_get_name (x: filenv): filename

(* ****** ****** *)
//
// static items
//
datatype s2itm =
  | S2ITMvar of s2var
  | S2ITMcst of s2cstlst
  | S2ITMe1xp of e1xp
  | S2ITMdatcontyp of d2con
  | S2ITMdatconptr of d2con
  | S2ITMfilenv of filenv
// end of [s2itm]

typedef s2itmlst = List s2itm
vtypedef s2itmopt_vt = Option_vt (s2itm)

fun print_s2itm (x: s2itm): void
overload print with print_s2itm
fun prerr_s2itm (x: s2itm): void
overload prerr with prerr_s2itm
fun fprint_s2itm : fprint_type (s2itm)

(* ****** ****** *)

datatype
tyreckind =
  | TYRECKINDbox (* boxed *)
  | TYRECKINDbox_lin (* boxed *)
  | TYRECKINDflt0 (* flat *)
  | TYRECKINDflt1 of stamp (* flat *)
  | TYRECKINDflt_ext of string  (* flat *)
// end of [tyreckind]

fun tyreckind_is_box (knd: tyreckind): bool
fun tyreckind_is_boxlin (knd: tyreckind): bool
fun tyreckind_is_boxed (knd: tyreckind): bool

fun tyreckind_is_flted (knd: tyreckind): bool
fun tyreckind_is_fltext (knd: tyreckind): bool
fun tyreckind_is_nameless (knd: tyreckind): bool

fun print_tyreckind (x: tyreckind): void
fun prerr_tyreckind (x: tyreckind): void
fun fprint_tyreckind: fprint_type (tyreckind)

fun eq_tyreckind_tyreckind
  (knd1: tyreckind, knd2: tyreckind): bool
overload = with eq_tyreckind_tyreckind

fun neq_tyreckind_tyreckind
  (knd1: tyreckind, knd2: tyreckind): bool
overload != with eq_tyreckind_tyreckind

(* ****** ****** *)

(*
** HX: s2hnf for s2exp in head normal form (HNF)
*)
abstype s2hnf_type
typedef s2hnf = s2hnf_type
typedef s2hnflst = List (s2hnf)

fun print_s2hnf (x: s2hnf): void
overload print with print_s2hnf
fun prerr_s2hnf (x: s2hnf): void
overload prerr with prerr_s2hnf
fun fprint_s2hnf : fprint_type (s2hnf)

(* ****** ****** *)

datatype
s2exp_node =
//
  | S2Eint of int // integer
  | S2Eintinf of intinf // integer of flexible precision
(*
  | S2Echar of char // character
*)
//
  | S2Ecst of s2cst // constant
//
  | S2Eextype of (string(*name*), s2explstlst) // external type
  | S2Eextkind of (string(*name*), s2explstlst) // external tkind
//
  | S2Evar of s2var // variable
  | S2EVar of s2Var // existential variable
  | S2Ehole of s2hole // it used to form contexts
//
  | S2Edatcontyp of (* unfolded datatype *)
      (d2con, s2explst) (* constructor and types of arguments *)
  | S2Edatconptr of (* unfolded datatype *)
      (d2con, s2exp, s2explst) (* constructor and addrs of arguments *)
//
  | S2Eat of (s2exp, s2exp) // for at-views
  | S2Esizeof of (s2exp) // for sizes of types
//
  | S2Eeff of (s2eff) // effects
  | S2Eeqeq of (s2exp, s2exp) // generic static equality
//
  | S2Eproj of (s2exp(*addr*), s2exp(*type*), s2lablst) // projection
//
  | S2Eapp of (s2exp, s2explst) // static application
  | S2Elam of (s2varlst, s2exp) // static abstraction
//
  | S2Efun of ( // function type
      funclo, int(*lin*), s2eff, int(*npf*), s2explst(*arg*), s2exp(*res*)
    ) // end of S2Efun
//
  | S2Emetfun of (stampopt, s2explst, s2exp) // metricked function
  | S2Emetdec of
      (s2explst(*met*), s2explst(*metbound*)) // expected to strictly decrease
    // end of [S2Emetdec]
//
  | S2Etop of (int(*knd*), s2exp) // knd: 0/1: topization/typization
  | S2Ewithout of (s2exp) // for a component taken out by the [view@] operation
//
  | S2Etyarr of (s2exp (*element*), s2explst (*dimension*))
  | S2Etyrec of (tyreckind, int(*npf*), labs2explst) // tuple and record
//
// HX: note that [S2Einvar] is *not* related to [S1Einvar];
  | S2Einvar of (s2exp) // it is a special type for handling type unification
//
  | S2Eexi of ( // exist. quantified type
      s2varlst(*vars*), s2explst(*props*), s2exp(*body*)
    ) // end of [S2Euni]
  | S2Euni of ( // universally quantified type
      s2varlst(*vars*), s2explst(*props*), s2exp(*body*)
    ) // end of [S2Euni]
//
// HX: reference argument type // related to [S1Einvar]
  | S2Erefarg of (int(*0/1:val/ref*), s2exp) (* !/&: call-by-val/ref *)
//
  | S2Evararg of (s2exp) // variadic argument type
//
  | S2Ewth of (s2exp, wths2explst) // the result part of a fun type
//
  | S2Eerr of () // HX: placeholder for indicating error or something else
//
// end of [s2exp_node]

and s2lab = 
  | S2LABlab of (label) | S2LABind of (s2explst)
// end of [s2lab]

and s2eff =
  | S2EFFset of effset
  | S2EFFexp of (s2exp)
  | S2EFFadd of (s2eff, s2eff)
// end of [s2eff]

and s2rtext = (* extended sort *)
  | S2TEsrt of s2rt
  | S2TEsub of (s2var, s2rt, s2explst)
  | S2TEerr of ()
// end of [s2rtext]

and labs2exp = SLABELED of (label, Option(string), s2exp)

and wths2explst =
  | WTHS2EXPLSTnil of ()
  | WTHS2EXPLSTcons_invar of (int(*refval*), s2exp, wths2explst)
  | WTHS2EXPLSTcons_trans of (int(*refval*), s2exp, wths2explst)
  | WTHS2EXPLSTcons_none of wths2explst
// end of [wths2explst]

where
s2exp = '{
  s2exp_srt= s2rt, s2exp_node= s2exp_node
} // end of [s2exp]
and s2explst = List (s2exp)
and s2expopt = Option (s2exp)
and s2explstlst = List (s2explst)
and s2explstopt = Option (s2explst)
and s2lablst = List (s2lab)
and labs2explst = List (labs2exp)

vtypedef s2explst_vt = List_vt (s2exp)
vtypedef s2expopt_vt = Option_vt (s2exp)

(* ****** ****** *)

typedef
locs2exp = (location, s2exp)
typedef locs2explst = List (locs2exp)

vtypedef
s2rtextopt_vt = Option_vt (s2rtext)

(* ****** ****** *)

typedef syms2rt = (symbol, s2rt)
typedef syms2rtlst = List (syms2rt)

(* ****** ****** *)
//
// HX: there is no [s2qua]
//
typedef
s2qua = @{
  s2qua_svs= s2varlst, s2qua_sps= s2explst
} // end of [s2qua]
typedef s2qualst = List (s2qua)
vtypedef s2qualst_vt = List_vt (s2qua)

fun s2qua_make (s2vs: s2varlst, s2ps: s2explst): s2qua

fun fprint_s2qua : fprint_type (s2qua)

fun print_s2qualst (xs: s2qualst): void
fun prerr_s2qualst (xs: s2qualst): void
fun fprint_s2qualst : fprint_type (s2qualst)

(* ****** ****** *)

fun s2cst_make (
  id: symbol // the name
, loc: location // the location of declaration
, s2t: s2rt // the sort
, isabs: Option (s2expopt)
, iscon: bool
, isrec: bool
, isasp: bool
, islst: Option @(d2con(*nil*), d2con(*cons*))
, argsrtss: List (syms2rtlst) // HX: containing info on arg variances
, def: s2expopt
) : s2cst // end of [s2cst_make]

fun s2cst_make_dat (
  id: symbol
, loc: location
, s2ts_arg: s2rtlstlst
, s2t_res: s2rt
, argsrtss: List (syms2rtlst) // HX: containing info on arg variances
) : s2cst // end of [s2cst_make_dat]

(* ****** ****** *)

fun s2cst_get_sym (x: s2cst): symbol
fun s2cst_get_name (x: s2cst): string

fun s2cst_get_loc (x: s2cst): location
fun s2cst_get_fil (x: s2cst): filename

fun s2cst_get_srt (x: s2cst): s2rt

fun s2cst_get_def (x: s2cst): s2expopt
fun s2cst_set_def (x: s2cst, def: s2expopt): void

fun s2cst_get_pack (x: s2cst): Stropt

fun s2cst_get_isabs (x: s2cst): Option (s2expopt)

fun s2cst_get_iscon (x: s2cst): bool

fun s2cst_get_isrec (x: s2cst): bool

fun s2cst_get_isasp (x: s2cst): bool
fun s2cst_set_isasp (x: s2cst, asp: bool): void

fun s2cst_get_iscpy (x: s2cst): s2cstopt
fun s2cst_set_iscpy (x: s2cst, cpy: s2cstopt): void

fun s2cst_get_islst (x: s2cst): Option @(d2con, d2con)
fun s2cst_set_islst (x: s2cst, lst: Option @(d2con, d2con)): void

fun s2cst_get_arylst (x: s2cst): List int // arity list
fun s2cst_get_argsrtss (x: s2cst): List (syms2rtlst) // arg variances

fun s2cst_get_dconlst (x: s2cst): Option d2conlst
fun s2cst_set_dconlst (x: s2cst, lst: Option d2conlst): void

fun s2cst_get_sup (x: s2cst): s2cstlst
fun s2cst_add_sup (x: s2cst, sup: s2cst): void
fun s2cst_get_supcls (x: s2cst): s2explst
fun s2cst_add_supcls (x: s2cst, sup: s2exp): void

fun s2cst_get_sVarset (x: s2cst): s2Varset
fun s2cst_set_sVarset (x: s2cst, _: s2Varset): void

fun s2cst_get_tag (x: s2cst):<> int
fun s2cst_set_tag (x: s2cst, tag: int): void

fun s2cst_get_stamp (x: s2cst): stamp

(* ****** ****** *)

fun lt_s2cst_s2cst (x1: s2cst, x2: s2cst):<> bool
overload < with lt_s2cst_s2cst
fun lte_s2cst_s2cst (x1: s2cst, x2: s2cst):<> bool
overload <= with lte_s2cst_s2cst

fun eq_s2cst_s2cst (x1: s2cst, x2: s2cst):<> bool
overload = with eq_s2cst_s2cst
fun neq_s2cst_s2cst (x1: s2cst, x2: s2cst):<> bool
overload != with neq_s2cst_s2cst

fun compare_s2cst_s2cst (x1: s2cst, x2: s2cst):<> Sgn
overload compare with compare_s2cst_s2cst

(* ****** ****** *)

fun s2cst_is_abstr (x: s2cst): bool
fun s2cst_is_tkind (x: s2cst): bool

fun s2cst_is_datype (s2c: s2cst): bool

fun s2cst_is_tagless (x: s2cst): bool
fun s2cst_is_listlike (x: s2cst): bool
fun s2cst_is_singular (x: s2cst): bool
fun s2cst_is_binarian (x: s2cst): bool

(* ****** ****** *)

fun s2cst_subeq (s2c1: s2cst, s2c2: s2cst): bool
fun s2cst_lte_cls_cls (s2c1: s2cst, s2c2: s2cst): bool

(* ****** ****** *)

fun print_s2cst (x: s2cst): void
fun prerr_s2cst (x: s2cst): void
overload print with print_s2cst
overload prerr with prerr_s2cst
fun fprint_s2cst : fprint_type (s2cst)
overload fprint with fprint_s2cst

fun print_s2cstlst (xs: s2cstlst): void
fun prerr_s2cstlst (xs: s2cstlst): void
overload print with print_s2cstlst
overload prerr with prerr_s2cstlst
fun fprint_s2cstlst : fprint_type (s2cstlst)
overload fprint with fprint_s2cstlst

(* ****** ****** *)
//
absvtype
s2cstset_vtype // assumed in [pats_staexp2_scst.dats]
vtypedef s2cstset_vt = s2cstset_vtype
fun s2cstset_vt_nil (): s2cstset_vt
fun s2cstset_vt_free (xs: s2cstset_vt): void
fun s2cstset_vt_add (xs: s2cstset_vt, x: s2cst): s2cstset_vt
//
(* ****** ****** *)
//
abstype
s2cstmap_type_type (a:type)
stadef s2cstmap = s2cstmap_type_type
//
fun s2cstmap_nil {a:type} (): s2cstmap (a)
fun s2cstmap_add {a:type}
  (map: s2cstmap (a), key: s2cst, itm: a):<> s2cstmap (a)
fun s2cstmap_find
  {a:type} (map: s2cstmap (a), key: s2cst):<> Option_vt (a)
//
(* ****** ****** *)

fun s2var_make_srt (s2t: s2rt): s2var
fun s2var_make_id_srt (id: symbol, s2t: s2rt): s2var
fun s2var_dup (s2v: s2var): s2var // HX: s2var-duplication

(* ****** ****** *)

fun s2var_get_sym (s2v: s2var):<> symbol
fun s2var_get_srt (s2v: s2var):<> s2rt
fun s2var_get_tmplev (s2v: s2var): int
fun s2var_set_tmplev (s2v: s2var, lev: int): void
fun s2var_get_sVarset (s2v: s2var): s2Varset
fun s2var_set_sVarset (s2v: s2var, s2Vs: s2Varset): void
fun s2varlst_set_sVarset (s2vs: s2varlst, s2Vs: s2Varset): void
fun s2var_get_stamp (s2v: s2var):<> stamp

fun lt_s2var_s2var (x1: s2var, x2: s2var):<> bool
overload < with lt_s2var_s2var
fun lte_s2var_s2var (x1: s2var, x2: s2var):<> bool
overload <= with lte_s2var_s2var

fun eq_s2var_s2var (x1: s2var, x2: s2var):<> bool
overload = with eq_s2var_s2var
fun neq_s2var_s2var (x1: s2var, x2: s2var):<> bool
overload != with neq_s2var_s2var

fun compare_s2var_s2var (x1: s2var, x2: s2var):<> Sgn
overload compare with compare_s2var_s2var

fun compare_s2vsym_s2vsym (x1: s2var, x2: s2var):<> Sgn

(* ****** ****** *)

fun print_s2var (x: s2var): void
fun prerr_s2var (x: s2var): void
overload print with print_s2var
overload prerr with prerr_s2var
fun fprint_s2var : fprint_type (s2var)
overload fprint with fprint_s2var

(* ****** ****** *)

fun print_s2varlst (xs: s2varlst): void
fun prerr_s2varlst (xs: s2varlst): void
overload print with print_s2varlst
overload prerr with prerr_s2varlst
fun fprint_s2varlst : fprint_type (s2varlst)
overload fprint with fprint_s2varlst

(* ****** ****** *)

fun s2var_is_bool
  (s2v: s2var): bool // is boolean?
// end of [s2var_is_bool]

(*
fun s2var_is_boxed (s2v: s2var): bool
fun s2var_is_unboxed (s2v: s2var): bool
*)

(* ****** ****** *)

fun s2varset_nil (): s2varset
fun s2varset_add (xs: s2varset, x: s2var): s2varset
fun s2varset_del (xs: s2varset, x: s2var): s2varset
fun s2varset_union (xs: s2varset, ys: s2varset): s2varset

fun s2varset_vt_nil (): s2varset_vt
fun s2varset_vt_add
  (xs: s2varset_vt, x: s2var): s2varset_vt
fun s2varset_vt_del
  (xs: s2varset_vt, x: s2var): s2varset_vt
fun s2varset_vt_delist
  (xs1: s2varset_vt, xs2: s2varlst): s2varset_vt
fun s2varset_vt_union
  (xs: s2varset_vt, ys: s2varset_vt): s2varset_vt

fun s2varset_vt_free (xs: s2varset_vt): void
fun s2varset_vt_listize_free (xs: s2varset_vt): s2varlst_vt

(* ****** ****** *)

fun s2varmset_nil (): s2varmset
fun s2varmset_sing (x: s2var): s2varmset
fun s2varmset_pair (x1: s2var, x2: s2var): s2varmset
//
fun s2varmset_gte
  (xs: s2varmset, ys: s2varmset): bool
//
fun s2varmset_is_equal
  (xs: s2varmset, ys: s2varmset): bool
//
fun s2varmset_add
  (xs: s2varmset, x: s2var): s2varmset
fun s2varmset_del
  (xs: s2varmset, x: s2var): s2varmset
fun s2varmset_union
  (xs: s2varmset, ys: s2varmset): s2varmset
//
fun s2varmset_listize (xs: s2varmset): s2varlst_vt
//
fun fprint_s2varmset : fprint_type (s2varmset)
//
(* ****** ****** *)

fun s2varbindmap_make_nil (): s2varbindmap
fun s2varbindmap_search
  (map: !s2varbindmap, s2v: s2var): Option_vt (s2exp)
fun s2varbindmap_insert
  (map: &s2varbindmap, s2v: s2var, s2f: s2hnf): void
fun s2varbindmap_remove (map: &s2varbindmap, s2v: s2var): void
fun s2varbindmap_listize (map: !s2varbindmap): List_vt @(s2var, s2exp)

(* ****** ****** *)
//
// HX: [s2Var] is assumed in [pats_staexp2_sVar.dats]
//
fun s2Var_make_srt (loc: location, s2t: s2rt): s2Var
fun s2Var_make_var (loc: location, s2v: s2var): s2Var

(* ****** ****** *)

fun s2Var_get_cnt (s2V: s2Var):<> count
fun s2Var_get_srt (s2V: s2Var):<> s2rt
fun s2Var_get_link (s2V: s2Var): s2expopt
fun s2Var_set_link (s2V: s2Var, link: s2expopt): void
//
// HX: this is for occurchecks
//
fun s2Var_get_sVarlst (s2V: s2Var): s2Varlst
fun s2Var_add_sVarlst (s2V: s2Var, s2V2: s2Var): void
fun s2Varlst_add_sVarlst (s2Vs: s2Varlst, s2V2: s2Var): void
//
fun s2Var_get_lbs (s2V: s2Var): s2VarBoundlst
fun s2Var_set_lbs (s2V: s2Var, lbs: s2VarBoundlst): void
//
fun s2Var_get_ubs (s2V: s2Var): s2VarBoundlst
fun s2Var_set_ubs (s2V: s2Var, ubs: s2VarBoundlst): void
//
fun s2Var_get_stamp (s2V: s2Var):<> stamp

(* ****** ****** *)

fun s2VarBound_make
  (loc: location, s2f: s2exp): s2VarBound
fun s2VarBound_get_loc (x: s2VarBound): location
fun s2VarBound_get_val (x: s2VarBound): s2exp

(* ****** ****** *)

fun lt_s2Var_s2Var (x1: s2Var, x2: s2Var):<> bool
overload < with lt_s2Var_s2Var
fun lte_s2Var_s2Var (x1: s2Var, x2: s2Var):<> bool
overload <= with lte_s2Var_s2Var

fun eq_s2Var_s2Var (x1: s2Var, x2: s2Var):<> bool
overload = with eq_s2Var_s2Var
fun neq_s2Var_s2Var (x1: s2Var, x2: s2Var):<> bool
overload != with neq_s2Var_s2Var

fun compare_s2Var_s2Var (x1: s2Var, x2: s2Var):<> Sgn
overload compare with compare_s2Var_s2Var

(* ****** ****** *)

fun print_s2Var (x: s2Var): void
overload print with print_s2Var
fun prerr_s2Var (x: s2Var): void
overload prerr with prerr_s2Var
fun fprint_s2Var : fprint_type (s2Var)

fun print_s2Varlst (xs: s2Varlst): void
overload print with print_s2Varlst
fun prerr_s2Varlst (xs: s2Varlst): void
overload prerr with prerr_s2Varlst
fun fprint_s2Varlst : fprint_type (s2Varlst)

(* ****** ****** *)

fun s2Varset_make_nil (): s2Varset
fun s2Varset_add (xs: s2Varset, x: s2Var): s2Varset
fun s2Varset_is_member (xs: s2Varset, x: s2Var): bool
fun s2Varset_listize (xs: s2Varset): List_vt (s2Var)

fun print_s2Varset (xs: s2Varset): void
overload print with print_s2Varset
fun prerr_s2Varset (xs: s2Varset): void
overload prerr with prerr_s2Varset
fun fprint_s2Varset : fprint_type (s2Varset)

(* ****** ****** *)

fun s2hole_make_srt (s2t: s2rt): s2hole

fun s2hole_get_srt (s2h: s2hole):<> s2rt
fun s2hole_get_stamp (s2h: s2hole):<> stamp

fun fprint_s2hole (out: FILEref, x: s2hole): void

(* ****** ****** *)

fun s2ctxt_make (s2e: s2exp, s2h: s2hole): s2ctxt

(* ****** ****** *)
//
// HX: [d2con] is assumed in [pats_staexp2_dcon.dats]
//
fun d2con_make (
  loc: location // location
, fil: filename // filename
, id: symbol // the name
, s2c: s2cst // the type constructor
, vwtp: int
, qua: s2qualst
, npf: int // pfarity
, arg: s2explst // arguments
, ind: s2explstopt // indexes
) : d2con // end of [d2con_make]

(* ****** ****** *)

fun d2con_make_list_nil (): d2con
fun d2con_make_list_cons (): d2con

(* ****** ****** *)
//
// HX: implemented in [pats_staexp2_dcon.dats]
//
fun print_d2con (x: d2con): void
overload print with print_d2con
fun prerr_d2con (x: d2con): void
overload prerr with prerr_d2con
fun fprint_d2con : fprint_type (d2con)

fun print_d2conlst (xs: d2conlst): void
overload print with print_d2conlst
fun prerr_d2conlst (xs: d2conlst): void
overload prerr with prerr_d2conlst
fun fprint_d2conlst : fprint_type (d2conlst)

(* ****** ****** *)

fun d2con_get_sym (x: d2con):<> symbol
fun d2con_get_name (x: d2con):<> string
fun d2con_get_loc (x: d2con):<> location
fun d2con_get_fil (x: d2con):<> filename
fun d2con_get_scst (x: d2con):<> s2cst
fun d2con_get_npf (x: d2con):<> int
fun d2con_get_vwtp (x: d2con):<> int
fun d2con_get_qua (x: d2con):<> s2qualst
fun d2con_get_arg (x: d2con):<> s2explst
fun d2con_get_arity_full (x: d2con):<> int
fun d2con_get_arity_real (x: d2con):<> int
fun d2con_get_ind (x: d2con):<> s2explstopt
fun d2con_get_type (x: d2con):<> s2exp
fun d2con_get_tag (x: d2con): int
fun d2con_set_tag (x: d2con, tag: int): void
fun d2con_get_pack (x: d2con):<> Stropt
fun d2con_get_stamp (x: d2con):<> stamp

(* ****** ****** *)

fun eq_d2con_d2con (x1: d2con, x2: d2con):<> bool
overload = with eq_d2con_d2con
fun neq_d2con_d2con (x1: d2con, x2: d2con):<> bool
overload != with neq_d2con_d2con

fun compare_d2con_d2con (x1: d2con, x2: d2con):<> Sgn
overload compare with compare_d2con_d2con

(* ****** ****** *)

fun d2con_is_con (d2c: d2con): bool // data constructor
fun d2con_is_exn (d2c: d2con): bool // exceptn constructor

fun d2con_is_nullary (d2c: d2con): bool // nullary constructor
fun d2con_is_tagless (d2c: d2con): bool // tagless constructor
//
fun d2con_is_listnil (d2c: d2con): bool // like listnil
fun d2con_is_listcons (d2c: d2con): bool // like listcons
fun d2con_is_listlike (d2c: d2con): bool // like listnil/listcons
//
fun d2con_is_singular (d2c: d2con): bool // singular constructor
fun d2con_is_binarian (d2c: d2con): bool // binarian constructor

(* ****** ****** *)

fun d2conset_nil ():<> d2conset
fun d2conset_ismem (xs: d2conset, x: d2con):<> bool
fun d2conset_add (xs: d2conset, x: d2con):<> d2conset

(* ****** ****** *)
//
// HX: static expressions
//
fun s2exp_int (i: int): s2exp
fun s2exp_intinf (i: intinf): s2exp
fun s2exp_int_char (c: char): s2exp
fun s2exp_int_uchar (c: uchar): s2exp
(*
fun s2exp_bool (b: bool): s2exp // HX: in stacst.sats
fun s2exp_char (c: char): s2exp // HX: merged into S2Eint
*)
fun s2exp_cst (x: s2cst): s2exp // HX: static constant
fun s2exp_var (x: s2var): s2exp // HX: static variable
fun s2exp_Var (x: s2Var): s2exp // HX: static existential variable
fun s2exp_hole (x: s2hole): s2exp // HX: static context hole

(*
** HX: please be cautious!
*)
fun s2exp_var_srt (s2t: s2rt, s2v: s2var): s2exp

fun s2exp_extype_srt
  (s2t: s2rt, name: string, arg: s2explstlst): s2exp
// end of [s2exp_extype_srt]
fun s2exp_extkind_srt
  (s2t: s2rt, name: string, arg: s2explstlst): s2exp
// end of [s2exp_extkind_srt]

(* ****** ****** *)

fun s2exp_at
  (s2e1: s2exp, s2e2: s2exp): s2exp
// end of [s2exp_at]

(* ****** ****** *)

fun s2exp_sizeof (s2e_type: s2exp): s2exp

(* ****** ****** *)

fun s2exp_eff (s2fe: s2eff): s2exp
fun s2exp_eqeq (s2e1: s2exp, s2e2: s2exp): s2exp
fun s2exp_proj (s2ae: s2exp, s2te: s2exp, s2ls: s2lablst): s2exp

(* ****** ****** *)

fun s2exp_app_srt
  (s2t: s2rt, _fun: s2exp, _arg: s2explst): s2exp
// end of [s2exp_app_srt]

fun s2exp_lam (s2vs: s2varlst, s2e: s2exp): s2exp
fun s2exp_lam_srt (s2t: s2rt, s2vs: s2varlst, s2e: s2exp): s2exp
fun s2exp_lamlst (s2vss: s2varlstlst, s2e: s2exp): s2exp

fun s2exp_fun_srt (
  s2t: s2rt
, fc: funclo
, lin: int
, s2fe: s2eff
, npf: int
, s2es_arg: s2explst
, s2e_res: s2exp
) : s2exp // end of [s2exp_fun_srt]

fun s2exp_metfun
  (opt: stampopt, met: s2explst, s2e: s2exp): s2exp
// end of [s2exp_metfun]

(* ****** ****** *)

fun s2exp_metdec (s2es1: s2explst, s2es2: s2explst): s2exp

(* ****** ****** *)

fun s2exp_cstapp (s2c: s2cst, s2es: s2explst): s2exp
fun s2exp_confun (npf: int, s2es: s2explst, s2e: s2exp): s2exp

(* ****** ****** *)

fun s2exp_datcontyp (d2c: d2con, arg: s2explst): s2exp
fun s2exp_datconptr (d2c: d2con, rt: s2exp, arg: s2explst): s2exp

(* ****** ****** *)

fun s2exp_top (knd: int, s2e: s2exp): s2exp
fun s2exp_top_srt (s2t: s2rt, knd: int, s2e: s2exp): s2exp

(* ****** ****** *)

fun s2exp_without (s2e: s2exp): s2exp

(* ****** ****** *)

fun s2exp_tyarr
  (s2e_elt: s2exp, s2es_int: s2explst): s2exp
// end of [s2exp_tyarr]
fun s2exp_tyarr_srt
  (s2t: s2rt, s2e_elt: s2exp, s2es_int: s2explst): s2exp
// end of [s2exp_tyarr_srt]

fun s2exp_tytup (
  knd: int, npf: int, s2es: s2explst
) : s2exp // end of [s2exp_tytup]

fun s2exp_tyrec (
  knd: int, npf: int, ls2es: labs2explst
) : s2exp // end of [s2exp_tyrec]

fun s2exp_tyrec_srt (
  s2t: s2rt, knd: tyreckind, npf: int, ls2es: labs2explst
) : s2exp // end of [s2exp_tyrec_srt]

(* ****** ****** *)

fun s2exp_invar (s2e: s2exp): s2exp

(* ****** ****** *)

fun s2exp_refarg
  (refval: int, s2e: s2exp): s2exp
// end of [s2exp_refarg]

fun s2exp_vararg (s2e: s2exp): s2exp

(* ****** ****** *)

fun s2exp_exi
  (s2vs: s2varlst, s2ps: s2explst, s2f: s2exp): s2exp
fun s2exp_uni
  (s2vs: s2varlst, s2ps: s2explst, s2f: s2exp): s2exp
fun s2exp_exiuni // knd=0/1: exi/uni
  (knd: int, s2vs: s2varlst, s2ps: s2explst, s2f: s2exp): s2exp
// end of [s2exp_exiuni]

fun uns2exp_exiuni (
  knd: int, s2f: s2exp // knd=0/1:exi/uni
, s2vs: &s2varlst? >> s2varlst
, s2ps: &s2explst? >> s2explst
, scope: &s2exp? >> s2exp
) : bool // succ/fail: true/false

(* ****** ****** *)

fun s2exp_unis (s2qs: s2qualst, s2f: s2exp): s2exp

(* ****** ****** *)

fun s2exp_wth (_res: s2exp, _with: wths2explst): s2exp

(* ****** ****** *)

fun s2exp_err (s2t: s2rt): s2exp // HX: error indication
fun s2exp_s2rt_err (): s2exp // HX: s2exp_err (s2rt_err ())
fun s2exp_t0ype_err (): s2exp // HX: s2exp_err (s2rt_t0ype)

(* ****** ****** *)

fun s2exp_refeq (s2e1: s2exp, s2e2: s2exp):<> bool

(* ****** ****** *)

fun print_s2exp (x: s2exp): void
overload print with print_s2exp
fun prerr_s2exp (x: s2exp): void
overload prerr with prerr_s2exp
fun fprint_s2exp : fprint_type (s2exp)
overload fprint with fprint_s2exp

fun print_s2explst (xs: s2explst): void
overload print with print_s2explst
fun prerr_s2explst (xs: s2explst): void
overload prerr with prerr_s2explst
fun fprint_s2explst : fprint_type (s2explst)
overload fprint with fprint_s2explst

(* ****** ****** *)

fun print_s2expopt (opt: s2expopt): void
overload print with print_s2expopt
fun prerr_s2expopt (opt: s2expopt): void
overload prerr with prerr_s2expopt
fun fprint_s2expopt : fprint_type (s2expopt)
overload fprint with fprint_s2expopt

(* ****** ****** *)

fun fprint_labs2explst : fprint_type (labs2explst)
overload fprint with fprint_labs2explst
fun fprint_wths2explst : fprint_type (wths2explst)
overload fprint with fprint_wths2explst

(* ****** ****** *)

fun fprint_s2explstlst : fprint_type (s2explstlst)
fun fprint_s2explstopt : fprint_type (s2explstopt)

(* ****** ****** *)

fun print_s2lab (s2l: s2lab): void
fun prerr_s2lab (s2l: s2lab): void
fun fprint_s2lab : fprint_type (s2lab)

fun fprint_s2lablst : fprint_type (s2lablst)

(* ****** ****** *)

val s2eff_nil: s2eff
val s2eff_all: s2eff
fun s2eff_effset (efs: effset):<> s2eff
fun s2eff_var (s2v: s2var): s2eff
fun s2eff_exp (s2e: s2exp): s2eff
fun s2eff_add (s2fe1: s2eff, s2fe2: s2eff): s2eff

fun print_s2eff (s2fe: s2eff): void
overload print with print_s2eff
fun prerr_s2eff (s2fe: s2eff): void
overload prerr with prerr_s2eff
fun fprint_s2eff : fprint_type (s2eff)

(* ****** ****** *)

fun fprint_s2rtext : fprint_type (s2rtext)

(* ****** ****** *)
//
// HX: for reporting error messages
//
fun pprint_s2exp (s2e: s2exp): void
and pprerr_s2exp (s2e: s2exp): void
fun fpprint_s2exp : fprint_type (s2exp)

fun pprint_s2explst (s2es: s2explst): void
and pprerr_s2explst (s2es: s2explst): void
fun fpprint_s2explst : fprint_type (s2explst)

fun fpprint_s2explstlst : fprint_type (s2explstlst)

fun fpprint_labs2explst : fprint_type (labs2explst)
fun fpprint_wths2explst : fprint_type (wths2explst)
//
(* ****** ****** *)

fun s2exp_is_prf (x: s2exp): bool
fun s2exp_is_nonprf (x: s2exp): bool
fun s2exp_is_lin (x: s2exp): bool
fun s2exp_is_nonlin (x: s2exp): bool
fun s2exp_is_boxed (x: s2exp): bool
fun s2exp_is_prgm (x: s2exp): bool
fun s2exp_is_impred (x: s2exp): bool

(* ****** ****** *)

fun s2exp_is_tyfun (x: s2exp): bool

(* ****** ****** *)

datatype
sp2at_node =
  | SP2Tcon of (s2cst, s2varlst)
  | SP2Terr of () // HX: a placeholder for indicating an error
// end of [sp2at_node]

typedef
sp2at = '{
  sp2at_loc= location
, sp2at_exp= s2exp, sp2at_node= sp2at_node
} // end of [sp2at]

fun sp2at_con
  (loc: location, s2c: s2cst, s2vs: s2varlst): sp2at
// end of [sp2at_con]

fun sp2at_err (loc: location): sp2at

fun fprint_sp2at : fprint_type (sp2at)

(* ****** ****** *)

datatype s2kexp =
  | S2KEany of ()
  | S2KEcst of s2cst
  | S2KEvar of s2var
  | S2KEextype of (string(*name*), s2kexplstlst)
  | S2KEextkind of (string(*name*), s2kexplstlst)
  | S2KEfun of (s2kexplst(*arg*), s2kexp(*res*))
  | S2KEapp of (s2kexp, s2kexplst)
  | S2KEtyarr of (s2kexp)
  | S2KEtyrec of (tyreckind, labs2kexplst)
// end of [s2kexp]

and labs2kexp = SKLABELED of (label, s2kexp)

where
s2kexplst = List (s2kexp)
and
s2kexplstlst = List (s2kexplst)
and
labs2kexplst = List (labs2kexp)

fun print_s2kexp (x: s2kexp): void
overload print with print_s2kexp
fun prerr_s2kexp (x: s2kexp): void
overload prerr with prerr_s2kexp
fun fprint_s2kexp : fprint_type (s2kexp)

fun fprint_s2kexplst : fprint_type (s2kexplst)
fun fprint_labs2kexp : fprint_type (labs2kexp)

fun s2kexp_make_s2exp (s2e: s2exp): s2kexp

(* ****** ****** *)

datatype s2zexp =
//
  | S2ZEprf of () (* proof size *)
  | S2ZEptr of () (* pointer size *)
//
  | S2ZEcst of s2cst
  | S2ZEvar of s2var
  | S2ZEVar of s2Var
//
  | S2ZEextype of (string (*name*), s2zexplstlst)
  | S2ZEextkind of (string (*name*), s2zexplstlst)
//
  | S2ZEapp of (s2zexp, s2zexplst)
  | S2ZEtyarr of // array size
      (s2zexp (*element*), s2explst (*dimension*))
  | S2ZEtyrec of (tyreckind, labs2zexplst)
//
  | S2ZEclo of () // HX: for flat closures
//
  | S2ZEbot of () // HX: no available info
// end of [s2zexp]

and labs2zexp = SZLABELED of (label, s2zexp)

where
s2zexplst = List (s2zexp)
and
s2zexplstlst = List (s2zexplst)
and
labs2zexplst = List (labs2zexp)

fun print_s2zexp (s2ze: s2zexp): void
overload print with print_s2zexp
fun prerr_s2zexp (s2ze: s2zexp): void
overload prerr with prerr_s2zexp
fun fprint_s2zexp : fprint_type (s2zexp)

fun s2Var_get_szexp (s2V: s2Var): s2zexp
fun s2Var_set_szexp (s2V: s2Var, s2ze: s2zexp): void

fun s2zexp_is_bot (s2ze: s2zexp): bool
fun s2zexp_make_s2exp (s2e: s2exp): s2zexp

(* ****** ****** *)

datatype
s2vararg =
  | S2VARARGone (* {..} *)
  | S2VARARGall (* {...} *)
  | S2VARARGseq of s2varlst
// end of [s2vararg]

typedef s2vararglst = List (s2vararg)

fun fprint_s2vararg : fprint_type (s2vararg)

(* ****** ****** *)

datatype
s2exparg_node =
  | S2EXPARGone (* {..} *)
  | S2EXPARGall (* {...} *)
  | S2EXPARGseq of s2explst
// end of [s2exparg_node]

typedef
s2exparg = '{
  s2exparg_loc= location, s2exparg_node= s2exparg_node
} // end of [s2exparg]

typedef s2exparglst = List (s2exparg)

fun fprint_s2exparg : fprint_type (s2exparg)
fun fprint_s2exparglst : fprint_type (s2exparglst)

fun s2exparg_one (loc: location): s2exparg
fun s2exparg_all (loc: location): s2exparg
fun s2exparg_seq (loc: location, s2fs: s2explst): s2exparg

(* ****** ****** *)

typedef
t2mpmarg = '{
  t2mpmarg_loc= location, t2mpmarg_arg= s2explst
} // end of [t2mpmarg]

typedef t2mpmarglst = List (t2mpmarg)
vtypedef t2mpmarglst_vt = List_vt (t2mpmarg)

fun t2mpmarg_make (loc: location, arg: s2explst): t2mpmarg

fun fpprint_t2mpmarg : fprint_type (t2mpmarg)
fun fpprint_t2mpmarglst : fprint_type (t2mpmarglst)

(* ****** ****** *)

typedef
s2tavar = '{
  s2tavar_loc= location, s2tavar_var= s2var
} // end of [s2tavar]
typedef s2tavarlst = List s2tavar

fun s2tavar_make
  (loc: location, s2v: s2var): s2tavar
// end of [s2tavar_make]

(* ****** ****** *)

typedef
s2aspdec = '{
  s2aspdec_loc= location
, s2aspdec_cst= s2cst
, s2aspdec_def= s2exp
} // end of [s2aspdec]

fun s2aspdec_make (
  loc: location, s2c: s2cst, def: s2exp
) : s2aspdec // end of [s2aspdec_make]

(* ****** ****** *)

(* end of [pats_staexp2.sats] *)
