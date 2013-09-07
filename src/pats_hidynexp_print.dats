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
// Start Time: September, 2012
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload FIL = "./pats_filename.sats"
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

implement
fprint_hipat
  (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x.hipat_node of
//
| HIPany () => {
    val () = prstr "HIPany()"
  }
| HIPvar (d2v) => {
    val () = prstr "HIPvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| HIPcon (
    pck, d2c, hse_sum, lhips
  ) => {
    val () = prstr "HIPcon("
    val () = fprint_d2con (out, d2c)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_sum)
    val () = prstr "; "
    val () = fprint_labhipatlst (out, lhips)
    val () = prstr ")"
    val () = prstr ")"
  }
| HIPcon_any (pck, d2c) => {
    val () = prstr "HIPcon_any("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
//
| HIPint (i) => {
    val () = prstr "HIPint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| HIPbool (b) => {
    val () = prstr "HIPbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| HIPchar (c) => {
    val () = prstr "HIPchar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| HIPstring (str) => {
    val () = prstr "HIPstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
| HIPfloat (rep) => {
    val () = prstr "HIPfloat("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
//
| HIPi0nt (tok) => {
    val () = prstr "HIPi0nt("
    val () = $SYN.fprint_i0nt (out, tok)
    val () = prstr ")"
  }
| HIPf0loat (tok) => {
    val () = prstr "HIPf0loat("
    val () = $SYN.fprint_f0loat (out, tok)
    val () = prstr ")"
  }
//
| HIPempty () => prstr "HIPempty()"
//
| HIPrec (
    knd, lhips, hse_rec
  ) => {
    val () = prstr "HIPrec("
    val () = fprintf (out, "knd= %i", @(knd))
    val () = prstr "; "
    val () = fprint_labhipatlst (out, lhips)
    val () = prstr ")"
  } // end of [HIPrec]
//
| HIPann (hip, ann) => {
    val () = prstr "HIPann("
    val () = fprint_hipat (out, hip)
    val () = prstr " : "
    val () = fprint_hisexp (out, ann)
    val () = prstr ")"
  }
//
| _ => {
    val () = fprint_string (out, "HIP...(...)")
  } // end of [_]
//
end // end of [fprint_hipat]

implement
print_hipat (x) = fprint_hipat (stdout_ref, x)
implement
prerr_hipat (x) = fprint_hipat (stderr_ref, x)

implement
fprint_hipatlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_hipat)
// end of [fprint_hipatlst]

extern
fun fprint_labhipat : fprint_type (labhipat)
implement
fprint_labhipat
  (out, lx) = {
  val LABHIPAT (l, x) = lx
  val () =
    $LAB.fprint_label (out, l)
  val () = fprint_string (out, "= ")
  val () = fprint_hipat (out, x)
} // end of [fprint_labhipat]

implement
fprint_labhipatlst
  (out, lxs) = $UT.fprintlst (out, lxs, ", ", fprint_labhipat)
// end of [fprint_labhipatlst]

(* ****** ****** *)

implement
fprint_hilab
  (out, hil) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ hil.hilab_node of
| HILlab (lab) => {
    val () = prstr "HILlab("
    val () = $LAB.fprint_label (out, lab)
    val () = prstr ")"
  } // end of [HILlab]
| HILind (ind) => {
    val () = prstr "HILind("
    val () = $UT.fprintlst (out, ind, ", ", fprint_hidexp)
    val () = prstr ")"
  } // end of [HILind]
//
end // end of [fprint_hilab]

implement
fprint_hilablst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_hilab)
// end of [fprint_hilablst]

(* ****** ****** *)

extern
fun fprint_higmat : fprint_type (higmat)
extern
fun fprint_hiclau : fprint_type (hiclau)

(* ****** ****** *)

implement
fprint_hidexp
  (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+
  x.hidexp_node of
//
| HDEcst (d2c) => {
    val () = prstr "HDEcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ")"
  }
| HDEvar (d2v) => {
    val () = prstr "HDEvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| HDEint (i) => {
    val () = prstr "HDEint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| HDEintrep (rep) => {
    val () = prstr "HDEintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| HDEbool (b) => {
    val () = prstr "HDEbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| HDEchar (c) => {
    val () = prstr "HDEchar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| HDEfloat (rep) => {
    val () = prstr "HDEfloat("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| HDEstring (str) => {
    val () = prstr "HDEstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| HDEi0nt (tok) => {
    val () = prstr "HDEi0nt("
    val () = $SYN.fprint_i0nt (out, tok)
    val () = prstr ")"
  }
| HDEf0loat (tok) => {
    val () = prstr "HDEf0loat("
    val () = $SYN.fprint_f0loat (out, tok)
    val () = prstr ")"
  }
//
| HDEcstsp (x) => {
    val () = $SYN.fprint_cstsp (out, x)
  }
//
| HDEtop () => prstr "HDEtop()"
| HDEempty () => prstr "HDEempty()"
//
| HDEextval (name) =>
  {
    val () = prstr "HDEextval("
    val () = prstr "\""
    val () = fprint_string (out, name)
    val () = prstr "\""
    val () = prstr ")"
  }
| HDEextfcall
    (_fun, _arg) =>
  {
    val () = prstr "HDEextfcall("
    val () = prstr "\""
    val () = fprint_string (out, _fun)
    val () = prstr "\""
    val () = prstr "; "
    val () = fprint_hidexplst (out, _arg)
    val () = prstr ")"
  }
//
| HDEcastfn (d2c, arg) => {
    val () = prstr "HDEcastfn("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ", "
    val () = fprint_hidexp (out, arg)
    val () = prstr ")"
  }
//
| HDEcon (
    d2c, hse_sum, lhdes
  ) => {
    val () = prstr "HDEcon("
    val () = fprint_d2con (out, d2c)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_sum)
    val () = prstr "; "
    val () = fprint_labhidexplst (out, lhdes)
    val () = prstr ")"
    val () = prstr ")"
  } // end of [HDEcon]
//
| HDEtmpcst (d2c, t2mas) => {
    val () = prstr "HDEtmpcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
| HDEtmpvar (d2v, t2mas) => {
    val () = prstr "HDEtmpvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
//
| HDEfoldat () => prstr "HDEfoldat()"
| HDEfreeat (hde) => {
    val () = prstr "HDEfreeat("
    val () = fprint_hidexp (out, hde)
    val () = prstr ")"
  }
//
| HDElet (hids, hde) => {
    val () = prstr "HDElet(\n"
    val () = fprint_hideclist (out, hids)
    val () = prstr "**in**\n"
    val () = fprint_hidexp (out, hde)
    val () = prstr "\n)"
  }
//
| HDEapp (
    _fun, hse_fun, _arg
  ) => {
    val () = prstr "HDEapp("
    val () = fprint_hidexp (out, _fun)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_fun)
    val () = prstr "; "
    val () = fprint_hidexplst (out, _arg)
    val () = prstr ")"
    val () = prstr ")"
  }
//
| HDEif (
    _cond, _then, _else
  ) => {
    val () = prstr "HDEif("
    val () = fprint_hidexp (out, _cond)
    val () = prstr "; "
    val () = fprint_hidexp (out, _then)
    val () = prstr "; "
    val () = fprint_hidexp (out, _else)
    val () = prstr ")"
  } // end of [HDEif]
| HDEsif (
    _cond, _then, _else
  ) => {
    val () = prstr "HDEsif("
    val () = fpprint_s2exp (out, _cond)
    val () = prstr "; "
    val () = fprint_hidexp (out, _then)
    val () = prstr "; "
    val () = fprint_hidexp (out, _else)
    val () = prstr ")"
  } // end of [HDEsif]
//
| HDEcase (
    knd, hdes, hcls
  ) => {
    val () = prstr "HDEcase(\n"
    val () = fprint_caskind (out, knd)
    val () = prstr "\n"
    val () = fprint_hidexplst (out, hdes)
    val () = prstr "\n"
    val () = $UT.fprintlst (out, hcls, "\n", fprint_hiclau)
    val () = prstr "\n)"
  } // end of [HDEcase]
//
| HDElst (
    lin, hse_elt, hdes
  ) => {
    val () = prstr "HDElst("
    val () = fprintf (out, "lin= %i", @(lin))
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr "; "
    val () = fprint_hidexplst (out, hdes)
    val () = prstr ")"
  } // end of [HDElst]
| HDErec (
    knd, lhdes, hse_rec
  ) => {
    val () = prstr "HDErec("
    val () = fprintf (out, "knd= %i", @(knd))
    val () = prstr "; "
    val () = fprint_labhidexplst (out, lhdes)
    val () = prstr ")"
  } // end of [HDErec]
| HDEseq (hdes) => {
    val () = prstr "HDEseq("
    val () = fprint_hidexplst (out, hdes)
    val () = prstr ")"
  }
//
| HDEselab (
    hde, hse_flt, hils
  ) => {
    val () = prstr "HDEselab("
    val () = fprint_hidexp (out, hde)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_flt)
    val () = prstr "; "
    val () = fprint_hilablst (out, hils)
    val () = prstr ")"
  }
//
| HDEptrofvar
    (d2v) => {
    val () = prstr "HDEptrofvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
| HDEptrofsel
    (hde, hse_rt, hils) => {
    val () = prstr "HDEptrofsel("
    val () = fprint_hidexp (out, hde)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr ")"
  }
//
| HDErefarg
    (knd, freeknd, hde) => {
    val () = prstr "HDErefarg("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, freeknd)
    val () = prstr "; "
    val () = fprint_hidexp (out, hde)
    val () = prstr ")"
  }
//
| HDEselvar
    (d2v, hse_rt, hils) =>
  {
    val () = prstr "HDEselvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr ")"
  }
