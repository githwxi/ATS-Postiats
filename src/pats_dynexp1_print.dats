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
// Start Time: April, 2011
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload SYM = "./pats_symbol.sats"
staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"
macdef fprint_i0de = $SYN.fprint_i0de

(* ****** ****** *)

staload "./pats_basics.sats"
staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)

implement
fprint_p1at
  (out, p1t0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ p1t0.p1at_node of
//
| P1Tany () => prstr "P1Tany()"
| P1Tany2 () => prstr "P1Tany2()"
//
| P1Tide (id) => {
    val () = prstr "P1Tide("
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr ")"
  }
| P1Tdqid (q, id) => {
    val () = prstr "P1Tdqid("
    val () = $SYN.fprint_d0ynq (out, q)
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| P1Tint (int) => {
    val () = prstr "P1Tint("
    val () = fprint_int (out, int)
    val () = prstr ")"
  }
| P1Tintrep (rep) => {
    val () = prstr "P1Tintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| P1Tchar (x) => {
    val () = prstr "P1Tchar("
    val () = fprint_char (out, x)
    val () = prstr ")"
  }
| P1Tfloat (x) => {
    val () = prstr "P1Tfloat("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
| P1Tstring (x) => {
    val () = prstr "P1Tint("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
//
| P1Ti0nt (x) => {
    val () = prstr "P1Ti0nt("
    val () = $SYN.fprint_i0nt (out, x)
    val () = prstr ")"
  }
| P1Tf0loat (x) => {
    val () = prstr "P1Tf0loat("
    val () = $SYN.fprint_f0loat (out, x)
    val () = prstr ")"
  }
//
| P1Tempty () => prstr "P1Tempty()"
//
| P1Tapp_sta (p1t, s1vs) => {
    val () = prstr "P1Tapp_sta("
    val () = $UT.fprintlst (out, s1vs, ", ", fprint_s1vararg)
    val () = prstr ")"
  }
| P1Tapp_dyn (
    p1t, locarg, npf, p1ts
  ) => {
    val () = prstr "P1Tapp_dyn("
    val () = fprint_p1at (out, p1t)
    val () = prstr "; "    
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p1atlst (out, p1ts)
    val () = prstr ")"
  }
//
| P1Tlist (npf, p1ts) => {
    val () = prstr "P1Tlist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p1atlst (out, p1ts)
    val () = prstr ")"
  }
//
| P1Ttup (knd, npf, p1ts) => {
    val () = prstr "P1Ttup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p1atlst (out, p1ts)
    val () = prstr ")"
  }
| P1Trec (knd, npf, lp1ts) => {
    val () = prstr "P1Ttup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = $UT.fprintlst (out, lp1ts, ", ", fprint_labp1at)
    val () = prstr ")"
  }
| P1Tlst (lin, p1ts) => {
    val () = prstr "P1Tlst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_p1atlst (out, p1ts)
    val () = prstr ")"
  }
//
| P1Tfree (p1t) => {
    val () = prstr "P1Tfree("
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  }
| P1Tunfold (p1t) => {
    val () = prstr "P1Tunfold("
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  }
//
| P1Trefas
    (sym, loc_id, p1t) => {
    val () = prstr "P1Trefas("
    val () = $SYM.fprint_symbol (out, sym)
    val () = prstr "; "
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  }
//
| P1Texist (s1as, p1t) => {
    val () = prstr "P1Texist("
    val () = fprint_s1arglst (out, s1as)
    val () = prstr "; "
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  }
| P1Tsvararg (s1v) => {
    val () = prstr "P1Tsvararg("
    val () = fprint_s1vararg (out, s1v)
    val () = prstr ")"
  }
//
| P1Tann (p1t, s1e) => {
    val () = prstr "P1Tann("
    val () = fprint_p1at (out, p1t)
    val () = fprint_string (out, " : ")
    val () = fprint_s1exp (out, s1e)
    val () = prstr ")"
  }
//
| P1Terrpat ((*void*)) => prstr "P1Terrpat()"
//
(*
| _ => prstr "P1T...(...)"
*)
//
end // end of [fprint_p1at]

implement
print_p1at (p1t) = fprint_p1at (stdout_ref, p1t)
implement
prerr_p1at (p1t) = fprint_p1at (stderr_ref, p1t)

(* ****** ****** *)

implement
fprint_p1atlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_p1at)
// end of [fprint_p1atlst]

implement
fprint_labp1at (out, x) = let
//
macdef prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ x.labp1at_node of
| LABP1ATnorm
    (lab, p1t) => {
    val () = prstr "LABP1ATnorm("
    val () = $SYN.fprint_l0ab (out, lab)
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  } (* end of [LABP1ATnorm] *)
| LABP1ATomit () => prstr "LABP1ATomit()"
//
end // end of [fprint_labp1at]

(* ****** ****** *)

implement
fprint_d1exp
  (out, d1e0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1e0.d1exp_node of
//
| D1Eide (id) => {
    val () = prstr "D1Eide("
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr ")"
  }
| D1Edqid
    (dq, id) => {
    val () = prstr "D1Edqid("
    val () = $SYN.fprint_d0ynq (out, dq)
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| D1Eidextapp
    (id, d1es) => {
    val () = prstr "D1Eidextapp("
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr "; "
    val () = fprint_d1explst (out, d1es)
    val () = prstr ")"
  }
//
| D1Eint (x) => {
    val () = prstr "D1Eint("
    val () = fprint_int (out, x)
    val () = prstr ")"
  }
| D1Eintrep (x) => {
    val () = prstr "D1Eintrep("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
| D1Ebool (x) => {
    val () = prstr "D1Ebool("
    val () = fprint_bool (out, x)
    val () = prstr ")"
  }
| D1Echar (x) => {
    val () = prstr "D1Echar("
    val () = fprint_char (out, x)
    val () = prstr ")"
  }
| D1Efloat (x) => {
    val () = prstr "D1Efloat("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
| D1Estring (x) => {
    val () = prstr "D1Estring("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }
//
| D1Ei0nt (x) => {
    val () = prstr "D1Ei0nt("
    val () = $SYN.fprint_i0nt (out, x)
    val () = prstr ")"
  }
| D1Ec0har (x) => {
    val () = prstr "D1Ec0har("
    val () = $SYN.fprint_c0har (out, x)
    val () = prstr ")"
  }
| D1Ef0loat (x) => {
    val () = prstr "D1Ef0loat("
    val () = $SYN.fprint_f0loat (out, x)
    val () = prstr ")"
  }
| D1Es0tring (x) => {
    val () = prstr "D1Es0tring("
    val () = $SYN.fprint_s0tring (out, x)
    val () = prstr ")"
  }
//
| D1Ecstsp (x) => {
    val () = prstr "D1Ecstsp("
    val () = $SYN.fprint_cstsp (out, x)
    val () = prstr ")"
  }
//
| D1Eliteral (d1e_lit) => {
    val () = prstr "D1Eliteral("
    val () = fprint_d1exp (out, d1e_lit)
    val () = prstr ")"
  }
//
| D1Etop () => prstr "D1Etop()"
| D1Eempty () => prstr "D1Eempty()"
//
| D1Eextval
    (s1e, name) => {
    val () = prstr "D1Eextval("
    val () = fprint_s1exp (out, s1e)
    val () = prstr "; "
    val () = prstr "\""
    val () = fprint_string (out, name)
    val () = prstr "\""
    val ((*closing*)) = prstr ")"
  } // end of [D1Eextval]
| D1Eextfcall
    (s1e, _fun, _arg) => {
    val () = prstr "D1Eextfcall("
    val () = fprint_s1exp (out, s1e)
    val () = prstr "; "
    val () = prstr "\""
    val () = fprint_string (out, _fun)
    val () = prstr "\""
    val () = prstr "; "
    val () = fprint_d1explst (out, _arg)
    val ((*closing*)) = prstr ")"
  } (* end of [D1Eextfcall] *)
| D1Eextmcall
    (s1e, _obj, _mtd, _arg) => {
    val () = prstr "D1Eextmcall("
    val () = fprint_s1exp (out, s1e)
    val () = prstr "; "
    val () = fprint_d1exp (out, _obj)
    val () = prstr "; "
    val () = prstr "\""
    val () = fprint_string (out, _mtd)
    val () = prstr "\""
    val () = prstr "; "
    val () = fprint_d1explst (out, _arg)
    val ((*closing*)) = prstr ")"
  } (* end of [D1Eextmcall] *)
//
| D1Eloopexn (knd) => {
    val () = fprintf (out, "D1Eloopexn(%i)", @(knd))
  } // end of [D1Eloopexn]
//
| D1Efoldat _ => {
    val () = fprintf (out, "D1Efoldat(...)", @())
  }
| D1Efreeat _ => {
    val () = fprintf (out, "D1Efreeat(...)", @())
  }
//
| D1Etmpid
    (qid, arg) => {
    val () = prstr "D1Etmpid("
    val () = $SYN.fprint_dqi0de (out, qid)
    val () = prstr "; "
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Elet _ => {
    val () = prstr "D1Elet("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Ewhere _ => {
    val () = prstr "D1Ewhere("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Edecseq _ => {
    val () = prstr "D1Edecseq("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Eapp_dyn (
    _fun, _locarg, npf, _arg
  ) => {
    val () = prstr "D1Eapp_dyn("
    val () = fprint_d1exp (out, _fun)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d1explst (out, _arg)
    val () = prstr ")"
  }
| D1Eapp_sta (
    d1e, s1as
  ) => {
    val () = prstr "D1Eapp_sta("
    val () = fprint_d1exp (out, d1e)
    val () = prstr "; "
    val () = fprint_s1exparglst (out, s1as)
    val () = prstr ")"
  }
//
| D1Esing (d1e) => {
    val () = prstr "D1Esing("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
| D1Elist (npf, d1es) => {
    val () = prstr "D1Elist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d1explst (out, d1es)
    val () = prstr ")"
  }
//
| D1Eifhead (
    inv, _cond, _then, _else
  ) => {
    val () = prstr "D1Eifhead("
    val () = fprint_d1exp (out, _cond)
    val () = prstr "; "
    val () = fprint_d1exp (out, _then)
    val () = prstr "; "
    val () = fprint_d1expopt (out, _else)
    val () = prstr ")"
  }
| D1Esifhead (
    inv, _cond, _then, _else
  ) => {
    val () = prstr "D1Esifhead("
    val () = fprint_s1exp (out, _cond)
    val () = prstr "; "
    val () = fprint_d1exp (out, _then)
    val () = prstr "; "
    val () = fprint_d1exp (out, _else)
    val () = prstr ")"
  }
| D1Ecasehead _ => {
    val () = prstr "D1Ecasehead("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Escasehead _ => {
    val () = prstr "D1Escasehead("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Elst (lin, opt, d1es) => {
    val () = prstr "D1Etup("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_s1expopt (out, opt)
    val () = prstr "; "
    val () = fprint_d1explst (out, d1es)
    val () = prstr ")"
  }
//
| D1Etup
    (knd, npf, d1es) => {
    val () = prstr "D1Etup(knd="
    val () = fprint_int (out, knd)
    val () = prstr "; npf="
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d1explst (out, d1es)
    val () = prstr ")"
  } // end of [D1Etup]
| D1Erec
    (knd, npf, ld1es) => {
    val () = prstr "D1Erec(knd="
    val () = fprint_int (out, knd)
    val () = prstr "; npf="
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_labd1explst (out, ld1es)
    val () = prstr ")"
  } // end of [D1Erec]
| D1Eseq (d1es) => {
    val () = prstr "D1Eseq("
    val () = fprint_d1explst (out, d1es)
    val () = prstr ")"
  } // end of [D1Eseq]
//
| D1Earrsub _ => {
    val () = prstr "D1Earrsub("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D1Earrpsz _ => {
    val () = prstr "D1Earrpsz("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D1Earrinit _ => {
    val () = prstr "D1Earrinit("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D1Eselab
    (knd, d1e, d1l) => {
    val () = prstr "D1Eselab("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_d1exp (out, d1e)
    val () = prstr "; "
    val () = fprint_d1lab (out, d1l)
    val () = prstr ")"
  }
//
| D1Eptrof (d1e) => {
    val () = prstr "D1Eptrof("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
| D1Eviewat (d1e) => {
    val () = prstr "D1Eviewat("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
//
| D1Eraise (d1e) => {
    val () = prstr "D1Eraise("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
| D1Eeffmask _ => {
    val () = prstr "D1Eeffmask("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D1Eshowtype (d1e) => {
    val () = prstr "D1Eshowtype("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
//
| D1Evcopyenv
    (knd, d1e) => {
    val () = prstr "D1Evcopyenv("
    val () = fprint_int (out, knd)
    val () = prstr ", "
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
//
| D1Etempenver (d1e) => {
    val () = prstr "D1Etempenver("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
//
| D1Esexparg (s1a) => {
    val () = prstr "D1Esexparg("
    val () = fprint_s1exparg (out, s1a)
    val () = prstr ")"
  }
//
| D1Eexist (s1a, d1e) => {
    val () = prstr "D1Eexist("
    val () = fprint_s1exparg (out, s1a)
    val () = prstr "; "
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
//
| D1Elam_dyn _ => {
    val () = prstr "D1Elam_dyn("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Elaminit_dyn _ => {
    val () = prstr "D1Elaminit_dyn("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Elam_sta_ana _ => {
    val () = prstr "D1Elam_sta_ana("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Elam_sta_syn _ => {
    val () = prstr "D1Elam_sta_syn("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Elam_met _ => {
    val () = prstr "D1Elam_met("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Efix _ => {
    val () = prstr "D1Efix("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Edelay _ => {
    val () = prstr "D1Edelay("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D1Efor _ => {
    val () = prstr "D1Efor("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Ewhile _ => {
    val () = prstr "D1Ewhile("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Etrywith _ => {
    val () = prstr "D1Etrywith("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Eann_type(d1e, s1e) => {
    val () = prstr "D1Eann_type("
    val () = fprint_d1exp (out, d1e)
    val () = prstr " : "
    val () = fprint_s1exp (out, s1e)
    val () = prstr ")"
  }
| D1Eann_effc(d1e, efc) => {
    val () = prstr "D1Eann_effc("
    val () = fprint_d1exp (out, d1e)
    val () = prstr " : "
    val () = fprint_effcst (out, efc)
    val () = prstr ")"
  }
| D1Eann_funclo(d1e, fc) => {
    val () = prstr "D1Eann_funclo("
    val () = fprint_d1exp (out, d1e)
    val () = prstr " : "
    val () = fprint_funclo (out, fc)
    val () = prstr ")"
  }
//
| D1Emacsyn(knd, d1e) => {
    val () = prstr "D1Emacsyn("
    val () = $SYN.fprint_macsynkind (out, knd)
    val () = prstr "; "
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
| D1Emacfun(name, d1es) => {
    val () = prstr "D1Emacfun("
    val () = $SYM.fprint_symbol (out, name)
    val () = prstr "; "
    val () = fprint_d1explst (out, d1es)
    val () = prstr ")"
  }
//
| D1Esolassert(d1e) => {
    val () = prstr "D1Esolassert("
    val () = fprint_d1exp (out, d1e)
    val () = prstr ")"
  }
| D1Esolverify(s1e) => {
    val () = prstr "D1Esolverify("
    val () = fprint_s1exp (out, s1e)
    val () = prstr ")"
  }
//
| D1Eerrexp ((*void*)) => prstr "D1Eerrexp()"
//
(*
| _ => prstr "D1E...(...)"
*)
//
end // end of [fprint_d1exp]

implement
print_d1exp (x) = fprint_d1exp (stdout_ref, x)
implement
prerr_d1exp (x) = fprint_d1exp (stderr_ref, x)

(* ****** ****** *)

implement
fprint_d1explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d1exp)
// end of [fprint_d1explst]

(* ****** ****** *)

implement
fprint_d1expopt
  (out, opt) = $UT.fprintopt (out, opt, fprint_d1exp)
// end of [fprint_d1expopt]

(* ****** ****** *)

implement
fprint_labd1exp
  (out, x) = {
  val $SYN.DL0ABELED (l, d1e) = x
  val () = $SYN.fprint_l0ab (out, l)
  val () = fprint_string (out, "=")
  val () = fprint_d1exp (out, d1e)
} // end of [fprint_labd1exp]

implement
fprint_labd1explst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_labd1exp)
// end of [fprint_labs1explst]

(* ****** ****** *)

implement
fprint_d1lab
  (out, d1l) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1l.d1lab_node of
| D1LABlab (lab) => {
    val () = prstr "D1LABlab("
    val () = $LAB.fprint_label (out, lab)
    val () = prstr ")"
  } // end of [D1LABlab]
| D1LABind (ind) => {
    val () = prstr "D1LABind("
    val () = $UT.fprintlst (out, ind, ", ", fprint_d1exp)
    val () = prstr ")"
  } // end of [D1LABind]
//
end // end of [fprint_d1lab]

(* ****** ****** *)

extern
fun
fprint_m1acdef : fprint_type (m1acdef)
implement
fprint_m1acdef
  (out, m1d) = {
  val sym = m1d.m1acdef_sym
  val () = $SYM.fprint_symbol (out, sym)
  val () = fprint_string (out, "(...) = ")
  val () = fprint_d1exp (out, m1d.m1acdef_def)
} (* end of [fprint_m1acdef] *)

(* ****** ****** *)

extern
fun fprint_v1aldec : fprint_type (v1aldec)
implement
fprint_v1aldec (out, x) = {
  val () = fprint_p1at (out, x.v1aldec_pat)
  val () = fprint_string (out, " = ")
  val () = fprint_d1exp (out, x.v1aldec_def)
}

(* ****** ****** *)

extern
fun fprint_v1ardec : fprint_type (v1ardec)
implement
fprint_v1ardec (out, x) = let
//
macdef
prstr (str) = fprint_string (out, ,(str))
//
val () = fprint_int (out, x.v1ardec_knd)
val () = prstr "; "
val () = $SYM.fprint_symbol (out, x.v1ardec_sym)
//
val (
) = (
  case+ x.v1ardec_type of
  | None () => ()
  | Some s1e => (prstr ": "; fprint_s1exp (out, s1e))
) (* end of [val] *)
val (
) = (
  case+ x.v1ardec_pfat of
  | None () => ()
  | Some id => (
      prstr " with "; $SYN.fprint_i0de (out, id)
    ) (* end of [Some] *)
) (* end of [val] *)
val (
) = (
  case+ x.v1ardec_init of
  | None () => ()
  | Some d1e => (prstr " = "; fprint_d1exp (out, d1e))
) (* end of [val] *)
//
in
  // nothing
end // end of [fprint_v1ardec]

(* ****** ****** *)

implement
fprint_d1ecl
  (out, d1c0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1c0.d1ecl_node of
//
| D1Cnone () => prstr "D1Cnone()"
//
| D1Clist (ds) =>
  {
    val () = prstr "D1Clist(\n"
    val () = fprint_d1eclist (out, ds)
    val () = prstr "\n)"
  } // end of [D1Clist]
//
| D1Cpackname (opt) =>
  {
    val () = prstr "D1Cpackname("
    val () = $UT.fprint_stropt (out, opt)
    val () = prstr ")"
  } // end of [D1Cpackname]
//
| D1Csymintr (ids) =>
  {
    val () = prstr "D1Csymintr("
    val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D1Csymelim (ids) =>
  {
    val () = prstr "D1Csymelim("
    val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D1Coverload
    (id, dqid, pval) => {
    val () = prstr "D1Coverload("
    val () = fprint_i0de (out, id)
    val () = prstr "; "
    val () = $SYN.fprint_dqi0de (out, dqid)
    val () = prstr "; "
    val () = fprint_int (out, pval)
    val () = prstr ")"
  } // end of [D1Coverload]
//
| D1Ce1xpdef
    (id, def) =>
  {
    val () = prstr "D1Ce1xpdef("
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr " = "
    val () = fprint_e1xp (out, def)
    val () = prstr ")"
  }
| D1Ce1xpundef
    (id, _(*def*)) => {
    val () = prstr "D1Ce1xpundef("
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| D1Cpragma(xs) =>
  {
    val () =
    prstr "D1Cpragma("
    val () = $UT.fprintlst (out, xs, ", ", fprint_e1xp)
    val () = prstr (")")  
  }
| D1Ccodegen
    (knd, xs) => {
    val () =
    prstr "D1Ccodegen("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, xs, ", ", fprint_e1xp)
    val () = prstr (")")
  } (* end of [D1Ccodegen] *)
//
| D1Cdatsrts (xs) =>
  {
    val () = prstr "D1Cdatsrts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1atsrtdec)
    val () = prstr "\n)"
  }
| D1Csrtdefs (xs) =>
  {
    val () = prstr "D1Csrtdefs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1rtdef)
    val () = prstr "\n)"
  }
//
| D1Cstacsts (xs) =>
  {
    val () = prstr "D1Cstacsts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacst)
    val () = prstr "\n)"
  }
| D1Cstacons (knd, xs) =>
  {
    val () = prstr "D1Cstacons("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacon)
    val () = prstr "\n)"
  }
//
(*
| D1Cstavars (xs) =>
  {
    val () = prstr "D1Cstavars(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tavar)
    val () = prstr "\n)"
  }
*)
//
| D1Csexpdefs (knd, xs) =>
  {
    val () = prstr "D1Csexpdefs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1expdef)
    val () = prstr "\n)"
  }
| D1Csaspdec (x) =>
  {
    val () = prstr "D1Csaspdec("
    val () = fprint_s1aspdec (out, x)
    val () = prstr ")"
  }
//
| D1Cdatdecs
    (knd, xs1, xs2) => {
    val () = prstr "D1Cdatdecs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cexndecs (xs) =>
  {
    val () = prstr "D1Cexndecs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_e1xndec)
    val () = prstr "\n)"
  }
//
| D1Cclassdec
    (id, sup) => {
    val () = prstr "D1Cclassdec("
    val () = fprint_i0de (out, id)
    val () = (case+ sup of
      | Some s1e => let
          val () = prstr " : " in fprint_s1exp (out, s1e)
        end // end of [Some]
      | None () => ()
    ) : void // end of [val]
    val () = prstr ")"
  }
//
| D1Cdcstdecs
  (
    knd, dck, qarg, xs
  ) => {
    val () = prstr "D1Cdcstdecs("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_dcstkind (out, dck)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1cstdec)
    val () = prstr "\n)"
  }
//
| D1Cextype
    (name, def) => {
    val () = prstr "D1Cextype("
    val () = (
      fprint_string (out, name);
      prstr " = "; fprint_s1exp (out, def)
    ) (* end of [val] *)
    val () = prstr ")"
  }
| D1Cextype
  (
    knd, name, def
  ) => {
    val () = prstr "D1Cextype("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_s1exp (out, def)
    val () = prstr ")"
  }
//
| D1Cextvar
    (name, def) => {
    val () = prstr "D1Cextvalr"
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_d1exp (out, def)
    val ((*closing*)) = prstr ")"
  }
//
| D1Cextcode
  (
    knd, pos, code
  ) => {
    val () = prstr "D1Cextcode("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, pos)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
//
| D1Cmacdefs
  (
    knd, isrec, ds
  ) => {
    val () = prstr "D1macdef("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_bool (out, isrec)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_m1acdef)
    val () = prstr "\n)"
  }
//
| D1Cimpdec
  (
    knd, imparg, d
  ) => {
    val qid = d.i1mpdec_qid
    val () = prstr "D1Cimpdec["
    val () = fprint_int (out, knd)
    val () = prstr "]"
    val () = fprint_i1mparg (out, imparg)
    val () = prstr "(\n"
//
    val q = qid.impqi0de_qua
    and id = qid.impqi0de_sym
    val () = $SYN.fprint_d0ynq (out, q)
    val () = $SYM.fprint_symbol (out, id)
//
    val () = prstr "; "
    val () = fprint_d1exp (out, d.i1mpdec_def)
    val () = prstr "\n)"
  }
//
| D1Cfundecs
    (knd, q1mas, ds) => {
    val () = prstr "D1Cfundecs("
    val () = fprint_funkind (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, q1mas, "; ", fprint_q1marg)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cvaldecs
    (knd, isrec, ds) => {
    val () = prstr "D1Cvaldecs("
    val () = fprint_valkind (out, knd)
    val () = prstr "; "
    val () = fprint_bool (out, isrec)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_v1aldec)
    val () = prstr "\n)"
  }
| D1Cvardecs (knd, ds) => {
    val () = prstr "D1Cvardecs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_v1ardec)
    val () = prstr "\n)"
  }
//
| D1Cinclude
    (knd, ds) => {
    val () = prstr "D1Cinclude("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_d1ecl)
    val () = prstr "\n)"
  }
//
| D1Cstaload
  (
    idopt, fname, _, _
  ) => {
    val () = prstr "D1Cstaload("
    val () =
      $SYM.fprint_symbolopt (out, idopt)
    val () = prstr "="
    val () =
      $FIL.fprint_filename_full (out, fname)
    val () = prstr ")"
  } (* end of [D1Cstaload] *)
| D1Cstaloadnm
    (alias, nspace) => {
    val () = prstr "D1Cstaloadnm("
    val () =
      $SYM.fprint_symbolopt (out, alias)
    val () = prstr "="
    val () = $SYM.fprint_symbol (out, nspace)
    val () = prstr ")"
  } (* end of [D1Cstaname] *)
| D1Cstaloadloc
    (pfil, nspace, d1cs) => {
    val () = prstr "D1Cstaloadloc("
    val () = $SYM.fprint_symbol (out, nspace)
    val ((*omitted*)) = prstr ", ...)"
  } (* end of [D1Cstaloadloc] *)
//
| D1Cdynload (fname) => {
    val () = prstr "D1Cdynload("
    val () = $FIL.fprint_filename_full (out, fname)
    val () = prstr ")"
  } (* end of [D1Cdynload] *)
//
| D1Clocal
  (
    ds_head, ds_body
  ) => {
    val () = prstr "D1Clocal(\n"
    val () = fprint_d1eclist (out, ds_head)
    val () = prstr "\n(*in*)\n"
    val () = fprint_d1eclist (out, ds_body)
    val () = prstr "\n)"
  }
//
  | _ => prstr "D1C...(...)"
//
end // end of [fprint_d1ecl]

implement
print_d1ecl (x) = fprint_d1ecl (stdout_ref, x)
implement
prerr_d1ecl (x) = fprint_d1ecl (stderr_ref, x)

(* ****** ****** *)

implement
fprint_d1eclist
  (out, xs) = $UT.fprintlst (out, xs, "\n", fprint_d1ecl)
// end of [fprint_d1eclist]

(* ****** ****** *)

(* end of [pats_dynexp1_print.dats] *)
