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
// Start Time: June, 2011
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

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_impdec"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"

macdef
prerr_dqid (dq, id) =
  ($SYN.prerr_d0ynq ,(dq); $SYM.prerr_symbol ,(id))
// end of [prerr_dqid]

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

#define :: list_cons
#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

fun
i1mpdec_select_d2cst
(
  d1c0: d1ecl, impdec: i1mpdec
) : Option_vt (d2cst) = let
//
fn auxerr1 (
  d1c: i1mpdec
) :<cloref1> void = let
  val qid = d1c.i1mpdec_qid
  val dq = qid.impqi0de_qua and id = qid.impqi0de_sym
  val () = prerr_error2_loc (d1c.i1mpdec_loc)
  val () = prerr ": there is no suitable dynamic constant declared for ["
  val () = prerr_dqid (dq, id)
  val () = prerr "]."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
end // end of [auxerr1]
fn auxerr2 (
  d1c: i1mpdec
) :<cloref1> void = let
  val qid = d1c.i1mpdec_qid
  val dq = qid.impqi0de_qua and id = qid.impqi0de_sym
  val () = prerr_error2_loc (d1c.i1mpdec_loc)
  val () = prerr ": the identifier ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] does not refer to a declared dynamic constant."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
end // end of [auxerr2]
fn auxerr3 (
  d1c: i1mpdec
) :<cloref1> void = let
  val qid = d1c.i1mpdec_qid
  val dq = qid.impqi0de_qua and id = qid.impqi0de_sym
  val () = prerr_error2_loc (d1c.i1mpdec_loc)
  val () = prerr ": the identifier ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
end // end of [auxerr3]
//
val qid = impdec.i1mpdec_qid
val dq = qid.impqi0de_qua and id = qid.impqi0de_sym
val def = impdec.i1mpdec_def
//
fun aux1 (
  d2pis: d2pitmlst
) :<cloref1> List_vt (d2cst) =
  case+ d2pis of
  | list_cons (d2pi, d2pis) => let
      val D2PITM (_(*pval*), d2i) = d2pi
    in
      case+ d2i of
      | D2ITMcst (d2c) => let
          val d2cs = aux1 (d2pis)
          val ismat = d2cst_match_def (d2c, def)
        in
          if ismat then list_vt_cons (d2c, d2cs) else d2cs
        end (* end of [D2ITMcst] *)
      | _ => aux1 (d2pis)
    end // end of [list_cons]
  | list_nil () => list_vt_nil ()
(* end of [aux1] *)
//
fun aux2 (
  d2cs: List_vt (d2cst)
) :<cloref1> Option_vt (d2cst) =
  case+ d2cs of
  | ~list_vt_cons (d2c, d2cs) => let
      val () = list_vt_free (d2cs) in Some_vt (d2c)
    end (* end of [list_vt_cons] *)
  | ~list_vt_nil () => let
      val () = auxerr1 (impdec) in None_vt () // HX: error is reported
    end (* end of [list_vt_nil] *)
(* end of [aux2] *)
//
val ans = the_d2expenv_find_qua (dq, id)
//
in
//
case+ ans of
| ~Some_vt (d2i) => (
  case+ d2i of
  | D2ITMcst (d2c) => Some_vt (d2c)
  | D2ITMsymdef (sym, d2pis) => let
      val d2cs = aux1 (d2pis) in aux2 (d2cs)
    end // end of [D2ITMsymdef]
  | _ => let
      val () = auxerr2 (impdec) in None_vt () // HX: error is reported
    end (* end of [_] *)
  ) // end of [Some_vt]
| ~None_vt () => let
    val () = auxerr3 (impdec) in None_vt () // HX: error is reported
  end (* end of [None_vt] *)
//
end // end of [i1mpdec_select_d2cst]

(* ****** ****** *)

