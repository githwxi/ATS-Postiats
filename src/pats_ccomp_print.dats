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
// Start Time: October, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _ (*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload FIL = "./pats_filename.sats"
staload LOC = "./pats_location.sats"

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
fprint_primcstsp
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
| PMCSTSPmyfil (fil) => {
    val () = prstr ("$myfilename(")
    val () = $FIL.fprint_filename_full (out, fil)
    val () = prstr ")"
  }
| PMCSTSPmyloc (loc) => {
    val () = prstr ("$mylocation(")
    val () = $LOC.fprint_location (out, loc)
    val () = prstr ")"
  }
| PMCSTSPmyfun (flab) => {
    val () = prstr ("$myfunction(")
    val () = fprint_funlab (out, flab)
    val () = prstr ")"
  }
//
end // end of [fprint_primcstsp]

(* ****** ****** *)

implement
fprint_primdec
  (out, x) = let
//
val sep = ", "
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x.primdec_node of
//
| PMDnone () => prstr "PMDnone()"
//
| PMDlist (pmds) => {
    val () = prstr "PMDlist(\n"
    val () = fprint_primdeclst (out, pmds)
    val () = prstr ")"
  }
//
| PMDsaspdec (d2c) => {
    val () = prstr "PMDsaspdec("
    val () = fprint_s2cst (out, d2c.s2aspdec_cst)
    val () = prstr ")"
  }
//
| PMDdatdecs (s2cs) => {
    val () = prstr "PMDdatdecs("
    val () = fprint_s2cstlst (out, s2cs)
    val () = prstr ")"
  }
| PMDexndecs (d2cs) => {
    val () = prstr "PMDexndecs("
    val () = fprint_d2conlst (out, d2cs)
    val () = prstr ")"
  }
//
| PMDimpdec (imp) => {
    val d2c = imp.hiimpdec_cst
    val imparg = imp.hiimpdec_imparg
    val tmparg = imp.hiimpdec_tmparg
    val () = prstr "PMDimpdec("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "; imparg="
    val () = fprint_s2varlst (out, imparg)
    val () = prstr "; tmparg="
    val () = $UT.fprintlst (out, tmparg, "; ", fprint_s2explst)
    val () = prstr ")"
  }
//
| PMDfundecs (
    knd, decarg, hfds
  ) => {
    val () = prstr "PMDfundecs("
    val () = fprint_funkind (out, knd)
    val () = prstr "; "
    val () = fprint_s2qualst (out, decarg)
    val () = prstr "; "
    val () =
      $UT.fprintlst<hifundec> (
      out, hfds, sep, lam (out, hfd) => fprint_d2var (out, hfd.hifundec_var)
    ) // end of [val]
    val () = prstr ")"
  }
//
| PMDvaldecs
    (knd, hvds, inss) => {
    val () = prstr "PMDvaldecs("
    val () = fprint_valkind (out, knd)
    val () = prstr "; "
    val () =
      $UT.fprintlst<hivaldec> (
      out, hvds, sep, lam (out, hvd) => fprint_hipat (out, hvd.hivaldec_pat)
    ) // end of [val]
    val () = prstr ")"
  }
| PMDvaldecs_rec
    (knd, hvds, inss) => {
    val () = prstr "PMDvaldecs_rec("
    val () = fprint_valkind (out, knd)
    val () = prstr "; "
    val () =
      $UT.fprintlst<hivaldec> (
      out, hvds, sep, lam (out, hvd) => fprint_hipat (out, hvd.hivaldec_pat)
    ) // end of [val]
    val () = prstr ")"
  }
//
| PMDvardecs
    (hvds, inss) => {
    val () = prstr "PMDvardecs("
    val () =
      $UT.fprintlst<hivardec> (
      out, hvds, sep, lam (out, hvd) => fprint_d2var (out, hvd.hivardec_dvar_ptr)
    ) // end of [val]
    val () = prstr ")"
  }
//
| PMDinclude (pmds) =>
  {
    val () = prstr "PMDinclude(\n"
    val () = fprint_primdeclst (out, pmds)
    val () = prstr ")"
  }
