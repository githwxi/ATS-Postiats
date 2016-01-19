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
//
staload
S1E = "./pats_staexp1.sats"
//
overload fprint with $S1E.fprint_e1xp
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

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
val () = fprint! (out, loc0, ": error(codegen2): #codegen2()\n")
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
val () = fprint! (out, loc0, ": error(codegen2): #codegen2(", x, ", ...)\n")
val () = fprint! (out, "*)\n")
//
} (* end of [auxerr_cons] *)

in (* in-of-local *)

implement
codegen2_process
  (out, d2c0) = let
//
(*
val () =
println!
  ("codegen2_process: d2c0 = ", d2c0)
*)
//
macdef datcon_test = datcon_test_e1xp
macdef datcontag_test = datcontag_test_e1xp
//
macdef fprint_test = fprint_test_e1xp
//
val-D2Ccodegen(knd, xs) = d2c0.d2ecl_node
//
in
//
case+ xs of
//
| list_cons
    (x, xs) =>
  (
  case+ x of
  | _ when
      datcon_test(x) =>
      codegen2_datcon(out, d2c0, xs)
  | _ when
      datcontag_test(x) =>
      codegen2_datcontag(out, d2c0, xs)
  | _ when
      fprint_test(x) =>
      codegen2_fprint(out, d2c0, xs)
  | _ (*unrecognized*) => auxerr_cons(out, d2c0, x)
  )
//
| list_nil((*void*)) => auxerr_nil(out, d2c0)
//
end // end of [codegen2_process]

end // end of [local]

(* ****** ****** *)

implement
d2eclist_codegen_out
  (out, d2cs) = let
//
(*
val () =
  println! ("d2eclist_codegen_out")
*)
//
fun
aux
(
  d2c0: d2ecl
) :<cloref1> void =
(
case+
d2c0.d2ecl_node
of // case+
| D2Ccodegen
    (knd, _) =>
  (
    if knd <= 2
      then codegen2_process(out, d2c0) else ()
    // end of [if]
  ) (* D2Ccodegen *)
//
| D2Clist(d2cs) => auxlst (d2cs)
//
| D2Clocal(_, d2cs_body) => auxlst (d2cs_body)
//
| _(*rest-of-d2ecl*) => ()
)
//
and
auxlst
(
  d2cs: d2eclist
) :<cloref1> void =
(
//
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) => (aux(d2c); auxlst(d2cs))
//
) (* end of [auxlst] *)
//
in
  auxlst (d2cs)
end // end of [d2eclist_codegen_out]

(* ****** ****** *)

(* end of [pats_codegen2.dats] *)
