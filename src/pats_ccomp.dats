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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)
//
implement
hifundec_get_funlabopt
  (hfd) = $UN.cast{funlabopt}(hfd.hifundec_funlab)
implement
hifundec_set_funlabopt (hfd, opt) =
  $UN.ptrset<funlabopt> (hifundec_getref_funlabopt (hfd), opt)
//
(* ****** ****** *)
//
implement
hiimpdec_get_funlabopt
  (imp) = $UN.cast{funlabopt}(imp.hiimpdec_funlab)
implement
hiimpdec_set_funlabopt (imp, opt) =
  $UN.ptrset<funlabopt> (hiimpdec_getref_funlabopt (imp), opt)
//
(* ****** ****** *)
//
implement
hiimpdec_get_instrlstopt
  (imp) = $UN.cast{instrlstopt}(imp.hiimpdec_instrlst)
implement
hiimpdec_set_instrlstopt (imp, opt) =
  $UN.ptrset<instrlstopt> (hiimpdec_getref_instrlstopt (imp), opt)
//
(* ****** ****** *)

extern
fun
primdec_make_node
(
  loc: loc_t, node: primdec_node
) : primdec // end-of-function
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
primdec_list (loc, pmds) =
  primdec_make_node (loc, PMDlist (pmds))
// end of [primdec_list]

(* ****** ****** *)

implement
primdec_saspdec (loc, d2c) =
  primdec_make_node (loc, PMDsaspdec (d2c))
// end of [primdec_saspdec]

(* ****** ****** *)

implement
primdec_extvar
  (loc, name, inss) =
  primdec_make_node (loc, PMDextvar (name, inss))
// end of [primdec_extvar]

(* ****** ****** *)

implement
primdec_datdecs (loc, s2cs) =
  primdec_make_node (loc, PMDdatdecs (s2cs))
implement
primdec_exndecs (loc, d2cs) =
  primdec_make_node (loc, PMDexndecs (d2cs))

(* ****** ****** *)

implement
primdec_impdec
  (loc, impdec) =
  primdec_make_node (loc, PMDimpdec (impdec))
// end of [primdec_impdec]

(* ****** ****** *)

implement
primdec_fundecs
  (loc, knd, decarg, hfds) =
  primdec_make_node (loc, PMDfundecs (knd, decarg, hfds))
// end of [primdec_fundecs]

(* ****** ****** *)

implement
primdec_valdecs (loc, knd, hvds, inss) =
  primdec_make_node (loc, PMDvaldecs (knd, hvds, inss))
implement
primdec_valdecs_rec (loc, knd, hvds, inss) =
  primdec_make_node (loc, PMDvaldecs_rec (knd, hvds, inss))

(* ****** ****** *)
//
implement
primdec_vardecs
  (loc, hvds, inss) =
  primdec_make_node (loc, PMDvardecs (hvds, inss))
//
(* ****** ****** *)
//
implement
primdec_include
  (loc, knd, pmds) =
  primdec_make_node (loc, PMDinclude (knd, pmds))
//
(* ****** ****** *)
//
implement
primdec_staload (loc, hid) =
  primdec_make_node (loc, PMDstaload (hid))
//
implement
primdec_staloadloc
(
  loc, pfil, nspace, hids
) = primdec_make_node
  (loc, PMDstaloadloc (pfil, nspace, hids))
//
implement
primdec_dynload (loc, hid) =
  primdec_make_node (loc, PMDdynload (hid))
//
(* ****** ****** *)

implement
primdec_local
  (loc, _head, _body) =
  primdec_make_node (loc, PMDlocal (_head, _body))
// end of [primdec_local]

(* ****** ****** *)

extern
fun
primval_make_node
  (loc: loc_t, hse: hisexp, node: primval_node): primval
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
//
implement
primval_arg (loc, hse, narg) =
  primval_make_node (loc, hse, PMVarg (narg))
implement
primval_argref (loc, hse, narg) =
  primval_make_node (loc, hse, PMVargref (narg))
