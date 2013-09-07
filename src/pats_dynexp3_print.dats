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
// Start Time: May, 2012
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload LEX = "./pats_lexing.sats"

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol
staload SYN = "./pats_syntax.sats"
macdef fprint_cstsp = $SYN.fprint_cstsp
macdef fprint_l0ab = $SYN.fprint_l0ab
macdef fprint_i0de = $SYN.fprint_i0de
macdef fprint_d0ynq = $SYN.fprint_d0ynq

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

implement
fprint_p3at
  (out, p3t0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ p3t0.p3at_node of
//
| P3Tany (d2v) => {
    val () = prstr "P3Tany("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| P3Tvar (d2v) => {
    val () = prstr "P3Tvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| P3Tcon (
    pck, d2c, npf, p3ts
  ) => {
    val () = prstr "P3Tcon("
    val () = fprint_pckind (out, pck)
    val () = prstr "; "
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p3atlst (out, p3ts)
    val () = prstr ")"
  } // end of [P3Tcon]
//
| P3Tint (i) =>
    fprintf (out, "P3Tint(%i)", @(i))
| P3Tintrep (s) =>
    fprintf (out, "P3Tintrep(%s)", @(s))
//
| P3Tbool (b) => let
    val name = if b then "true" else "false"
  in
    fprintf (out, "P3Tbool(%s)", @(name))
  end // end of [P3Tbool]
| P3Tchar (c) =>
    fprintf (out, "P3Tchar(%c)", @(c))
| P3Tfloat (rep) =>
    fprintf (out, "P3Tfloat(%s)", @(rep))
| P3Tstring (str) =>
    fprintf (out, "P3Tstring(%s)", @(str))
//
| P3Ti0nt (i) => prstr "P3Ti0nt(...)"
| P3Tf0loat (f) => prstr "P3Tf0loat(...)"
//
| P3Tempty () => prstr "P3Tempty()"
//
| P3Trec _ => prstr "P3Trec(...)"
| P3Tlst (
    lin, s2e_elt, p3ts
  ) => {
    val () = prstr "P3Tlst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e_elt)
    val () = prstr "; "
    val () = fprint_p3atlst (out, p3ts)
    val () = prstr ")"
  }
//
| P3Trefas (d2v, p3t) => {
    val () = prstr "P3Trefas("
    val () = fprint_d2var (out, d2v)
    val () = prstr " -> "
    val () = fprint_p3at (out, p3t)
    val () = prstr ")"
  } // end of [P3Trefas]
//
| P3Texist (s2vs, p3t) => {
    val () = prstr "P3Texist("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_p3at (out, p3t)
    val () = prstr ")"
  } // end of [P3Texist]
//
| P3Tvbox (d2v) => {
    val () = prstr "P3Tvbox("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  } // end of [P3Tvbox]
//
| P3Tann (p3t, s2e) => {
    val () = prstr "P3Tann("
    val () = fprint_p3at (out, p3t)
    val () = prstr " : "
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [P3Tann]
//
| P3Terr () => prstr "P3Terr()"
// end of [p3at_node]
end // end of [fprint_p3at]

implement
print_p3at (p3t) = fprint_p3at (stdout_ref, p3t)
implement
prerr_p3at (p3t) = fprint_p3at (stderr_ref, p3t)

(* ****** ****** *)

implement
fprint_p3atlst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_p3at)
// end of [fprint_p3atlst]

(* ****** ****** *)

implement
fprint_d3exp
  (out, d3e0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ d3e0.d3exp_node of
//
| D3Ecst (d2c) => {
    val () = prstr "D3Ecst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ")"
  }
| D3Evar (d2v) => {
    val () = prstr "D3Evar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| D3Eint (i) => {
    val () = prstr "D3Eint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| D3Eintrep (rep) => {
    val () = prstr "D3Eintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| D3Ebool (b) => {
    val () = prstr "D3Ebool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| D3Echar (c) => {
    val () = prstr "D3Echar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| D3Efloat (rep) => {
    val () = prstr "D3Efloat("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| D3Estring (str) => {
    val () = prstr "D3Estring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| D3Ei0nt (tok) => {
    val () = prstr "D3Ei0nt("
    val () = $SYN.fprint_i0nt (out, tok)
    val () = prstr ")"
  }
| D3Ef0loat (tok) => {
    val () = prstr "D3Ef0loat("
    val () = $SYN.fprint_f0loat (out, tok)
    val () = prstr ")"
  }
//
| D3Ecstsp (x) => {
    val () = $SYN.fprint_cstsp (out, x)
  }
//
| D3Etop () => prstr "D3Etop()"
| D3Eempty () => prstr "D3Eempty()"
//
| D3Eextval
    (name) => {
    val () = prstr "D3Eextval("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
| D3Eextfcall
    (_fun, _arg) => {
    val () = prstr "D3Eextfcall("
    val () = fprint_string (out, _fun)
    val () = prstr "; "
    val () = fprint_d3explst (out, _arg)
    val () = prstr ")"
  }
//
| D3Econ (
    d2c, npf, d3es
  ) => {
    val () = prstr "D3Econ("
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d3explst (out, d3es)
    val () = prstr ")"
  }
//
| D3Etmpcst (d2c, _) => {
    val () = prstr "D3Etmpcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "; "
    val () = prstr "..."
    val () = prstr ")"
  }
| D3Etmpvar (d2v, _) => {
    val () = prstr "D3Etmpvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr "; "
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D3Efoldat (d3e) => {
    val () = prstr "D3Efoldat("
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
| D3Efreeat (d3e) => {
    val () = prstr "D3Efreeat("
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
//
| D3Elet _ => prstr "D3Elet(...)"
//
| D3Eapp_sta (d3e) => {
    val () = prstr "D3Eapp_sta("
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
| D3Eapp_dyn (
    d3e, npf, d3es
  ) => {
    val () = prstr "D3Eapp_dyn("
    val () = prstr "; "
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d3explst (out, d3es)
    val () = prstr ")"
  } // end of [D3Eapp_dyn]
//
| D3Eitem
    (d2i, t2mas) => {
    val () = prstr "D3Eitem("
    val () = fprint_d2itm (out, d2i)
    val () = prstr "; "
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ")"
  }
//
| D3Eif (
    _cond, _then, _else
  ) => {
    val () = prstr "D3Eif("
    val () = fprint_d3exp (out, _cond)
    val () = prstr "; "
    val () = fprint_d3exp (out, _then)
    val () = prstr "; "
    val () = fprint_d3exp (out, _else)
    val () = prstr ")"
  }
| D3Esif (
    _cond, _then, _else
  ) => {
    val () = prstr "D3Esif("
    val () = fprint_s2exp (out, _cond)
    val () = prstr "; "
    val () = fprint_d3exp (out, _then)
    val () = prstr "; "
    val () = fprint_d3exp (out, _else)
    val () = prstr ")"
  }
//
| D3Ecase _ => {
    val () = prstr "D3Ecase("
    val () = prstr "..."
    val () = prstr ")"
  }
| D3Escase _ => {
    val () = prstr "D3Escase("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D3Elst (lin, s2e, d3es) => {
    val () = prstr "D3Elst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e)
    val () = prstr "; "
    val () = fprint_d3explst (out, d3es)
    val () = prstr ")"
  } // end of [D3Elst]
| D3Etup (
    knd, npf, d3es
  ) =>  {
    val () = prstr "D3Eseq("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d3explst (out, d3es)
    val () = prstr ")"
  } // end of [D3Etup]
| D3Erec _ => prstr "D3Erec(...)"
| D3Eseq (d3es) => {
    val () = prstr "D3Eseq("
    val () = fprint_d3explst (out, d3es)
    val () = prstr ")"
  } // end of [D3Eseq]
//
| D3Eselab (d3e, d3ls) => {
    val () = prstr "D3Eselab("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D3Eptrofvar
    (d2v) => {
    val () = prstr "D3Eptrofvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| D3Eptrofsel
    (d3e, s2rt, d3ls) => {
    val () = prstr "D3Eptrofsel("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2rt)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Eviewat
    (d3e, d3ls) => {
    val () = prstr "D3Eviewat("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D3Erefarg (
    refval, freeknd, d3e
  ) => {
    val () = prstr "D3Erefarg("
    val () = fprint_int (out, refval)
    val () = prstr "; "
    val () = fprint_int (out, freeknd)
    val () = prstr "; "
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
//
| D3Esel_var (d2v, s2rt, d3ls) => {
    val () = prstr "D3Esel_var("
    val () = fprint_d2var (out, d2v)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2rt)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Esel_ptr (d3e, s2rt, d3ls) => {
    val () = prstr "D3Esel_ptr("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2rt)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Esel_ref (d3e, s2rt, d3ls) => {
    val () = prstr "D3Esel_ref("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2rt)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D3Eassgn_var _ => prstr "D3Eassgn_var(...)"
| D3Eassgn_ptr _ => prstr "D3Eassgn_ptr(...)"
| D3Eassgn_ref _ => prstr "D3Eassgn_ref(...)"
//
| D3Exchng_var _ => prstr "D3Exchng_var(...)"
| D3Exchng_ptr _ => prstr "D3Exchng_ptr(...)"
| D3Exchng_ref _ => prstr "D3Exchng_ref(...)"
//
| D3Eviewat_assgn _ => prstr "D3Eviewat_assgn(...)"
//
| D3Earrpsz
    (s2e, d3es, asz) => {
    val () = prstr "D3Earrpsz("
    val () = fprint_s2exp (out, s2e)
    val () = prstr "; "
    val () = fprint_d3explst (out, d3es)
    val () = prstr "; "
    val () = fprint_int (out, asz)
    val () = prstr ")"
  }
| D3Earrinit
  (
    s2e_elt, d3e_asz, d3es_elt
  ) => {
    val () = prstr "D3Earrinit("
    val () = fprint_s2exp (out, s2e_elt)
    val () = prstr "; "
    val () = fprint_d3exp (out, d3e_asz)
    val () = prstr "; "
    val () = fprint_d3explst (out, d3es_elt)
    val () = prstr ")"
  } // end of [D3Earrinit]
//
| D3Eraise (d3e) => {
    val () = prstr "D3Eraise("
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
| D3Eeffmask
    (s2fe, d3e) => {
    val () = prstr "D3Eraise("
    val () = fprint_s2eff (out, s2fe)
    val () = prstr "; "
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
//
| D3Evcopyenv
    (knd, d2v) => {
    val () = prstr "D3Evcopyenv("
    val () = fprint_int (out, knd)
    val () = prstr ", "
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| D3Elam_dyn (
    lin, npf, _arg, _body
  ) => {
    val () = prstr "D3Elam_dyn("
    val () = prstr "lin="
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = prstr "npf="
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_p3atlst (out, _arg)
    val () = prstr "; "
    val () = fprint_d3exp (out, _body)
    val () = prstr ")"
  } // end of [D3Elam_dyn]
| D3Elaminit_dyn _ => prstr "D3Elaminit_dyn(...)"
| D3Elam_sta (
    s2vs, s2ps, _body
  ) => {
    val () = prstr "D3Elam_sta("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_s2explst (out, s2ps)
    val () = prstr "; "
    val () = fprint_d3exp (out, _body)
    val () = prstr ")"
  }
| D3Elam_met
    (_met, _body) => {
    val () = prstr "D3Elam_met("
    val () = fprint_s2explst (out, _met)
    val () = prstr "; "
    val () = fprint_d3exp (out, _body)
    val () = prstr ")"
  }
//
| D3Edelay (d3e) => {
    val () = prstr "D3Edelay("
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
| D3Eldelay (d3e, opt) => {
    val () = prstr "D3Eldelay("
    val () = fprint_d3exp (out, d3e)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Elazy_force (lin, d3e) => {
    val () = prstr "D3Elazy_force("
    val () = fprint_int (out, lin)
    val () = fprint_d3exp (out, d3e)
    val () = prstr ")"
  }
//
| D3Eloop _ => {
    val () = prstr "D3Eloop("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D3Eloopexn (knd) => {
    val () = fprintf (out, "D3Eloopexn(%i)", @(knd))
  }
//
| D3Etrywith _ => {
    val () = prstr "D3Etrywith("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D3Eann_type
    (d3e, ann) => {
    val () = prstr "D3Eann_type("
    val () = fprint_d3exp (out, d3e)
    val () = prstr " : "
    val () = fprint_s2exp (out, ann)
    val () = prstr ")"
  }
//
| D3Eerr _ => prstr "D3Eerr()"
//
(*
| _ => {
    val () = prstr "D3E...(...)"
  }
*)
//
end // end of [fprint_d3exp]

(* ****** ****** *)

implement
print_d3exp (x) = fprint_d3exp (stdout_ref, x)
implement
prerr_d3exp (x) = fprint_d3exp (stderr_ref, x)

(* ****** ****** *)

implement
fprint_d3explst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_d3exp)
// end of [fprint_d3explst]

(* ****** ****** *)

implement
fprint_d3ecl
  (out, d3c0) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ d3c0.d3ecl_node of
//
| D3Cnone _ => prstr "D3Cnone()"
| D3Clist _ => prstr "D3Clist(...)"
//
// HX: needed for compiling abstract types
//
| D3Csaspdec _ => prstr "D3Csaspdec(...)"
//
| D3Cextcode _ => prstr "D3Cextcode(...)"
//
| D3Cdatdecs _ => prstr "D3Cdatdecs(...)"
| D3Cexndecs _ => prstr "D3Cexndecs(...)"
| D3Cdcstdecs _ => prstr "D3Cdcstdecs(...)"
//
| D3Cimpdec _ => prstr "D3Cimpdec(...)"
//
| D3Cfundecs _ => prstr "D3Cfundecs(...)"
//
| D3Cvaldecs _ => prstr "D3Cvaldecs(...)"
| D3Cvaldecs_rec _ => prstr "D3Cvaldecs(...)"
//
| D3Cvardecs _ => prstr "D3Cvardecs(...)"
| D3Cprvardecs _ => prstr "D3Cprvardecs(...)"
//
| D3Cinclude _ => prstr "D3Cinclude(...)"
//
| D3Cstaload _ => prstr "D3Cstaload(...)"
//
| D3Cdynload (fil) =>
  {
    val () = prstr "D3Cdynload("
    val () = $FIL.fprint_filename_full (out, fil)
    val () = prstr ")"
  }
//
| D3Clocal _ => prstr "D3Clocal(...)"
//
end // end of [fprint_d3ecl]

(* ****** ****** *)

implement
print_d3ecl (x) = fprint_d3ecl (stdout_ref, x)
implement
prerr_d3ecl (x) = fprint_d3ecl (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_dynexp3_print.dats] *)
