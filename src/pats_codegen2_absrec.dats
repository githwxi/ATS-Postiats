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
//
datatype
absrecfd =
//
  | ABSRECFDget of s2exp
  | ABSRECFDset of s2exp
  | ABSRECFDgetset of s2exp
//
  | ABSRECFDexch of s2exp
//
  | ABSRECFDvtget of s2exp
//
  | ABSRECFDgetref of s2exp
//
  | ABSRECFDunknown of s2exp
//
(* ****** ****** *)
//
extern
fun
absrecfd_of_s2exp
  (s2e0: s2exp): absrecfd
//
implement
absrecfd_of_s2exp
  (s2e0) = let
//
macdef
is_get(name) = (,(name) = "get")
macdef
is_set(name) =  (,(name) = "set")
macdef
is_getset(name) = (,(name) = "getset")
//
macdef
is_exch(name) = (,(name) = "exch")
//
macdef
is_vtget(name) = (,(name) = "vtget")
//
macdef
is_getref(name) = (,(name) = "getref")
//
in
//
case+
s2e0.s2exp_node of
| S2Eapp
  (
    s2e1, list_nil()
  ) => ABSRECFDunknown(s2e0)
| S2Eapp
  (
    s2e1, list_cons(s2e2, _)
  ) => (
    case+
    s2e1.s2exp_node
    of // case+
    | S2Ecst(s2c1) => let
        val sym =
          s2cst_get_sym(s2c1)
        val name =
          $SYM.symbol_get_name(sym)
        // end of [val]
      in
        case+ 0 of
//
        | _ when
            is_get(name) => ABSRECFDget(s2e2)
        | _ when
            is_set(name) => ABSRECFDset(s2e2)
        | _ when
            is_getset(name) => ABSRECFDgetset(s2e2)
//
        | _ when
            is_exch(name) => ABSRECFDexch(s2e2)
        | _ when
            is_vtget(name) => ABSRECFDvtget(s2e2)
        | _ when
            is_getref(name) => ABSRECFDvtget(s2e2)
//
        | _(* unrecognized *) => ABSRECFDunknown(s2e0)
//
      end (* end of [S2Ecst] *)
    | _(*non-S2Ecst*) => ABSRECFDunknown(s2e0)
  )
| _(*non-S2Eapp*) => ABSRECFDunknown(s2e0)
//
end // end of [absrecfd_of_s2exp]
//
(* ****** ****** *)
//
extern
fun
emit_absrecfd
(
  out: FILEref, tnm: string, fd: absrecfd
) : void // end of [emit_absrecfd]
//
(* ****** ****** *)
//
extern
fun
s2cst_get_tyrec
  (s2c0: s2cst): s2expopt_vt
//
implement
s2cst_get_tyrec
  (s2c0) = let
//
fun
auxget
(
  s2e0: s2exp
) : s2expopt_vt =
(
case+
s2e0.s2exp_node
of // case+
| S2Etyrec _ => Some_vt(s2e0)
| S2Euni(s2vs, s2ps, s2e_body) => auxget(s2e_body)
| _(*rest-of-s2exp*) => None_vt(*void*)
)
//
val-
Some(s2e0) = s2cst_get_def(s2c0)
//
in
  auxget(s2e0)
end // end of [s2cst_get_tyrec]

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
auxerr_s2cst_tyrec
(
  out: FILEref, d2c0: d2ecl, s2c: s2cst
) : void = {
//
val loc0 = d2c0.d2ecl_loc
//
val () = fprint! (out, "(*\n")
//
val () =
fprint! (
  out, loc0
, ": error(codegen2): absrec: [", s2c, "] does not refer to a record\n"
) (* end of [val] *)
//
val () = fprintln! (out, "*)")
//
} (* end of [auxerr_s2cst_tyrec] *)

fun
aux_tydef
(
  out: FILEref
, d2c0: d2ecl
, s2c0: s2cst, xs: e1xplst
) : void = let
//
// (*
val () =
println! (
//
"aux_tydef: s2c0 = ", s2c0
//
) (* println! *)
// *)
//
val opt = s2cst_get_tyrec(s2c0)
//
in
//
case+ opt of
| ~None_vt() => auxerr_s2cst_tyrec(out, d2c0, s2c0)
| ~Some_vt(s2e_def) => aux_tydef_tyrec(out, d2c0, s2c0, s2e_def, xs)
//
end (* end of [aux_tydef] *)

and
aux_tydef_tyrec
(
  out: FILEref
, d0c0: d2ecl
, s2c0: s2cst
, s2e_def: s2exp, xs: e1xplst
) : void = let
//
val () =
println!
(
  "aux_tydef_tyrec: s2e_def = ", s2e_def
) (* println! *)
//
in
  // nothing
end // end of [aux_tydef_tyrec]

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