//
| PMDstaload (hid) =>
  {
    val-HIDstaload
      (fil, _, _, _) = hid.hidecl_node
    val () = prstr "PMDstaload("
    val () = $FIL.fprint_filename_full (out, fil)
    val () = prstr ")"
  }
//
| PMDdynload (hid) =>
  {
    val-HIDdynload (fil) = hid.hidecl_node
    val () = prstr "PMDdynload("
    val () = $FIL.fprint_filename_full (out, fil)
    val () = prstr ")"
  }
//
| PMDlocal (
    pmds_head, pmds_body
  ) => {
    val () = prstr "PMDlocal("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  } // end of [PMDlocal]
//
end // end of [fprint_primdec]

implement
print_primdec (pmd) = fprint_primdec (stdout_ref, pmd)
implement
prerr_primdec (pmd) = fprint_primdec (stderr_ref, pmd)

(* ****** ****** *)

implement
fprint_primdeclst
  (out, pmds) = let
  val () =
    $UT.fprintlst (out, pmds, "\n", fprint_primdec)
  // end of [val]
in
  fprint_newline (out)
end // end of [fprint_primdeclst]

(* ****** ****** *)

implement
fprint_primval (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x.primval_node of
//
| PMVtmp (tmp) =>
  {
    val () = prstr "PMVtmp("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| PMVtmpref (tmp) =>
  {
    val () = prstr "PMVtmpref("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
//
| PMVarg (n) =>
  {
    val () = prstr "PMVarg("
    val () = fprint_int (out, n)
    val () = prstr ")"
  }
| PMVargref (n) =>
  {
    val () = prstr "PMVargref("
    val () = fprint_int (out, n)
    val () = prstr ")"
  }
| PMVargtmpref (n) =>
  {
    val () = prstr "PMVargtmpref("
    val () = fprint_int (out, n)
    val () = prstr ")"
  }
| PMVargenv (nenv) =>
  {
    val () = prstr "PMVargenv("
    val () = fprint_int (out, nenv)
    val () = prstr ")"
  }
//
| PMVcst (d2c) => {
    val () = prstr "PMVcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ")"
  }
| PMVenv (d2v) => {
    val () = prstr "PMVenv("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| PMVint (i) => {
    val () = prstr "PMVint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| PMVintrep (rep) => {
    val () = prstr "PMVintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
//
| PMVbool (b) => {
    val () = prstr "PMVbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| PMVchar (c) => {
    val i = $UN.cast2int(c)
    val () = prstr "PMVchar("
    val () =
    (
    if char_isprint(c)
      then fprint_char (out, c)
      else fprintf (out, "int(%i)", @(i))
    // end of [if]
    ) : void // end of [val]
    val () = prstr ")"
  }
| PMVfloat (f) => {
    val () = prstr "PMVfloat("
    val () = fprint_double (out, f)
    val () = prstr ")"
  }
| PMVstring (str) => {
    val () = prstr "PMVstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| PMVi0nt (tok) => {
    val () = prstr "PMVi0nt("
    val () = $SYN.fprint_i0nt (out, tok)
    val () = prstr ")"
  }
| PMVf0loat (tok) => {
    val () = prstr "PMVf0loat("
    val () = $SYN.fprint_f0loat (out, tok)
    val () = prstr ")"
  }
//
| PMVsizeof (hselt) => {
    val () = prstr "PMVsizeof("
    val () = fprint_hisexp (out, hselt)
    val () = prstr ")"
  }
//
| PMVcstsp (x) => {
    val () = fprint_primcstsp (out, x)
  }
//
| PMVtop () => prstr "PMVtop()"
| PMVempty () => prstr "PMVempty()"
//
| PMVextval (name) => {
    val () = prstr "PMVextval("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
//
| PMVcastfn (d2c, arg) => {
    val () = prstr "PMVcastfn("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ", "
    val () = fprint_primval (out, arg)
    val () = prstr ")"
  }
//
| PMVselcon (
    pmv, hse_sum, lab
  ) => {
    val () = prstr "PMVselcon("
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_sum)
    val () = prstr "; "
    val () = $LAB.fprint_label (out, lab) // HX: argument label
    val () = prstr ")"
  } // end of [PMVselcon]
//
| PMVselect (
    pmv, hse_sel, pml
  ) => {
    val () = prstr "PMVselect("
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_sel)
    val () = prstr "; "
    val () = fprint_primlab (out, pml)
    val () = prstr ")"
  } // end of [PMVselect]
| PMVselect2 (
    pmv, hse_sel, pmls
  ) => {
    val () = prstr "PMVselect2("
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_sel)
    val () = prstr "; "
    val () = fprint_primlablst (out, pmls)
    val () = prstr ")"
  } // end of [PMVselect2]
//
| PMVselptr (
    pmv, hse_sel, pmls
  ) => {
    val () = prstr "PMVselptr("
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_sel)
    val () = prstr "; "
    val () = fprint_primlablst (out, pmls)
    val () = prstr ")"
  } // end of [PMVselptr]
//
| PMVptrof (pmv) => {
    val () = prstr "PMVptrof("
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| PMVptrofsel
    (pmv, hse_rt, pmls) => {
    val () = prstr "PMVptrofsel("
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr "; "
    val () = fprint_primlablst (out, pmls)
    val () = prstr ")"    
  }
| PMVrefarg
    (knd, freeknd, pmv) =>
  {
    val () = prstr "PMVrefarg("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, freeknd)
    val () = prstr "; "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| PMVfunlab (flab) =>
  {
    val () = prstr "PMVfunlab("
    val () = fprint_funlab (out, flab)
    val () = prstr ")"
  }
| PMVcfunlab
    (knd, flab) =>
  {
    val () = prstr "PMVcfunlab("
    val () = prstr "knd="
    val () = fprint_int (out, knd)
    val () = prstr "; flab="
    val () = fprint_funlab (out, flab)
    val () = prstr ")"
  }
//
| PMVd2vfunlab
    (d2v, flab) =>
  {
    val () = prstr "PMVd2vfunlab("
    val () = prstr "d2v="
    val () = fprint_d2var (out, d2v)
    val () = prstr ", flab="
    val () = fprint_funlab (out, flab)
    val () = prstr ")"
  }
//
| PMVlamfix (knd, pmv) =>
  {
    val () = prstr "PMVlamfix("
    val () = prstr "knd="
    val () = fprint_int (out, knd)
    val () = prstr "; fun="
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| PMVtmpltcst
    (d2c, t2mas) =>
  {
    val () = prstr "PMVtmpltcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
| PMVtmpltvar
    (d2v, t2mas) =>
  {
    val () = prstr "PMVtmpltvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
//
| PMVtmpltcstmat
    (d2c, t2mas, mat) =>
  {
    val () = prstr "PMVtmpltcstmat["
    val () = fprint_tmpcstmat_kind (out, mat)
    val () = prstr "]("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
| PMVtmpltvarmat
    (d2c, t2mas, mat) =>
  {
    val () = prstr "PMVtmpltvarmat["
    val () = fprint_tmpvarmat_kind (out, mat)
    val () = prstr "]("
    val () = fprint_d2var (out, d2c)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
//
| PMVerr () => prstr "PMVerr()"
//
end // end of [fprint_primval]

(* ****** ****** *)

implement
print_primval (pmv) = fprint_primval (stdout_ref, pmv)
implement
prerr_primval (pmv) = fprint_primval (stderr_ref, pmv)

(* ****** ****** *)

implement
fprint_primvalist
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_primval)
// end of [fprint_primvalist]

(* ****** ****** *)

implement
fprint_primlab
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x.primlab_node of
//
| PMLlab (l) => {
    val () = prstr "PMLlab("
    val () = $LAB.fprint_label (out, l)
    val () = prstr ")"
  }
| PMLind (pmvs) => {
    val () = prstr "PMLind("
    val () = fprint_primvalist (out, pmvs)
    val () = prstr ")"
  }
//
end // end of [fprint_primlab]

implement
fprint_primlablst
  (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_primlab)
// end of [fprint_primlablst]

(* ****** ****** *)

extern
fun fprint_labprimval : fprint_type (labprimval)
implement
fprint_labprimval
  (out, lx) = let
  val LABPRIMVAL (l, x) = lx in
  $LAB.fprint_label (out, l); fprint_string (out, "="); fprint_primval (out, x)
end // end of [fprint_labprimval]

implement
fprint_labprimvalist
  (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_labprimval)
// end of [fprint_labprimvalist]

(* ****** ****** *)

implement
fprint_patck
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
//
| PATCKcon (d2c) => {
    val () = prstr "PATCKcon("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
//
| PATCKint (i) => {
    val () = prstr "PATCKint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| PATCKbool (b) => {
    val () = prstr "PATCKbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| PATCKchar (c) => {
    val () = prstr "PATCKchar("
    val () = fprint_char (out, c)
    val () = prstr ")"
  }
| PATCKfloat (f) => {
    val () = prstr "PATCKfloat("
    val () = fprint_double (out, f)
    val () = prstr ")"
  }
| PATCKstring (str) => {
    val () = prstr "PATCKstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| PATCKi0nt (tok) => {
    val () = prstr "PATCKi0nt("
    val () = $SYN.fprint_i0nt (out, tok)
    val () = prstr ")"
  }
| PATCKf0loat (tok) => {
    val () = prstr "PATCKf0loat("
    val () = $SYN.fprint_f0loat (out, tok)
    val () = prstr ")"
  }
//
end // end of [patck]

implement
print_patck (x) = fprint_patck (stdout_ref, x)
implement
prerr_patck (x) = fprint_patck (stderr_ref, x)

(* ****** ****** *)

implement
fprint_tmpmovlst (out, xs) = let
//
fun fpr
(
  out: FILEref, x: tmpmov
) : void =
{
  val () = fprint_tmpvar (out, x.0)
  val () = fprint_string (out, "->")
  val () = fprint_tmpvar (out, x.1)
}
//
in
  $UT.fprintlst (out, xs, ", ", fpr)
end // end of [fprint_tmpmovlst]

(* ****** ****** *)

implement
fprint_patckont
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
//
| PTCKNTnone (
  ) => prstr "PTCKNTnone()"
//
| PTCKNTtmplab (tl) =>
  {
    val () = prstr "PTCKNTtmplab("
    val () = fprint_tmplab (out, tl)
    val () = prstr ")"
  }
//
| PTCKNTtmplabint
    (tl, int) => {
    val (
    ) = prstr "PTCKNTtmplabint("
    val () = fprint_tmplab (out, tl)
    val () = prstr ", "
    val () = fprint_int (out, int)
    val () = prstr ")"
  }
//
| PTCKNTtmplabmov
    (tl, tmvlst) => {
    val (
    ) = prstr "PTCKNTtmplabmov("
    val () = fprint_tmplab (out, tl)
    val () = prstr "; "
    val () = fprint_tmpmovlst (out, tmvlst)
    val () = prstr ")"
  }
//
| PTCKNTcaseof_fail
    (loc) => {
    val () = prstr "PTCKNTcaseof_fail("
    val () = prstr ")"
  }
//
| PTCKNTfunarg_fail
    (loc, fl) => {
    val () = prstr "PTCKNTfunarg_fail("
    val () = prstr ")"
  }
//
| PTCKNTraise (tmp, pmv) =>
  {
    val () = prstr "PTCKNTraise("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ", "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  } 
end // end of [patckont]

implement
print_patckont (x) = fprint_patckont (stdout_ref, x)
implement
prerr_patckont (x) = fprint_patckont (stderr_ref, x)

(* ****** ****** *)

implement
fprint_instr
  (out, x) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x.instr_node of
//
| INSfunlab (fl) => {
    val () = prstr "INSfunlab("
    val () = fprint_funlab (out, fl)
    val () = prstr ")"
  }
//
| INStmplab (tl) => {
    val () = prstr "INStmplab("
    val () = fprint_tmplab (out, tl)
    val () = prstr ")"
  }
//
| INScomment (str) => {
    val () = prstr "INScomment("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| INSmove_val (tmp, pmv) => {
    val () = prstr "INSmove_val("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
| INSpmove_val (tmp, pmv) => {
    val () = prstr "INSpmove_val("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| INSmove_arg_val (i, pmv) => {
    val () = prstr "INSmove_arg_val("
    val () = fprintf (out, "arg(%i)", @(i))
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| INSfcall
  (
    tmpret
  , hde_fun, hse_fun, hdes_arg
  ) => {
    val () = prstr "INSfcall("
    val () = fprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_primval (out, hde_fun)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_fun)
    val () = prstr "; "
    val () = fprint_primvalist (out, hdes_arg)
    val () = prstr ")"
    val () = prstr ")"
  } // end of [INSfcall]
| INSfcall2
  (
    tmpret
  , flab, ntl, hse_fun, hdes_arg
  ) => {
    val () = prstr "INSfcall2("
    val () = fprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_funlab (out, flab)
    val () = prstr "("
    val () = fprint_int (out, ntl)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_fun)
    val () = prstr "; "
    val () = fprint_primvalist (out, hdes_arg)
    val () = prstr ")"
    val () = prstr ")"
  } // end of [INSfcall2]
| INSextfcall
  (
    tmpret, _fun, hdes_arg
  ) => {
    val () = prstr "INSfcall("
    val () = fprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_string (out, _fun)
    val () = prstr "("
    val () = fprint_primvalist (out, hdes_arg)
    val () = prstr ")"
    val () = prstr ")"
  } // end of [INSextfcall]
//
| INScond
  (
    pmv_cond, inss_then, inss_else
  ) => {
    val () = prstr "INScond(\n"
    val () = prstr "**COND**\n"
    val () = fprint_primval (out, pmv_cond)
    val () = prstr "\n"
    val () = prstr "**THEN**\n"
    val () = fprint_instrlst (out, inss_then)
    val () = prstr "**ELSE**\n"
    val () = fprint_instrlst (out, inss_else)
    val () = prstr ")"
  }
//
| INSfreecon (pmv) =>
  {
    val () = prstr "INSfreecon("
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| INSloop _ =>
  {
    val () = prstr "INSloop(...)"
  }
| INSloopexn (knd, tlab) =>
  {
    val () = prstr "INSloopexn("
    val () = fprint_int (out, knd)
    val () = prstr ", "
    val () = fprint_tmplab (out, tlab)
    val () = prstr ")"
  }
//
| INScaseof _ =>
  {
    val () = prstr "INScaseof("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| INSletpop () =>
  {
    val () = prstr "INSletpop()"
  }
| INSletpush (pmds) =>
  {
    val () = prstr "INSletpush(\n"
    val () = fprint_primdeclst (out, pmds)
    val () = prstr ")"
  }
//
| INSmove_con (
    tmpret, d2c, hse_sum, lpmvs
  ) => {
    val () = prstr "INSmove_con("
    val () = fprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_d2con (out, d2c)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_sum)
    val () = prstr ";"
    val () = fprint_labprimvalist (out, lpmvs)
    val () = prstr ")"
    val () = prstr ")"
  }
//
| INSmove_boxrec _ => {
    val () =
      prstr "INSmove_boxrec("
    val () = prstr "..."
    val () = prstr ")"
  }
| INSmove_fltrec _ => {
    val () =
      prstr "INSmove_fltrec("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| INSpatck
    (pmv, pck, pcknt) => {
    val () = prstr "INSpatck("
    val () = fprint_patck (out, pck)
    val () = prstr "; "
    val () = fprint_patckont (out, pcknt)
    val () = prstr ")"
  }
//
| INSmove_ptrofsel (
    tmp, pmv, hse_sel, pmls
  ) => {
    val () = prstr "INSmove_ptrofsel("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_sel)
    val () = prstr "; "
    val () = fprint_primlablst (out, pmls)
    val () = prstr ")"
  } // end of [INSmove_ptrofsel]
//
(*
| INSload_ptrofs
    (tmp, pmv, hse_sel, ofs) => {
    val () = prstr "INSload_ptrofs("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_sel)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_primlablst (out, ofs)
    val () = prstr "]"
    val () = prstr ")"
  }
*)
//
| INSstore_ptrofs
    (pmv_l, hse_rt, ofs, pmv_r) => {
    val () = prstr "INSstore_ptrofs("
    val () = fprint_primval (out, pmv_l)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_rt)
    val () = prstr ")"
    val () = prstr "["
    val () = fprint_primlablst (out, ofs)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_primval (out, pmv_r)
    val () = prstr ")"
  }
//
| INSxstore_ptrofs _ => prstr "INSxstore_ptrofs(...)"
//
| INSraise
    (tmp, pmv_exn) => {
    val () = prstr "INSraise("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ", "
    val () = fprint_primval (out, pmv_exn)
    val () = prstr ")"
  } // end of [INSraise]
//
| INStrywith
  (
    tmp_exn, inss_try, ibrs_with
  ) => {
    val () = prstr "INStrywith("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  } (* end of [INStrywith] *)
//
| INSmove_list_nil (tmp) => {
    val () =
      prstr "INSmove_list_nil("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| INSpmove_list_nil (tmp) => {
    val () =
      prstr "INSpmove_list_nil("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| INSpmove_list_cons
    (tmp, hse_elt) => {
    val () =
      prstr "INSpmove_list_cons("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ", "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
//
| INSmove_list_phead
    (tmphd, tmptl, hse_elt) => {
    val () = prstr "INSmove_list_phead("
    val () = fprint_tmpvar (out, tmphd)
    val () = prstr "; "
    val () = fprint_tmpvar (out, tmptl)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
| INSmove_list_ptail
    (tmptl1, tmptl2, hse_elt) => {
    val () = prstr "INSmove_list_ptail("
    val () = fprint_tmpvar (out, tmptl1)
    val () = prstr "; "
    val () = fprint_tmpvar (out, tmptl2)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
//
| INSstore_arrpsz_asz
    (tmp, asz) => {
    val () = prstr "INSstore_arrpsz_asz("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr "; "
    val () = fprint_int (out, asz)
    val () = prstr ")"
  }
| INSstore_arrpsz_ptr
    (tmp, hse_elt, asz) => {
    val () = prstr "INSstore_arrpsz_ptr("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr "; "
    val () = fprint_int (out, asz)
    val () = prstr ")"
  }
//
| INSmove_arrpsz_ptr
    (tmp1, tmp2) => {
    val () = prstr "INSmove_arrpsz_ptr("
    val () = fprint_tmpvar (out, tmp1)
    val () = prstr "; "
    val () = fprint_tmpvar (out, tmp2)
    val () = prstr ")"
  }
//
| INSupdate_ptrinc
    (tmp, hse_elt) =>
  {
    val () = prstr "INSupdate_ptrinc("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
| INSupdate_ptrdec
    (tmp, hse_elt) =>
  {
    val () = prstr "INSupdate_ptrdec("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
//
| INStmpdec (tmp) =>
  {
    val () = prstr "INStmpdec("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
//
| INSdcstdef (d2c, pmv) =>
  {
    val () = prstr "INSdcstdef("
    val () = fprint_d2cst (out, d2c)
    val () = prstr " = "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| _ => prstr "INS...(...)"
//
end // end of [fprint_instr]

(* ****** ****** *)

implement
print_instr (ins) = fprint_instr (stdout_ref, ins)
implement
prerr_instr (ins) = fprint_instr (stderr_ref, ins)

(* ****** ****** *)

implement
fprint_instrlst
  (out, xs) = let
  val () =
    $UT.fprintlst (out, xs, "\n", fprint_instr)
  // end of [val]
in
  fprint_newline (out)
end // end of [fprint_instrlst]

(* ****** ****** *)

implement
fprint_tmpsub
  (out, xs) = let
//
fun loop (
  out: FILEref, xs: tmpsub, i: int
) : void = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ xs of
| TMPSUBcons
   (s2v, s2e, xs) => let
   val () =
     if i > 0 then prstr "; "
   // end of [val]
   val () = fprint_s2var (out, s2v)
   val () = prstr " -> "
   val () = fprint_s2exp (out, s2e)
 in
   loop (out, xs, i+1)
 end // end of [tmpsub_cons]
| TMPSUBnil () => ()
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_tmpsub]

implement
fprint_tmpsubopt
  (out, opt) = let
//
macdef
prstr (x) = fprint_string (out, ,(x))
//
in
//
case opt of
| Some (tsub) => {
    val () = prstr "Some("
    val () = fprint_tmpsub (out, tsub)
    val () = prstr ")"
  } // end of [Some]
| None () => prstr "None()"
//
end // end of [fprint_tmpsubopt]

(* ****** ****** *)

implement
fprint_hiimpdec2
  (out, imp2) = let
//
val HIIMPDEC2 (imp, tsub, s2ess) = imp2
val () = fprint_string (out, "HIIMPDEC2(")
val () = fprint_hiimpdec (out, imp)
val () = fprint_string (out, "; ")
val () = fprint_tmpsub (out, tsub)
val () = fprint_string (out, ")")
//
in
  // nothing
end // end of [fprint_hiimpdec2]

(* ****** ****** *)

implement
fprint_tmpcstmat
  (out, opt) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ opt of
| TMPCSTMATnone (
  ) => prstr "TMPCSTMATnone()"
| TMPCSTMATsome
    (imp, tmpsub) => let
    val () = prstr "TMPCSTMATsome("
    val () = fprint_d2cst (out, imp.hiimpdec_cst)
    val () = prstr "; "
    val () = fprint_s2varlst (out, imp.hiimpdec_imparg)
    val () = prstr "; "
    val () = fprint_s2explstlst (out, imp.hiimpdec_tmparg)
    val () = prstr "; "
    val () = fprint_tmpsub (out, tmpsub)
    val () = prstr ")"
  in
    // nothing
  end // end of [TMPCSTMATnone]
| TMPCSTMATsome2
    (d2c, s2ess, flab) => let
    val () = prstr "TMPCSTMATsome2("
    val () = fprint_funlab (out, flab)
    val () = prstr "; "
    val () = fprint_s2explstlst (out, s2ess)
    val () = prstr ")"
  in
    // nothing
  end // end of [TMPCSTMATsome2]
//
end // end of [fprint_tmpcstmat]

implement
fprint_tmpcstmat_kind (out, opt) = let
//
val knd =
(
  case+ opt of
  | TMPCSTMATnone _ => 0 | TMPCSTMATsome _ => 1 | TMPCSTMATsome2 _ => 2
) : int // end of [val]
//
in
  fprint_int (out, knd)
end // end of [fprint_tmpcstmat_kind]

(* ****** ****** *)

implement
fprint_tmpvarmat
  (out, opt) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ opt of
| TMPVARMATnone (
  ) => prstr "TMPVARMATnone()"
| TMPVARMATsome
    (hfd, tmpsub) => let
    val () = prstr "TMPVARMATsome("
    val () = fprint_d2var (out, hfd.hifundec_var)
    val () = prstr "; "
    val () = fprint_s2varlst (out, hfd.hifundec_imparg)
    val () = prstr "; "
    val () = fprint_tmpsub (out, tmpsub)
    val () = prstr ")"
  in
    // nothing
  end // end of [TMPVARMATnone]
| TMPVARMATsome2
    (d2v, s2ess, flab) => let
    val () = prstr "TMPVARMATsome2("
    val () = fprint_funlab (out, flab)
    val () = prstr "; "
    val () = fprint_s2explstlst (out, s2ess)
    val () = prstr ")"
  in
    // nothing
  end // end of [TMPVARMATsome2]
//
end // end of [fprint_tmpvarmat]

implement
fprint_tmpvarmat_kind (out, opt) = let
//
val knd =
(
  case+ opt of
  | TMPVARMATnone _ => 0 | TMPVARMATsome _ => 1 | TMPVARMATsome2 _ => 2
) : int // end of [val]
//
in
  fprint_int (out, knd)
end // end of [fprint_tmpvarmat_kind]

(* ****** ****** *)

implement
fprint_vbindmap (out, vbmap) = let
//
fun fpr
(
  out: FILEref, vb: @(d2var, primval)
) : void =
(
  fprint_d2var (out, vb.0); fprint_string (out, "->"); fprint_primval (out, vb.1)
) (* end of [fpr] *)
//
val vbs = d2varmap_listize (vbmap)
val () = $UT.fprintlst (out, $UN.linlst2lst(vbs), "; ", fpr)
val () = list_vt_free (vbs)
//
in
  // nothing
end // end of [fprint_vbindlst]

(* ****** ****** *)

(* end of [pats_ccomp_print.dats] *)
