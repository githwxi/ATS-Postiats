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
SYM = "./pats_symbol.sats"
//
overload
fprint with $SYM.fprint_symbol
//
(* ****** ****** *)
//
staload "./pats_staexp1.sats"
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
//
implement
datcon_test_e1xp(x0) = aux_test(x0, "datcon")
implement
datcontag_test_e1xp(x0) = aux_test(x0, "datcontag")
//
implement
fprint_test_e1xp(x0) = aux_test(x0, "fprint")
//
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
(*
| E1XPstring
    (name) => let
    val name2 =
      $SYM.symbol_make_string(name)
    // end of [val]
  in
    aux_find(name2)
  end // end of [E1XPstring]
*)
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
//
| ~None_vt((*void*)) => None_vt()
//
end // end of [codegen2_get_datype]

(* ****** ****** *)

local

fun
aux_find
(
  name: symbol
) : Option_vt(d2cst) = let
//
val ans = the_d2expenv_find (name)
//
in
//
case+ ans of
//
| ~Some_vt(d2i) => (
  case+ d2i of
  | D2ITMcst(d2c) => Some_vt(d2c)
  | _ (*non-D2ITMcst*) => None_vt()
  ) (* end of [Some_vt] *)
//
| ~None_vt((*void*)) => None_vt()
//
end // end of [aux_find]

in (* in-of-local *)

implement
codegen2_get_d2cst
  (x0) = let
(*
//
val () =
println!
  ("codegen2_get_d2cst: x0 = ", x0)
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
(*
| E1XPstring
    (name) => let
    val name2 =
      $SYM.symbol_make_string(name)
    // end of [val]
  in
    aux_find(name2)
  end // end of [E1XPstring]
*)
| _(*rest-of-e1xp*) => None_vt((*void*))
//
end // end of [codegen2_get_d2cst]

end // end of [local]

(* ****** ****** *)

local

fun
aux_s2qua
(
  out: FILEref
, lpar: string, rpar: string, s2q: s2qua
) : void = let
//
fun
auxlst
(
  s2vs: s2varlst
) :<cloref1> void =
(
case+ s2vs of
| list_nil() => ()
| list_cons(s2v, s2vs) =>
  (
    fprint(out, s2var_get_sym(s2v)); auxlst(s2vs)
  )
)
//
in
  fprint(out, lpar); auxlst(s2q.s2qua_svs); fprint(out, rpar)
end // end of [aux_s2qua]

fun
aux_s2qualst
(
  out: FILEref
, lpar: string, rpar: string, s2qs: s2qualst
) : void =
(
case+ s2qs of
| list_nil() => ()
| list_cons
    (s2q, s2qs) => () where
  {
    val () = aux_s2qua(out, lpar, rpar, s2q)
    val () = aux_s2qualst(out, lpar, rpar, s2qs)
  }
) (* end of [aux_s2qualst] *)

in (* in-of-local *)

implement
codegen2_emit_tmpcstapp
  (out, d2cf) = let
//
val s2qs = d2cst_get_decarg(d2cf)
//
in
//
aux_s2qualst(out, "<", ">", s2qs)
//
end // end of [codegen2_emit_tmpcstapp]

implement
codegen2_emit_tmpcstimp
  (out, d2cf) = let
//
val s2qs = d2cst_get_decarg(d2cf)
//
in
//
aux_s2qualst(out, "{", "}", s2qs)
//
end // end of [codegen2_emit_tmpcstimp]

end // end of [local]

(* ****** ****** *)

implement
codegen2_emit_tmpcstdec
  (out, d2cf) = let
//
fun
aux
(
  s2q: s2qua
) :<cloref1> void = let
//
fun
fprs2t
(
  out: FILEref, s2t: s2rt
) : void = (
//
if s2rt_is_prgm(s2t) then
{
  val () =
  if s2rt_is_lin(s2t) then fprint(out, "vt0p")
  val () =
  if s2rt_is_nonlin(s2t) then fprint(out, "t0p")
}
//
) (* end of [fprs2t] *)
//
fun
loop
(
  s2vs: s2varlst
) :<cloref1> void =
(
case+ s2vs of
| list_nil() => ()
| list_cons
    (s2v, s2vs) => let
    val sym = s2var_get_sym(s2v)
    val s2t = s2var_get_srt(s2v)
  in
    fprint(out, sym);
    fprint(out, ":");
    fprs2t(out, s2t); loop(s2vs)
  end // end of [list_cons]
)
//
val s2vs = s2q.s2qua_svs
//
in
  fprint(out, "{"); loop(s2vs); fprint(out, "}");
end // end of [aux]

fun
auxlst
(
  s2qs: s2qualst
) :<cloref1> void =
(
case+ s2qs of
| list_nil() => ()
| list_cons(s2q, s2qs) => (aux(s2q); auxlst(s2qs))
) (* end of [auxlst] *)
//
in
  auxlst(d2cst_get_decarg(d2cf))
end // end of [codegen2_emit_tmpcstdec]

(* ****** ****** *)
//
implement
codegen2_emit_s2exp
  (out, s2e0) = let
in
  fprint_s2exp(out, s2e0)
end // codegen2_emit_s2exp
//
(* ****** ****** *)

(* end of [pats_codegen2_util.dats] *)
