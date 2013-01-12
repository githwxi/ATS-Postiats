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
// Start Time: November, 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

dataviewtype impenv =
  | IMPENVcons of (s2var, s2hnf, impenv) | IMPENVnil of ()
// end of [impenv]

extern
fun fprint_impenv : fprint_vtype (impenv)

extern
fun impenv_find (env: !impenv, s2v: s2var): s2hnf
extern
fun impenv_update
  (env: !impenv, s2v: s2var, s2f: s2hnf): bool(*updated*)
// end of [impenv_update]

(* ****** ****** *)

implement
fprint_impenv
  (out, env) = let
//
fun loop (
  out: FILEref, env: !impenv, i: int
) : void = let
in
//
case+ env of
| IMPENVcons (
    s2v, s2f, !p_env
  ) => let
    val () =
      if i > 0 then
        fprint_string (out, "; ")
      // end of [if]
    val () = fprint_s2var (out, s2v)
    val () = fprint_string (out, " -> ")
    val () = fprint_s2hnf (out, s2f)
    val () = loop (out, !p_env, i+1)
    prval () = fold@ (env)
  in
    // nothing
  end // end of [IMPENVcons]
| IMPENVnil () => let
    prval () = fold@ (env) in (*nothing*)
  end // end of [IMPENVnil]
//
end // end of [loop]
//
in
  loop (out, env, 0)
end // end of [fprint_impenv]

(* ****** ****** *)

implement
impenv_find
  (env, s2v) = let
in
//
case+ env of
| IMPENVcons (
    s2v1, s2f, !p_env
  ) => (
    if s2v = s2v1 then let
      prval () = fold@ (env)
    in
      s2f
    end else let
      val s2f =
        impenv_find (!p_env, s2v)
      // end of [val]
      prval () = fold@ (env)
    in
      s2f
    end // end of [if]
  ) // end of [IMPENVcons]
| IMPENVnil () => let
    prval () = fold@ (env)
    val s2t = s2var_get_srt (s2v)
    val s2e = s2exp_err (s2t)
  in
    s2exp2hnf_cast (s2e)
  end // end of [IMPENVnil]
//
end // end of [impenv_find]

(* ****** ****** *)

implement
impenv_update
  (env, s2v, s2f) = let
in
//
case+ env of
| IMPENVcons (
    s2v1, !p_s2f, !p_env
  ) => (
    if s2v = s2v1 then let
      val () = !p_s2f := s2f
      prval () = fold@ (env)
    in
      true
    end else let
      val ans =
        impenv_update (!p_env, s2v, s2f)
      // end of [val]
      prval () = fold@ (env)
    in
      ans
    end // end of [if]
  ) // end of [IMPENVcons]
| IMPENVnil () => let
    prval () = fold@ (env) in false
  end // end of [IMPENVnil]
//
end // end of [impenv_update]

(* ****** ****** *)

extern
fun s2hnf_is_err (s2f: s2hnf): bool
implement
s2hnf_is_err
  (s2f) = let
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2e.s2exp_node of S2Eerr () => true | _ => false
//
end // end of [s2hnf_is_err]

(* ****** ****** *)

extern
fun impenv_make_svarlst
  (s2vs: s2varlst): impenv
implement
impenv_make_svarlst (s2vs) = let
in
//
case+ s2vs of
| list_cons
    (s2v, s2vs) => let
    val s2t =
      s2var_get_srt (s2v)
    // end of [val]
    val s2e = s2exp_err (s2t)
    val s2f = s2exp2hnf_cast (s2e)
    val env = impenv_make_svarlst (s2vs)
  in
    IMPENVcons (s2v, s2f, env)
  end // end of [list_cons]
| list_nil () => IMPENVnil ()
//
end // end of [impenv_make_svarlst]

(* ****** ****** *)

