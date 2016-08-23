(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: August, 2016
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
//
staload SYM = "./pats_symbol.sats"
//
(* ****** ****** *)
//
staload S1E = "./pats_staexp1.sats"
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
  out, loc0
, ": error(codegen2): absrec: no spec on typedef is given\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
//
} (* end of [auxerr_nil] *)

fun
auxerr_s2cst
(
  out: FILEref, d2c0: d2ecl
) : void = {
//
val loc0 = d2c0.d2ecl_loc
//
val () = fprint! (out, "(*\n")
//
val () =
fprint! (
  out, loc0
, ": error(codegen2): absrec: no typedef of the given spec\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
//
} (* end of [auxerr_s2cst] *)

fun
aux_tydef
(
  out: FILEref
, d2c0: d2ecl
, s2def: s2cst, xs: e1xplst
) : void = let
//
// (*
val () =
println! (
//
"aux_tydef: s2def = ", s2def
//
) (* println! *)
// *)
//
in
  // nothing
end (* end of [aux_tydef] *)

in (* in-of-local *)

implement
codegen2_absrec
  (out, d2c0, xs) = let
//
val () =
println!
  ("codegen2_absrec: d2c0 = ", d2c0)
//
in
//
case+ xs of
| list_nil() => 
    auxerr_nil(out, d2c0)
  // end of [list_nil]
| list_cons(x, xs) => let
    val opt = codegen2_get_tydef(x)
  in
    case+ opt of
    | ~None_vt() => auxerr_s2cst(out, d2c0)
    | ~Some_vt(s2c) => aux_tydef(out, d2c0, s2c, xs)
  end // end of [list_cons]
//
end // end of [codegen2_absrec]

end // end of [local]

(* ****** ****** *)

(* end of [pats_codegen2_absrec.dats] *)