implement
primval_argtmpref (loc, hse, narg) =
  primval_make_node (loc, hse, PMVargtmpref (narg))
//
implement
primval_argenv (loc, hse, nenv) =
  primval_make_node (loc, hse, PMVargenv (nenv))
//
(* ****** ****** *)

implement
primval_cst
  (loc, hse, d2c) =
  primval_make_node (loc, hse, PMVcst (d2c))
// end of [primval_cst]

implement
primval_env
  (loc, hse, d2v) =
  primval_make_node (loc, hse, PMVenv (d2v))
// end of [primval_env]

(* ****** ****** *)

implement
primval_int
  (loc, hse, i) =
  primval_make_node (loc, hse, PMVint (i))
// end of [primval_int]

implement
primval_intrep
  (loc, hse, rep) =
  primval_make_node (loc, hse, PMVintrep (rep))
// end of [primval_intrep]

(* ****** ****** *)

implement
primval_bool
  (loc, hse, b) =
  primval_make_node (loc, hse, PMVbool (b))
// end of [primval_bool]

implement
primval_char
  (loc, hse, c) =
  primval_make_node (loc, hse, PMVchar (c))
// end of [primval_char]

implement
primval_float
  (loc, hse, f) =
  primval_make_node (loc, hse, PMVfloat (f))
// end of [primval_float]

implement
primval_string
  (loc, hse, str) =
  primval_make_node (loc, hse, PMVstring (str))
// end of [primval_string]

(* ****** ****** *)

implement
primval_i0nt
  (loc, hse, x) =
  primval_make_node (loc, hse, PMVi0nt (x))
// end of [primval_i0nt]

implement
primval_f0loat
  (loc, hse, x) =
  primval_make_node (loc, hse, PMVf0loat (x))
// end of [primval_f0loat]

(* ****** ****** *)

implement
primval_cstsp
  (loc, hse, cstsp) =
  primval_make_node (loc, hse, PMVcstsp (cstsp))
// end of [primval_cstsp]

(* ****** ****** *)

implement
primval_tyrep
  (loc, hse0, hse) =
  primval_make_node (loc, hse0, PMVtyrep (hse))
// end of [primval_tyrep]

implement
primval_sizeof
  (loc, hse0, hse) =
  primval_make_node (loc, hse0, PMVsizeof (hse))
// end of [primval_sizeof]

(* ****** ****** *)

implement
primval_top (loc, hse) =
  primval_make_node (loc, hse, PMVtop ())
// end of [primval_top]

implement
primval_empty (loc, hse) =
  primval_make_node (loc, hse, PMVempty ())
// end of [primval_empty]

(* ****** ****** *)

implement
primval_extval (loc, hse, name) =
  primval_make_node (loc, hse, PMVextval (name))
// end of [primval_extval]

(* ****** ****** *)

implement
primval_castfn
  (loc, hse, d2c, arg) =
  primval_make_node (loc, hse, PMVcastfn (d2c, arg))
// end of [primval_castfn]

(* ****** ****** *)

implement
primval_selcon
  (loc, hse, pmv, hse_sum, lab) =
  primval_make_node (loc, hse, PMVselcon (pmv, hse_sum, lab))
// end of [primval_selcon]

(* ****** ****** *)

implement
primval_select
  (loc, hse, pmv, hse_rt, pml) =
  primval_make_node (loc, hse, PMVselect (pmv, hse_rt, pml))
// end of [primval_select]

implement
primval_select2
  (loc, hse, pmv, hse_rt, pmls) =
  primval_make_node (loc, hse, PMVselect2 (pmv, hse_rt, pmls))
// end of [primval_select2]

(* ****** ****** *)

implement
primval_selptr
  (loc, hse, pmv, hse_rt, pmls) =
  primval_make_node (loc, hse, PMVselptr (pmv, hse_rt, pmls))
// end of [primval_selptr]

(* ****** ****** *)

