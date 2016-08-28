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
LAB = "./pats_label.sats"
//
overload
fprint with $LAB.fprint_label
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
staload "./pats_staexp1.sats"
//
(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
//
(* ****** ****** *)

staload "./pats_codegen2.sats"

(* ****** ****** *)

fun
s2cst_get_name
  (s2c: s2cst): string =
(
  $SYM.symbol_get_name(s2cst_get_sym(s2c))
) (* end of [s2cst_get_name] *)

(* ****** ****** *)
//
datatype
absrecfld =
//
  | ABSRECFLDget of s2exp
  | ABSRECFLDset of s2exp
  | ABSRECFLDgetset of s2exp
//
  | ABSRECFLDexch of s2exp
//
  | ABSRECFLDvtget of s2exp
//
  | ABSRECFLDgetref of s2exp
//
  | ABSRECFLDunknown of s2exp
//
(* ****** ****** *)
//
extern
fun
absrecfld_of_s2exp
  (s2e0: s2exp): absrecfld
//
implement
absrecfld_of_s2exp
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
  ) => ABSRECFLDunknown(s2e0)
| S2Eapp
  (
    s2e1, list_cons(s2e2, _)
  ) => (
    case+
    s2e1.s2exp_node
    of // case+
    | S2Ecst(s2c1) => let
        val name = s2cst_get_name(s2c1)
      in
        case+ 0 of
//
        | _ when
            is_get(name) => ABSRECFLDget(s2e2)
        | _ when
            is_set(name) => ABSRECFLDset(s2e2)
        | _ when
            is_getset(name) => ABSRECFLDgetset(s2e2)
//
        | _ when
            is_exch(name) => ABSRECFLDexch(s2e2)
//
        | _ when
            is_vtget(name) => ABSRECFLDvtget(s2e2)
//
        | _ when
            is_getref(name) => ABSRECFLDvtget(s2e2)
//
        | _(* unrecognized *) => ABSRECFLDunknown(s2e0)
//
      end (* end of [S2Ecst] *)
    | _(*non-S2Ecst*) => ABSRECFLDunknown(s2e0)
  )
| _(*non-S2Eapp*) => ABSRECFLDunknown(s2e0)
//
end // end of [absrecfld_of_s2exp]
//
(* ****** ****** *)
//
extern
fun
emit_tyrecfld
(
  out: FILEref
, s2c0: s2cst, tnm: string, ls2e: labs2exp
) : void // end of [emit_tyrecfld]
//
implement
emit_tyrecfld
(
  out, s2c0, tnm, ls2e
) = let
//
val
SLABELED
  (l0, _, s2e) = ls2e
//
val
fld = absrecfld_of_s2exp(s2e)
//
fun
auxproc
(
  fld: absrecfld
) :<cloref1> void =
(
case+ fld of
//
| ABSRECFLDget(s2e) =>
  {
    val () = fprint!(out, "fun{}\n")
    val () = fprint!(out, tnm, "_get_", l0)
    val () = fprint!(out, ": (", s2c0, ") -<> (", s2e, ")\n")
    val () =
    fprint!
      (out, "overload ", ".", l0, " with ", tnm, "_get_", l0, "\n")
    // end of [fprint!]
    val ((*void*)) = fprint_newline(out)
  }
//
| ABSRECFLDset(s2e) =>
  {
    val () = fprint!(out, "fun{}\n")
    val () = fprint!(out, tnm, "_set_", l0)
    val () = fprint!(out, ": (", s2c0, ", ", s2e, ") -<ref> void\n")
    val () =
    fprint!
      (out, "overload ", ".", l0, " with ", tnm, "_set_", l0, "\n")
    // end of [fprint!]
    val ((*void*)) = fprint_newline(out)
  }
//
| ABSRECFLDexch(s2e) =>
  {
    val () = fprint!(out, "fun{}\n")
    val () = fprint!(out, tnm, "_exch_", l0)
    val () = fprint!(out, ": (", s2c0, ", ", s2e, ") -<ref> ", s2e, "\n")
    val ((*void*)) = fprint_newline(out)
  }
//
| _(*rest-of-absrecfld*) => ()
//
)
//
in
//
  auxproc(fld)
//
end (* end of [emit_tyrecfld] *)
//
extern
fun
emit_tyrecfldlst
(
  out: FILEref
, s2c0: s2cst, tnm: string, ls2es: labs2explst
) : void // end of [emit_tyrecfldlst]
//
implement
emit_tyrecfldlst
(
  out, s2c0, tnm, ls2es
) = (
//
case+ ls2es of
| list_nil() => ()
| list_cons(ls2e, ls2es) =>
  {
    val () = emit_tyrecfld(out, s2c0, tnm, ls2e)
    val () = emit_tyrecfldlst(out, s2c0, tnm, ls2es)
  } (* end of [list_cons] *)
//
) (* end of [emit_tyrecfldlst] *)
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
) : s2expopt_vt = let
//
val () =
println!
(
  "s2cst_get_tyrec: auxget: s2e0 = ", s2e0
) (* end of [println!] *)
//
in
//
case+
s2e0.s2exp_node
of // case+
| S2Etyrec _ => Some_vt(s2e0)
| S2Elam(s2vs, s2e) => auxget(s2e)
| S2Eexi(s2vs, s2ps, s2e) => auxget(s2e)
| _(*rest-of-s2exp*) => None_vt(*void*)
//
end // end of [auxget]
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
| ~None_vt() =>
    auxerr_s2cst_tyrec(out, d2c0, s2c0)
| ~Some_vt(s2e_rec) =>
    aux_tydef_tyrec(out, d2c0, s2c0, s2e_rec, xs)
//
end (* end of [aux_tydef] *)

and
aux_tydef_tyrec
(
  out: FILEref
, d0c0: d2ecl
, s2c0: s2cst
, s2e_rec: s2exp, xs: e1xplst
) : void = let
//
val () =
println!
(
  "aux_tydef_tyrec: s2e_rec = ", s2e_rec
) (* println! *)
//
val tnm =
(
//
case+ xs of
| list_nil() =>
    s2cst_get_name(s2c0)
  // list_nil
| list_cons(x0, _) =>
  (
    case+
    x0.e1xp_node
    of // case+
    | E1XPide(id) =>
        $SYM.symbol_get_name(id)
      // E1XPide
    | E1XPstring(name) => name
    | _(*unrecogized*) => s2cst_get_name(s2c0)
  )
//
) : string // end of [val]
//
val-
S2Etyrec
  (knd, npf, ls2es) = s2e_rec.s2exp_node
//
in
  emit_tyrecfldlst(out, s2c0, tnm, ls2es)
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
