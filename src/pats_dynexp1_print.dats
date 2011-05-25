(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: April, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol
staload SYN = "pats_syntax.sats"

(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

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
(*
| P1Tanys () => prstr "P1Tanys()"
*)
| P1Tide (id) => {
    val () = prstr "P1Tide("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
| P1Tdqid (q, id) => {
    val () = prstr "P1Tdqid("
    val () = ($SYN.fprint_d0ynq (out, q); fprint_symbol (out, id))
    val () = prstr ")"
  }
| P1Tref (sym) => {
    val () = prstr "P1Tref("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
//
| P1Tint (rep) => {
    val () = prstr "P1Tint("
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
| P1Tlst (p1ts) => {
    val () = prstr "P1Tlst("
    val () = fprint_p1atlst (out, p1ts)
    val () = prstr ")"
  }
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
//
| P1Tfree (p1t) => {
    val () = prstr "P1Tfree("
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  }
//
| P1Tas (sym, loc_id, p1t) => {
    val () = prstr "P1Tas("
    val () = fprint_symbol (out, sym)
    val () = prstr "; "
    val () = fprint_p1at (out, p1t)
    val () = prstr ")"
  }
| P1Trefas (sym, loc_id, p1t) => {
    val () = prstr "P1Trefas("
    val () = fprint_symbol (out, sym)
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
| P1Terr () => prstr "P1Terr()"
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
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x.labp1at_node of
  | LABP1ATnorm (lab, p1t) => {
      val () = prstr "LABP1ATnorm("
      val () = fprint_l0ab (out, lab)
      val () = fprint_p1at (out, p1t)
      val () = prstr ")"
    }
  | LABP1ATomit () => prstr "LABP1ATomit()"
end // end of [fprint_labp1at]

(* ****** ****** *)

implement
fprint_d1exp
  (out, d1e0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1e0.d1exp_node of
| D1Eide (id) => {
    val () = prstr "D1Eide("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
| D1Edqid (dq, id) => {
    val () = prstr "D1Edqid("
    val () = fprint_d0ynq (out, dq)
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| D1Ebool (x) => {
    val () = prstr "D1Ebool("
    val () = fprint_bool (out, x)
    val () = prstr ")"
  }
| D1Eint (rep) => {
    val () = prstr "D1Eint("
    val () = fprint_string (out, rep)
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
    val () = fprint_i0nt (out, x)
    val () = prstr ")"
  }
| D1Ec0har (x) => {
    val () = prstr "D1Ec0har("
    val () = fprint_c0har (out, x)
    val () = prstr ")"
  }
| D1Ef0loat (x) => {
    val () = prstr "D1Ef0loat("
    val () = fprint_f0loat (out, x)
    val () = prstr ")"
  }
| D1Es0tring (x) => {
    val () = prstr "D1Es0tring("
    val () = fprint_s0tring (out, x)
    val () = prstr ")"
  }
//
| D1Eempty () => prstr "D1Eempty()"
| D1Etop () => prstr "D1Etop()"
//
| D1Etmpid (qid, arg) => {
    val () = prstr "D1Etmpid("
    val () = fprint_dqi0de (out, qid)
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
| D1Elist (npf, xs) => {
    val () = prstr "D1Elist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d1explst (out, xs)
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
| D1Esel (knd, d1e, d1l) => {
    val () = prstr "D1Esel("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_d1exp (out, d1e)
    val () = prstr "; "
    val () = fprint_d1lab (out, d1l)
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
//
| D1Etrywith _ => {
    val () = prstr "D1Etrywith("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Eann_type (d1e, s1e) => {
    val () = prstr "D1Eann_type("
    val () = fprint_d1exp (out, d1e)
    val () = prstr " : "
    val () = fprint_s1exp (out, s1e)
    val () = prstr ")"
  }
| D1Eann_effc _ => {
    val () = prstr "D1Eann_effc("
    val () = prstr "..."
    val () = prstr ")"
  }
| D1Eann_funclo _ => {
    val () = prstr "D1Eann_funclo("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D1Eerr () => {
    val () = prstr "D1Eerr()"
  }
//
| _ => prstr "D1E...(...)"
//
end // end of [fprint_d1exp]

implement
print_d1exp (x) = fprint_d1exp (stdout_ref, x)
implement
prerr_d1exp (x) = fprint_d1exp (stderr_ref, x)

implement
fprint_d1explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d1exp)
// end of [fprint_d1explst]

implement
fprint_d1expopt
  (out, opt) = $UT.fprintopt (out, opt, fprint_d1exp)
// end of [fprint_d1expopt]

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
    val () = $UT.fprintlst (out, ind, "; ", fprint_d1explst)
    val () = prstr ")"
  } // end of [D1LABind]
//
end // end of [fprint_d1lab]

(* ****** ****** *)

extern
fun fprint_m1acdef : fprint_type (m1acdef)
implement
fprint_m1acdef (out, x) = {
  val () = fprint_symbol (out, x.m1acdef_sym)
  val () = fprint_string (out, "(...)")
  val () = fprint_string (out, " = ")
  val () = fprint_d1exp (out, x.m1acdef_def)
}

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

implement
fprint_d1ecl
  (out, d1c0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ d1c0.d1ecl_node of
| D1Cnone () => prstr "D1Cnone()"
| D1Clist (ds) => {
    val () = prstr "D1Clist(\n"
    val () = fprint_d1eclist (out, ds)
    val () = prstr "\n)"
  } // end of [D1Clist]
//
| D1Csymintr (ids) => {
    val () = prstr "D1Csymintr("
    val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D1Csymelim (ids) => {
    val () = prstr "D1Csymelim("
    val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D1Coverload (id, dqid) => {
    val () = prstr "D1Coverload("
    val () = fprint_i0de (out, id)
    val () = prstr "; "
    val () = fprint_dqi0de (out, dqid)
    val () = prstr ")"
  }
//
| D1Ce1xpdef (id, def) => {
    val () = prstr "D1Ce1xpdef("
    val () = fprint_symbol (out, id)
    val () = prstr " = "
    val () = fprint_e1xp (out, def)
    val () = prstr ")"
  }
| D1Ce1xpundef (id) => {
    val () = prstr "D1Ce1xpundef("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| D1Cdatsrts (xs) => {
    val () = prstr "D1Cdatsrts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1atsrtdec)
    val () = prstr "\n)"
  }
| D1Csrtdefs (xs) => {
    val () = prstr "D1Csrtdefs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1rtdef)
    val () = prstr "\n)"
  }
//
| D1Cstacsts (xs) => {
    val () = prstr "D1Cstacsts(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacst)
    val () = prstr "\n)"
  }
| D1Cstacons (knd, xs) => {
    val () = prstr "D1Cstacons("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tacon)
    val () = prstr "\n)"
  }
| D1Cstavars (xs) => {
    val () = prstr "D1Cstavars(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1tavar)
    val () = prstr "\n)"
  }
//
| D1Csexpdefs (knd, xs) => {
    val () = prstr "D1Csexpdefs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_s1expdef)
    val () = prstr "\n)"
  }
| D1Csaspdec (x) => {
    val () = prstr "D1Csaspdec("
    val () = fprint_s1aspdec (out, x)
    val () = prstr ")"
  }
//
| D1Cdatdecs (knd, xs1, xs2) => {
    val () = prstr "D1Cdatdecs("
    val () = fprint_int (out, knd)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cexndecs (xs) => {
    val () = prstr "D1Cexndecs(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_e1xndec)
    val () = prstr "\n)"
  }
//
| D1Cclassdec (id, sup) => {
    val () = prstr "D1Cclassdec("
    val () = fprint_i0de (out, id)
    val () = (case+ sup of
      | Some s1e => let
          val () = prstr " : " in fprint_s1exp (out, s1e)
        end
      | None () => ()
    ) : void // end of [val]
    val () = prstr ")"
  }
//
| D1Cdcstdecs (dck, qarg, xs) => {
    val () = prstr "D1Cdcstdecs("
    val () = fprint_dcstkind (out, dck)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1cstdec)
    val () = prstr "\n)"
  }
//
| D1Cextype (name, def) => {
    val () = prstr "D1Cextype("
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_s1exp (out, def)
    val () = prstr ")"
  }
| D1Cextype (knd, name, def) => {
    val () = prstr "D1Cextype("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_s1exp (out, def)
    val () = prstr ")"
  }
| D1Cextval (name, def) => {
    val () = prstr "D1Cextval("
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_d1exp (out, def)
    val () = prstr ")"
  }
//
| D1Cmacdefs (knd, isrec, ds) => {
    val () = prstr "D1macdef("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_bool (out, isrec)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_m1acdef)
    val () = prstr "\n)"
  }
//
| D1Cvaldecs (knd, isrec, ds) => {
    val () = prstr "D1Cvaldecs("
    val () = fprint_valkind (out, knd)
    val () = prstr "; "
    val () = fprint_bool (out, isrec)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, ds, "\n", fprint_v1aldec)
    val () = prstr "\n)"
  }
| D1Cfundecs (knd, q1mas, ds) => {
    val () = prstr "D1Cfundecs("
    val () = fprint_funkind (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, q1mas, "; ", fprint_q1marg)
    val () = prstr "\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cvardecs (ds) => {
    val () = prstr "D1Cvardecs(\n"
    val () = prstr "..."
    val () = prstr "\n)"
  }
| D1Cimpdec (s1mas, d) => {
    val () = prstr "D1Cimpdec("
    val () = $UT.fprintlst (out, s1mas, "; ", fprint_s1marg)
    val () = prstr "..."
    val () = prstr "\n)"
  }
//
| D1Cinclude (xs) => {
    val () = prstr "D1Cinclude(\n"
    val () = $UT.fprintlst (out, xs, "\n", fprint_d1ecl)
    val () = prstr "\n)"
  }
//
| D1Clocal (
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
