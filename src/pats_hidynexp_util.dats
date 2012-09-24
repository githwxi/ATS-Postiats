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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2012
//
(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

local

fun hidexplst_is_value
  (xs: hidexplst): bool =
  list_forall_fun (xs, hidexp_is_value)
// end of [hidexplst_is_value]

fun labhidexplst_is_value
  (lxs: labhidexplst): bool = let
//
fun ftest (lx: labhidexp) = let
  val LABHIDEXP (l, x) = lx in hidexp_is_value (x)
end // end of [fun]
//
in
  list_forall_fun (lxs, ftest)
end // end of [labhidexplst_is_value]

in // in of [local]

implement
hidexp_is_value
  (hde0) = case+ hde0.hidexp_node of
//
  | HDEvar _ => true
  | HDEcst _ => true
//
  | HDEbool _ => true
  | HDEchar _ => true
  | HDEstring _ => true
//
  | HDEi0nt _ => true
  | HDEf0loat _ => true
//
  | HDEextval _ => true
//
  | HDElam _ => true
  | HDErec (_, lhdes, _) => labhidexplst_is_value (lhdes)
//
  | HDEtmpcst _ => true
  | HDEtmpvar _ => true
//
  | _ => false
// end of [hidexp_is_value]

end // end of [local]

(* ****** ****** *)

implement
hidexp_let_simplify
  (loc, hse, hids, hde) = hidexp_let (loc, hse, hids, hde)

(* ****** ****** *)

(* end of [pats_hidynexp_util.dats] *)
