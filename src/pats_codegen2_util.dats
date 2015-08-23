(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: August, 2015
//
(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"

(* ****** ****** *)
//
staload "./pats_staexp1.sats"
//
staload "./pats_staexp2.sats"
//
staload "./pats_trans2_env.sats"
//
(* ****** ****** *)

staload "./pats_codegen2.sats"

(* ****** ****** *)

local

fun
aux_test
(
  x0: e1xp, name: string
) : bool = (
//
case+
x0.e1xp_node
of // case+
| E1XPide(id2) =>
  (
    name = $SYM.symbol_get_name(id2)
  ) (* end of [E1XPide] *)
| E1XPstring(name2) => (name = name2)
//
| _ (*rest-of-e1xp*) => false
//
) (* end of [aux_test] *)

in (* in-of-local *)

implement
datcon_test_e1xp(x0) = aux_test(x0, "datcon")
implement
fprint_test_e1xp(x0) = aux_test(x0, "fprint")

end // end of [local]

(* ****** ****** *)

local

fun
aux_find
(
  name: symbol
) : Option_vt(s2cst) = let
//
val ans = the_s2expenv_find (name)
//
in
//
case+ ans of
//
| ~Some_vt(s2i) => (
  case+ s2i of
  | S2ITMcst(s2cs) =>
    (
      case+ s2cs of
      | list_cons(s2c, _) => Some_vt(s2c) | list_nil() => None_vt()
    )
  | _ (*non-S2ITMcst*) => None_vt()
  ) (* end of [Some_vt] *)
//
| ~None_vt((*void*)) => None_vt()
//
end // end of [aux_find]

in (* in-of-local *)

implement
codegen2_get_s2cst
  (x0) = let
(*
//
val () =
println!
  ("codegen2_get_s2cst: x0 = ", x0)
//
*)
in
//
case+
x0.e1xp_node
of // case+
//
| E1XPide(name) => aux_find(name)
//
| _(*rest-of-e1xp*) => None_vt((*void*))
//
end // end of [codegen2_get_s2cst]

end // end of [local]

(* ****** ****** *)

implement
codegen2_get_datype
  (x0) = let
//
val opt = codegen2_get_s2cst(x0)
//
in
//
case+ opt of
| Some_vt(s2c) =>
  (
    if s2cst_is_datype(s2c)
      then (fold@{s2cst}(opt); opt)
      else (free@{s2cst}(opt); None_vt())
  ) (* end of [Some_vt] *)
| ~None_vt((*void*)) => None_vt()
//
end // end of [codegen2_get_datype]

(* ****** ****** *)

(* end of [pats_codegen2_util.dats] *)
