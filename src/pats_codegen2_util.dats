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
LAB = "./pats_label.sats"
overload
fprint with $LAB.fprint_label
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
implement
absrec_test_e1xp(x0) = aux_test(x0, "absrec")
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
codegen2_get_tydef
  (x0) = let
//
val opt = codegen2_get_s2cst(x0)
//
in
//
case+ opt of
| Some_vt(s2c) =>
  (
    if s2cst_is_tydef(s2c)
      then (fold@{s2cst}(opt); opt)
      else (free@{s2cst}(opt); None_vt())
  ) (* end of [Some_vt] *)
//
| ~None_vt((*void*)) => None_vt()
//
end // end of [codegen2_get_tydef]

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

implement
codegen2_emit_s2rt
  (out, s2t0) = let
//
fun
aux_s2rt
(
  s2t0: s2rt
) :<cloref1> void =
(
case+ s2t0 of
| S2RTbas
    (s2tb) =>
  {
    val () = aux_s2rtbas(s2tb)
  }
| S2RTfun
  (
    s2ts_arg, s2t_res
  ) => () where
  {
    val () = fprint(out, "(")
    val () =
      aux_s2rtlst(s2ts_arg, 0)
    // end of [val]
    val () = fprint(out, ") ->")
    val () = aux_s2rt(s2t_res)
  }
| _(*rest-of_s2rt*) => fprint(out, s2t0)
) (* end of [aux_s2rt] *)
//
and
aux_s2rtlst
(
  s2ts: s2rtlst, i: int
) :<cloref1> void =
(
case+ s2ts of
| list_nil() => ()
| list_cons(s2t, s2ts) =>
  {
    val () =
    if i > 0
      then fprint(out, ", ")
    // end of [if]
    val () = aux_s2rt(s2t)
    val () = aux_s2rtlst(s2ts, i+1)
  } (* end of [list_cons] *)
) (* end of [aux_s2rtlst] *)
//
and
aux_s2rtbas
(
  s2tb: s2rtbas
) :<cloref1> void =
(
case+ s2tb of
| S2RTBASpre
    (sym) => fprint(out, sym)
  // end of [S2RTBASpre]
| S2RTBASimp
    (knd, sym) => fprint(out, sym)
  // end of [S2RTBASimp]
| S2RTBASdef(s2td) =>
    fprint(out, s2rtdat_get_sym(s2td))
  // end of [S2RTBASdef]
) (* end of [aux_s2rtbas] *)
//
in
  aux_s2rt(s2t0)
end // end of [codegen2_emit_s2rt]

(* ****** ****** *)

implement
codegen2_emit_s2cst
  (out, s2c0) = () where
{
  val () = fprint(out, s2cst_get_sym(s2c0))
} (* codegen2_emit_s2cst *)

implement
codegen2_emit_s2var
  (out, s2v0) = () where
{
  val () = fprint(out, s2var_get_sym(s2v0))
} (* codegen2_emit_s2var *)

(* ****** ****** *)
//
local

fun
aux_istup
(
  ls2es: labs2explst
) : bool =
(
case+ ls2es of
| list_nil() => true
| list_cons
    (ls2e, ls2es) => let
    val+SLABELED(l, _, _) = ls2e
  in
    if $LAB.label_is_int(l) then aux_istup(ls2es) else false
  end // end of [list_cons]
)

fun
aux_s2exp
(
  out: FILEref, s2e0: s2exp
) : void = let
//
(*
val () =
println!
  ("aux_s2exp: s2e0 = ", s2e0)
*)
//
in
//
case+
s2e0.s2exp_node
of (* case+ *)
//
| S2Ecst(s2c) =>
  {
    val () = codegen2_emit_s2cst(out, s2c)
  }
//
| S2Evar(s2v) => () where
  {
    val () = codegen2_emit_s2var(out, s2v)
  }
//
| S2Eapp(s2e_fun, s2es_arg) =>
  {
    val () = aux_s2exp(out, s2e_fun)
    val () = fprint(out, "(")
    val () = aux_s2explst(out, s2es_arg, 0)
    val () = fprint(out, ")")
  }
//
| S2Etyrec
    (knd, npf, ls2es) => () where
  {
//
    val
    istup = aux_istup(ls2es)
//
    val
    tuprec =
    (
      if istup then "$tup" else "$rec"
    ) : string // end of [val]
//
    val
    isflted =
    tyreckind_is_flted(knd)
    val () =
    if isflted then fprint(out, "@")
//
    val
    isboxed =
    tyreckind_is_boxed(knd)
    val () =
    if isboxed then
    (
      if s2exp_is_nonlin(s2e0)
        then fprint!(out, tuprec, "_t")
        else fprint!(out, tuprec, "_vt")
    ) (* end of [val] *)
//
    val () =
    if istup
      then fprint_string(out, "(")
      else fprint_string(out, "{")
    // end of [if]
//
    val () = aux_labs2explst(out, ls2es, 0)
//
    val () =
    if istup
      then fprint_string(out, ")")
      else fprint_string(out, "}")
    // end of [if]
//
  } (* end of [S2Etyrec] *)
//
| _ (*rest-of-s2exp*) => fprint_s2exp(out, s2e0)
//
end (* end of [aux_s2exp] *)

and
aux_s2explst
(
  out: FILEref
, s2es: s2explst, i: int
) : void = let
(*
val () =
println! ("aux_labs2explst")
*)
in
//
case+ s2es of
| list_nil() => ()
| list_cons(s2e, s2es) =>
  {
    val () =
    if i > 0 then fprint(out, ", ")
    val () = aux_s2exp(out, s2e)
    val () = aux_s2explst(out, s2es, i+1)
  } (* end of [list_cons] *)
//
end // end of [aux_s2explst]

and
aux_labs2explst
(
  out: FILEref
, ls2es: labs2explst, i: int
) : void = let
(*
val () =
println! ("aux_labs2explst")
*)
in
//
case+ ls2es of
| list_nil() => ()
| list_cons(ls2e, ls2es) =>
  {
//
    val () =
    if i > 0 then fprint(out, ", ")
//
    val+
    SLABELED(l, _(*name*), s2e) = ls2e
    val () =
    if $LAB.label_is_sym(l) then fprint!(out, l, "=")
//
    val () = aux_s2exp(out, s2e)
//
    val () = aux_labs2explst(out, ls2es, i+1)
  } (* end of [list_cons] *)
//
end // end of [aux_labs2explst]

in (* in-of-local *)

implement
codegen2_emit_s2exp
  (out, s2e0) = let
//
(*
val () =
println!
(
"codegen2_emit_s2exp: s2e0 = ", s2e0
) (* println! *)
*)
//
in
  aux_s2exp(out, s2e0)
end // codegen2_emit_s2exp

end // end of [local]
//
(* ****** ****** *)

(* end of [pats_codegen2_util.dats] *)
