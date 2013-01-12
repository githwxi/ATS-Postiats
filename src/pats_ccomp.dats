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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
hiimpdec_get_funlabopt (imp) =
  $UN.ptrget<Option(funlab)> (hiimpdec_getref_funlabopt (imp))
// end of [hiimpdec_get_funlabopt]

implement
hiimpdec_set_funlabopt (imp, opt) =
  $UN.ptrset<Option(funlab)> (hiimpdec_getref_funlabopt (imp), opt)
// end of [hiimpdec_set_funlabopt]

(* ****** ****** *)

extern
fun primdec_make_node
  (loc: location, node: primdec_node): primdec
implement
primdec_make_node
  (loc, node) = '{
  primdec_loc= loc, primdec_node= node
} // end of [primdec_make_node]

(* ****** ****** *)

implement
primdec_none (loc) =
  primdec_make_node (loc, PMDnone ())
// end of [primdec_none]

(* ****** ****** *)

implement
primdec_datdecs (loc, s2cs) =
  primdec_make_node (loc, PMDdatdecs (s2cs))

(* ****** ****** *)

implement
primdec_fundecs (loc, hfds) =
  primdec_make_node (loc, PMDfundecs (hfds))

(* ****** ****** *)

implement
primdec_valdecs (loc, knd, hvds, inss) =
  primdec_make_node (loc, PMDvaldecs (knd, hvds, inss))
implement
primdec_valdecs_rec (loc, knd, hvds, inss) =
  primdec_make_node (loc, PMDvaldecs_rec (knd, hvds, inss))

(* ****** ****** *)

implement
primdec_vardecs (loc, hvds, inss) =
  primdec_make_node (loc, PMDvardecs (hvds, inss))

(* ****** ****** *)

implement
primdec_staload (loc, fenv) =
  primdec_make_node (loc, PMDstaload (fenv))

(* ****** ****** *)

implement
primdec_impdec
  (loc, impdec) =
  primdec_make_node (loc, PMDimpdec (impdec))
// end of [primdec_impdec]

(* ****** ****** *)

implement
primdec_local
  (loc, _head, _body) =
  primdec_make_node (loc, PMDlocal (_head, _body))
// end of [primdec_local]

(* ****** ****** *)

extern
fun primval_make_node
  (loc: location, hse: hisexp, node: primval_node): primval
implement
primval_make_node
  (loc, hse, node) = '{
  primval_loc= loc, primval_type= hse, primval_node= node
} // end of [primval_make_node]

(* ****** ****** *)

implement
primval_tmp (loc, hse, tmp) =
  primval_make_node (loc, hse, PMVtmp (tmp))
// end of [primval_tmp]

implement
primval_tmpref (loc, hse, tmp) =
  primval_make_node (loc, hse, PMVtmpref (tmp))
// end of [primval_tmpref]

(* ****** ****** *)

implement
primval_arg (loc, hse, narg) =
  primval_make_node (loc, hse, PMVarg (narg))
implement
primval_argref (loc, hse, narg) =
  primval_make_node (loc, hse, PMVargref (narg))
implement
primval_argtmpref (loc, hse, narg) =
  primval_make_node (loc, hse, PMVargtmpref (narg))

(* ****** ****** *)

implement
primval_cst
  (loc, hse, d2c) =
  primval_make_node (loc, hse, PMVcst (d2c))
// end of [primval_cst]

implement
primval_var
  (loc, hse, d2v) =
  primval_make_node (loc, hse, PMVvar (d2v))
// end of [primval_var]

(* ****** ****** *)

implement
primval_int (loc, hse, i) =
  primval_make_node (loc, hse, PMVint (i))
// end of [primval_int]

implement
primval_bool (loc, hse, b) =
  primval_make_node (loc, hse, PMVbool (b))
// end of [primval_bool]

implement
primval_char (loc, hse, c) =
  primval_make_node (loc, hse, PMVchar (c))
// end of [primval_char]

implement
primval_string (loc, hse, str) =
  primval_make_node (loc, hse, PMVstring (str))
// end of [primval_string]

(* ****** ****** *)

implement
primval_i0nt (loc, hse, x) =
  primval_make_node (loc, hse, PMVi0nt (x))
// end of [primval_i0nt]

implement
primval_f0loat (loc, hse, x) =
  primval_make_node (loc, hse, PMVf0loat (x))
// end of [primval_f0loat]

(* ****** ****** *)

implement
primval_empty (loc, hse) =
  primval_make_node (loc, hse, PMVempty ())
// end of [primval_empty]

implement
primval_extval (loc, hse, name) =
  primval_make_node (loc, hse, PMVextval (name))
// end of [primval_extval]

(* ****** ****** *)

implement
primval_funlab (loc, hse, fl) =
  primval_make_node (loc, hse, PMVfunlab (fl))
// end of [primval_funlab]

(* ****** ****** *)

implement
primval_tmpltcst
  (loc, hse, d2c, t2mas) =
  primval_make_node (loc, hse, PMVtmpltcst (d2c, t2mas))
// end of [primval_tmpltcst]

implement
primval_tmpltcstmat
  (loc, hse, d2c, t2mas, mat) =
  primval_make_node (loc, hse, PMVtmpltcstmat (d2c, t2mas, mat))
// end of [primval_tmpltcstmat]

implement
primval_tmpltvar
  (loc, hse, d2v, t2mas) =
  primval_make_node (loc, hse, PMVtmpltvar (d2v, t2mas))
// end of [primval_tmpltvar]

(* ****** ****** *)