implement
primval_ptrof
  (loc, hse, pmv) =
  primval_make_node (loc, hse, PMVptrof (pmv))
// end of [primval_ptrof]

implement
primval_ptrofsel (
  loc, hse, pmv, hse_rt, pmls
) =
  primval_make_node (loc, hse, PMVptrofsel (pmv, hse_rt, pmls))
// end of [primval_ptrofsel]

(* ****** ****** *)

implement
primval_refarg
  (loc, hse, knd, freeknd, pmv) =
  primval_make_node (loc, hse, PMVrefarg (knd, freeknd, pmv))
// end of [primval_refarg]

(* ****** ****** *)

implement
primval_funlab
  (loc, hse, fl) =
  primval_make_node (loc, hse, PMVfunlab (fl))
// end of [primval_funlab]

implement
primval_cfunlab
  (loc, hse, knd, fl) =
  primval_make_node (loc, hse, PMVcfunlab (knd, fl))
// end of [primval_cfunlab]

(* ****** ****** *)

implement
primval_d2vfunlab
  (loc, hse, d2v, fl) =
  primval_make_node (loc, hse, PMVd2vfunlab (d2v, fl))
// end of [primval_d2vfunlab]

(* ****** ****** *)

implement
primval_lamfix
  (knd, pmv_funval) = let
//
val loc = pmv_funval.primval_loc
val hse = pmv_funval.primval_type
//
in
  primval_make_node (loc, hse, PMVlamfix (knd, pmv_funval))
end // end of [primval_lamfix]

(* ****** ****** *)

implement
primval_tmpltcst
  (loc, hse, d2c, t2mas) =
  primval_make_node(loc, hse, PMVtmpltcst (d2c, t2mas))
// end of [primval_tmpltcst]
implement
primval_tmpltvar
  (loc, hse, d2v, t2mas) =
  primval_make_node(loc, hse, PMVtmpltvar (d2v, t2mas))
// end of [primval_tmpltvar]

(* ****** ****** *)
//
implement
primval_tmpltcstmat
  (loc, hse, d2c, t2mas, mat) =
  primval_make_node
    (loc, hse, PMVtmpltcstmat (d2c, t2mas, mat))
// end of [primval_tmpltcstmat]
//
implement
primval_tmpltvarmat
  (loc, hse, d2v, t2mas, mat) =
  primval_make_node
    (loc, hse, PMVtmpltvarmat (d2v, t2mas, mat))
// end of [primval_tmpltvarmat]
//
(* ****** ****** *)
//
(*
implement
primval_tempenver
  (loc, hse, d2vs) =
  primval_make_node(loc, hse, PMVtempenver(d2vs))
*)
//
(* ****** ****** *)

implement
primval_error
  (loc, hse) =
  primval_make_node (loc, hse, PMVerror((*error*)))
// end of [primval_error]

(* ****** ****** *)

implement
primval_make_sizeof
  (loc, s2e) = let
//
val hse =
  hisexp_size_t0ype() in primval_sizeof(loc, hse, s2e)
//
end // end of [primval_make_sizeof]

(* ****** ****** *)

implement
primval_make_tmp
  (loc, tmp) = let
  val hse = tmpvar_get_type (tmp) in primval_tmp (loc, hse, tmp)
end // end of [primval_make_tmp]

implement
primval_make_tmpref
  (loc, tmp) = let
  val hse = tmpvar_get_type (tmp) in primval_tmpref (loc, hse, tmp)
end // end of [primval_make_tmpref]
  
(* ****** ****** *)

implement
primval_make_ptrofsel
(
  loc, pmv, hse_rt, pmls
) = let
  val hse_ptr = hisexp_typtr
  val hse_undef = hisexp_undefined // HX: a place holder
  val pmv_sel = primval_selptr (loc, hse_undef, pmv, hse_rt, pmls)
in
  primval_ptrof (loc, hse_ptr, pmv_sel)
end // end of [primval_make_ptrofsel]

(* ****** ****** *)

