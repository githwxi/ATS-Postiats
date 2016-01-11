(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: June, 2011
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

(*
** for T_* constructors
*)
staload "./pats_lexing.sats"

(* ****** ****** *)
//
staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"
//
macdef fprint_symbol = $SYM.fprint_symbol
//
macdef fprint_l0ab = $SYN.fprint_l0ab
macdef fprint_i0de = $SYN.fprint_i0de
macdef fprint_cstsp = $SYN.fprint_cstsp
macdef fprint_d0ynq = $SYN.fprint_d0ynq
macdef fprint_macsynkind = $SYN.fprint_macsynkind
//
(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

implement
fprint_d2itm
  (out, x0) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x0 of
//
| D2ITMcst d2c => begin
    prstr "D2ITMcst("; fprint_d2cst (out, d2c); prstr ")"
  end // end of [D2ITMcst]
| D2ITMvar d2v => begin
    prstr "D2ITMvar("; fprint_d2var (out, d2v); prstr ")"
  end // end of [D2ITMvar]
| D2ITMcon d2cs => {
    val () = prstr "D2ITMcon("
    val () = fprint_d2conlst (out, d2cs)
    val () = prstr ")"
  } // end of [D2ITMcon]
| D2ITMe1xp e1xp => begin
    prstr "D2ITMe1xp("; fprint_e1xp (out, e1xp); prstr ")"
  end // end of [D2ITMe1xp]
//
| D2ITMsymdef
    (sym, d2pis) => {
    val () = prstr "D2ITMsymdef("
    val () = fprint_symbol (out, sym)
    val () = prstr "; "
    val () = fprint_d2pitmlst (out, d2pis)
    val () = prstr ")"
  } // end of [D2ITMsymdef]
//
| D2ITMmacdef d2m => begin
    prstr "D2ITMmacdef("; fprint_d2mac (out, d2m); prstr ")"
  end // end of [D2ITMmacdef]
| D2ITMmacvar d2v => begin
    prstr "D2ITMmacvar("; fprint_d2var (out, d2v); prstr ")"
  end // end of [D2ITMmacvar]
//
// end of [case]
end // end of [fprint_d2item]

(* ****** ****** *)

implement
print_d2itm (x) = fprint_d2itm (stdout_ref, x)
implement
prerr_d2itm (x) = fprint_d2itm (stderr_ref, x)

(* ****** ****** *)

implement
fprint_d2itmlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d2itm)
// end of [fprint_d2itmlst]

(* ****** ****** *)

implement
fprint_d2pitm
  (out, x) = {
  val D2PITM (pval, d2i) = x
  val () = fprint_string (out, "D2PITM(")
  val () = fprint_int (out, pval)
  val () = fprint_string (out, ", ")
  val () = fprint_d2itm (out, d2i)
  val () = fprint_string (out, ")")
} // end of [fprint_d2pitm]

implement
fprint_d2pitmlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d2pitm)
// end of [fprint_d2pitmlst]

(* ****** ****** *)
//
implement
fprint_d2sym
  (out, d2s) = {
  val () = fprint_d0ynq (out, d2s.d2sym_qua)
  val () = fprint_symbol (out, d2s.d2sym_sym)
} (* end of [d2sym] *)
//
implement
print_d2sym (d2s) = fprint (stdout_ref, d2s)
implement
prerr_d2sym (d2s) = fprint (stderr_ref, d2s)
//
(* ****** ****** *)
//
implement
fprint_pckind
  (out, pck) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))
//
in
//
  case+ pck of
  | PCKcon () => prstr "PCKcon"
  | PCKlincon () => prstr "PCKlincon"
  | PCKfree () => prstr "PCKfree"
  | PCKunfold () => prstr "PCKunfold"
//
end // end of [fprint_pckind]
//
implement
print_pckind (x) = fprint (stdout_ref, x)
implement
prerr_pckind (x) = fprint (stderr_ref, x)
//
(* ****** ****** *)

implement
fprint_pckindopt
  (out, opt) = $UT.fprintopt (out, opt, fprint_pckind)
// end of [fprint_pckindopt]

(* ****** ****** *)

implement
fprint_p2at
  (out, x0) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+
x0.p2at_node of
//
| P2Tany () => {
    val () = prstr "P2Tany()"
  }
