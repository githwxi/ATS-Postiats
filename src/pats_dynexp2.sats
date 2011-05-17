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

staload "pats_basics.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location

staload FIL = "pats_filename.sats"
typedef filename = $FIL.filename

staload SYN = "pats_syntax.sats"
typedef dcstextdef = $SYN.dcstextdef

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"

(* ****** ****** *)

abstype d2var_type
typedef d2var = d2var_type
typedef d2varlst = List (d2var)

abstype d2cst_type
typedef d2cst = d2cst_type
typedef d2cstlst = List (d2cst)

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

fun d2cst_make (
  id: symbol
, loc: location
, fil: filename
, dck: dcstkind
, decarg: s2qualstlst
, arilst: List int
, typ: s2exp
, extdef: dcstextdef
) : d2cst // end of [d2cst_make]

(* ****** ****** *)

fun d2cst_get_loc (x: d2cst): location
fun d2cst_get_fil (_: d2cst): filename
fun d2cst_get_sym (x: d2cst): symbol
fun d2cst_get_kind (x: d2cst): dcstkind
fun d2cst_get_arilst (x: d2cst): List int
fun d2cst_get_decarg (x: d2cst): s2qualst
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
  | P2Tlist of (int(*npf*), p2atlst)
  | P2Tlst of (p2atlst)
(*
  | P2Trec of (int(*knd*), int(*npf*), labp2atlst)
*)
  | P2Tann of (p2at, s2exp) // ascribed pattern
// end of [p2at_node]

where
p2at = '{
  p2at_loc= location
(*
, p2at_svs= s2varlstord_t
, p2at_dvs= d2varlstord_t
, p2at_typ= ref@ (s2expopt)
*)
, p2at_node= p2at_node
}
and p2atlst = List (p2at)
and p2atopt = Option (p2at)

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
  | D2Cinclude of d2eclist (* file inclusion *)
// end of [d2ecl_node]

and
d2exp_node =
  | D2Ebool of bool (* boolean values *)
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

and s2tavar = '{
  s2tavar_loc= location, s2tavar_var= s2var
}
and s2tavarlst = List s2tavar

(* ****** ****** *)

and s2aspdec = '{
  s2aspdec_loc= location
, s2aspdec_cst= s2cst
, s2aspdec_def= s2exp
} // end of [s2aspdec]

(* ****** ****** *)

fun d2exp_let
  (loc: location, d2cs: d2eclist, body: d2exp): d2exp
// end of [d2exp_let]

fun d2exp_where
  (loc: location, body: d2exp, d2cs: d2eclist): d2exp
// end of [d2exp_where]

fun d2exp_ann_type (loc: location, d2e: d2exp, ann: s2exp): d2exp

(* ****** ****** *)

fun s2tavar_make
  (loc: location, s2v: s2var): s2tavar
// end of [s2tavar_make]

(* ****** ****** *)

fun s2aspdec_make (
  loc: location, s2c: s2cst, def: s2exp
) : s2aspdec // end of [s2aspdec_make]

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

fun d2ecl_include (loc: location, d2cs: d2eclist): d2ecl

(* ****** ****** *)

(* end of [pats_dynexp2.sats] *)