fun
d1exp_tr_ann (
  d1e0: d1exp, s2e0: s2exp
) : d2exp = let
//
val loc0 = d1e0.d1exp_loc
val s2f0 = s2exp2hnf (s2e0)
val s2e0 = s2hnf2exp (s2f0)
//
(*
val () = (
  print "d1exp_tr_ann: d1e0 = "; print_d1exp (d1e0); print_newline ();
  print "d1exp_tr_ann: s2f0 = "; print_s2exp (s2e0); print_newline ();
) // end of [val]
*)
//
fn auxerr (
  d1e0: d1exp, s2e0: s2exp, locarg: location, serr: int
) : void = let
  val () = prerr_error2_loc (locarg)
  val () = prerr ": static arity mismatch"
  val () = if serr < 0 then prerr ": more arguments are expected."
  val () = if serr > 0 then prerr ": fewer arguments are expected."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1exp_tr_ann (d1e0, s2e0))
end // end of [auxerr]
//
in
//
case+ s2e0.s2exp_node of
| S2Euni (s2vs, s2ps, s2e) => (
  case+ d1e0.d1exp_node of
  | D1Elam_sta_ana (locarg, arg, body) => let
//
      var serr: int = 0
      val (sub, s2vs) =
        s1vararg_bind_svarlst (arg, s2vs, serr)
      val s2vs = list_of_list_vt (s2vs)
      val () = if serr != 0 then auxerr (d1e0, s2e0, locarg, serr)
//
      val (pf_s2expenv | ()) = the_s2expenv_push_nil ()
      val () = the_s2expenv_add_svarlst (s2vs)
      val s2ps = s2explst_subst (sub, s2ps) and s2e = s2exp_subst (sub, s2e)
      val () = stasub_free (sub)
      val body = d1exp_tr_ann (body, s2e)
      val () = the_s2expenv_pop_free (pf_s2expenv | (*none*))
    in
      d2exp_lam_sta (loc0, s2vs, s2ps, body)
    end // end of [D1Elam_sta_ana]
  | _ => let
      val d2e0 = d1exp_tr_ann (d1e0, s2e)
    in
      d2exp_lam_sta (loc0, s2vs, s2ps, d2e0)
    end // end of [_]
  ) // end of [S2Euni]
| S2Efun (
    fc, lin1, s2fe, npf1, s2es_arg, s2e_res
  ) => (
  case+ d1e0.d1exp_node of
  | D1Elam_dyn
    (
      lin2, p1t_arg, d1e_body
    ) => let
      val @(p2ts_arg, d2e_body) = d1exp_tr_arg_body_ann (
        d1e0, fc, lin1, s2fe, npf1, s2es_arg, s2e_res, lin2, p1t_arg, d1e_body
      ) // end of [val]
    in
      d2exp_lam_dyn (loc0, lin1, npf1, p2ts_arg, d2e_body)
    end // end of [D2Elam_dyn]
  | D1Elaminit_dyn
    (
      lin2, p1t_arg, d1e_body
    ) => let
      val @(p2ts_arg, d2e_body) = d1exp_tr_arg_body_ann (
        d1e0, fc, lin1, s2fe, npf1, s2es_arg, s2e_res, lin2, p1t_arg, d1e_body
      ) // end of [val]
    in
      d2exp_laminit_dyn (loc0, lin1, npf1, p2ts_arg, d2e_body)
    end // end of [D2Elam_dyn]
  | _ => let
      val d2e0 = d1exp_tr (d1e0) in d2exp_ann_type (loc0, d2e0, s2e0)
    end (* end of [_] *)
  ) // end of [S2Efun]
| _ => let
    val d2e0 = d1exp_tr d1e0 in d2exp_ann_type (loc0, d2e0, s2e0)
  end (* end of [_] *)
//
end // end of [d1exp_tr_ann]

and
d1exp_tr_arg_body_ann
(
  d1e0: d1exp
, fc: funclo, lin1: int
, s2fe: s2eff, npf1: int
, s2es_arg: s2explst, s2e_res: s2exp
, lin2: int
, p1t_arg: p1at, d1e_body: d1exp
) : @(p2atlst, d2exp) = let
(*
val () = (
  println! ("d1exp_tr_arg_body_ann: p1t_arg = ", p1t_arg);
  println! ("d1exp_tr_arg_body_ann: s2es_arg = ", s2es_arg);
  println! ("d1exp_tr_arg_body_ann: d1e_body = ", d1e_body);
) // end of [val]
*)
val () = let
  fun auxck .<>. (
    d1e0: d1exp, fc: funclo
  ) : void =
    case+ fc of
    | FUNCLOclo (knd) when knd = 0 => let
        val () = prerr_error2_loc (d1e0.d1exp_loc)
        val () = filprerr_ifdebug "d1exp_tr_arg_body_ann"
        val () = prerr ": the function cannot be given an unboxed closure type.";
        val ((*void*)) = prerr_newline ((*void*))
      in
        the_trans2errlst_add (T2E_d1exp_tr (d1e0))
      end // end of [FUNCLOclo]
    | _ => ()
  // end of [auxck]