| P2Tvar (d2v) => {
    val () = prstr "P2Tvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| P2Tbool (x) => {
    val () = prstr "P2Tbool("
    val () = fprint_bool (out, x)
    val () = prstr ")"
  }
| P2Tint (x) => {
    val () = prstr "P2Tint("
    val () = fprint_int (out, x)
    val () = prstr ")"
  }
| P2Tintrep (rep) => {
    val () = prstr "P2Tintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| P2Tchar (x) => {
    val () = prstr "P2Tchar("
    val () = fprint_char (out, x)
    val () = prstr ")"
  }
| P2Tfloat (x) => {
    val () = prstr "P2Tfloat("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
| P2Tstring (x) => {
    val () = prstr "P2Tstring("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
//
| P2Ti0nt (x) => {
    val () = prstr "P2Ti0nt("
    val () = $SYN.fprint_i0nt (out, x)
    val () = prstr ")"
  }
| P2Tf0loat (x) => {
    val () = prstr "P2Tf0loat("
    val () = $SYN.fprint_f0loat (out, x)
    val () = prstr ")"
  }
//
| P2Tempty () => {
    val () = prstr "P2Tempty()"
  }
| P2Tcon (
    pck, d2c, s2qs, s2f, npf, p2ts
  ) => {
    val () = prstr "P2Tcon("
    val () = fprint_pckind (out, pck)
    val () = prstr "; "
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = fprint_s2qualst (out, s2qs)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2f)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p2atlst (out, p2ts)
    val () = prstr ")"
  }
//
| P2Tlist (npf, p2ts) => {
    val () = prstr "P2Tlist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p2atlst (out, p2ts)
    val () = prstr ")"
  }
//
| P2Trec (knd, npf, lp2ts) => {
    val () = prstr "P2Ttup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_labp2atlst (out, lp2ts)
    val () = prstr ")"
  }
| P2Tlst (lin, p2ts) => {
    val () = prstr "P2Tlst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_p2atlst (out, p2ts)
    val () = prstr ")"
  }
//
| P2Trefas (d2v, p2t) => {
    val () = prstr "P2Trefas("
    val () = fprint_d2var (out, d2v)
    val () = prstr "; "
    val () = fprint_p2at (out, p2t)
    val () = prstr ")"
  }
//
| P2Texist (s2vs, p2t) => {
    val () = prstr "P2Texist("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_p2at (out, p2t)
    val () = prstr ")"
  }
//
| P2Tvbox (d2v) => {
    val () = prstr "P2Tvbox("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| P2Tann (p2t, s2f) => {
    val () = prstr "P2Tann("
    val () = fprint_p2at (out, p2t)
    val () = prstr ", "
    val () = fprint_s2exp (out, s2f)
    val () = prstr ")"
  }
| P2Terrpat ((*void*)) => prstr "P2Terrpat()"
(*
| _ => prstr "P2T...(...)"
*)
//
end // end of [fprint_p2at]

(* ****** ****** *)

implement
print_p2at (x) = fprint_p2at (stdout_ref, x)
implement
prerr_p2at (x) = fprint_p2at (stderr_ref, x)

(* ****** ****** *)
//
implement
fprint_p2atlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_p2at)
// end of [fprint_p2atlst]
//
implement
print_p2atlst (xs) = fprint_p2atlst (stdout_ref, xs)
implement
prerr_p2atlst (xs) = fprint_p2atlst (stderr_ref, xs)
//
(* ****** ****** *)

implement
fprint_labp2at
  (out, lp2t) = case+ lp2t of
  | LABP2ATnorm (l0, p2t) => {
      val () = fprint_l0ab (out, l0)
      val () = fprint_string (out, "=")
      val () = fprint_p2at (out, p2t)
    } // end of [LABP2ATnorm]
  | LABP2ATomit (loc) => fprint_string (out, "...")
// end of [fprint_labp2at]

implement
fprint_labp2atlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_labp2at)
// end of [fprint_p2atlst]

(* ****** ****** *)

implement
fprint_d2exp
  (out, d2e0) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))
//
in
//
case+
d2e0.d2exp_node of
//
| D2Ecst (d2c) => {
    val () = prstr "D2Ecst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ")"
  } // end of [D2Ecst]