| HDEselptr
    (hde, hse_rt, hils) =>
  {
    val () = prstr "HDEselptr("
    val () = fprint_hidexp (out, hde)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr ")"
  }
//
| HDEassgn_var (
    d2v_l, hse_rt, hils, hde_r
  ) => {
    val () = prstr "HDEassgn_var("
    val () = fprint_d2var (out, d2v_l)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_hidexp (out, hde_r)
    val () = prstr ")"
  }
| HDEassgn_ptr (
    hde_l, hse_rt, hils, hde_r
  ) => {
    val () = prstr "HDEassgn_ptr("
    val () = fprint_hidexp (out, hde_l)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_hidexp (out, hde_r)
    val () = prstr ")"
  }
//
| HDExchng_var (
    d2v_l, hse_rt, hils, hde_r
  ) => {
    val () = prstr "HDExchng_var("
    val () = fprint_d2var (out, d2v_l)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_hidexp (out, hde_r)
    val () = prstr ")"
  }
| HDExchng_ptr (
    hde_l, hse_rt, hils, hde_r
  ) => {
    val () = prstr "HDExchng_ptr("
    val () = fprint_hidexp (out, hde_l)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_hilablst (out, hils)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_hidexp (out, hde_r)
    val () = prstr ")"
  }
//
| HDEarrpsz (
    hse_elt, hdes_elt, asz
  ) => {
    val () = prstr "HDEarrpsz("
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr "; "
    val () = fprint_hidexplst (out, hdes_elt)
    val () = prstr "; "
    val () = fprint_int (out, asz)
    val () = prstr ")"
  }