implement
ibranch_make
  (loc, inss) = '{
  ibranch_loc= loc, ibranch_inslst= inss
} // end of [ibranch_make]

(* ****** ****** *)

implement
primlab_is_lab (pml) =
  case+ pml.primlab_node of
  | PMLlab _ => true | PMLind _ => false
// end of [primlab_is_lab]

implement
primlab_is_ind (pml) =
  case+ pml.primlab_node of
  | PMLlab _ => false | PMLind _ => true
// end of [primlab_is_ind]

(* ****** ****** *)

implement
primlab_lab (loc, lab) = '{
  primlab_loc= loc, primlab_node= PMLlab (lab)
} // end of [primlab_lab]

implement
primlab_ind (loc, ind) = '{
  primlab_loc= loc, primlab_node= PMLind (ind)
} // end of [primlab_ind]

(* ****** ****** *)

extern
fun
instr_make_node
(
  loc: loc_t, node: instr_node
) : instr // end-of-function
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
instr_tmplab (loc, tl) =
  instr_make_node (loc, INStmplab (tl))
// end of [instr_tmplab]

(* ****** ****** *)

implement
instr_comment (loc, str) =
  instr_make_node (loc, INScomment (str))
// end of [instr_comment]

(* ****** ****** *)

implement
instr_move_val (loc, tmp, pmv) =
  instr_make_node (loc, INSmove_val (tmp, pmv))
// end of [instr_move_val]

implement
instr_pmove_val (loc, tmp, pmv) =
  instr_make_node (loc, INSpmove_val (tmp, pmv))
// end of [instr_pmove_val]

(* ****** ****** *)

implement
instr_move_arg_val (loc, arg, pmv) =
  instr_make_node (loc, INSmove_arg_val (arg, pmv))
// end of [instr_move_arg_val]

(* ****** ****** *)

implement
instr_fcall
(
  loc, tmpret, hde_fun, hse_fun, hdes_arg
) = instr_make_node
  (loc, INSfcall (tmpret, hde_fun, hse_fun, hdes_arg))
// end of [instr_fcall]

implement
instr_fcall2
(
  loc, tmpret, flab, ntl ,hse_fun, hdes_arg
) = instr_make_node
  (loc, INSfcall2 (tmpret, flab, ntl, hse_fun, hdes_arg))
// end of [instr_fcall2]

(* ****** ****** *)

implement
instr_extfcall
  (loc, tmpret, _fun, _arg) =
  instr_make_node(loc, INSextfcall (tmpret, _fun, _arg))
// end of [instr_extfcall]

implement
instr_extmcall
  (loc, tmpret, _obj, _mtd, _arg) =
  instr_make_node(loc, INSextmcall (tmpret, _obj, _mtd, _arg))
// end of [instr_extmcall]

(* ****** ****** *)

implement
instr_cond
  (loc, _cond, _then, _else) =
  instr_make_node (loc, INScond (_cond, _then, _else))
// end of [instr_cond]

(* ****** ****** *)

implement
instr_freecon
  (loc, pmv) = instr_make_node (loc, INSfreecon (pmv))
// end of [instr_freecon]

(* ****** ****** *)

implement
instr_loop
(
  loc, tlab_init, tlab_fini, tlab_cont
, inss_init, pmv_test, inss_test, inss_post, inss_body
) = let
//
val node = INSloop
(
  tlab_init, tlab_fini, tlab_cont
, inss_init, pmv_test, inss_test, inss_post, inss_body
)
//
in
  instr_make_node (loc, node)
end // end of [instr_loop]  

implement
instr_loopexn (
  loc, knd, tlab
) = instr_make_node (loc, INSloopexn (knd, tlab))

(* ****** ****** *)

implement
instr_caseof
  (loc, xs) = instr_make_node (loc, INScaseof (xs))
// end of [instr_caseof]

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

implement
instr_move_con (
  loc, tmpret, d2c, hse_sum, _arg
) = instr_make_node
  (loc, INSmove_con (tmpret, d2c, hse_sum, _arg))
