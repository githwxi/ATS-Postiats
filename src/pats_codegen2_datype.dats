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
, ": error(codegen2): no spec on datatype is given\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
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
  out, loc0
, ": error(codegen2): no datatype of the given spec\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
//
} (* end of [auxerr_cons] *)

fun
aux_datype
(
  out: FILEref
, d2c0: d2ecl, s2dat: s2cst, xs: e1xplst
) : void = let
//
fun
auxfun0
(
// argless
) :<cloref1> void = let
//
val sym = s2cst_get_sym(s2dat)
val name = $SYM.symbol_get_name(sym)
//
in
  fprint! (out, "datcon_", name, "_")
end // end of [auxfun0]
//
fun
auxfun1
(
  x0: e1xp
) :<cloref1> void =
(
case+
x0.e1xp_node
of // case+
| $S1E.E1XPide(sym) =>
    $SYM.fprint_symbol (out, sym)
  // end of [E1XPide]
| $S1E.E1XPstring(name) => fprint (out, name)
| _(*rest-of-e1xp*) => auxfun0((*void*))
)
//
fun
auxcon
(
  d2c: d2con
) :<cloref1> void = let
//
val sym = d2con_get_sym(d2c)
val name = $SYM.symbol_get_name(sym)
//
in
  fprintln! (out, "| ", name, " _ => \"", name, "\"")
end // end of [auxcon]
//
fun
auxconlst
(
  d2cs: d2conlst
) :<cloref1> void =
(
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) =>
  let val () = auxcon(d2c) in auxconlst(d2cs) end
)
//
val name = s2cst_get_name(s2dat)
val-Some(d2cs) = s2cst_get_dconlst(s2dat)
//
(*
val () =
println!
  ("codegen2_datcon: aux_datype: s2dat = ", s2dat)
val () =
println!
  ("codegen2_datcon: aux_datype: d2conlst = ", d2cs)
*)
//
val
linesep =
"(* ****** ****** *)\n"
//
val () =
fprint!
  (out, linesep, "//\n")
val () =
fprint! (out, "implement\n")
val () =
fprint! (out, "{}(*tmp*)\n")
val () =
(
case+ xs of
| list_nil() => auxfun0()
| list_cons(x, _) => auxfun1(x)
)
val () =
fprint! (out, "\n  ")
val () =
fprint! (out, "(arg0) =\n")
//
val () =
fprint! (out, "(\n")
val () =
fprint! (out, "case+ arg0 of\n")
//
val () = auxconlst (d2cs)
//
val () = fprint! (out, ")\n")
val () =
fprint! (out, "//\n", linesep)
//
in
  // nothing
end // end of [aux_datype]

in (* in-of-local *)

implement
codegen2_datcon
  (out, d2c0, xs) = let
(*
//
val () =
println!
  ("codegen2_datcon: d2c0 = ", d2c0)
//
*)
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
    | ~Some_vt(s2dat) => aux_datype(out, d2c0, s2dat, xs)
  end // end of [list_cons]
//
end // end of [codegen2_datcon]

end // end of [local]

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
, ": error(codegen2): no spec on datatype is given\n"
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
  out, loc0
, ": error(codegen2): no datatype of the given spec\n"
) (* end of [val] *)
//
val () = fprint! (out, "*)\n")
//
} (* end of [auxerr_cons] *)

fun
aux_datype
(
  out: FILEref
, d2c0: d2ecl, s2dat: s2cst, xs: e1xplst
) : void = let
//
fun
auxfun0
(
// argless
) :<cloref1> void = let
//
val sym = s2cst_get_sym(s2dat)
val name = $SYM.symbol_get_name(sym)
//
in
  fprint! (out, "datcontag_", name, "_")
end // end of [auxfun0]
//
fun
auxfun1
(
  x0: e1xp
) :<cloref1> void =
(
case+
x0.e1xp_node
of // case+
| $S1E.E1XPide(sym) =>
    $SYM.fprint_symbol (out, sym)
  // end of [E1XPide]
| $S1E.E1XPstring(name) => fprint (out, name)
| _(*rest-of-e1xp*) => auxfun0((*void*))
)
//
fun
auxcon
(
  d2c: d2con
) :<cloref1> void = let
//
val sym = d2con_get_sym(d2c)
val tag = d2con_get_tag(d2c)
val name = $SYM.symbol_get_name(sym)
//
in
  fprintln! (out, "| ", name, " _ => ", tag)
end // end of [auxcontag]
//
fun
auxconlst
(
  d2cs: d2conlst
) :<cloref1> void =
(
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) =>
  let val () = auxcon(d2c) in auxconlst(d2cs) end
)
//
val name = s2cst_get_name(s2dat)
val-Some(d2cs) = s2cst_get_dconlst(s2dat)
//
(*
val () =
println!
  ("codegen2_datcontag: aux_datype: s2dat = ", s2dat)
val () =
println!
  ("codegen2_datcontag: aux_datype: d2conlst = ", d2cs)
*)
//
val
linesep =
"(* ****** ****** *)\n"
//
val () =
fprint!
  (out, linesep, "//\n")
//
val () =
fprint! (out, "implement\n")
val () =
fprint! (out, "{}(*tmp*)\n")
val () =
(
case+ xs of
| list_nil() => auxfun0()
| list_cons(x, _) => auxfun1(x)
)
val () =
fprint! (out, "\n  ")
val () =
fprint! (out, "(arg0) =\n")
//
val () =
fprint! (out, "(\n")
val () =
fprint! (out, "case+ arg0 of\n")
//
val () = auxconlst (d2cs)
//
val () = fprint! (out, ")\n")
val () =
fprint! (out, "//\n", linesep)
//
in
  // nothing
end // end of [aux_datype]

in (* in-of-local *)

implement
codegen2_datcontag
  (out, d2c0, xs) = let
(*
//
val () =
println!
  ("codegen2_datcontag: d2c0 = ", d2c0)
//
*)
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
    | ~Some_vt(s2dat) => aux_datype(out, d2c0, s2dat, xs)
  end // end of [list_cons]
//
end // end of [codegen2_datcontag]

end // end of [local]

(* ****** ****** *)

(* end of [pats_codegen2_datype.dats] *)