| HDEarrinit (
    hse_elt, hde_asz, hdes_elt
  ) => {
    val () = prstr "HDEarrinit("
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr "; "
    val () = fprint_hidexp (out, hde_asz)
    val () = prstr "; "
    val () = fprint_hidexplst (out, hdes_elt)
    val () = prstr ")"
  }
//
| HDEraise (hde) => {
    val () = prstr "HDEraise("
    val () = fprint_hidexp (out, hde)
    val () = prstr ")"
  }
//
| HDElam
    (_arg, _body) =>
  {
    val () = prstr "HDElam("
    val () = fprint_hipatlst (out, _arg)
    val () = prstr "; "
    val () = fprint_hidexp (out, _body)
    val () = prstr ")"
  } // end of [DDElam]
//
| HDEloop _ => {
    val () = prstr "HDEloop(...)"
  }
| HDEloopexn (knd) =>
  {
    val () = prstr "HDEloopexn("
    val () = fprint_int (out, knd)
    val () = prstr ")"
  }
//
| HDEtrywith
    (hde, hicls) =>
  {
    val () = prstr "HDEtrywith("
    val () = fprint_hidexp (out, hde)
    val () = prstr "; "
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| HDEerr () => prstr "HDEerr()"
//
(*
| _ => {
    val () = fprint_string (out, "HDE...(...)")
  } // end of [_]
*)
//
end // end of [fprint_hidexp]

implement
print_hidexp (x) = fprint_hidexp (stdout_ref, x)
implement
prerr_hidexp (x) = fprint_hidexp (stderr_ref, x)

implement
fprint_hidexplst
  (out, xs) = $UT.fprintlst (out, xs, "; ", fprint_hidexp)
// end of [fprint_hidexplst]

(* ****** ****** *)

extern
fun fprint_labhidexp : fprint_type (labhidexp)
implement
fprint_labhidexp
  (out, lx) = {
  val LABHIDEXP (l, x) = lx
  val () =
    $LAB.fprint_label (out, l)
  val () = fprint_string (out, "= ")
  val () = fprint_hidexp (out, x)
} // end of [fprint_labhidexp]

implement
fprint_labhidexplst
  (out, lxs) = $UT.fprintlst (out, lxs, "; ", fprint_labhidexp)
// end of [fprint_labhidexplst]

(* ****** ****** *)

implement
fprint_higmat (out, x) = {
  val () = fprint_string (out, "HIGMAT(")
  val () = fprint_hidexp (out, x.higmat_exp)
  val () = fprint_string (out, "; ")
  val () = $UT.fprintopt (out, x.higmat_pat, fprint_hipat)
  val () = fprint_string (out, ")")
} // end of [fprint_higmat]

(* ****** ****** *)

implement
fprint_hiclau (out, x) = {
  val () = fprint_string (out, "HICLAU(")
  val () = fprint_hipatlst (out, x.hiclau_pat)
  val () = fprint_string (out, " => ")
  val () = fprint_hidexp (out, x.hiclau_body)
  val () = fprint_string (out, ")")
} // end of [fprint_hiclau]

(* ****** ****** *)

implement
fprint_hidecl
  (out, hid) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ hid.hidecl_node of
//
| HIDnone () => prstr "HIDnone()"
//
| HIDlist (hids) => {
    val () = prstr "HIDlist(\n"
    val () = $UT.fprintlst (out, hids, "\n", fprint_hidecl)
    val () = prstr "\n)"
  }
//
| HIDextcode
    (knd, pos, code) => {
    val () = prstr "HIDextcode("
    val () = fprintf (out, "knd=%i, pos=%i, code=...", @(knd, pos))
    val () = prstr ")"
  } (* end of [HIDextcode] *)
//
| HIDdatdecs
    (knd, s2cs) => {
    val () = prstr "HIDdatdecs("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_s2cstlst (out, s2cs)
    val () = prstr ")"
  }
//
| HIDexndecs (d2cs) => {
    val () = prstr "HIDexndecs("
    val () = fprint_d2conlst (out, d2cs)
    val () = prstr ")"
  }
//
| HIDdcstdecs
    (knd, d2cs) => {
    val () = prstr "HIDdcstdecs("
    val () = fprint_dcstkind (out, knd)
    val () = prstr "; "
    val () = fprint_d2cstlst (out, d2cs)
    val () = prstr ")"
  }
//
| HIDfundecs
    (knd, decarg, hfds) =>
  {
    val () = prstr "HIDfundecs(\n"
    val () = $UT.fprintlst (out, hfds, "\n", fprint_hifundec)
    val () = prstr "\n)"
  } // end of [HIDfundec]
//
| HIDvaldecs
    (knd, hvds) => {
    val () = prstr "HIDvaldecs(\n"
    val () = $UT.fprintlst (out, hvds, "\n", fprint_hivaldec)
    val () = prstr "\n)"
  } // end of [HIDvaldec]
| HIDvaldecs_rec
    (knd, hvds) => {
    val () = prstr "HIDvaldecs_rec(\n"
    val () = $UT.fprintlst (out, hvds, "\n", fprint_hivaldec)
    val () = prstr "\n)"
  } // end of [HIDvaldec_rec]
//
| HIDvardecs (hvds) => {
    val () = prstr "HIDvardecs(\n"
    val () = $UT.fprintlst (out, hvds, "\n", fprint_hivardec)
    val () = prstr "\n)"
  } // end of [HIDvardec]
//
| HIDimpdec
    (knd, himpdec) => {
    val () = prstr "HIDimpdec(\n"
    val () = fprint_hiimpdec (out, himpdec)
    val () = prstr "\n)"
  } (* end of [HIDimpdec] *)
//
| HIDinclude (hids) =>
  {
    val () = prstr "HIDinclude(\n"
    val () = $UT.fprintlst (out, hids, "\n", fprint_hidecl)
    val () = prstr "\n)"
  } (* end of [HIDinclude] *)
//
| HIDstaload
    (fil, _, _, _) => (
    prstr "HIDstaload("; $FIL.fprint_filename_full (out, fil); prstr ")"
  ) (* end of [HIDstaload] *)
//
| _ => {
    val () = prstr "HID...(...)"
  } // end of [_]
//
end // end of [fprint_hidecl]

implement
print_hidecl (hid) = fprint_hidecl (stdout_ref, hid)
implement
prerr_hidecl (hid) = fprint_hidecl (stderr_ref, hid)

(* ****** ****** *)

implement
fprint_hideclist
  (out, hids) = let
in
//
case+ hids of
| list_cons
    (hid, hids) => let
    val () =
      fprint_hidecl (out, hid)
    val () = fprint_newline (out)
  in
    fprint_hideclist (out, hids)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [fprint_hideclist]

(* ****** ****** *)

implement
fprint_hiimpdec
  (out, himpdec) = {
  val () = fprint_d2cst (out, himpdec.hiimpdec_cst)
  val () = fprint_string (out, " = ")
  val () = fprint_hidexp (out, himpdec.hiimpdec_def)
} // end of [fprint_hiimpdec]

(* ****** ****** *)

implement
fprint_hifundec
  (out, hvd) = {
  val () = fprint_d2var (out, hvd.hifundec_var)
  val () = fprint_string (out, " = ")
  val () = fprint_hidexp (out, hvd.hifundec_def)
} // end of [fprint_hifundec]

implement
fprint_hivaldec
  (out, hvd) = {
  val () = fprint_hipat (out, hvd.hivaldec_pat)
  val () = fprint_string (out, " = ")
  val () = fprint_hidexp (out, hvd.hivaldec_def)
} // end of [fprint_hivaldec]

implement
fprint_hivardec
  (out, hvd) = let
  macdef prstr (s) = fprint_string (out, ,(s))
  val () = fprint_d2var (out, hvd.hivardec_dvar_ptr)
  val () = prstr " : "
  val () = fprint_hisexp (out, hvd.hivardec_type)
  val () = prstr " = "
  val () = $UT.fprintopt (out, hvd.hivardec_ini, fprint_hidexp)
in
  // nothing
end // end of [fprint_hivardec]

(* ****** ****** *)

(* end of [pats_hidynexp_print.dats] *)