in
  auxck (d1e0, fc)
end (* end of [val] *)
//
val () = let
  fun auxck .<>. (
    d1e0: d1exp, lin1: int, lin2: int
  ) : void =
    if lin1 != lin2 then let
      val loc0 = d1e0.d1exp_loc
      val () = prerr_error2_loc (loc0)
      val () = filprerr_ifdebug "d1exp_tr_arg_body_ann"
      val () = if lin1 < lin2 then prerr ": linear function is given a nonlinear type."
      val () = if lin1 > lin2 then prerr ": nonlinear function is given a linear type."
      val ((*void*)) = prerr_newline ()
    in
      the_trans2errlst_add (T2E_d1exp_tr (d1e0))
    end // end of [if]
in
  auxck (d1e0, lin1, lin2)
end (* end of [val] *)
//
var wths1es = WTHS1EXPLSTnil ()
val p2t_arg = 
p1at_tr_arg (p1t_arg, wths1es)
//
val () = let
  fun auxck .<>. ( // check for refval types
    d1e0: d1exp, p1t_arg: p1at, wths1es: wths1explst
  ) : void = let
    val isnone = wths1explst_is_none (wths1es)
  in
    if ~isnone then let
      val loc = p1t_arg.p1at_loc
      val () = prerr_error2_loc (loc)
      val () = filprerr_ifdebug "d1exp_tr_arg_body_ann"
      val () = prerr ": the function argument cannot be ascribed refval types."
      val ((*void*)) = prerr_newline ()
    in
      the_trans2errlst_add (T2E_d1exp_tr (d1e0))
    end (* end of [if] *)
  end // end of [auxck]
in
  auxck (d1e0, p1t_arg, wths1es)
end (* end of [val] *)
//
var npf2: int = ~1
val p2ts_arg = (
  case+ p2t_arg.p2at_node of
  | P2Tlist (npf, p2ts) => (npf2 := npf; p2ts)
  | _ => list_sing (p2t_arg)
) : p2atlst // end of [val]
//
val () = let
  fun auxck .<>. (
    d1e0: d1exp, npf1: int, npf2: int
  ) : void =
    if npf1 != npf2 then let // check for pfarity match
      val () = prerr_error2_loc (d1e0.d1exp_loc)
      val () = filprerr_ifdebug "d1exp_tr_arg_body_ann"
      val () = prerr ": proof arity mismatch"
      val () = prerrf (": the expected number of proof arguments is [%i]", @(npf1))
      val () = prerr_newline ()
    in
      the_trans2errlst_add (T2E_d1exp_tr (d1e0))
    end // end of [if]
  // end of [auxck]
in
  auxck (d1e0, npf1, npf2)
end (* end of [val] *)
//
val p2ts_arg = let
//
  fn auxerr (
    d1e0: d1exp, serr: int
  ) : void = let
     val loc0 = d1e0.d1exp_loc
     val () = prerr_error2_loc (loc0)
     val () = filprerr_ifdebug "d1exp_tr_arg_body_ann"
     val () = prerr ": arity mismatch"
     val () = if serr < 0 then prerr ": more arguments are expected."
     val () = if serr > 0 then prerr ": fewer arguments are expected."
     val ((*void*)) = prerr_newline ()
   in
      the_trans2errlst_add (T2E_d1exp_tr (d1e0))
   end // end of [auxerr]
