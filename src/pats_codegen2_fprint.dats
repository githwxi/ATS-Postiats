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
UN =
"prelude/SATS/unsafe.sats"
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
staload "./pats_trans2_env.sats"
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
, ": error(codegen2): no datatype of the given spec\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
//
} (* end of [auxerr_s2cst] *)

fun
auxerr_d2cst
(
  out: FILEref, d2c0: d2ecl, s2dat: s2cst
) : void = {
//
val loc0 = d2c0.d2ecl_loc
//
val () = fprint! (out, "(*\n")
//
val () =
fprint! (
  out, loc0
, ": error(codegen2): no fprint-function of the given spec\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
//
} (* end of [auxerr_d2cst] *)

fun
aux_datype
(
  out: FILEref
, d2c0: d2ecl, s2dat: s2cst, xs: e1xplst
) : void = let
//
fun
auxfun1
(
  s2dat: s2cst
) : Option_vt(d2cst) = let
//
val sym = s2cst_get_sym(s2dat)
val name = $SYM.symbol_get_name(sym)
val d2cf =
  $UN.castvwtp0{string}(sprintf("fprint_%s", @(name)))
val d2cf = $SYM.symbol_make_string(d2cf)
//
in
//
case+
the_d2expenv_find(d2cf)
of // case+
| ~None_vt() => None_vt()
| ~Some_vt(d2i) =>
  (
    case+ d2i of
    | D2ITMcst(d2cf) => Some_vt(d2cf) | _ => None_vt()
  ) (* end of [Some_vt] *)
//  
end // end of [auxfun1]
//
fun
auxfun2
(
  s2dat: s2cst, xs: e1xplst
) : Option_vt(d2cst) =
(
case+ xs of
| list_nil() => auxfun1(s2dat)
| list_cons(x, _) => codegen2_get_d2cst(x)
)
//
val opt = auxfun2(s2dat, xs)
val xs2 =
(
  case+ xs of
  | list_nil() => xs | list_cons(_, xs) => xs
) : e1xplst // end of [val]
//
//
in
//
case+ opt of
| ~None_vt() =>
    auxerr_d2cst(out, d2c0, s2dat)
  // end of [None_vt]
| ~Some_vt(d2cf) =>
    aux_datype_d2cf(out, d2c0, s2dat, d2cf, xs2)
  // end of [Some_vt]
//
end (* end of [aux_datype] *)

and
aux_datype_d2cf
(
  out: FILEref
, d2c0: d2ecl, s2dat: s2cst, d2cf: d2cst, xs: e1xplst
) : void = let
//
val
fname = d2cst_get_name(d2cf)
//
fun
auxcon
(
  d2c: d2con
) :<cloref1> void = let
//
val cname = d2con_get_name(d2c)
//
val () =
fprint! (out, "| ", cname, " _ => ")
//
val () = fprint! (out, fname, "$", cname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val () = fprintln! (out, "(out, arg0)")
//
in
  // nothing
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
val-
Some(d2cs) =
s2cst_get_dconlst(s2dat)
//
val
linesep =
"(* ****** ****** *)"
//
val () =
fprint!
  (out, linesep, "\n//\n")
val () =
fprint! (out, "implement\n")
//
val () =
  codegen2_emit_tmpcstimp(out, d2cf)
val () =
  if d2cst_is_tmpcst(d2cf) then fprintln! (out)
//
val () =
fprint! (out, fname)
//
val () =
fprint! (out, "\n  ")
val () =
fprintln! (out, "(out, arg0) =")
//
val () =
fprint! (out, "(\n")
val () =
fprintln! (out, "case+ arg0 of")
//
val () = auxconlst (d2cs) // clauses
//
val () = fprint! (out, ")\n")
val () =
fprintln! (out, "//\n", linesep)
//
in
  // nothing
end // end of [aux_datype_d2cf]

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
    | ~None_vt() => auxerr_s2cst(out, d2c0)
    | ~Some_vt(s2c) => aux_datype(out, d2c0, s2c, xs)
  end // end of [list_cons]
//
end // end of [codegen2_fprint]

end // end of [local]

(* ****** ****** *)

(* end of [pats_codegen2_fprint.dats] *)