// end of [instr_move_con]

(* ****** ****** *)

implement
instr_move_ref
  (loc, tmpret, pmv) =
  instr_make_node (loc, INSmove_ref (tmpret, pmv))
// end of [instr_move_ref]

(* ****** ****** *)

implement
instr_move_boxrec
(
  loc, tmpret, lpmvs, hse_rec
) = instr_make_node
  (loc, INSmove_boxrec (tmpret, lpmvs, hse_rec))
// end of [instr_move_boxrec]

implement
instr_move_fltrec
(
  loc, tmpret, lpmvs, hse_rec
) = instr_make_node
  (loc, INSmove_fltrec (tmpret, lpmvs, hse_rec))
// end of [instr_move_fltrec]

implement
instr_move_fltrec2
(
  loc, tmpret, lpmvs, hse_rec
) = let
in
//
case+
  hse_rec.hisexp_node of
| HSEtyrecsin (lhse) => let
    val-list_cons (lpmv, _) = lpmvs
    val+LABPRIMVAL (lab, pmv) = lpmv
  in
    instr_move_val (loc, tmpret, pmv)
  end // end of [HSEtyrecsin]
| _ => instr_move_fltrec (loc, tmpret, lpmvs, hse_rec)
//
end // end of [instr_move_fltrec2]

(* ****** ****** *)

implement
instr_patck
  (loc, pmv, ptck, ptcknt) =
  instr_make_node (loc, INSpatck (pmv, ptck, ptcknt))
// end of [instr_patck]

(* ****** ****** *)

implement
instr_move_selcon (
  loc, tmp, hse, pmv, hse_sum, lab
) = let
  val pmv_sel = primval_selcon (loc, hse, pmv, hse_sum, lab)
in
  instr_move_val (loc, tmp, pmv_sel)
end // end of [instr_selcon]

implement
instr_move_select (
  loc, tmp, hse, pmv, hse_rt, pml
) = let
  val pmv_sel = primval_select (loc, hse, pmv, hse_rt, pml)
in
  instr_move_val (loc, tmp, pmv_sel)
end // end of [instr_select]

implement
instr_move_select2 (
  loc, tmp, hse, pmv, hse_rt, pmls
) = let
  val pmv_sel = primval_select2 (loc, hse, pmv, hse_rt, pmls)
in
  instr_move_val (loc, tmp, pmv_sel)
end // end of [instr_select2]

(* ****** ****** *)

implement
instr_move_ptrofsel
(
  loc, tmp, pmv, hse_rt, hils
) = let
//
val ins = INSmove_ptrofsel (tmp, pmv, hse_rt, hils)
//
in
  instr_make_node (loc, ins)
end // end of [instr_move_ptrofsel]

(* ****** ****** *)

(*
implement
instr_load_ptrofs
  (loc, tmp, pmv, hse_rt, pmls) =
  instr_make_node (loc, INSload_ptrofs (tmp, pmv, hse_rt, pmls))
// end of [instr_load_ptrofs]
*)

(* ****** ****** *)

implement
instr_store_ptrofs
(
  loc, pmv_l, hse_rt, ofs, pmv_r
) = let
//
val ins =
INSstore_ptrofs (pmv_l, hse_rt, ofs, pmv_r)
//
in
  instr_make_node (loc, ins)
end // end of [instr_store_ptrofs]

implement
instr_xstore_ptrofs
(
  loc, tmp, pmv_l, hse_rt, ofs, pmv_r
) = let
//
val ins =
INSxstore_ptrofs(tmp, pmv_l, hse_rt, ofs, pmv_r)
//
in
  instr_make_node (loc, ins)
end // end of [instr_xstore_ptrofs]

(* ****** ****** *)

implement
instr_raise
  (loc, tmp, pmv_exn) =
  instr_make_node (loc, INSraise (tmp, pmv_exn))
// end of [instr_raise]

(* ****** ****** *)

