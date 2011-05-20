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
typedef lstord (a:type) = $UT.lstord (a)

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location

staload FIL = "pats_filename.sats"
typedef filename = $FIL.filename

staload SYN = "pats_syntax.sats"
typedef dcstextdef = $SYN.dcstextdef
typedef i0nt = $SYN.i0nt
typedef c0har = $SYN.c0har
typedef f0loat = $SYN.f0loat
typedef s0tring = $SYN.s0tring

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"

(* ****** ****** *)

abstype d2cst_type
typedef d2cst = d2cst_type
typedef d2cstlst = List (d2cst)

abstype d2var_type
typedef d2var = d2var_type
typedef d2varlst = List (d2var)
typedef d2varopt = Option (d2var)

abstype d2mac_type
typedef d2mac = d2mac_type

(* ****** ****** *)

datatype d2itm =
  | D2ITMcon of d2conlst
  | D2ITMcst of d2cst
  | D2ITMe1xp of e1xp
  | D2ITMmacdef of d2mac
  | D2ITMmacvar of d2var
  | D2ITMsymdef of d2itmlst (* overloaded symbol *)
  | D2ITMvar of d2var
// end of [d2itm]

where d2itmlst = List (d2itm)

viewtypedef d2itmopt_vt = Option_vt (d2itm)

(* ****** ****** *)

fun d2var_make (loc: location, id: symbol): d2var

fun d2var_get_sym (x: d2var): symbol

fun d2var_get_loc (x: d2var): location

fun d2var_get_isfix (x: d2var): bool
fun d2var_set_isfix (x: d2var, isfix: bool): void

fun d2var_get_isprf (x: d2var): bool
fun d2var_set_isprf (x: d2var, isprf: bool): void

fun d2var_get_level (x: d2var): int
fun d2var_set_level (x: d2var, level: int): void

fun d2var_get_linval (x: d2var): int

fun d2var_get_decarg (x: d2var): s2qualstlst
fun d2var_set_decarg (x: d2var, decarg: s2qualstlst): void

fun d2var_get_addr (x: d2var): s2expopt
fun d2var_set_addr (x: d2var, s2eopt: s2expopt): void

fun d2var_get_view (x: d2var): d2varopt
fun d2var_set_view (x: d2var, d2vopt: d2varopt): void

fun d2var_get_type (x: d2var): s2expopt
fun d2var_set_type (x: d2var, s2eopt: s2expopt): void
fun d2var_get_mastype (x: d2var): s2expopt
fun d2var_set_mastype (x: d2var, s2eopt: s2expopt): void

fun d2var_get_stamp (x: d2var): stamp

fun compare_d2var_d2var (x1: d2var, x2: d2var):<> Sgn
overload compare with compare_d2var_d2var

(* ****** ****** *)

fun d2cst_make (
  id: symbol
, loc: location
, fil: filename
, dck: dcstkind
, decarg: s2qualstlst
, arylst: List int
, typ: s2exp
, extdef: dcstextdef
) : d2cst // end of [d2cst_make]

(* ****** ****** *)

fun d2cst_get_loc (x: d2cst): location
fun d2cst_get_fil (_: d2cst): filename
fun d2cst_get_sym (x: d2cst): symbol
fun d2cst_get_kind (x: d2cst): dcstkind
fun d2cst_get_arylst (x: d2cst): List int
fun d2cst_get_decarg (x: d2cst): s2qualstlst
fun d2cst_set_decarg (x: d2cst, s2qss: s2qualstlst): void
fun d2cst_get_typ (x: d2cst): s2exp
fun d2cst_get_extdef (x: d2cst): dcstextdef
fun d2cst_get_stamp (x: d2cst): stamp

(* ****** ****** *)

fun lt_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
overload < with lt_d2cst_d2cst
fun lte_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
overload <= with lte_d2cst_d2cst

fun compare_d2cst_d2cst (x1: d2cst, x2: d2cst):<> Sgn
overload compare with compare_d2cst_d2cst

(* ****** ****** *)

datatype p2at_node =
  | P2Tany of () // wildcard
  | P2Tvar of (int(*refknd*), d2var)
  | P2Tbool of bool
  | P2Tchar of char
  | P2Tstring of string
  | P2Tfloat of float
  | P2Tempty of ()
  | P2Tcon of ( // constructor pattern
      d2con, s2vararglst, int(*npf*), p2atlst
    ) // end of [P2Tcon]
  | P2Tlist of (int(*npf*), p2atlst)
  | P2Tlst of (p2atlst)
  | P2Ttup of (int(*knd*), int(*npf*), p2atlst)
(*
  | P2Trec of (int(*knd*), int(*npf*), labp2atlst)
*)
  | P2Tann of (p2at, s2exp) // ascribed pattern
//
  | P2Terr of () // HX: placeholder for indicating an error
// end of [p2at_node]

where
p2at = '{
  p2at_loc= location
, p2at_svs= lstord (s2var)
, p2at_dvs= lstord (d2var)
(*
, p2at_typ= ref@ (s2expopt)
*)
, p2at_node= p2at_node
}
and p2atlst = List (p2at)
and p2atopt = Option (p2at)

(* ****** ****** *)

fun p2atlst_svs_union (p2ts: p2atlst): lstord (s2var)
fun p2atlst_dvs_union (p2ts: p2atlst): lstord (d2var)

(* ****** ****** *)

fun p2at_make (
  loc: location
, svs: lstord (s2var), dvs: lstord (d2var)
, node: p2at_node
) : p2at // end of [p2at_make]