| D2Evar (d2v) => {
    val () = prstr "D2Evar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  } // end of [D2Evar]
//
| D2Eint (x) => {
    val () = fprint! (out, "D2Eint(", x, ")")
  } (* end of [D2Eint] *)
| D2Eintrep (rep) => {
    val () = fprint! (out, "D2Eintrep(", rep, ")")
  } (* end of [D2Eintrep] *)
| D2Ebool (x) => {
    val () = fprint! (out, "D2Ebool(", x, ")")
  } (* end of [D2Ebool] *)
| D2Echar (x) => {
    val () = fprint! (out, "D2Echar(", x, ")")
  } (* end of [D2Echar] *)
| D2Efloat (rep) => {
    val () = fprint! (out, "D2Efloat(", rep, ")")
  } (* end of [D2Efloat] *)
| D2Estring (str) => {
    val () = fprint! (out, "D2Estring(", str, ")")
  } (* end of [D2Estring] *)
//
| D2Ei0nt (tok) => {
    val-T_INT (
      _(*base*), rep, _(*sfx*)
    ) = tok.token_node
    val () = fprint! (out, "D2Ei0nt(", rep, ")")
  } (* end of [D2Ei0nt] *)
| D2Ec0har (tok) => {
    val-T_CHAR (chr) = tok.token_node
    val () = fprint! (out, "D2Ec0har(", chr, ")")
  } (* end of [D2Ec0har] *)
| D2Ef0loat (tok) => {
    val-T_FLOAT (
      _(*base*), rep, _(*sfx*)
    ) = tok.token_node
    val () = fprint! (out, "D2Ef0loat(", rep, ")")
  } (* end of [D2Ef0loat] *)
| D2Es0tring (tok) => {
    val-T_STRING (str) = tok.token_node
    val () = fprint! (out, "D2Es0tring(", str, ")")
  } (* end of [D2Es0tring] *)
//
| D2Ecstsp (csp) => {
    val () = prstr "D2Ecstsp("
    val () = fprint_cstsp (out, csp)
    val () = prstr ")"
  } // end of [D2Ecstsp]
//
| D2Eliteral (d2e) => {
    val () = prstr "D2Eliteral("
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  } // end of [D2Eliteral]
//
| D2Etop () => {
    val () = prstr "D2Etop()"
  } // end of [D2Etop]
| D2Etop2 (s2e) => {
    val () = prstr "D2Etop2("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [D2Etop2]
//
| D2Eempty () => prstr "D2Eempty()"
//
| D2Eextval
    (s2e, name) => {
    val () = prstr "D2Eextval("
    val () = fprint_s2exp (out, s2e)
    val () = prstr "; "
    val () = prstr "\""
    val () = fprint_string (out, name)
    val () = prstr "\""
    val ((*closing*)) = prstr ")"
  } // end of [D2Eextval]
//
| D2Eextfcall
    (s2e, _fun, _arg) =>
  {
    val () = prstr "D2Eextfcall("
    val () = fprint_s2exp (out, s2e)
    val () = prstr "; "
    val () = prstr "\""
    val () = fprint_string (out, _fun)
    val () = prstr "\""
    val () = prstr "; "
    val () = fprint_d2explst (out, _arg)
    val ((*closing*)) = prstr ")"
  } (* end of [D2Eextfcall] *)
| D2Eextmcall
    (s2e, _obj, _mtd, _arg) => {
    val () = prstr "D2Eextmcall("
    val () = fprint_s2exp (out, s2e)
    val () = prstr "; "
    val () = fprint_d2exp (out, _obj)
    val () = prstr "; "
    val () = prstr "\""
    val () = fprint_string (out, _mtd)
    val () = prstr "\""
    val () = prstr "; "
    val () = fprint_d2explst (out, _arg)
    val ((*closing*)) = prstr ")"
  } (* end of [D2Eextmcall] *)
//
| D2Eloopexn (knd) => {
    val () = prstr "D2Eloopexn("
    val () = fprint_int (out, knd)
    val () = prstr ")"
  } // end of [D2Eloopexn]
//
| D2Econ
  (
    d2c, _(*loc*), s2as, npf, _(*loc*), d2es
  ) => {
    val () = prstr "D2Econ("
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = $UT.fprintlst (out, s2as, ", ", fprint_s2exparg)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d2explst (out, d2es)
    val () = prstr ")"
  } // end of [D2Econ]
//
| D2Esym (d2s) =>
  {
    val () =
      fprint! (out, "D2Esym(", d2s, ")")
    // end of [val]
  } // end of [D2Esym]
//
| D2Efoldat
    (s2as, d2e) => {
    val () = prstr "D2Efoldat("
    val () = fprint_s2exparglst (out, s2as)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  } // end of [D2Efoldat]
| D2Efreeat
    (s2as, d2e) => {
    val () = prstr "D2Efreeat("
    val () = fprint_s2exparglst (out, s2as)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  } // end of [D2Efreeat]
//
| D2Etmpid
    (d2e_id, t2mas) => {
    val () = prstr "D2Etmpid("
    val () = fprint_d2exp (out, d2e_id)
    val () = prstr "; "
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ")"
  } (* end of [D2Etmpid] *)
//
| D2Elet (d2cs, d2e) => {
    val () = prstr "D2Elet(\n"
    val () =
      fprint_d2eclist (out, d2cs)
    // end of [val]
    val () = prstr "\n>>in-of-let<<\n"
    val () = fprint_d2exp (out, d2e)
    val () = prstr "\n)"
  } (* end of [D2Elet] *)
| D2Ewhere (d2e, d2cs) => {
    val () = prstr "D2Ewhere("
    val () = fprint_d2exp (out, d2e)
    val () = prstr ";\n"
    val () = fprint_d2eclist (out, d2cs)
    val () = prstr "\n)"
  } (* end of [D2Ewhere] *)
//
| D2Eapplst (d2e, d2as) => {
    val () = prstr "D2Eapplst("
    val () = fprint_d2exp (out, d2e)
    val () = prstr "; "
    val () = fprint_d2exparglst (out, d2as)
    val () = prstr ")"
  } (* end of [D2Eapplst] *)
//
| D2Eifhead
  (
    invres, _test, _then, _else
  ) => { // D2Eifhead
    val () = prstr "D2Eifhead("
    val () = fprint_d2exp (out, _test)
    val () = prstr "; "
    val () = fprint_d2exp (out, _then)
    val () = prstr "; "
    val () = fprint_d2expopt (out, _else)
    val () = prstr ")"
  } (* end of [D2Eifhead] *)
| D2Esifhead
  (
    invres, _test, _then, _else
  ) => { // D2Esifhead
    val () = prstr "D2Esifhead("
    val () = fprint_s2exp (out, _test)
    val () = prstr "; "
    val () = fprint_d2exp (out, _then)
    val () = prstr "; "
    val () = fprint_d2exp (out, _else)
    val () = prstr ")"
  } (* end of [D2Esifhead] *)
//
| D2Ecasehead _ => {
    val () = prstr "D2Ecasehead("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D2Escasehead _ => {
    val () = prstr "D2Escasehead("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D2Esing (d2e) =>
    fprint! (out, "D2Esing(", d2e, ")")
| D2Elist (npf, d2es) =>
    fprint! (out, "D2Elist(", npf, "; ", d2es, ")")
  (* end of [D2Elist] *)
//
| D2Elst (
    lin, opt, d2es
  ) => {
    val () = prstr "D2Elst("
    val () = fprint_s2expopt (out, opt)
    val () = prstr "; "
    val () = fprint_d2explst (out, d2es)
    val () = prstr ")"
  } (* end of [D2Elst] *)
| D2Etup (
    knd, npf, d2es
  ) => {
    val () = prstr "D2Etup(knd="
    val () = fprint_int (out, knd)
    val () = prstr "; npf="
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d2explst (out, d2es)
    val () = prstr ")"
  } (* end of [D2Etup] *)
| D2Erec (
    knd, npf, ld2es
  ) => {
    val () = prstr "D2Erec(knd="
    val () = fprint_int (out, knd)
    val () = prstr "; npf="
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_labd2explst (out, ld2es)
    val () = prstr ")"
  } (* end of [D2Erec] *)
//
| D2Eseq (d2es) =>
    fprint! (out, "D2Eseq(", d2es, ")")
//
| D2Eraise (d2e) =>
    fprint! (out, "D2Eraise(", d2e, ")")
//
| D2Eeffmask (s2fe, d2e) =>
  fprint!
    (out, "D2Eeffmask(", s2fe, "; ", d2e, ")")
  // end of [D2Eeffmask]
//
| D2Eshowtype (d2e) =>
    fprint! (out, "D2Eshowtype(", d2e, ")")
//
| D2Evcopyenv (knd, d2e) =>
    fprint! (out, "D2Evcopyenv(", knd, "; ", d2e, ")")
//
| D2Etempenver (d2vs) =>
    fprint! (out, "D2Etempenver(", d2vs, ")")
//
| D2Eselab (d2e, d2ls) =>
    fprint! (out, "D2Eselab(", d2e, "; ", d2ls, ")")
//
| D2Eptrof (d2e) => fprint! (out, "D2Eptrof(", d2e, ")")
//
| D2Eviewat (d2e) => fprint! (out, "D2Eviewat(", d2e, ")")
//
| D2Ederef (d2e) => fprint! (out, "D2Ederef(", d2e, ")")
//
| D2Eassgn (d2e_l, d2e_r) =>
    fprint! (out, "D2Eassgn(", d2e_l, " := ", d2e_r, ")")
| D2Exchng (d2e_l, d2e_r) =>
    fprint! (out, "D2Exchng(", d2e_l, " :=: ", d2e_r, ")")
//
| D2Earrsub _ => {
    val () = prstr "D2Earrsub("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D2Earrpsz _ => {
    val () = prstr "D2Earrpsz("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D2Earrinit _ => {
    val () = prstr "D2Earrinit("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D2Eexist
    (s2a, d2e) => {
    val () = prstr "D2Eexist("
    val () = fprint_s2exparg (out, s2a)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  } (* end of [D2Eexist] *)
//
| D2Elam_dyn (
    lin, npf, p2ts, d2e
  ) => {
    val () =
      prstr "D2Elam_dyn("
    // end of [val]
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p2atlst (out, p2ts)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  } // end of [D2Elam_dyn]
| D2Elaminit_dyn (
    lin, npf, p2ts, d2e
  ) => {
    val () =
      prstr "D2Elaminit_dyn("
    // end of [val]
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p2atlst (out, p2ts)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val ((*closed*)) = prstr ")"
  } // end of [D2Elaminit_dyn]
//
| D2Elam_sta
    (s2vs, s2ps, d2e) =>
  {
    val () = prstr "D2Elam_sta("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_s2explst (out, s2ps)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val ((*closed*)) = prstr ")"
  } (* end of [D2Elam_sta] *)
//
| D2Elam_met _ => {
    val () = prstr "D2Elam_met("
    val () = fprint_string (out, "...")
    val ((*closed*)) = prstr ")"
  } // end of [D2Elam_met]
//
| D2Efix _ => {
    val () = prstr "D2Efix("
    val () = fprint_string (out, "...")
    val ((*closed*)) = prstr ")"
  } // end of [D2Efix]
//
| D2Edelay (d2e) =>
    fprint! (out, "D2Edelay(", d2e, ")")
  // end of [D2Edelay]
| D2Eldelay
    (_eval, _free) => {
    val () = prstr "D2Eldelay("
    val () = fprint_d2exp (out, _eval)
    val () = prstr "; "
    val () = fprint_d2expopt (out, _free)
    val () = prstr ")"
  } // end of [D2Edelay]
//
| D2Efor
  (
    i2nv
  , init, test, post, body
  ) => {
    val () = prstr "D2Efor("
    val () = fprint_loopi2nv (out, i2nv)
    val () = prstr "; init="
    val () = fprint_d2exp (out, init)
    val () = prstr "; test="
    val () = fprint_d2exp (out, test)
    val () = prstr "; post="
    val () = fprint_d2exp (out, post)
    val () = prstr "; body="
    val () = fprint_d2exp (out, body)
    val () = prstr ")"
  } (* end of [D2Efor] *)
| D2Ewhile
    (i2nv, test, body) => {
    val () = prstr "D2Ewhile("
    val () = fprint_loopi2nv (out, i2nv)
    val () = prstr "; "
    val () = fprint_d2exp (out, test)
    val () = prstr "; "
    val () = fprint_d2exp (out, body)
    val () = prstr ")"
  } // end of [D2Ewhile]
//
| D2Etrywith _ => {
    val () = prstr "D2Etrywith("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  } // end of [D2Etrywith]
//
| D2Eann_type
    (d2e, s2f) => {
    val () = prstr "D2Eann_type("
    val () = fprint_d2exp (out, d2e)
    val () = prstr " : "
    val () = fprint_s2exp (out, s2f)
    val () = prstr ")"
  } // end of [D2Eann_type]
| D2Eann_seff
    (d2e, s2fe) => {
    val () = prstr "D2Eann_seff("
    val () = fprint_d2exp (out, d2e)
    val () = prstr " : "
    val () = fprint_s2eff (out, s2fe)
    val () = prstr ")"
  } // end of [D2Eann_seff]
| D2Eann_funclo
    (d2e, funclo) => {
    val () = prstr "D2Eann_funclo("
    val () = fprint_d2exp (out, d2e)
    val () = prstr " : "
    val () = fprint_funclo (out, funclo)
    val () = prstr ")"
  } // end of [D2Eann_funclo]
//
| D2Emac (d2m) => {
    val () = prstr "D2Emac("
    val () = fprint_d2mac (out, d2m)
    val () = prstr ")"
  }
| D2Emacsyn (knd, d2e) => {
    val () = prstr "D2Emacsyn("
    val () = fprint_macsynkind (out, knd)
    val () = prstr "; "
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  } // end of [D2Emacsyn]
| D2Emacfun (name, d2es) => {
    val () = prstr "D2Emacfun("
    val () = fprint_symbol (out, name)
    val () = prstr "; "
    val () = fprint_d2explst (out, d2es)
    val () = prstr ")"
  } // end of [D2Emacfun]
//
| D2Esolassert
    (d2e_prf) => {
    val () = prstr "D2Esolassert("
    val () = fprint_d2exp(out, d2e_prf)
    val () = prstr ")"
  }
| D2Esolverify
    (s2e_prop) => {
    val () = prstr "D2Esolverify("
    val () = fprint_s2exp(out, s2e_prop)
    val () = prstr ")"
  }
//
| D2Eerrexp ((*void*)) => prstr "D2Eerr()"
//
(*
| _ => prstr "D2E...(...)"
*)
//
end // end of [fprint_d2exp]

(* ****** ****** *)

implement
print_d2exp (x) = fprint_d2exp (stdout_ref, x)
implement
prerr_d2exp (x) = fprint_d2exp (stderr_ref, x)

(* ****** ****** *)

implement
fprint_d2explst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_d2exp)
// end of [fprint_d2explst]

(* ****** ****** *)

implement
fprint_d2expopt
  (out, opt) = let
in
  case+ opt of
  | Some (d2e) => {
      val () =
        fprint_string (out, "Some(")
      // end of [val]
      val () = fprint_d2exp (out, d2e)
      val () = fprint_string (out, ")")
    } // end of [Some]
  | None () => fprint_string (out, "None()")
end // end of [fprint_d2expopt]

(* ****** ****** *)

implement
fprint_labd2exp
  (out, x) = {
  val $SYN.DL0ABELED (l0, d2e) = x
  val () = fprint_l0ab (out, l0)
  val () = fprint_string (out, "=")
  val () = fprint_d2exp (out, d2e)
} // end of [fprint_labd2exp]

implement
fprint_labd2explst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_labd2exp)
// end of [fprint_labs2explst]

(* ****** ****** *)

implement
fprint_d2exparg
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
| D2EXPARGsta
    (_(*loc*), s2as) => {
    val () = prstr "D2EXPARGsta("
    val () = fprint_s2exparglst (out, s2as)
    val () = prstr ")"
  }
| D2EXPARGdyn
    (npf, _(*loc*), d2es) => {
    val () = prstr "D2EXPARGdyn("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d2explst (out, d2es)
    val () = prstr ")"
  }
//
end // end of [fprint_d2exparg]

implement
fprint_d2exparglst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_d2exparg)
// end of [fprint_d2exparglst]

(* ****** ****** *)

implement
fprint_d2lab
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x.d2lab_node of
| D2LABlab (lab) => {
    val () = prstr "D2LABlab("
    val () = $LAB.fprint_label (out, lab)
    val () = prstr ")"
  } // end of [D2LABlab]
| D2LABind (ind) => {
    val () = prstr "D2LABind("
    val () = $UT.fprintlst (out, ind, ", ", fprint_d2exp)
    val () = prstr ")"
  } // end of [D2LABind]
//
end // end of [fprint_d2lab]

implement
fprint_d2lablst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_d2lab)
// end of [fprint_d2lablst]

(* ****** ****** *)
//
extern
fun
fprint_i2nvarg : fprint_type (i2nvarg)
//
implement
fprint_i2nvarg
  (out, arg) = let
//
val d2v = arg.i2nvarg_var
val opt = arg.i2nvarg_type
val () = fprint_d2var (out, d2v)
//
in
//
case+ opt of
| Some (s2e) => {
    val () =
      fprint_string (out, ": ")
    val () = fprint_s2exp (out, s2e)
  } // end of [Some]
| None () => () // end of [None]
//
end // end of [fprint_i2nvarg]

implement
fprint_i2nvarglst
  (out, args) =
  $UT.fprintlst (out, args, ", ", fprint_i2nvarg)
// end of [fprint_i2nvarglst]

implement
fprint_i2nvresstate
  (out, r2es) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  prstr ("i2nvresstate(svs=");
  fprint_s2varlst (out, r2es.i2nvresstate_svs);
  prstr ("; gua=");
  fprint_s2explst (out, r2es.i2nvresstate_gua);
  prstr ("; met=");
  fprint_s2explstopt (out, r2es.i2nvresstate_met);
  prstr ("; state=");
  fprint_i2nvarglst (out, r2es.i2nvresstate_arg);
  prstr (")");
end // end of [fprint_i2nvresstate]

implement
fprint_loopi2nv
  (out, i2nv) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  prstr ("loop2inv(svs=");
  fprint_s2varlst (out, i2nv.loopi2nv_svs);
  prstr ("; gua=");
  fprint_s2explst (out, i2nv.loopi2nv_gua);
  prstr ("; met=");
  fprint_s2explstopt (out, i2nv.loopi2nv_met);
  prstr ("; state=");
  fprint_i2nvarglst (out, i2nv.loopi2nv_arg);
  prstr ("; ");
  fprint_i2nvresstate (out, i2nv.loopi2nv_res);
  prstr (")");
end // end of [fprint_loopi2nv]

(* ****** ****** *)
//
implement
print_d2ecl
  (x) = fprint_d2ecl (stdout_ref, x)
implement
prerr_d2ecl
  (x) = fprint_d2ecl (stderr_ref, x)
//
implement
fprint_d2ecl
  (out, x0) = let
//
macdef
prstr(s) = fprint_string (out, ,(s))
//
in
//
case+
x0.d2ecl_node
of // case+
//
| D2Cnone () => prstr "D2Cnone()"
//
| D2Clist (xs) => {
    val () = prstr "D2Clist(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d2ecl)
    val () = prstr "\n)"
  } // end of [D2Clist]
//
| D2Coverload
    (id, pval, opt) => {
    val () = prstr "D2Coverload("
    val (
    ) = fprint_i0de (out, id)
    val () = prstr "("
    val () = fprint_int (out, pval)
    val () = prstr "); "
    val () = (
      case+ opt of
      | Some d2i => fprint_d2itm (out, d2i)
      | None ((*void*)) => fprint_string (out, "*ERROR*")
    ) : void // end of [val]
    val () = prstr ")"
  } // end of [D2Coverload]
//
| D2Cstacsts
    (s2cs) => {
    val () = fprint! (out, "D2Cstacsts(", s2cs, ")")
  } (* end of [D2Cstacsts] *)
| D2Cstacons
    (knd, s2cs) => {
    val () = fprint! (out, "D2Cstacons(", knd, "; ", s2cs, ")")
  } (* end of [D2Cstacons] *)
//
| D2Cextype
    (name, s2e) => {
    val () = fprint! (out, "D2Cextype(", name, " = ", s2e, ")")
  } (* end of [D2Cextype] *)
| D2Cextvar 
    (name, d2e) => {
    val () = fprint! (out, "D2Cextvar(", name, " = ", d2e, ")")
  } (* end of [D2Cextvar] *)
//
| D2Cextcode _ => prstr "D2Cextcode(...)"
//
| D2Cpragma(xs) =>
  {
    val () =
    prstr "D2Cpragma("
    val () = $UT.fprintlst (out, xs, ", ", fprint_e1xp)
    val () = prstr (")")  
  }
| D2Ccodegen
    (knd, xs) => {
    val () =
    prstr "D2Ccodegen("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, xs, ", ", fprint_e1xp)
    val () = prstr (")")
  } (* end of [D2Ccodegen] *)
//
| D2Cdatdecs
   (knd, s2cs) => {
    val () = prstr "D2Cdatdecs("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, s2cs, ", ", fprint_s2cst)
    val () = prstr ")"
  } // end of [D2Cdatdecs]
//
| D2Cdcstdecs
    (knd, dck, d2cs) =>
  {
    val () = prstr "D2Cdcstdecs("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_dcstkind (out, dck)
    val () = prstr "; "
    val () = $UT.fprintlst (out, d2cs, ", ", fprint_d2cst)
    val () = prstr ")"
  } // end of [D2Cdcstdecs]
//
| D2Cfundecs _ => {
    val () = prstr "D2Cfundecs(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cfundecs]
| D2Cvaldecs _ => {
    val () = prstr "D2Cvaldecs(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cvaldecs]
| D2Cvaldecs_rec _ => {
    val () = prstr "D2Cvaldecs_rec(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cvaldecs_rec]
| D2Cvardecs _ => {
    val () = prstr "D2Cvardecs(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cvardecs]
| D2Cprvardecs _ => {
    val () = prstr "D2Cprvardecs(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cprvardecs]
//
| D2Cinclude
    (knd, d2cs) => {
    val () = prstr "D2Cinclude("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cinclude]    
//
| D2Cstaload _ => {
    val () = prstr "D2Cstaload(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cstaload]    
| D2Cstaloadloc _ => {
    val () = prstr "D2Cstaloadloc(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cstaload]    
//
| D2Cdynload _ => {
    val () = prstr "D2Cdynload(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Cdynload]    
//
| D2Clocal _ => {
    val () = prstr "D2Clocal(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  } // end of [D2Clocal]    
//
| D2Cerrdec () => prstr "D2Cerrdec()"
//
| _ (*rest-of-d2ecl*) => prstr "D2C...(...)"
//
end // end of [fprint_d2ecl]
//
implement
fprint_d2eclist
  (out, d2cs) =
  $UT.fprintlst (out, d2cs, "\n", fprint_d2ecl)
//
(* ****** ****** *)

implement
fprint_d2lval
  (out, x0) = let
//
macdef
prstr(s) = fprint_string (out, ,(s))
//
in
//
case+ x0 of
//
| D2LVALderef
    (d2e, d2ls) => {
    val () = prstr "D2LVALderef("
    val () = fprint_d2exp (out, d2e)
    val () = prstr "; "
    val () = fprint_d2lablst (out, d2ls)
    val () = prstr ")"
  }
| D2LVALvar_lin
    (d2v, d2ls) => {
    val () = prstr "D2LVALvar_lin("
    val () = fprint_d2var (out, d2v)
    val () = prstr "; "
    val () = fprint_d2lablst (out, d2ls)
    val () = prstr ")"
  }
| D2LVALvar_mut
    (d2v, d2ls) => {
    val () = prstr "D2LVALvar_mul("
    val () = fprint_d2var (out, d2v)
    val () = prstr "; "
    val () = fprint_d2lablst (out, d2ls)
    val () = prstr ")"
  }
| D2LVALarrsub
    (d2s, d2e, loc, ind) => {
    val () = prstr "D2LVALarrsub("
    val () = fprint_d2exp (out, d2e)
    val () = prstr "; "
    val () = $UT.fprintlst (out, ind, ", ", fprint_d2exp)
    val () = prstr ")"
  }
| D2LVALviewat (d2e) => {
    val () = prstr "D2LVALviewat("
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  }
| D2LVALnone (d2e) => {
    val () = prstr "D2LVALnone("
    val () = fprint_d2exp (out, d2e)
    val () = prstr ")"
  }
//
end // end of [fprint_d2lval]

(* ****** ****** *)
//
implement
print_d2lval (x) = fprint_d2lval (stdout_ref, x)
implement
prerr_d2lval (x) = fprint_d2lval (stderr_ref, x)
//
(* ****** ****** *)

(* end of [pats_dynexp2_print.dats] *)