//
  fun aux (
    p2ts: p2atlst, s2es: s2explst, err: &int
  ) : p2atlst =
    case+ (p2ts, s2es) of
    | (p2t :: p2ts, s2e :: s2es) => let
         val s2f = s2exp_hnfize (s2e)
         val p2t = p2at_ann (p2t.p2at_loc, p2t, s2f)
         val p2ts = aux (p2ts, s2es, err)
       in
         list_cons (p2t, p2ts)
       end
    | (list_nil (), list_nil ()) => list_nil ()
    | (list_cons _, list_nil ()) => let
        val () = err := err + 1 in list_nil ()
      end
    | (list_nil (), list_cons _) => let
        val () = err := err - 1 in list_nil ()
      end // end of [nil, cons]
  (* end of [aux] *)
//
  var serr: int = 0
  val p2ts_arg = aux (p2ts_arg, s2es_arg, serr)
  val () = if serr != 0 then auxerr (d1e0, serr)
in
  p2ts_arg
end // end of [val]
//
val (pfenv | ()) = the_trans2_env_push ()
val () = let
  val s2vs = $UT.lstord2list (p2t_arg.p2at_svs)
in
  the_s2expenv_add_svarlst s2vs
end // end of [val]
val () = let
  val d2vs = $UT.lstord2list (p2t_arg.p2at_dvs)
in
  the_d2expenv_add_dvarlst d2vs
end // end of [val]
//
val (pflev | ()) = the_d2varlev_inc ()
//
val () = let
  var err: int = 0
  val () = (case+
    d1e_body.d1exp_node of
    | D1Eann_effc _ => (err := err + 1)
    | D1Eann_funclo _ => (err := err + 1)
    | _ => ()
  ) : void // end of [val]
  fun auxck .<>.
    (d1e0: d1exp, err: int): void =
    if err > 0 then let
      val () = prerr_error2_loc (d1e0.d1exp_loc)
      val () = prerr ": the [funclo/effect] annonation is redundant."
      val () = prerr_newline ()
    in
      the_trans2errlst_add (T2E_d1exp_tr (d1e0))
    end // end of [if]
  // end of [auxck]
in
  auxck (d1e0, err)
end (* end of [val] *)
//
val d2e_body = d1exp_tr_ann (d1e_body, s2e_res)
//
val () = the_d2varlev_dec (pflev | (*none*))
val () = the_trans2_env_pop (pfenv | (*none*))
//
val loc_body = d2e_body.d2exp_loc
val d2e_body = d2exp_ann_seff (loc_body, d2e_body, s2fe)
val d2e_body = d2exp_ann_funclo (loc_body, d2e_body, fc)
//
in
  @(p2ts_arg, d2e_body)
end // end of [d2exp_tr_arg_body_ann]

(* ****** ****** *)

fun
stasub_add_tmparg
(
  sub: &stasub, s2qs: s2qualst, s2fss: s2explstlst
) : void = let
in
//
  case+ s2qs of
  | list_cons (s2q, s2qs) => (
    case+ s2fss of
    | list_cons (s2fs, s2fss) => let
        val _(*err*) = stasub_addlst (sub, s2q.s2qua_svs, s2fs)
      in
        stasub_add_tmparg (sub, s2qs, s2fss)
      end // end of [list_cons]
    | list_nil () => ()
    )
  | list_nil () => ()
//
end // end of [stasub_add_tmparg]

(* ****** ****** *)
//
extern
fun
i1mpdec_tr_main
(
  d1c0: d1ecl
, d2c: d2cst, imparg: i1mparg, impdec: i1mpdec
) : i2mpdec // end of [i1mpdec_tr_main]
//
implement
i1mpdec_tr_main
(
  d1c0, d2c, imparg, impdec
) = let
//
fun
aux_imparg_sarglst
(
  d1c0: d1ecl, s1as: s1arglst
) : s2varlst = s2vs where {
  val s2vs = s1arglst_trup (s1as)
  val () = the_s2expenv_add_svarlst (s2vs)
} (* end of [aux_imparg_sarglst] *)
//
fun
aux_imparg_svararg
(
  d1c0: d1ecl
, s1v: s1vararg, s2qs: s2qualst, out: &s2varlstlst
) : s2qualst = let
//
fun
auxerr1 .<>.
  ():<cloref1> void = let
  val () = prerr_error2_loc (d1c0.d1ecl_loc)
  val () = filprerr_ifdebug "i1mpdec_tr_main"
  val () = prerr ": the implementation is overly applied."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
