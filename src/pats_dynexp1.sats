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
  | D1Ce1xpdef of (symbol, e1xp)
(*
  | D1Cdatsrts of (* datasort declaration *)
      (int(*para: 0/1*), d1atsrtdeclst)
  | D1Csrtdefs of (* sort definition *)
      s1rtdeflst
  | D1Cstacons of (* static constructor *)
      (abskind, s1taconlst)
*)
  | D1Cstacsts of s1tacstlst // static constants
(*
  | D1Cstavars of (* static variable *)
      s1tavarlst
  | D1Csexpdefs of (* static definition *)
      (s1rtopt, s1expdeflst)
  | D1Csaspdec of (* static assumption *)
      s1aspdec
  | D1Cdcstdecs of (* dynamic constant *)
      (dcstkind, s1qualstlst, d1cstdeclst)
  | D1Cdatdecs of (* datatype declaration *)
      (datakind, d1atdeclst, s1expdeflst)
  | D1Cexndecs of (* exception declaration *)
      e1xndeclst
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
  | D1Clocal of (* local declaration *)
      (d1eclst, d1eclst)
  | D1Cdynload of (* dynamic load *)
      fil_t
  | D1Cstaload of (* static load *)
      (Option sym_t, fil_t, int (*loaded*), int (*loadflag*), d1eclst)
*)
// end of [d1ecl_node]

(* ****** ****** *)

where d1ecl = '{
  d1ecl_loc= location, d1ecl_node= d1ecl_node
} // end of [d1ec]

and d1eclist = List (d1ecl)

(* ****** ****** *)

and s1tacst = '{ // static constant declaration
  s1tacst_loc= location
, s1tacst_sym= symbol
, s1tacst_arg= s1rtlstlst
, s1tacst_res= s1rt
} // end of [s1tacst]

and s1tacstlst = List s1tacst

(* ****** ****** *)

fun s1tacst_make (
  loc: location, sym: symbol, arg: s1rtlstlst, res: s1rt
) : s1tacst // end of [s1tacst_make]

fun fprint_s1tacst : fprint_type (s1tacst)

(* ****** ****** *)

fun d1ecl_none (loc: location): d1ecl

fun d1ecl_stacsts (loc: location, ds: s1tacstlst): d1ecl

(* ****** ****** *)

fun fprint_d1ecl : fprint_type (d1ecl)
fun fprint_d1eclist : fprint_type (d1eclist)

(* ****** ****** *)

(* end of [pats_dynexp1.sats] *)