implement
instr_move_delay
  (loc, tmp, lin, hse, thunk) = let
in
//
instr_make_node
  (loc, INSmove_delay (tmp, lin, hse, thunk))
// instr_make_node
//
end // end of [instr_move_delay]

implement
instr_move_lazyeval
  (loc, tmp, lin, hse, pmv_lazy) = let
in
//
instr_make_node
  (loc, INSmove_lazyeval (tmp, lin, hse, pmv_lazy))
// instr_make_node
end // end of [instr_move_lazyeval]

(* ****** ****** *)

implement
instr_trywith
  (loc, tmp, _try, _with) = let
in
  instr_make_node (loc, INStrywith (tmp, _try, _with))
end // end of [instr_trywith]

(* ****** ****** *)

implement
instr_move_list_nil
  (loc, tmp) =
  instr_make_node (loc, INSmove_list_nil (tmp))
// end of [instr_move_list_nil]
implement
instr_pmove_list_nil
  (loc, tmp) =
  instr_make_node (loc, INSpmove_list_nil (tmp))
// end of [instr_pmove_list_nil]
implement
instr_pmove_list_cons
  (loc, tmp, hse_elt) =
  instr_make_node (loc, INSpmove_list_cons (tmp, hse_elt))
// end of [instr_pmove_list_cons]

(* ****** ****** *)

implement
instr_move_list_phead
  (loc, tmphd, tmptl, hse_elt) =
  instr_make_node
  (loc, INSmove_list_phead (tmphd, tmptl, hse_elt))
// end of [instr_move_list_phead]

implement
instr_move_list_ptail
  (loc, tl_new, tl_old, hse_elt) =
  instr_make_node
  (loc, INSmove_list_ptail (tl_new, tl_old, hse_elt))
// end of [instr_move_list_ptail]

(* ****** ****** *)

implement
instr_move_arrpsz_ptr
  (loc, tmp, psz) =
  instr_make_node
  (loc, INSmove_arrpsz_ptr (tmp, psz))
// end of [instr_move_arrpsz_ptr]

(* ****** ****** *)

implement
instr_store_arrpsz_asz
  (loc, tmp, asz) =
  instr_make_node
  (loc, INSstore_arrpsz_asz (tmp, asz))
// end of [instr_store_arrpsz_asz]

implement
instr_store_arrpsz_ptr
  (loc, tmp, hse_elt, asz) =
  instr_make_node
  (loc, INSstore_arrpsz_ptr (tmp, hse_elt, asz))
// end of [instr_store_arrpsz_ptr]

(* ****** ****** *)

implement
instr_update_ptrinc
  (loc, tmpelt, hse_elt) =
  instr_make_node (loc, INSupdate_ptrinc (tmpelt, hse_elt))
// end of [instr_update_ptrinc]

implement
instr_update_ptrdec
  (loc, tmpelt, hse_elt) =
  instr_make_node (loc, INSupdate_ptrdec (tmpelt, hse_elt))
// end of [instr_update_ptrdec]

(* ****** ****** *)
//
implement
instr_closure_initize
  (loc, tmpret, flab) =
  instr_make_node
  (loc, INSclosure_initize (tmpret, flab))
//
(* ****** ****** *)

implement
instr_tmpdec
  (loc, tmp) =
  instr_make_node(loc, INStmpdec (tmp))
// end of [instr_tmpdec]

(* ****** ****** *)

implement
instr_extvar
  (loc, xnm, pmv) =
  instr_make_node(loc, INSextvar(xnm, pmv))
// end of [instr_extvar]

(* ****** ****** *)

implement
instr_dcstdef
  (loc, d2c, pmv) =
  instr_make_node(loc, INSdcstdef(d2c, pmv))
// end of [instr_dcstdef]

(* ****** ****** *)

implement
instr_tempenver
  (loc, d2vs) =
  instr_make_node(loc, INStempenver( d2vs ))
// end of [instr_dcstdef]

(* ****** ****** *)

(* end of [pats_ccomp.dats] *)
