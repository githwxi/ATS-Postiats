(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _ (*anon*) = "./pats_utils.dats"

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

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
fpprint_tmpvar
  (out, tmp) = let
  val opt = tmpvar_get_alias (tmp)
in
//
case+ opt of
| Some (pmv) => {
    val () = fprint_string (out, "*")
    val () = fprint_primval (out, pmv)
  } // end of [Some]
| None () => fprint_tmpvar (out, tmp)
//
end // end of [fpprint_tmpvar]

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
| PMDfundecs (hfds) => {
    val () = prstr "PMDfundecs("
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
| PMDstaload (fil) => {
    val () = prstr "PMDstaload("
    val () = $FIL.fprint_filename (out, fil)
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
| PMVtmp (tmp) => {
    val () = prstr "PMVtmp("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| PMVtmpref (tmp) => {
    val () = prstr "PMVtmpref("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
//
| PMVcst (d2c) => {
    val () = prstr "PMVcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr ")"
  }
| PMVvar (d2v) => {
    val () = prstr "PMVvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr ")"
  }
//
| PMVarg (n) => {
    val () = prstr "PMVarg("
    val () = fprint_int (out, n)
    val () = prstr ")"
  }
| PMVargref (n) => {
    val () = prstr "PMVargref("
    val () = fprint_int (out, n)
    val () = prstr ")"
  }
| PMVargtmpref (n) => {
    val () = prstr "PMVargtmpref("
    val () = fprint_int (out, n)
    val () = prstr ")"
  }
//
| PMVint (i) => {
    val () = prstr "PMVint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| PMVbool (b) => {
    val () = prstr "PMVbool("
    val () = fprint_bool (out, b)
    val () = prstr ")"
  }
| PMVchar (c) => {
    val () = prstr "PMVchar("
    val () = fprint_char (out, c)
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
| PMVempty () => prstr "PMVempty()"
//
| PMVextval (name) => {
    val () = prstr "PMVextval("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
//
| PMVfunlab (fl) => {
    val () = prstr "PMVfunlab("
    val () = fprint_funlab (out, fl)
    val () = prstr ")"
  }
//
| PMVptrof (pmv) => {
    val () = prstr "PMVptrof("
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| PMVtmpltcst
    (d2c, t2mas) => {
    val () = prstr "PMVtmpltcst("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
| PMVtmpltcstmat
    (d2c, t2mas, mat) => {
    val () = prstr "PMVtmpltcstmat["
    val () = fprint_tmpcstmat_kind (out, mat)
    val () = prstr "]("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
| PMVtmpltvar
    (d2v, t2mas) => {
    val () = prstr "PMVtmpltvar("
    val () = fprint_d2var (out, d2v)
    val () = prstr "<"
    val () = fpprint_t2mpmarglst (out, t2mas)
    val () = prstr ">"
    val () = prstr ")"
  }
//
| PMVcastfn (d2c, pmv) => {
    val () = prstr "PMVcastfn("
    val () = fprint_d2cst (out, d2c)
    val () = prstr "; "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| _ => {
    val () = prstr "PMV...(...)"
  }
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
    val () = prstr "PATCKi0nt("
    val () = $SYN.fprint_f0loat (out, tok)
    val () = prstr ")"
  }
//
| PATCKcon (d2c) => {
    val () = prstr "PATCKcon("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
| PATCKexn (d2c) => {
    val () = prstr "PATCKexn("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
//
end // end of [patck]

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
| PTCKNTnone () =>
    prstr "PTCKNTnone()"
| PTCKNTtmplab (tl) => {
    val () = prstr "PTCKNTtmplab("
    val () = fprint_tmplab (out, tl)
    val () = prstr ")"
  }
| PTCKNTtmplabint (tl, i) => {
    val () = prstr "PTCKNTtmplab("
    val () = fprint_tmplab (out, tl)
    val () = prstr ", "
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
| PTCKNTcaseof_fail (loc) => {
    val () = prstr "PTCKNTcaseof_fail("
    val () = prstr ")"
  }
| PTCKNTfunarg_fail (loc, fl) => {
    val () = prstr "PTCKNTfunarg_fail("
    val () = prstr ")"
  }
| PTCKNTraise (pmv) => {
    val () = prstr "PTCKNTraise("
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  } 
end // end of [patckont]

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
| INSmove_val (tmp, pmv) => {
    val () = prstr "INSmove_val("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
| INSmove_arg_val (i, pmv) => {
    val () = prstr "INSmove_arg_val("
    val () = fprintf (out, "arg(%i)", @(i))
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr ")"
  }
//
| INSmove_con (
    tmpret, d2c, hse_sum, pmvs
  ) => {
    val () = prstr "INSmove_con("
    val () = fpprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_d2con (out, d2c)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_sum)
    val () = prstr ";"
    val () = fprint_primvalist (out, pmvs)
    val () = prstr ")"
    val () = prstr ")"
  }
//
| INSmove_list_nil (tmp) => {
    val () =
      prstr "INSmove_list_nil("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| INSpmove_list_nil (tmp) => {
    val () =
      prstr "INSpmove_list_nil("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| INSpmove_list_cons (tmp) => {
    val () =
      prstr "INSpmove_list_cons("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
//
| INSupdate_list_head
    (tmphd, tmptl, hse_elt) => {
    val () = prstr "INSupdate_list_head("
    val () = fpprint_tmpvar (out, tmphd)
    val () = prstr "; "
    val () = fpprint_tmpvar (out, tmptl)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
| INSupdate_list_tail
    (tl_new, tl_old, hse_elt) => {
    val () = prstr "INSupdate_list_tail("
    val () = fpprint_tmpvar (out, tl_new)
    val () = prstr "; "
    val () = fpprint_tmpvar (out, tl_old)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
//
| INSmove_arrpsz (
    tmp, hse_elt, asz
  ) => {
    val () = prstr "INSmov_arrpsz("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr "; "
    val () = fprint_int (out, asz)
    val () = prstr ")"
  }
| INSupdate_ptrinc
    (tmpelt, hse_elt) => {
    val () = prstr "INSupdate_ptrinc("
    val () = fpprint_tmpvar (out, tmpelt)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_elt)
    val () = prstr ")"
  }
//
| INSfuncall (
    tmpret, _fun, hse_fun, _arg
  ) => {
    val () = prstr "INSfuncall("
    val () = fpprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_primval (out, _fun)
    val () = prstr "("
    val () = fprint_hisexp (out, hse_fun)
    val () = prstr "; "
    val () = fprint_primvalist (out, _arg)
    val () = prstr ")"
    val () = prstr ")"
  } // end of [INSfuncall]
//
| INScond (
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
| INSselect (
    tmp, pmv, hse_rec, hils
  ) => {
    val () = prstr "INSselect("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_rec)
    val () = prstr "; "
    val () = fprint_hilablst (out, hils)
    val () = prstr ")"
  } // end of [INSselect]
//
| INSselcon (
    tmp, pmv, hse_sum, narg
  ) => {
    val () = prstr "INSselcon("
    val () = fpprint_tmpvar (out, tmp)
    val () = prstr " <- "
    val () = fprint_primval (out, pmv)
    val () = prstr "; "
    val () = fprint_hisexp (out, hse_sum)
    val () = prstr "; "
    val () = fprint_int (out, narg) // HX: argument number
    val () = prstr ")"
  } // end of [INSselcon]
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
| INSassgn_varofs
    (d2v_l, ofs, pmv_r) => {
    val () = prstr "INSassgn_varofs("
    val () = fprint_d2var (out, d2v_l)
    val () = prstr "["
    val () = fprint_primlablst (out, ofs)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_primval (out, pmv_r)
    val () = prstr ")"
  }
| INSassgn_ptrofs
    (pmv_l, ofs, pmv_r) => {
    val () = prstr "INSassgn_ptrofs("
    val () = fprint_primval (out, pmv_l)
    val () = prstr "["
    val () = fprint_primlablst (out, ofs)
    val () = prstr "]"
    val () = prstr " := "
    val () = fprint_primval (out, pmv_r)
    val () = prstr ")"
  }
//
| INSletpop () => {
    val () = prstr "INSletpop()"
  }
| INSletpush (pmds) => {
    val () = prstr "INSletpush(\n"
    val () = fprint_primdeclst (out, pmds)
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
//
end // end of [fprint_tmpcstmat]

implement
fprint_tmpcstmat_kind
  (out, opt) = let
  val knd = (
    case+ opt of TMPCSTMATsome _ => 1 | TMPCSTMATnone _ => 0
  ) : int // end of [val]
in
  fprint_int (out, knd)
end // end of [fprint_tmpcstmat_kind]

(* ****** ****** *)

(* end of [pats_ccomp_print.dats] *)
