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

staload "pats_staexp1.sats"
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
  | D2Clist of d2eclist
// end of [d2ecl_node]

and
d2exp_node =
  | D2Ebool of bool (* boolean values *)
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

(* ****** ****** *)

(* end of [pats_dynexp2.sats] *)