end // end of [auxerr1]
fun
auxerr2 .<>.
(
  loc: location, serr: int
) :<cloref1> void = let
  val () = prerr_error2_loc (loc)
  val () = filprerr_ifdebug "i1mpdec_tr_main"
  val () = prerr ": the implementation argument group is expected to contain "
  val () = prerr_string (if serr > 0 then "fewer" else "more")
  val () = prerr " components."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
end // end of [auxerr2]
//
fun
auxseq (
  s1as: s1arglst, s2vs: s2varlst, serr: &int
) : s2varlst = (
  case+ (s1as, s2vs) of
  | (s1a :: s1as,
     s2v :: s2vs) => let
      val s2t0 = s2var_get_srt (s2v)
      val s2v = s1arg_trdn (s1a, s2t0)
      val s2vs = auxseq (s1as, s2vs, serr)
    in
      list_cons (s2v, s2vs)
    end
  | (list_nil (), list_nil ()) => list_nil ()
  | (list_cons _, list_nil ()) => let
      val () = serr := serr + 1 in list_nil ()
    end
  | (list_nil (), list_cons _) => let
      val () = serr := serr - 1 in list_nil ()
    end
) (* end of [auxseq] *)
//
in
  case+ s1v of
  | S1VARARGone (loc) => (
    case+ s2qs of
    | list_cons
        (s2q, s2qs) => let
        val s2vs =
          list_map_fun (s2q.s2qua_svs, s2var_dup)
        val s2vs = (l2l)s2vs
        val () = the_s2expenv_add_svarlst (s2vs)
        val () = out := list_cons (s2vs, out)
      in
        s2qs
      end // end of [list_cons]
    | list_nil () => let
        val () = auxerr1 () in list_nil ()
      end // end of [list_nil]
    ) (* end of [S1VARARGone] *)
  | S1VARARGall (loc) => (
    case+ s2qs of
    | list_cons
        (s2q, s2qs) => let
        val s2vs =
          list_map_fun (s2q.s2qua_svs, s2var_dup)
        val s2vs = (l2l)s2vs
        val () = the_s2expenv_add_svarlst (s2vs)
        val () = out := list_cons (s2vs, out)
      in
        aux_imparg_svararg (d1c0, s1v, s2qs, out)
      end
    | list_nil () => list_nil ()
    ) (* end of [S1VARARGall] *)
  | S1VARARGseq
      (loc, s1as) => (
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
        var serr: int = 0
        val s2vs =
          auxseq (s1as, s2q.s2qua_svs, serr)
        val () = the_s2expenv_add_svarlst (s2vs)
        val () = if serr != 0 then auxerr2 (loc, serr)
        val () = out := list_cons (s2vs, out)
      in
        s2qs
      end // end of [list_cons]
    | list_nil () => let
        val () = auxerr1 () in list_nil ()
      end // end of [list_nil]
    ) (* end of [S1VARARGseq] *)
end // end of [aux_imparg_svararg]
//
fun
aux_imparg_svararglst
(
  d1c0: d1ecl
, s2qs: s2qualst, s1vs: s1vararglst, out: &s2varlstlst
) : void = let
  fn auxerr ():<cloref1> void = let
    val () = prerr_error2_loc (d1c0.d1ecl_loc)
    val () = filprerr_ifdebug "i1mpdec_tr_main"
    val () = prerr ": the implementation is expected to be fully applied."
    val () = prerr_newline ()
  in
    the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
  end // end of [auxerr]
in
  case+ s1vs of
  | s1v :: s1vs => let
      val s2qs =
        aux_imparg_svararg (d1c0, s1v, s2qs, out)
      // end of [val]
    in
      aux_imparg_svararglst (d1c0, s2qs, s1vs, out)
    end // end of [::]
  | list_nil () => (
//
// HX: make sure the implementation is fully applied
//
    case+ s2qs of
    | list_cons _ => let 
        val () = auxerr () in ()
      end // end of [list_cons]
    | list_nil () => ()
    ) (* end of [list_nil] *)
