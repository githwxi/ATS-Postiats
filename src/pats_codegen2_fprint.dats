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
//
staload
LOC = "./pats_location.sats"
//
overload
fprint with $LOC.fprint_location
//
(* ****** ****** *)

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)
//
staload
S1E = "./pats_staexp1.sats"
//
overload fprint with $S1E.fprint_e1xp
//
(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
//
(* ****** ****** *)

staload "./pats_codegen2.sats"

(* ****** ****** *)

local

fun
auxerr_nil
(
  out: FILEref, d2c0: d2ecl
) : void =  {
//
val loc0 = d2c0.d2ecl_loc
//
val () = fprint! (out, "(*\n")
//
val () =
fprint! (
  out, loc0, ": error(codegen2): #codegen2(fprint, ...)\n"
) (* end of [val] *)
//
val () = fprint! (out, "*)\n")
//
} (* end of [auxerr_nil] *)

fun
auxerr_cons
(
  out: FILEref
, d2c0: d2ecl, x: e1xp
) : void =  {
//
val loc0 = d2c0.d2ecl_loc
//
val () = fprint! (out, "(*\n")
//
val () =
fprint! (
  out, loc0, ": error(codegen2): #codegen2(fprint, ", x, ", ...)\n"
) (* end of [val] *)
//
val () = fprint! (out, "*)\n")
//
} (* end of [auxerr_cons] *)

fun
aux_datype
(
  out: FILEref
, d2c0: d2ecl, s2c: s2cst, xs: e1xplst
) : void = let
//
val-Some(d2cs) = s2cst_get_dconlst(s2c)
//
val () =
println!
  ("codegen2_fprint: aux_datype: s2c = ", s2c)
val () =
println!
  ("codegen2_fprint: aux_datype: d2cs = ", d2cs)
//
in
end // end of [aux_datype]

in (* in-of-local *)

implement
codegen2_fprint
  (out, d2c0, xs) = let
//
(*
val () =
println!
  ("codegen2_fprint: d2c0 = ", d2c0)
*)
//
in
//
case+ xs of
| list_nil() =>
    auxerr_nil(out, d2c0)
  // end of [list_nil]
| list_cons(x, xs) => let
    val opt = codegen2_get_datype(x)
  in
    case+ opt of
    | ~None_vt() => auxerr_cons(out, d2c0, x)
    | ~Some_vt(s2c) => aux_datype(out, d2c0, s2c, xs)
  end // end of [list_cons]
//
end // end of [codegen2_fprint]

end // end of [local]

(* ****** ****** *)

(* end of [pats_codegen2_fprint.dats] *)