extern
fun impenv_free (env: impenv): void
implement
impenv_free (env) = let
in
//
case+ env of
| ~IMPENVcons (_, _, env) => impenv_free (env) | ~IMPENVnil () => ()
//
end // end of [impenv_free]

(* ****** ****** *)

extern
fun impenv2tmpsub (env: impenv): tmpsub
implement
impenv2tmpsub
  (env) = let
//
fun aux (
  env: impenv, tsub: tmpsub
) : tmpsub = let
in
//
case+ env of
| ~IMPENVcons
    (s2v, s2f, env) => let
    val s2e = s2hnf2exp (s2f)
  in
    TMPSUBcons (s2v, s2e, aux (env, tsub))
  end // end of [IMPENVcons]
| ~IMPENVnil () => tsub
//
end // end of [aux]
//
in
  aux (env, TMPSUBnil ())
end // end of [impenv2stasub]

(* ****** ****** *)

local

fun aux (
  env: !impenv
, s2e_pat: s2exp
, s2e_arg: s2exp
) : bool = let
//
val s2f_pat = s2exp2hnf (s2e_pat)
val s2f_arg = s2exp2hnf (s2e_arg)
val s2e_pat = s2hnf2exp (s2f_pat)
val s2e_arg = s2hnf2exp (s2f_arg)
val s2en_pat = s2e_pat.s2exp_node
val s2en_arg = s2e_arg.s2exp_node
//
in
//
case+ s2en_pat of
| S2Evar (s2v) => let
    val s2f = impenv_find (env, s2v)
  in
    if s2hnf_is_err (s2f) then (
      impenv_update (env, s2v, s2f_arg)
    ) else (
      s2hnf_syneq (s2f, s2f_arg)
    ) // end of [if]
  end // end of [S2Evar]
//
| S2Ecst (s2c_pat) => let
  in
    case+ s2en_arg of
    | S2Ecst (s2c_arg) =>
        if s2c_pat = s2c_arg then true else false
      // end of [S2Ecst]
    | _ => false
  end // end of [S2Ecst]
//
| S2Eapp (
    s2e_pat, s2es_pat
  ) => let
  in
    case+ s2en_arg of
    | S2Eapp (s2e_arg, s2es_arg) => let
        val ans = aux (env, s2e_pat, s2e_arg)
      in
        if ans then auxlst (env, s2es_pat, s2es_arg) else false
      end // end of [S2Eapp]
    | _ => false
  end // end of [S2Eapp]
//
| _ when s2hnf_syneq (s2f_pat, s2f_arg) => true
//
| _ => false
//
end // end of [aux]