end // end of [aux_imparg_svararglst]
//
fun
aux_imparg
(
  d1c0: d1ecl
, s2qs: s2qualst, imparg: i1mparg
) :
(
  s2varlst, Option_vt (s2varlstlst)
) = let
in
//
case+ imparg of
| I1MPARG_sarglst (s1as) => let
    val s2vs = aux_imparg_sarglst (d1c0, s1as)
  in
    (s2vs, None_vt ())
  end // end of [I1MPARG_sarglst]
| I1MPARG_svararglst (s1vs) => let
    var out: s2varlstlst = list_nil ()
    val () = aux_imparg_svararglst (d1c0, s2qs, s1vs, out)
    val out = l2l (list_reverse (out))
    val s2vs = l2l (list_concat (out))
  in
    (s2vs, Some_vt (out))
  end // end of [I1MPARG_svararglst]
//
end // end of [aux_imparg]
//
fun
aux_tmparg_s1explst
(
  d1c0: d1ecl
, s2vs: s2varlst, s1es: s1explst, serr: &int
) : s2explst = let
(*
  val () = (
    print "aux_tmparg_s1explst: s2vs = ";
    print_s2varlst (s2vs); print_newline ()
  ) // end of [val]
*)
in
  case+ (s2vs, s1es) of
  | (s2v :: s2vs, s1e :: s1es) => let
      val s2t = s2var_get_srt (s2v)
      val s2e = s1exp_trdn (s1e, s2t)
      val s2es = aux_tmparg_s1explst (d1c0, s2vs, s1es, serr)
    in
      list_cons (s2e, s2es)
    end // end of [::, ::]
  | (list_nil (), list_nil ()) => list_nil ()
  | (list_cons _, list_nil ()) => let
      val () = serr := serr + 1 in list_nil ()
    end
  | (list_nil (), list_cons _) => let 
      val () = serr := serr - 1 in list_nil ()
    end
end // end of [aux_tmparg_s1explst]
//
fun
aux_tmparg_marglst
(
  d1c0: d1ecl, s2qs: s2qualst, xs: t1mpmarglst
) : s2explstlst = let
//
  fn auxerr1 (
    x: t1mpmarg, serr: int
  ) :<cloref1> void = let
    val () = prerr_error2_loc (x.t1mpmarg_loc)
    val () = filprerr_ifdebug "i1mpdec_tr_main: aux_tmparg_marglst"
    val () = prerr ": the template argument group is expected to be contain "
    val () = if serr > 0 then prerr_string "more components."
    val () = if serr < 0 then prerr_string "fewer components."
    val () = prerr_newline ()
  in
    the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
  end // end of [auxerr1]
//
  fn auxerr2 ():<cloref1> void = let
    val () = prerr_error2_loc (d1c0.d1ecl_loc)
    val () = filprerr_ifdebug "i1mpdec_tr_main: aux_tmparg_marglst"
    val () = prerr ": the template is expected to be fully applied but it is not."
    val () = prerr_newline ()
  in
    the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
  end // end of [auxerr2]
//
  fn auxerr3 ():<cloref1> void = let
    val () = prerr_error2_loc (d1c0.d1ecl_loc)
    val () = filprerr_ifdebug "i1mpdec_tr_main: aux_tmparg_marglst"
    val () = prerr ": the template is overly applied."
    val () = prerr_newline ()
  in
    the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
  end // end of [auxerr3]
in
  case+ (s2qs, xs) of
  | (s2q :: s2qs, x :: xs) => let
      var serr: int = 0
      val s2es = aux_tmparg_s1explst
        (d1c0, s2q.s2qua_svs, x.t1mpmarg_arg, serr)
      val () = if serr != 0 then auxerr1 (x, serr)
      val s2ess = aux_tmparg_marglst (d1c0, s2qs, xs)
    in
      list_cons (s2es, s2ess)
    end
  | (list_nil (), list_nil ()) => list_nil ()
  | (list_cons _, list_nil ()) => let
      val () = auxerr2 () in list_nil ()
    end
  | (list_nil (), list_cons _) => let
      val () = auxerr3 () in list_nil ()
    end