implement
primval_make_tmp
  (loc, tmp) = let
  val hse = tmpvar_get_hisexp (tmp) in primval_tmp (loc, hse, tmp)
end // end of [primval_make_tmp]
  
(* ****** ****** *)

implement
primval_make_ptrof
  (loc, pmv) = let
  val hse = hisexp_typtr in primval_make_node (loc, hse, PMVptrof (pmv))
end // end of [primval_make_ptrof]

(* ****** ****** *)

implement
primlab_lab (loc, lab) = '{
  primlab_loc= loc, primlab_node= PMLlab (lab)
}

implement
primlab_ind (loc, ind) = '{
  primlab_loc= loc, primlab_node= PMLind (ind)
}

(* ****** ****** *)

extern
fun instr_make_node
  (loc: location, node: instr_node): instr
implement
instr_make_node
  (loc, node) = '{
  instr_loc= loc, instr_node= node
} // end of [instr_make_node]

(* ****** ****** *)

implement
instr_funlab (loc, fl) =
  instr_make_node (loc, INSfunlab (fl))
// end of [instr_funlab]

(* ****** ****** *)

implement
instr_move_val (loc, tmp, pmv) =
  instr_make_node (loc, INSmove_val (tmp, pmv))
// end of [instr_move_val]

implement
instr_move_arg_val (loc, arg, pmv) =
  instr_make_node (loc, INSmove_arg_val (arg, pmv))
// end of [instr_move_arg_val]

(* ****** ****** *)

implement
instr_move_con (
  loc, tmpret, d2c, hse_sum, _arg
) = instr_make_node
  (loc, INSmove_con (tmpret, d2c, hse_sum, _arg))
// end of [instr_move_con]

(* ****** ****** *)

implement
instr_move_boxrec (
  loc, tmpret, lpmvs, hse_rec
) = instr_make_node
  (loc, INSmove_boxrec (tmpret, lpmvs, hse_rec))
// end of [instr_move_boxrec]

implement
instr_move_fltrec (
  loc, tmpret, lpmvs, hse_rec
) = instr_make_node
  (loc, INSmove_fltrec (tmpret, lpmvs, hse_rec))
// end of [instr_move_fltrec]

(* ****** ****** *)

implement
instr_move_list_nil
  (loc, tmp) = instr_make_node (loc, INSmove_list_nil (tmp))
// end of [instr_move_list_nil]
implement
instr_pmove_list_nil
  (loc, tmp) = instr_make_node (loc, INSpmove_list_nil (tmp))
// end of [instr_pmove_list_nil]
implement
instr_pmove_list_cons
  (loc, tmp) = instr_make_node (loc, INSpmove_list_cons (tmp))
// end of [instr_pmove_list_cons]

implement
instr_update_list_head
  (loc, tmphd, tmptl, hse_elt) =
  instr_make_node (loc, INSupdate_list_head (tmphd, tmptl, hse_elt))
// end of [instr_update_list_head]

implement
instr_update_list_tail
  (loc, tl_new, tl_old, hse_elt) =
  instr_make_node (loc, INSupdate_list_tail (tl_new, tl_old, hse_elt))
// end of [instr_update_list_tail]

(* ****** ****** *)

implement
instr_move_arrpsz
  (loc, tmp, hse_elt, asz) =
  instr_make_node (loc, INSmove_arrpsz (tmp, hse_elt, asz))
// end of [instr_move_arrpsz]

implement
instr_update_ptrinc
  (loc, tmpelt, hse_elt) =
  instr_make_node (loc, INSupdate_ptrinc (tmpelt, hse_elt))
// end of [instr_update_ptrinc]

(* ****** ****** *)

implement
instr_move_select
  (loc, tmp, pmv, hse_rec, hils) =
  instr_make_node (loc, INSmove_select (tmp, pmv, hse_rec, hils))
// end of [instr_move_select]

implement
instr_move_selcon
  (loc, tmp, pmv, hse_sum, narg) =
  instr_make_node (loc, INSmove_selcon (tmp, pmv, hse_sum, narg))
// end of [instr_move_selcon]

(* ****** ****** *)

implement
instr_funcall (
  loc, tmpret, _fun, hse_fun, _arg
) = instr_make_node
  (loc, INSfuncall (tmpret, _fun, hse_fun, _arg))
// end of [instr_funcall]

(* ****** ****** *)

implement
instr_cond
  (loc, _cond, _then, _else) =
  instr_make_node (loc, INScond (_cond, _then, _else))
// end of [instr_cond]

(* ****** ****** *)

implement
instr_patck
  (loc, pmv, pck, pcknt) =
  instr_make_node (loc, INSpatck (pmv, pck, pcknt))
// end of [instr_patck]

(* ****** ****** *)

implement
instr_assgn_varofs
  (loc, d2v_l, ofs, pmv_r) =
  instr_make_node (loc, INSassgn_varofs (d2v_l, ofs, pmv_r))
// end of [instr_assgn_varofs]

implement
instr_assgn_ptrofs
  (loc, pmv_l, ofs, pmv_r) =
  instr_make_node (loc, INSassgn_ptrofs (pmv_l, ofs, pmv_r))
// end of [instr_assgn_ptrofs]

(* ****** ****** *)

implement
instr_letpop
  (loc) = instr_make_node (loc, INSletpop ())
// end of [instr_letpop]

implement
instr_letpush
  (loc, pmds) = instr_make_node (loc, INSletpush (pmds))
// end of [instr_letpush]

(* ****** ****** *)

(* end of [pats_ccomp.dats] *)