and auxlst (
  env: !impenv
, s2es_pat: s2explst
, s2es_arg: s2explst
) : bool = let
in
//
case+ s2es_pat of
| list_cons (
    s2e_pat, s2es_pat
  ) => (
    case+ s2es_arg of
    | list_cons (
        s2e_arg, s2es_arg
      ) => let
         val ans = aux (env, s2e_pat, s2e_arg)
       in
         if ans then auxlst (env, s2es_pat, s2es_arg) else false
       end // end of [list_cons]
     | list_nil () => true // HX: deadcode
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [auxlst]

fun auxlstlst (
  env: !impenv, s2ess: s2explstlst, t2mas: t2mpmarglst
) : bool = let
in
//
case+ s2ess of
| list_cons
    (s2es, s2ess) => (
    case+ t2mas of
    | list_cons (t2ma, t2mas) => let
        val ans =
          auxlst (env, s2es, t2ma.t2mpmarg_arg)
        // end of [val]
      in
        if ans then auxlstlst (env, s2ess, t2mas) else false
      end // end of [list_cons]
    | list_nil () => true // HX: deadcode
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [auxlstlst]

in // in of [local]

implement
hiimpdec_tmpcst_match
  (imp, d2c0, t2mas) = let
//
val d2c = imp.hiimpdec_cst
//
in
//
if d2c = d2c0 then let
  val env =
    impenv_make_svarlst (imp.hiimpdec_imparg)
  // end of [val]
  val ans = auxlstlst (env, imp.hiimpdec_tmparg, t2mas)
in
  if ans then let
    val tsub =
      impenv2tmpsub (env)
    // end of [val]
  in
    TMPCSTMATsome (imp, tsub)
  end else let
    val () = impenv_free (env) in TMPCSTMATnone ()
  end // end of [if]
end else
  TMPCSTMATnone ()
// end of [if]
//
end // end of [hiimpdec_tmpcst_match]

implement
hiimpdec2_tmpcst_match
  (imp2, d2c0, t2mas) = let
//
val HIIMPDEC2
  (imp, tsub0, tmparg) = imp2
val d2c = imp.hiimpdec_cst
val imparg = imp.hiimpdec_imparg
//
in
//
if d2c = d2c0 then let
  val env = impenv_make_svarlst (imparg)
  val ans = auxlstlst (env, tmparg, t2mas)
in
  if ans then let
    val tsub1 =
      impenv2tmpsub (env)
    val tsub01 =
      tmpsub_append (tsub0, tsub1)
  in
    TMPCSTMATsome (imp, tsub01)
  end else let
    val () = impenv_free (env) in TMPCSTMATnone ()
  end // end of [if]
end else
  TMPCSTMATnone ()
// end of [if]
//
end // end of [hiimpdec2_tmpcst_match]

implement
tmpcstmat_tmpcst_match
  (mat, d2c0, t2mas) = let
//
var ans: bool = false
//
val- TMPCSTMATsome2 (d2c, s2ess, flab) = mat
//
val () =
  if d2c = d2c0 then let
  val env = IMPENVnil ()
  val () = ans := auxlstlst (env, s2ess, t2mas)
  val () = impenv_free (env)
//
in
  // nothing
end //end of [val]
//
in
  if ans then mat else TMPCSTMATnone
end // end of [tmpcstmat_tmpcst_match]

end // end of [local]

(* ****** ****** *)

implement
hiimpdeclst_tmpcst_match
  (imps, d2c0, t2mas) = let
in
//
case+ imps of
| list_cons (
    imp, imps
  ) => let
    val opt = hiimpdec_tmpcst_match (imp, d2c0, t2mas)
  in
    case+ opt of
    | TMPCSTMATsome _ => opt
    | TMPCSTMATsome2 _ => opt
    | TMPCSTMATnone _ => hiimpdeclst_tmpcst_match (imps, d2c0, t2mas)
  end // end of [list_cons]
| list_nil () => TMPCSTMATnone ()
//
end // end of [hiimpdeclst_tmpcst_match]

(* ****** ****** *)
//
extern
fun ccomp_funlab_tmpsubst
  (env: !ccompenv, loc0: location, hse0: hisexp, fl: funlab, tsub: tmpsub): primval
extern
fun ccomp_funlab_tmpsubst_none
  (env: !ccompenv, loc0: location, hse0: hisexp, fl: funlab, tsub: tmpsub): primval
extern
fun ccomp_funlab_tmpsubst_some (
  env: !ccompenv, loc0: location, hse0: hisexp, fl: funlab, tsub: tmpsub, fent: funent
) : primval // end of [ccomp_funlab_tmpsubst_some]
//
extern
fun ccomp_tmpcstmat_some (
  env: !ccompenv, loc0: location, hse0: hisexp, d2c: d2cst, t2mas: t2mpmarglst, mat: tmpcstmat
) : primval // end of [ccomp_tmpcstmat_some]
//
(* ****** ****** *)

implement
ccomp_funlab_tmpsubst
  (env, loc0, hse0, flab, tsub) = let
//
val opt = funlab_get_funent (flab)
//
in
//
case+ opt of
| None () =>
    ccomp_funlab_tmpsubst_none (env, loc0, hse0, flab, tsub)
  // end of [None]
| Some (fent) =>
    ccomp_funlab_tmpsubst_some (env, loc0, hse0, flab, tsub, fent)
  // end of [None]
//
end // end of [ccomp_funlab_tmpsubst]

implement
ccomp_funlab_tmpsubst_none
  (env, loc0, hse0, flab, tsub) = let
//
val t2mas = funlab_get_tmparg (flab)
//
in
//
case+ t2mas of
| list_cons _ => let
    val- Some (d2c) = funlab_get_d2copt (flab)
    val t2mas = t2mpmarglst_tsubst (loc0, tsub, t2mas)
    val tmpmat = ccompenv_tmpcst_match (env, d2c, t2mas)
  in
    ccomp_tmpcstmat (env, loc0, hse0, d2c, t2mas, tmpmat)
  end // end of [list_cons]
| list_nil () => primval_funlab (loc0, hse0, flab)
//
end // end of [ccomp_funlab_tmpsubst_none]

implement
ccomp_funlab_tmpsubst_some
  (env, loc0, hse0, flab, tsub, fent) = let
//
val () = (
  println! ("ccomp_funlab_tmpsubst_some: tsub = ");
  fprint_tmpsub (stdout_ref, tsub); print_newline ()
) // end of [val]
//
val sub = tmpsub2stasub (tsub)
//
val sfx = funlab_incget_ncopy (flab)
//
val flab2 = funlab_subst (sub, flab)
val () = funlab_set_suffix (flab2, sfx)
val () = the_funlablst_add (flab2)
//
val (
  pfpush | ()
) = ccompenv_push (env)
val () = ccompenv_add_tmpsub (env, tsub)
val () = ccompenv_inc_tmprecdepth (env)
val fent2 = funent_subst (env, sub, flab2, fent, sfx)
val () = ccompenv_dec_tmprecdepth (env)
val (
) = ccompenv_pop (pfpush | env)
//
val () = funent_set_tmpsub (fent2, Some (tsub))
//
val () = funlab_set_funent (flab2, Some (fent2))
//
val () = stasub_free (sub)
//
in
  primval_funlab (loc0, hse0, flab2)
end // end of [ccomp_funlab_tmpsubst_some]

(* ****** ****** *)

implement
ccomp_tmpcstmat
  (env, loc0, hse0, d2c, t2mas, mat) = let
//
val () = (
  print ("ccomp_tmpcstmat: d2c = ");
  print_d2cst (d2c); print_newline ();
  print ("ccomp_tmpcstmat: t2mas = ");
  fpprint_t2mpmarglst (stdout_ref, t2mas); print_newline ();
  print ("ccomp_tmpcstmat: mat = ");
  fprint_tmpcstmat (stdout_ref, mat); print_newline ();
) // end of [val]
//
in
//
case+ mat of
| TMPCSTMATsome _ =>
    ccomp_tmpcstmat_some (env, loc0, hse0, d2c, t2mas, mat)
  // end of [TMPCSTMATsome]
| TMPCSTMATsome2
    (d2c, s2ess, flab) => primval_funlab (loc0, hse0, flab)
| TMPCSTMATnone
    () => primval_tmpltcstmat (loc0, hse0, d2c, t2mas, mat)
  // end of [TMPCSTMATnone]
//
end // end of [ccomp_tmpltcstmat]

(* ****** ****** *)

implement
ccomp_tmpcstmat_some
  (env, loc0, hse0, d2c, t2mas, mat) = let
//
val- TMPCSTMATsome (imp, tsub) = mat
val l0 = the_d2varlev_get ()
val () = hiimpdec_ccomp_if (env, l0, imp)
val- Some (flab) = hiimpdec_get_funlabopt (imp)
//
in
  ccomp_funlab_tmpsubst (env, loc0, hse0, flab, tsub)
end // end of [ccomp_tmpcstmat_some]

(* ****** ****** *)

(* end of [pats_ccomp_template.dats] *)