end // end of [aux_tmparg_s1explstlst]
//
fun
aux_tmparg
(
  d1c0: d1ecl
, s2qs: s2qualst, tmparg: t1mpmarglst
) : s2explstlst = let
in
  aux_tmparg_marglst (d1c0, s2qs, tmparg)
end // end of [aux_tmparg]
//
fun
auxerr_tmparg
  (d1c0: d1ecl): void = let
  val () =
  prerr_error2_loc (d1c0.d1ecl_loc)
  val () =
  filprerr_ifdebug "i1mpdec_tr_main"
  val () = prerr ": the redundantly provided template arguments are ignored."
  val () = prerr_newline ((*void*))
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec_tmparg (d1c0))
end // end of [auxerr_tmparg]
//
fun
auxerr_nontop
  (d1c0: d1ecl): void = let
  val () =
  prerr_error2_loc (d1c0.d1ecl_loc)
  val () =
  filprerr_ifdebug "i1mpdec_tr_main"
  val () = prerr ": the implementation should be at the top-level but it is not."
  val () = prerr_newline ((*void*))
in
  the_trans2errlst_add (T2E_d1ecl_tr_impdec_nontop (d1c0))
end // end of [auxerr_nontop]
//
val s2qs = d2cst_get_decarg (d2c)
val isdecarg = list_is_cons (s2qs)
val tmparg = impdec.i1mpdec_tmparg
var tmpargerr: int = 0 // HX: redundancy
val (pfenv | ()) = the_s2expenv_push_nil ()
val () = if isdecarg then the_tmplev_inc ()
val (imparg, opt) = aux_imparg (d1c0, s2qs, imparg)
val sfess = (
  case+ opt of
  | ~Some_vt (s2vss) => let
      fn f (
        s2vs: s2varlst
      ) : s2explst =
         l2l (list_map_fun (s2vs, s2exp_var))
      // end of [f]
      val () = (
        case+ tmparg of
          | list_cons _ => tmpargerr := 1 | _ => ()
      ) : void // end of [val]
    in
      l2l (list_map_fun (s2vss, f))
    end // end of [Some]
  | ~None_vt ((*void*)) => aux_tmparg (d1c0, s2qs, tmparg)
) : s2explstlst // end of [val]
//
val () =
  if tmpargerr > 0 then auxerr_tmparg (d1c0)
//
val tmparg = sfess
val tmpgua = list_nil () // HX: temp guards not supported
//
val () =
(
case+ sfess of
| list_nil () =>
    if the_d2varlev_get () > 0 then auxerr_nontop (d1c0)
| list_cons _ => ()
) (* end of [val] *)
//
val d2e = let
  var sub = stasub_make_nil ()
  val () = stasub_add_tmparg (sub, s2qs, tmparg)
  val s2e = d2cst_get_type (d2c)
  val s2e = s2exp_subst (sub, s2e) // proper instantiation
  val ((*freed*)) = stasub_free (sub)
in
  d1exp_tr_ann (impdec.i1mpdec_def, s2e)
end // end of [val]
//
val () = if isdecarg then the_tmplev_dec ()
val () = the_s2expenv_pop_free (pfenv | (*none*))
//
val () = d2cst_set_def (d2c, Some d2e)
//
val loc = impdec.i1mpdec_loc
val qid = impdec.i1mpdec_qid
val locid = qid.impqi0de_loc
//
in
//
i2mpdec_make (loc, locid, d2c, imparg, tmparg, tmpgua, d2e)
//
end // end of [i1mpdec_tr_main]
//
(* ****** ****** *)

implement
i1mpdec_tr (d1c0) = let
  val-D1Cimpdec
    (knd, imparg, impdec) = d1c0.d1ecl_node
  val d2copt = i1mpdec_select_d2cst (d1c0, impdec)
in
  case+ d2copt of
  | ~Some_vt (d2c) => let
      val impdec = i1mpdec_tr_main (d1c0, d2c, imparg, impdec)
    in
      Some_vt (impdec)
    end // end of [Some_vt]
  | ~None_vt ((*void*)) => None_vt ()
end // end of [i1mpdec_tr]

(* ****** ****** *)

(* end of [pats_trans2_impdec.dats] *)
