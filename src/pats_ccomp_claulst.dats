(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: January, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

(*
datatype
p2atcst =
  | P2TCany of ()
  | P2TCcon of (d2con, p2atcstlst)
  | P2TCempty of ()
  | P2TCint of intinf
  | P2TCbool of bool
  | P2TCchar of char
  | P2TCstring of string
  | P2TCfloat of string(*rep*)
  | P2TCrec of (int(*reckind*), labp2atcstlst)
  | P2TCintc of intinfset
// end of [p2atcst]
*)
datavtype
patcomp =
  | PTCMPnil of ()
  | PTCMPany of (patcomp)
  | PTCMPcon of (d2con, patcomplst)
  | PTCMPsum of (patcomplst)
  | P2TCrec of (int(*reckind*), labpatcomplst)
// end of [patcomp]

and
labpatcomp =
  | LABPATCOMP of ($LAB.label, patcomp)
// end of [labpatcomp]

where
patcomplst = List_vt (patcomp)

and
labpatcomplst = List_vt (labpatcomp)

(* ****** ****** *)

implement
hiclaulst_ccomp (
  env, pmvs, hicls, tmpret, fail
) = let
in
  list_nil
end // end of [hiclaulst_ccomp]

(* ****** ****** *)

(* end of [pats_ccomp_claulst.dats] *)