fun p2at_any (loc: location): p2at
fun p2at_anys (loc: location): p2at

fun p2at_var (
  loc: location, refknd: int, d2v: d2var
) : p2at // end of [p2at_var]

fun p2at_bool (loc: location, b: bool): p2at

fun p2at_char (loc: location, c: char): p2at
fun p2at_c0har (loc: location, tok: c0har): p2at

fun p2at_empty (loc: location): p2at

fun p2at_con (
  loc: location
, d2c: d2con, sarg: s2vararglst, npf: int, darg: p2atlst
) : p2at // end of [p2at_con]

fun p2at_list // HX: flat tuple
  (loc: location, npf: int, p2ts: p2atlst): p2at
// end of [p2at_list]

fun p2at_tup (
  loc: location, knd: int, npf: int, p2ts: p2atlst
) : p2at // end of [p2at_tup]

fun p2at_ann (loc: location, p2t: p2at, s2e: s2exp): p2at

fun p2at_err (loc: location): p2at

(* ****** ****** *)

datatype
d2ecl_node =
  | D2Cnone of () // for something already erased
  | D2Clist of d2eclist // for list of declarations
//
  | D2Cstavars of s2tavarlst // for [stavar] declarations
  | D2Csaspdec of s2aspdec (* for static assumption *)
  | D2Cextype of (string(*name*), s2exp(*def*))
//
  | D2Cdatdec of (int(*knd*), s2cstlst) // datatype declarations
  | D2Cexndec of (d2conlst) // exception constructor declarations
//
  | D2Cdcstdec of (dcstkind, d2cstlst) // dyn. const. declarations
//
  | D2Cvaldecs of (valkind, v2aldeclst) // (nonrec) value declarations
//
  | D2Cinclude of d2eclist (* file inclusion *)
  | D2Cstaload of (
      symbolopt(*id*), filename, int(*loadflag*), int(*loaded*), filenv
    ) // end of [D2staload]
// end of [d2ecl_node]

and
d2exp_node =
  | D2Ebool of bool (* boolean values *)
//
  | D2Ei0nt of i0nt
  | D2Ec0har of c0har
  | D2Ef0loat of f0loat
  | D2Es0tring of s0tring
//
  | D2Eempty of ()
  | D2Etup of (int(*knd*), int(*npf*), d2explst)
  | D2Elet of (d2eclist, d2exp) // let-expression
  | D2Ewhere of (d2exp, d2eclist) // where-expression
  | D2Eann_type of (d2exp, s2exp) // ascribled expression
// end of [d2exp_node]

where
d2ecl = '{
  d2ecl_loc= location, d2ecl_node= d2ecl_node
}
and d2eclist = List (d2ecl)

and
d2exp = '{
  d2exp_loc= location, d2exp_node= d2exp_node
}
and d2explst = List (d2exp)
and d2expopt = Option (d2exp)

(* ****** ****** *)

and v2aldec = '{
  v2aldec_loc= location
, v2aldec_pat= p2at
, v2aldec_def= d2exp
, v2aldec_ann= s2expopt
} // end of [v2aldec]

and v2aldeclst = List v2aldec

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

fun d2exp_make
  (loc: location, node: d2exp_node): d2exp
// end of [d2exp_make]

fun d2exp_i0nt (loc: location, x: i0nt): d2exp
fun d2exp_c0har (loc: location, x: c0har): d2exp
fun d2exp_f0loat (loc: location, x: f0loat): d2exp
fun d2exp_s0tring (loc: location, x: s0tring): d2exp

fun d2exp_empty (loc: location): d2exp

fun d2exp_tup (
  loc: location, knd: int, npf: int, d2es: d2explst
) : d2exp // end of [d2exp_tup]

fun d2exp_let
  (loc: location, d2cs: d2eclist, body: d2exp): d2exp
// end of [d2exp_let]

fun d2exp_where
  (loc: location, body: d2exp, d2cs: d2eclist): d2exp
// end of [d2exp_where]

fun d2exp_ann_type (loc: location, d2e: d2exp, ann: s2exp): d2exp

(* ****** ****** *)

fun v2aldec_make (
  loc: location, p2t: p2at, def: d2exp, ann: s2expopt
) : v2aldec // end of [v2aldec_make]

(* ****** ****** *)
//
// HX: various declarations
//
(* ****** ****** *)

fun d2ecl_none (loc: location): d2ecl
fun d2ecl_list (loc: location, xs: d2eclist): d2ecl

fun d2ecl_stavars (loc: location, xs: s2tavarlst): d2ecl

fun d2ecl_saspdec (loc: location, dec: s2aspdec): d2ecl

fun d2ecl_extype (loc: location, name: string, def: s2exp): d2ecl

fun d2ecl_datdec (
  loc: location, knd: int, s2cs: s2cstlst
) : d2ecl // end of [d2ecl_datdec]
fun d2ecl_exndec (loc: location, d2cs: d2conlst): d2ecl

fun d2ecl_dcstdec (
  loc: location, knd: dcstkind, d2cs: d2cstlst
) : d2ecl // end of [d2ecl_dcstdec]

fun d2ecl_valdecs (
  loc: location, knd: valkind, d2cs: v2aldeclst
) : d2ecl // end of [d2ecl_valdecs]

fun d2ecl_include (loc: location, d2cs: d2eclist): d2ecl

fun d2ecl_staload (
  loc: location
, idopt: symbolopt
, fil: filename, loadflag: int, loaded: int, fenv: filenv
) : d2ecl // end of [d2ecl_staload]

(* ****** ****** *)

(* end of [pats_dynexp2.sats] *)
