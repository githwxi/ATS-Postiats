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

staload UT = "pats_utils.sats"
staload _ (*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
staload SYN = "pats_syntax.sats"

(* ****** ****** *)

staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

implement
fprint_primdec
  (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x.primdec_node of
//
| PMDnone () => prstr "PMDnone()"
//
| PMDdcstdecs
    (knd, d2cs) => {
    val () = prstr "PMDdcstdecs("
    val () = $UT.fprintlst (out, d2cs, ", ", fprint_d2cst)
    val () = prstr ")"
  }
//
| PMDimpdec () => {
    val () = prstr "PMDimpdec("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| PMDfundecs () => {
    val () = prstr "PMDfundecs("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| PMDvaldecs () => {
    val () = prstr "PMDvaldecs("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| PMDvardecs (d2vs) => {
    val () = prstr "PMDvardecs("
    val () = fprint_d2varlst (out, d2vs)
    val () = prstr ")"
  }
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
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
| PMVtmpref (tmp) => {
    val () = prstr "PMVtmpref("
    val () = fprint_tmpvar (out, tmp)
    val () = prstr ")"
  }
//
| PMVdcst (d2c) => {
    val () = prstr "PMVdcst("
    val () = fprint_d2cst (out, d2c)
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
//
| PMVlet (pmds, pmv) => {
    val () = prstr "PMVlet("
    val () = fprint_string (out, "...")
    val () = prstr "; "
    val () = fprint_primval (out, pmv)
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
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_primlab)
// end of [fprint_primlablst]

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
| INSmove_val (tmp, pmv) => {
    val () = prstr "INSmove_val("
    val () = fprint_tmpvar (out, tmp)
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
| INSfuncall (
    tmpret, hse_fun, _fun, _arg
  ) => {
    val () = prstr "INSfuncall("
    val () = fprint_tmpvar (out, tmpret)
    val () = prstr " <- "
    val () = fprint_primval (out, _fun)
    val () = prstr "; "
    val () = fprint_primvalist (out, _arg)
    val () = prstr ")"
  } // end of [INSfuncall]
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
| _ => prstr "INS...(...)"
//
end // end of [fprint_instr]

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

(* end of [pats_ccomp_print.dats] *)
