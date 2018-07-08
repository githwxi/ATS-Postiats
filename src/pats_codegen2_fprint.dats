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
  $UN.castvwtp0{string}(sprintf("fprint_%s_", @(name)))
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
linesep =
"(* ****** ****** *)"
//
val
fname = d2cst_get_name(d2cf)
//
fun
auxd2c_dec
(
  d2c: d2con
) :<cloref1> void = let
//
val cname = d2con_get_name(d2c)
//
val () =
fprint(out, "extern\nfun")
val () =
codegen2_emit_tmpcstdec(out, d2cf)
val () = fprint(out, "\n")
val () =
fprint! (out, fname, "$", cname)
val () =
fprint! (out, ": $d2ctype(", fname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val ((*closing*)) = fprintln! (out, ")")
//
in
  // nothing
end // end of [auxd2c_dec]
//
fun
auxd2cs_dec
(
  d2cs: d2conlst
) :<cloref1> void =
(
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) =>
  let val () = auxd2c_dec(d2c) in auxd2cs_dec(d2cs) end
)
//
fun
auxd2c_cla
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
end // end of [auxd2c_cla]
//
fun
auxd2cs_cla
(
  d2cs: d2conlst
) :<cloref1> void =
(
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) =>
  let val () = auxd2c_cla(d2c) in auxd2cs_cla(d2cs) end
)
//
fun
auxsep
(
// argless
):<cloref1> void =
{
//
val () =
fprint!
(
  out, "//\nextern\nfun{}\n"
) (* end of [val] *)
val () =
fprintln! (out, fname, "$sep: (FILEref) -> void")
val () =
fprint! (out, "implement{}\n")
val () =
fprintln! (out, fname, "$sep(out) = fprint(out, \",\")")
//
} (* end of [auxsep] *)
//
fun
auxcarg
(
// argless
):<cloref1> void =
{
//
val () =
fprint!
( out
, "//\nextern\nfun{a:t0p}\n"
) (* end of [val] *)
val () =
fprintln! (out, fname, "$carg: (FILEref, INV(a)) -> void")
val () =
fprint! (out, "implement{a}\n")
val () =
fprintln! (out, fname, "$carg(out, arg) = fprint_val<a>(out, arg)")
//
} (* end of [auxcarg] *)
//
fun
auxlpar
(
// argless
):<cloref1> void =
{
//
val () =
fprint!
(
  out, "//\nextern\nfun{}\n"
) (* end of [val] *)
val () =
fprintln! (out, fname, "$lpar: (FILEref) -> void")
val () =
fprint! (out, "implement{}\n")
val () =
fprintln! (out, fname, "$lpar(out) = fprint(out, \"(\")")
//
} (* end of [auxlpar] *)
fun
auxrpar
(
// argless
):<cloref1> void =
{
//
val () =
fprint!
(
  out, "//\nextern\nfun{}\n"
) (* end of [val] *)
val () =
fprintln! (out, fname, "$rpar: (FILEref) -> void")
val () =
fprint! (out, "implement{}\n")
val () =
fprintln! (out, fname, "$rpar(out) = fprint(out, \")\")")
//
} (* end of [auxrpar] *)
//
val-
Some(d2cs) =
s2cst_get_dconlst(s2dat)
//
val () =
fprint!
  (out, linesep, "\n//\n")
//
val () = auxd2cs_dec (d2cs)
//
val () =
fprint!
  (out, "//\n", linesep, "\n//\n")
//
val () = fprint(out, "implement")
val () = codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
//
val () =
fprint! (out, fname)
//
val () =
fprint! (out, "\n  ")
val () =
fprintln!
  (out, "(out, arg0) =")
//
val () =
fprint! (out, "(\n")
val () =
fprintln!
  (out, "case+ arg0 of")
//
val () = auxd2cs_cla (d2cs) // clauses
//
val () = fprint! (out, ")\n")
val () = fprintln! (out, "//\n", linesep)
//
val () = auxsep ()
val () = auxlpar ()
val () = auxrpar ()
val () = auxcarg ()
//
val () = fprintln! (out, "//\n", linesep)
//
val () =
aux_datype_d2cf_conlst(out, d2c0, s2dat, d2cf, d2cs)
//
val () = fprintln! (out, "//\n", linesep)
//
in
  // nothing
end // end of [aux_datype_d2cf]

