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
// Start Time: November, 2012
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

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

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

datavtype impenv =
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
| IMPENVcons
  (
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
(*
val () = println! ("impenv_update: s2v = ", s2v)
val () = println! ("impenv_update: s2f = ", s2f)
*)
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
fun impenv_make_nil (): impenv
extern
fun impenv_make_svarlst (s2vs: s2varlst): impenv

(* ****** ****** *)

implement
impenv_make_nil () = IMPENVnil

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

fun auxmat
(
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
(*
val () = println! ("auxmat: s2e_pat(aft) = ", s2e_pat)
val () = println! ("auxmat: s2e_arg(aft) = ", s2e_arg)
*)
//
in
//
case+ s2en_pat of
| S2Evar (s2v) => let
    val s2f = impenv_find (env, s2v)
  in
    if s2hnf_is_err (s2f) then
    (
      impenv_update (env, s2v, s2f_arg)
    ) else (
      s2hnf_syneq (s2f, s2f_arg)
    ) // end of [if]
  end // end of [S2Evar]
//
| S2Ecst (s2c) => let
  in
    case+ s2en_arg of
    | S2Ecst (s2c_arg) =>
        if s2c = s2c_arg then true else false
      // end of [S2Ecst]
    | _ => false
  end // end of [S2Ecst]
//
| S2Eapp (
    s2e_pat, s2es_pat
  ) => let
  in
    case+ s2en_arg of
    | S2Eapp
      (
        s2e_arg, s2es_arg
      ) => let
        val ans = auxmat (env, s2e_pat, s2e_arg)
      in
        if ans then
          auxmatlst (env, s2es_pat, s2es_arg) else false
        // end of [if]
      end // end of [S2Eapp]
    | _ => false
  end // end of [S2Eapp]
//
| S2Etyrec (
    knd, npf, ls2es_pat
  ) => let
  in
    case+ s2en_arg of
    | S2Etyrec
      (
        knd2, npf2, ls2es_arg
      ) => (
        if knd = knd2 then
          auxlabmatlst (env, ls2es_pat, ls2es_arg) else false
        // end of [if]
      ) // end of [S2Etyrec]
    | _ => false
  end // end of [S2Etyrec]
//
| _ when s2hnf_syneq (s2f_pat, s2f_arg) => true
//
| _ => false
//
end // end of [auxmat]

and auxmatlst
(
  env: !impenv
, s2es_pat: s2explst
, s2es_arg: s2explst
) : bool = let
//
(*
val () = println! ("auxmatlst: s2es_pat = ", s2es_pat)
val () = println! ("auxmatlst: s2es_arg = ", s2es_arg)
*)
//
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
         val ans = auxmat (env, s2e_pat, s2e_arg)
       in
         if ans then auxmatlst (env, s2es_pat, s2es_arg) else false
       end // end of [list_cons]
     | list_nil () => true // HX: deadcode
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [auxmatlst]

and auxlabmatlst
(
  env: !impenv
, ls2es_pat: labs2explst
, ls2es_arg: labs2explst
) : bool = let
(*
val out = stdout_ref
val () = fprintln! (out, "auxlabmatlst: ls2es_pat = ", ls2es_pat)
val () = fprintln! (out, "auxlabmatlst: ls2es_arg = ", ls2es_arg)
*)
in
//
case+ ls2es_pat of
| list_cons _ => (
  case+ ls2es_arg of
  | list_cons _ => let
      val+list_cons (lx1, ls2es_pat) = ls2es_pat
      val+list_cons (lx2, ls2es_arg) = ls2es_arg
      val+SLABELED (l1, _, x1) = lx1 and SLABELED (l2, _, x2) = lx2
      val ans = (
        if l1 = l2 then auxmat (env, x1, x2) else false
      ) : bool // end of [val]
    in
      if ans then auxlabmatlst (env, ls2es_pat, ls2es_arg) else false
    end // end of [list_cons]
  | list_nil () => false
  )
| list_nil () => (
  case+ ls2es_arg of
  | list_cons _ => false | list_nil () => true
  ) // end of [list_nil]
//
end // end of [auxlabmatlst]

fun auxmatlstlst
(
  env: !impenv, s2ess: s2explstlst, t2mas: t2mpmarglst
) : bool = let
in
//
case+ s2ess of
| list_cons
    (s2es, s2ess) => (
    case+ t2mas of
    | list_cons
        (t2ma, t2mas) => let
        val ans =
          auxmatlst (env, s2es, t2ma.t2mpmarg_arg)
        // end of [val]
      in
        if ans then auxmatlstlst (env, s2ess, t2mas) else false
      end // end of [list_cons]
    | list_nil ((*void*)) => true // HX: deadcode
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [auxmatlstlst]

(* ****** ****** *)

fun auxbndlstlst
(
  s2vs: s2varlst, t2mas: t2mpmarglst
) : tmpsub = let
in
//
case+ t2mas of
| list_cons
    (t2ma, t2mas) => auxbndlstlst2 (s2vs, t2ma.t2mpmarg_arg, t2mas)
| list_nil () => TMPSUBnil ()
//
end // end of [auxbndlstlst]

and auxbndlstlst2
(
  s2vs: s2varlst, s2es: s2explst, t2mas: t2mpmarglst
) : tmpsub = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val s2e = s2exp_hnfize (s2e)
    val-list_cons (s2v, s2vs) = s2vs
    val tsub = auxbndlstlst2 (s2vs, s2es, t2mas)
  in
    TMPSUBcons (s2v, s2e, tsub)
  end // end of [list_cons]
| list_nil () => auxbndlstlst (s2vs, t2mas)
//
end // end of [auxbndlstlst2]

in (* in of [local] *)

implement
funlab_tmpcst_match
  (fl0, d2c0, t2mas) = let
//
val env = impenv_make_nil ()
val xs = funlab_get_tmparg (fl0)
val s2ess = list_map_fun<t2mpmarg><s2explst> (xs, lam x =<1> x.t2mpmarg_arg)
val ans = auxmatlstlst (env, $UN.linlst2lst(s2ess), t2mas)
val () = list_vt_free (s2ess)
val ((*env*)) = impenv_free (env)
//
in
  ans
end // end of [funlab_tmpcst_match]

(* ****** ****** *)

implement
hiimpdec_tmpcst_match
  (imp, d2c0, t2mas) = let
//
val d2c1 = imp.hiimpdec_cst
//
(*
val () = println! ("hiimpdec_tmpcst_match: d2c0 = ", d2c0)
val () = println! ("hiimpdec_tmpcst_match: d2c1 = ", d2c1)
*)
//
in
//
if d2c0 = d2c1 then let
  val env = impenv_make_svarlst (imp.hiimpdec_imparg)
  val ans = auxmatlstlst (env, imp.hiimpdec_tmparg, t2mas)
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
hiimpdeclst_tmpcst_match
  (imps, d2c0, t2mas) = let
//
(*
val () =
println! ("hiimpdeclst_tmpcst_match: d2c0 = ", d2c0)
*)
//
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

implement
hiimpdec2_tmpcst_match
  (imp2, d2c0, t2mas) = let
//
val HIIMPDEC2
  (imp, tsub0, tmparg) = imp2
val d2c1 = imp.hiimpdec_cst
val imparg = imp.hiimpdec_imparg
//
(*
val () = println! ("hiimpdec_tmpcst_match2: d2c0 = ", d2c0)
val () = println! ("hiimpdec_tmpcst_match2: d2c1 = ", d2c1)
*)
//
in
//
if d2c0 = d2c1 then let
  val env = impenv_make_svarlst (imparg)
  val ans = auxmatlstlst (env, tmparg, t2mas)
in
  if ans then let
    val tsub1 =
      impenv2tmpsub (env)
    val tsub01 =
      tmpsub_append (tsub0, tsub1)
    // end of [val]
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
val-TMPCSTMATsome2 (d2c, s2ess, flab) = mat
//
val () =
  if d2c = d2c0 then let
  val env = IMPENVnil ()
  val () = ans := auxmatlstlst (env, s2ess, t2mas)
  val () = impenv_free (env)
//
in
  // nothing
end //end of [val]
//
in
  if ans then mat else TMPCSTMATnone
end // end of [tmpcstmat_tmpcst_match]

(* ****** ****** *)

implement
hifundec2tmpvarmat
  (hfd, t2mas) = let
  val s2vs = hfd.hifundec_imparg
  val tsub = auxbndlstlst (s2vs, t2mas)
in
  TMPVARMATsome (hfd, tsub)
end // end of [hifundec2tmpvarmat]

implement
hifundecopt2tmpvarmat
  (hfdopt, t2mas) = let
in
//
case hfdopt of
| ~Some_vt (hfd) =>
    hifundec2tmpvarmat (hfd, t2mas)
| ~None_vt ((*void*)) => TMPVARMATnone ()
//
end // end of [hifundecopt2tmpvarmat]

implement
hifundec_tmpvar_match
  (hfd, d2v0, t2mas) = let
//
val d2v = hfd.hifundec_var
//
in
//
if d2v = d2v0 then
  hifundec2tmpvarmat (hfd, t2mas) else TMPVARMATnone ()
//
end // end of [hifundec_tmpvar_match]

implement
tmpvarmat_tmpvar_match
  (mat, d2v0, t2mas) = let
//
var ans: bool = false
//
val-TMPVARMATsome2 (d2v, s2ess, flab) = mat
//
val () =
  if d2v = d2v0 then let
  val env = IMPENVnil ()
  val () = ans := auxmatlstlst (env, s2ess, t2mas)
  val () = impenv_free (env)
//
in
  // nothing
end //end of [val]
//
in
  if ans then mat else TMPVARMATnone
end // end of [tmpvarmat_tmpvar_match]

end // end of [local]

(* ****** ****** *)
//
extern
fun ccomp_funlab_tmpsubst
  (env: !ccompenv, loc0: location, hse0: hisexp, fl: funlab, tsub: tmpsub): primval
extern
fun ccomp_funlab_tmpsubst_none
  (env: !ccompenv, loc0: location, hse0: hisexp, fl: funlab, tsub: tmpsub): primval
extern
fun ccomp_funlab_tmpsubst_some
(
  env: !ccompenv, loc0: location, hse0: hisexp, fl: funlab, tsub: tmpsub, fent: funent
) : primval // end of [ccomp_funlab_tmpsubst_some]
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
    val-Some(d2c) = funlab_get_d2copt (flab)
    val t2mas = t2mpmarglst_tsubst (loc0, tsub, t2mas)
    val tmpmat = ccompenv_tmpcst_match (env, d2c, t2mas)
  in
    ccomp_tmpcstmat (env, loc0, hse0, d2c, t2mas, tmpmat)
  end (* end of [list_cons] *)
| list_nil () => primval_make2_funlab (loc0, hse0, flab)
//
end // end of [ccomp_funlab_tmpsubst_none]

implement
ccomp_funlab_tmpsubst_some
  (env, loc0, hse0, flab, tsub, fent) = let
//
(*
val out = stdout_ref
val () =
  fprintln!
(
  out, "ccomp_funlab_tmpsubst_some: tsub = ", tsub
) // end of [val]
*)
//
val sub = tmpsub2stasub (tsub)
//
val sfx = funlab_incget_ncopy (flab)
//
val flab2 = funlab_subst (sub, flab)
val () = funlab_set_suffix (flab2, sfx)
val () = the_funlablst_add (flab2)
//
val () = ccompenv_add_flabsetenv (env, flab2)
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
  primval_make2_funlab (loc0, hse0, flab2)
end // end of [ccomp_funlab_tmpsubst_some]

(* ****** ****** *)

extern
fun ccomp_tmpcstmat_some
(
  env: !ccompenv
, loc0: location, hse0: hisexp, d2c: d2cst, t2mas: t2mpmarglst, mat: tmpcstmat
) : primval // end of [ccomp_tmpcstmat_some]

(* ****** ****** *)

implement
ccomp_tmpcstmat
  (env, loc0, hse0, d2c, t2mas, mat) = let
//
(*
val () =
(
  print ("ccomp_tmpcstmat: d2c = ");
  print_d2cst (d2c); print_newline ();
  print ("ccomp_tmpcstmat: t2mas = ");
  fpprint_t2mpmarglst (stdout_ref, t2mas);
  print_newline ();
  print ("ccomp_tmpcstmat: mat = ");
  fprint_tmpcstmat (stdout_ref, mat); print_newline ();
) // end of [val]
*)
//
in
//
case+ mat of
| TMPCSTMATsome _ =>
    ccomp_tmpcstmat_some (env, loc0, hse0, d2c, t2mas, mat)
  // end of [TMPCSTMATsome]
| TMPCSTMATsome2
    (d2c, s2ess, flab) => primval_make2_funlab (loc0, hse0, flab)
| TMPCSTMATnone
    () => primval_tmpltcstmat (loc0, hse0, d2c, t2mas, mat)
  // end of [TMPCSTMATnone]
//
end // end of [ccomp_tmpcstmat]

implement
ccomp_tmpcstmat_some
  (env, loc0, hse0, d2c, t2mas, mat) = let
//
val-TMPCSTMATsome (imp, tsub) = mat
//
val lvl0 = the_d2varlev_save ()
val () = hiimpdec_ccomp_if (env, 0(*level*), imp)
val () = the_d2varlev_restore (lvl0)
//
val-Some (flab) = hiimpdec_get_funlabopt (imp)
//
in
  ccomp_funlab_tmpsubst (env, loc0, hse0, flab, tsub)
end // end of [ccomp_tmpcstmat_some]

(* ****** ****** *)

extern
fun ccomp_tmpvarmat_some
(
  env: !ccompenv
, loc0: location, hse0: hisexp, d2v: d2var, t2mas: t2mpmarglst, mat: tmpvarmat
) : primval // end of [ccomp_tmpvarmat_some]

(* ****** ****** *)

implement
ccomp_tmpvarmat
  (env, loc0, hse0, d2v, t2mas, mat) = let
//
(*
val () =
(
  print ("ccomp_tmpvarmat: d2v = ");
  print_d2var (d2v); print_newline ();
  print ("ccomp_tmpvarmat: t2mas = ");
  fpprint_t2mpmarglst (stdout_ref, t2mas);
  print_newline ();
  print ("ccomp_tmpvarmat: mat = ");
  fprint_tmpvarmat (stdout_ref, mat); print_newline ();
) // end of [val]
*)
//
in
//
case+ mat of
| TMPVARMATsome _ =>
    ccomp_tmpvarmat_some (env, loc0, hse0, d2v, t2mas, mat)
  // end of [TMPVARMATsome]
| TMPVARMATsome2
    (d2c, s2ess, flab) => primval_make2_funlab (loc0, hse0, flab)
| TMPVARMATnone
    () => primval_tmpltvarmat (loc0, hse0, d2v, t2mas, mat)
  // end of [TMPVARMATnone]
//
end // end of [ccomp_tmpvarmat]

implement
ccomp_tmpvarmat_some
  (env, loc0, hse0, d2v, t2mas, mat) = let
//
val-TMPVARMATsome (hfd, tsub) = mat
val opt = hifundec_get_funlabopt (hfd)
val () =
(
case+ opt of
| None _ => let
    val-Some
      (hdc0) = hifundec_get_hideclopt (hfd)
    val-HIDfundecs
      (knd, decarg, hfds) = hdc0.hidecl_node
  in
    hifundeclst_ccomp (env, 0(*lvl0*), knd, decarg, hfds)
  end // end of [None]
| Some _ => ()
)
val-Some(flab) = hifundec_get_funlabopt (hfd)
//
in
  ccomp_funlab_tmpsubst (env, loc0, hse0, flab, tsub)
end // end of [ccomp_tmpvarmat_some]

(* ****** ****** *)

(* end of [pats_ccomp_template.dats] *)
