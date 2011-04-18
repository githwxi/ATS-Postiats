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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_syntax.sats"
staload "pats_staexp1.sats"

(* ****** ****** *)

typedef fprint_type (a:t@ype) = (FILEref, a) -> void

(* ****** ****** *)

datatype d1ecl_node =
  | D1Cnone
  | D1Clist of d1eclist
  | D1Cinclude of d1eclist (* inclusion *)
  | D1Csymintr of (* overloaded symbol intr *)
      i0delst
  | D1Csymelim of (* overloaded symbol elim *)
      i0delst
//
  | D1Ce1xpdef of (symbol, e1xp)
  | D1Ce1xpundef of (symbol) // HX: undefining
//
  | D1Cdatsrts of d1atsrtdeclst // datasorts
  | D1Csrtdefs of s1rtdeflst // sort definitions
  | D1Cstacsts of s1tacstlst // static constants
  | D1Cstacons of (int(*knd*), s1taconlst) // static constructors
  | D1Cstavars of s1tavarlst // static variables
  | D1Csexpdefs of (int(*knd*), s1expdeflst) // static definitions
  | D1Csaspdec of s1aspdec // static assumption
//
  | D1Cdatdecs of (int(*knd*), d1atdeclst, s1expdeflst) // DT declarations
  | D1Cexndecs of e1xndeclst // exception declaration
  | D1Cdcstdecs of (dcstkind, q1marglst, d1cstdeclst) // dyn constants
//
(*
  | D1Cclassdec of (i0de, s1expopt)
  | D1Coverload of (i0de, dqi0de) // overloading declaration
  | D1Cextype of (* external type *)
      (string (* extype name *), s1exp (* extype definition *))
  | D1Cextval of (* external type *)
      (string (* extval name *), d1exp (* extval definition *))
  | D1Cextcode of (* external code *)
      (int (*position: 0/1/2 : top/?/end*), string (*code*))
  | D1Cvaldecs of (* value declaration *)
      (valkind, v1aldeclst)
  | D1Cvaldecs_par of (* parallel value declaration *)
      v1aldeclst
  | D1Cvaldecs_rec of (* recursive value declaration *)
      v1aldeclst
  | D1Cfundecs of (* function declaration *)
      (funkind, s1qualstlst, f1undeclst)
  | D1Cvardecs of (* variable declaration *)
      v1ardeclst
  | D1Cmacdefs of (* macro declaration *)
      (int (*long/short*), m1acdeflst)
  | D1Cimpdec of (* implementation *)
      (s1arglstlst, i1mpdec)
*)
  | D1Clocal of (* local declaration *)
      (d1eclist, d1eclist)
  | D1Cdynload of (* dynloading a file *)
      filename
  | D1Cstaload of (* staloading a file *)
      (Option symbol, filename, int (*loaded*), int (*loadflag*), d1eclist)
// end of [d1ecl_node]

(* ****** ****** *)

where d1ecl = '{
  d1ecl_loc= location, d1ecl_node= d1ecl_node
} // end of [d1ec]

and d1eclist = List (d1ecl)

(* ****** ****** *)

fun d1ecl_none (loc: location): d1ecl

fun d1ecl_list (loc: location, ds: d1eclist): d1ecl

fun d1ecl_e1xpdef
  (loc: location, id: symbol, def: e1xp): d1ecl
fun d1ecl_e1xpundef (loc: location, id: symbol): d1ecl

fun d1ecl_datsrts (loc: location, ds: d1atsrtdeclst): d1ecl

fun d1ecl_srtdefs (loc: location, ds: s1rtdeflst): d1ecl

fun d1ecl_stacsts (loc: location, ds: s1tacstlst): d1ecl
fun d1ecl_stacons (loc: location, knd: int, ds: s1taconlst): d1ecl
fun d1ecl_stavars (loc: location, ds: s1tavarlst): d1ecl

fun d1ecl_sexpdefs
  (loc: location, knd: int, ds: s1expdeflst): d1ecl
// end of [d1ecl_sexpdefs]

fun d1ecl_saspdec (loc: location, d: s1aspdec): d1ecl

fun d1ecl_datdecs (
  loc: location, knd: int, ds1: d1atdeclst, ds2: s1expdeflst
) : d1ecl // end of [d1ecl_datdecs]

fun d1ecl_exndecs (loc: location, ds: e1xndeclst): d1ecl

fun d1ecl_dcstdecs (
  loc: location, dck: dcstkind, qarg: q1marglst, ds: d1cstdeclst
) : d1ecl // end of [d1ec_dcstdecs]

fun d1ecl_include (loc: location, ds: d1eclist): d1ecl

fun d1ecl_local (loc: location, ds1: d1eclist, ds2: d1eclist): d1ecl

(* ****** ****** *)

fun fprint_d1ecl : fprint_type (d1ecl)
fun fprint_d1eclist : fprint_type (d1eclist)

(* ****** ****** *)

(* end of [pats_dynexp1.sats] *)