and
aux_datype_d2cf_con
(
  out: FILEref
, d2c0: d2ecl, s2dat: s2cst, d2cf: d2cst, d2cn: d2con
) : void = let
//
val
fname = d2cst_get_name(d2cf)
//
val
ftype = d2cst_get_type(d2cf)
//
val
cname = d2con_get_name(d2cn)
//
val narg = d2con_get_arity_real(d2cn)
//
fun
auxcon1
(
// argless
) :<cloref1> void =
{
//
val () =
fprint(out, "extern\nfun")
val () =
codegen2_emit_tmpcstdec(out, d2cf)
val () = fprint(out, "\n")
val () =
fprint! (out, fname, "$", cname, "$con")
val () =
fprint! (out, ": $d2ctype(", fname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val ((*closing*)) = fprintln! (out, ")")
//
}
//
fun
auxlpar1
(
// argless
) :<cloref1> void =
{
//
val () =
fprint(out, "extern\nfun")
val () =
codegen2_emit_tmpcstdec(out, d2cf)
val () = fprint(out, "\n")
val () =
fprint! (out, fname, "$", cname, "$lpar")
val () =
fprint! (out, ": $d2ctype(", fname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val ((*closing*)) = fprintln! (out, ")")
//
}
//
fun
auxrpar1
(
// argless
) :<cloref1> void =
{
//
val () =
fprint(out, "extern\nfun")
val () =
codegen2_emit_tmpcstdec(out, d2cf)
val () = fprint(out, "\n")
val () =
fprint! (out, fname, "$", cname, "$rpar")
val () =
fprint! (out, ": $d2ctype(", fname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val ((*closing*)) = fprintln! (out, ")")
//
}
//
fun
auxsep1_n
(
  n: int
) :<cloref1> void =
{
//
val () =
fprint(out, "extern\nfun")
val () =
codegen2_emit_tmpcstdec(out, d2cf)
val () = fprint(out, "\n")
val () =
fprint!
(
out, fname, "$", cname, "$sep", n
) (* fprint! *)
//
val () =
fprint! (out, ": $d2ctype(", fname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val ((*closing*)) = fprintln! (out, ")")
//
}
//
fun
auxarg1_n
(
  n: int
) :<cloref1> void =
{
//
val () =
fprint(out, "extern\nfun")
val () =
codegen2_emit_tmpcstdec(out, d2cf)
val () = fprint(out, "\n")
val () =
fprint! (out, fname, "$", cname, "$arg", n)
val () =
fprint! (out, ": $d2ctype(", fname)
val () = codegen2_emit_tmpcstapp(out, d2cf)
val ((*closing*)) = fprintln! (out, ")")
//
}
//
fun
auxcon2
(
// argless
) :<cloref1> void =
{
//
val () =
fprint! (out, "val () = ")
val () =
fprint! (out, fname, "$", cname, "$con")
val () = codegen2_emit_tmpcstapp(out, d2cf)
val () = fprintln! (out, "(out, arg0)")
//
}
fun
auxlpar2
(
// argless
) :<cloref1> void =
{
//
val () =
fprint! (out, "val () = ")
val () =
fprint!
  (out, fname, "$", cname, "$lpar")
//
val () = codegen2_emit_tmpcstapp(out, d2cf)
val () = fprintln! (out, "(out, arg0)")
//
}
//
fun
auxrpar2
(
// argless
) :<cloref1> void =
{
//
val () =
fprint! (out, "val () = ")
val () =
fprint!
  (out, fname, "$", cname, "$rpar")
//
val () = codegen2_emit_tmpcstapp(out, d2cf)
val () = fprintln! (out, "(out, arg0)")
//
}
//
fun
auxsep2_n
(
  n: int
) :<cloref1> void =
{
//
val () =
fprint! (out, "val () = ")
val () =
fprint!
  (out, fname, "$", cname, "$sep", n)
//
val () = codegen2_emit_tmpcstapp(out, d2cf)
val () = fprintln! (out, "(out, arg0)")
//
}
fun
auxarg2_n
(
  n: int
) :<cloref1> void =
{
//
val () =
fprint! (out, "val () = ")
val () =
fprint!
  (out, fname, "$", cname, "$arg", n)
//
val () = codegen2_emit_tmpcstapp(out, d2cf)
val () = fprintln! (out, "(out, arg0)")
//
}
//
fun
auxbody2
(
  n0: int, n: int
) :<cloref1> void =
(
//
if
n < narg
then let
  val () =
  if n > n0
    then auxsep2_n(n)
  // end of [val]
  val () = auxarg2_n(n+1)
in
  auxbody2(n0, n+1)
end // end of [then]
else () // end of [else]
//
) (* end of [auxbody2] *)
//
fun
auxcon3
(
// argless
) :<cloref1> void =
{
//
val () =
fprint(out, "implement")
val () =
codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
//
val () =
fprint!
  (out, fname, "$", cname, "$con(out, _) = ")
val () =
fprintln! (out, "fprint(out, \"", cname, "\")")
//
} (* end of [auxcon3] *)
//
fun
auxlpar3
(
// argless
) :<cloref1> void =
{
//
val () =
fprint(out, "implement")
val () =
codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
val () =
fprintln!
  (out, fname, "$", cname, "$lpar(out, _) = ", fname, "$lpar(out)")
//
} (* end of [auxlpar3] *)
//
fun
auxrpar3
(
// argless
) :<cloref1> void =
{
//
val () =
fprint(out, "implement")
val () =
codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
val () =
fprintln!
  (out, fname, "$", cname, "$rpar(out, _) = ", fname, "$rpar(out)")
//
} (* end of [auxrpar3] *)
//
fun
auxsep3_n
(
  n: int
) :<cloref1> void =
{
//
val () =
fprint(out, "implement")
val () =
codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
val () =
fprintln!
  (out, fname, "$", cname, "$sep", n, "(out, _) = ", fname, "$sep<>(out)")
//
} (* end of [auxsep3_n] *)
//
fun
auxpat3_n
(
  n: int
) :<cloref1> void = let
//
fun
aux(i: int):<cloref1> void =
(
if
(i <= narg)
then let
  val () =
  if i > 1
    then fprint(out, ", ")
  // end of [val]
  val () =
  if (i = n)
    then fprint!(out, "arg", n)
  // end of [val]
  val () =
  if (i != n) then fprint(out, "_")
in
  aux(i+1)
end // end of [then]
else () // end of [else]
)
//
in
  fprint!(out, cname, "("); aux(1); fprint(out, ")")
end // end of [auxpat3_n]
//
fun
auxarg3_n
(
  n: int
) :<cloref1> void =
{
//
val () =
fprint(out, "implement")
val () =
codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
val () =
fprintln!
  (out, fname, "$", cname, "$arg", n, "(out, arg0) =")
//
val () =
fprint
  (out, "  let val-")
//
val () = auxpat3_n(n)
//
val () =
fprintln! (out, " = arg0 in ", fname, "$carg(out, arg", n, ") end")
//
} (* end of [auxarg3_n] *)
//
val () =
fprint(out, "//\n")
//
val () = auxcon1()
val () = auxlpar1()
val () = auxrpar1()
val () = loop(1) where
{
  fun loop(n: int):<cloref1> void = if n < narg then (auxsep1_n(n); loop(n+1))
}
val () = loop(1) where
{
  fun loop(n: int):<cloref1> void = if n <= narg then (auxarg1_n(n); loop(n+1))
}
//
val () =
fprint(out, "//\n")
//
val () =
fprint(out, "implement")
val () =
codegen2_emit_tmpcstimp(out, d2cf)
val () = fprintln! (out)
//
val () =
fprintln! (out, fname, "$", cname, "(out, arg0) = ")
//
val () = fprintln! (out, "{\n//")
val () = auxcon2()
val () = auxlpar2()
val () = auxbody2(0, 0)
val () = auxrpar2()
val () = fprintln! (out, "//\n}")
//
val () = auxcon3()
val () = auxlpar3()
val () = auxrpar3()
val () = loop(1) where
{
  fun loop(n: int):<cloref1> void = if n < narg then (auxsep3_n(n); loop(n+1))
}
val () = loop(1) where
{
  fun loop(n: int):<cloref1> void = if n <= narg then (auxarg3_n(n); loop(n+1))
}
//
in
  // nothing
end // end of [aux_datype_d2cf_con]

and
aux_datype_d2cf_conlst
(
  out: FILEref
, d2c0: d2ecl, s2dat: s2cst, d2cf: d2cst, xs: d2conlst
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  {
    val () = aux_datype_d2cf_con(out, d2c0, s2dat, d2cf, x)
    val () = aux_datype_d2cf_conlst(out, d2c0, s2dat, d2cf, xs)
  }
) (* end of [aux_datype_d2cf_conlst] *)

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
