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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: November, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/option_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_dynexp_dn"

(* ****** ****** *)

staload LOC = "pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

viewtypedef
funclopt_vt = Option_vt (funclo)
fn d2exp_funclopt_of_d2exp (
  d2e0: d2exp, opt: &(funclopt_vt?) >> funclopt_vt
) : d2exp =
  case+ :(
    opt: funclopt_vt
  ) => d2e0.d2exp_node of
  | D2Eann_funclo (d2e, fc) =>
      let val () = opt := Some_vt fc in d2e end
  | _ => let
      val () = opt := None_vt () in d2e0
    end // end of [_]
// end of [d2exp_funclopt_of_d2exp]

viewtypedef
s2effopt_vt = Option_vt (s2eff)
fn d2exp_s2effopt_of_d2exp (
  d2e0: d2exp, opt: &(s2effopt_vt?) >> s2effopt_vt
) : d2exp =
  case+ :(
    opt: s2effopt_vt
  ) =>
    d2e0.d2exp_node of
  | D2Eann_seff (d2e, s2fe) => 
      let val () = opt := Some_vt s2fe in d2e end
  | _ => let
      val () = opt := None_vt () in d2e0
    end // end of [_]
// end of [d2exp_s2eff_opt_of_d2exp]

(* ****** ****** *)

extern
fun d2exp_trdn_top (d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)

extern
fun d2exp_trdn_seq (d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)

extern
fun d2exp_trdn_effmask (d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)

extern
fun d2exp_trdn_exist (d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)

extern
fun d2exp_trdn_lam_dyn (d2e: d2exp, s2f: s2hnf): d3exp
extern
fun d2exp_trdn_lam_sta_nil (d2e: d2exp, s2f: s2hnf): d3exp

(* ****** ****** *)

extern
fun d2exp_trdn_trywith (d2e0: d2exp, s2f: s2hnf): d3exp

(* ****** ****** *)

implement
d2exp_trdn (d2e0, s2e0) = let
(*
val () = println! ("d2exp_trdn: d2e0 = ", d2e0)
val () = println! ("d2exp_trdn: loc0 = ", d2e0.d2exp_loc)
val () = println! ("d2exp_trdn: s2e0 = ", s2e0)
*)
val s2f0 = s2exp2hnf (s2e0)
//
in
//
case+ d2e0.d2exp_node of
//
| D2Etop _ => d2exp_trdn_top (d2e0, s2f0)
//
| D2Eifhead _ =>
    d2exp_trdn_ifhead (d2e0, s2f0)
  // end of [D2Eifhead]
| D2Esifhead _ =>
    d2exp_trdn_sifhead (d2e0, s2f0)
  // end of [D2Esifhead]
//
| D2Ecasehead _ =>
    d2exp_trdn_casehead (d2e0, s2f0)
  // end of [D2Ecasehead]
//
| D2Elet (d2cs, d2e) =>
    d2exp_trdn_letwhere (d2e0, s2f0, d2cs, d2e)
  // end of [D2Elet]
| D2Ewhere (d2e, d2cs) =>
    d2exp_trdn_letwhere (d2e0, s2f0, d2cs, d2e)
  // end of [D2Ewhere]
//
| D2Eseq _ => d2exp_trdn_seq (d2e0, s2f0)
//
| D2Eeffmask _ => d2exp_trdn_effmask (d2e0, s2f0)
//
| D2Eexist _ => d2exp_trdn_exist (d2e0, s2f0)
//
| D2Elam_dyn _ => d2exp_trdn_lam_dyn (d2e0, s2f0)
//
| D2Elam_sta (s2vs, _, _)
    when list_is_nil (s2vs) => d2exp_trdn_lam_sta_nil (d2e0, s2f0)
  // end of [D2Elam_sta_nil]
//
| D2Etrywith _ => d2exp_trdn_trywith (d2e0, s2f0)
//
| _ => d2exp_trdn_rest (d2e0, s2f0)
//
end // end of [d2exp_trdn]

(* ****** ****** *)

implement
d2exp_trdn_rest
  (d2e0, s2f0) = let
(*
val () = println! ("d2exp_trdn_rest: d2e0 = ", d2e0)
val () = println! ("d2exp_trdn_rest: loc0 = ", d2e0.d2exp_loc)
val () = println! ("d2exp_trdn_rest: s2f0 = ", s2f0)
*)
val loc0 = d2e0.d2exp_loc
val s2e0 = s2hnf2exp (s2f0)
val d3e0 = d2exp_trup (d2e0)
//
val iswth = s2exp_is_wthtype (s2e0)
//
val s2e0 = (
  if iswth then let
    val () = d3exp_open_and_add (d3e0)
  in
    s2exp_wth_instantiate (loc0, s2e0)
  end else begin
    s2e0 // HX: [s2e0] does not carry a state type
  end // end of [if]
) : s2exp // end of [val]
(*
val () = println! ("d2exp_trdn_rest: s2e0 = ", s2e0)
*)
val () = if iswth then funarg_d2vfin_check (loc0)
//
in
  d3exp_trdn (d3e0, s2e0)
end // end of [d2exp_trdn_rest]

(* ****** ****** *)

implement
d2explst_trdn_elt
  (d2es, s2f) = let
  var !p_clo = @lam
    (pf: !unit_v | d2e: d2exp): d3exp =<clo1> d2exp_trdn (d2e, s2f)
  // end of [var]
  prval pfu = unit_v
  val d3es = list_map_vclo<d2exp><d3exp> {unit_v} (pfu | d2es, !p_clo)
  prval unit_v () = pfu
in
  l2l (d3es)
end // end of [d2explst_trdn_elt]

implement
d2expopt_trdn_elt
  (od2e, s2f) = let
in
//
case+ od2e of
| Some (d2e) =>
    Some (d2exp_trdn (d2e, s2f))
| None () => None ()
//
end // end of [d2expopt_trdn_elt]

(* ****** ****** *)

implement
d2exp_trdn_lam_dyn
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val s2e0 = s2hnf2exp (s2f0)
//
in
//
case+ s2e0.s2exp_node of
| S2Efun (
    fc1, lin1, s2fe1, npf1, s2es_arg, s2e_res
  ) => let
    val- D2Elam_dyn
      (lin, npf, p2ts_arg, d2e_body) = d2e0.d2exp_node
    // end of [val]
    val err = $SOL.pfarity_equal_solve (loc0, npf, npf1)
    val () = if err != 0 then {
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_d2exp_trdn_lam_dyn (d2e0, s2e0))
    } // end of [val]
    val err =
      $SOL.linearity_equal_solve (loc0, lin, lin1)
    // end of [val]
    val () = if err != 0 then  {
(*
      val () = prerr_error3_loc (loc0)
      val () = prerr ": linarity mismatch"
      val () = if lin > lin1 then
        prerr ": the linear function is assigned a nonlinear function type."
      val () = if lin < lin1 then
        prerr ": the nonlinear function is assigned a linear function type."
      val () = prerr_newline ()
*)
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_d2exp_trdn_lam_dyn (d2e0, s2e0))
    } // end of [val]
//
    val (pfpush | ()) = trans3_env_push ()
//
    var err: int = 0
    var opt: funclopt_vt
    val d2e_body = d2exp_funclopt_of_d2exp (d2e_body, opt)
    val () = (case+ opt of
      | ~Some_vt (fc) => $SOL.funclo_equal_solve_err (loc0, fc, fc1, err)
      | ~None_vt () => ()
    ) : void // end of [val]
    val () = if err != 0 then let
      val () = prerr_the_staerrlst ()
    in
      the_trans3errlst_add (T3E_d2exp_trdn_lam_dyn (d2e0, s2e0))
    end // end of [if] // end of [val]
//
    var err: int = 0
    var opt: s2effopt_vt
    val d2e_body = d2exp_s2effopt_of_d2exp (d2e_body, opt)
    val () = (case+ opt of
      | ~Some_vt s2fe =>
          $SOL.s2eff_subeq_solve_err (loc0, s2fe, s2fe1, err)
      | ~None_vt () => ()
    ) : void // end of [val]
    val () = if err != 0 then let
      val () = prerr_the_staerrlst ()
    in
      the_trans3errlst_add (T3E_d2exp_trdn_lam_dyn (d2e0, s2e0))
    end // end of [if] // end of [val]
//
    val (pfeff | ()) = the_effenv_push_lam (s2fe1)
//
    var serr: int = 0
    val p3ts_arg =
      p2atlst_trdn_arg (loc0, npf, p2ts_arg, s2es_arg, serr)
    // end of [val]
    val () = if (serr != 0) then let
      val () = prerr_error3_loc (loc0)
      val () = prerr ": dynamic arity mismatch"
      val () = if serr < 0 then prerr ": more arguments are expected."
      val () = if serr > 0 then prerr ": fewer arguments are expected."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_d2exp_trdn_lam_dyn (d2e0, s2e0))
    end // end of [if] // end of [val]
//
    val (pfd2v | ()) = the_d2varenv_push_lam (lin1)
    val () = the_d2varenv_add_p3atlst (p3ts_arg)
    val (pfman | ()) = the_pfmanenv_push_lam (lin1) // lin:0/1:stopping/continuing
    val () = the_pfmanenv_add_p3atlst (p3ts_arg)
    val (pflamlp | ()) = the_lamlpenv_push_lam (p3ts_arg)
//
    val d3e_body = d2exp_trdn (d2e_body, s2e_res)
//
    val () = the_effenv_pop (pfeff | (*none*))
    val () = the_d2varenv_pop (pfd2v | (*none*))
    val () = the_pfmanenv_pop (pfman | (*none*))
    val () = the_lamlpenv_pop (pflamlp | (*none*))
//
    val () = trans3_env_pop_and_add_main (pfpush | loc0)
//
  in
    d3exp_lam_dyn (loc0, s2e0, lin, npf, p3ts_arg, d3e_body)
  end // end of [S2Efun]
| S2Euni (s2vs, s2ps, s2e) => let
    val (pfpush | ()) = trans3_env_push ()
    val () = trans3_env_add_svarlst (s2vs)
    val () = trans3_env_hypadd_proplst (loc0, s2ps)
    val d3e0 = d2exp_trdn (d2e0, s2e)
    val () = trans3_env_pop_and_add_main (pfpush | loc0)
  in
    d3exp_lam_sta (loc0, s2e0, s2vs, s2ps, d3e0)
  end // end of [S2Euni]
| _ => let
    val d3e0 = d2exp_trup (d2e0) in d3exp_trdn (d3e0, s2e0)
  end // end of [let]
//
end // end of [d2exp_trdn_lam_dyn]

(* ****** ****** *)

implement
d2exp_trdn_lam_sta_nil
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val s2e0 = s2hnf2exp (s2f0)
//
in
//
case+ s2e0.s2exp_node of
| S2Euni (s2vs, s2ps, s2e) => let
    val (pfpush | ()) = trans3_env_push ()
    val () = trans3_env_add_svarlst (s2vs)
    val () = trans3_env_hypadd_proplst (loc0, s2ps)
    val d3e0 = d2exp_trdn (d2e0, s2e)
    val () = trans3_env_pop_and_add_main (pfpush | loc0)
  in
    d3exp_lam_sta (loc0, s2e0, s2vs, s2ps, d3e0)
  end // end of [S2Euni]
| _ => let
    val- D2Elam_sta
      (_(*s2vs*), s2ps, d2e_body) = d2e0.d2exp_node
    // end of [val]
    val () = trans3_env_add_proplst (loc0, s2ps)
  in
    d2exp_trdn (d2e_body, s2e0)
  end // end of [_]
//
end // end of [d2exp_trdn_lam_sta_nil]

(* ****** ****** *)

implement
d2exp_trdn_ifhead
  (d2e0, s2f_if) = let
//
val loc0 = d2e0.d2exp_loc
val- D2Eifhead
  (invres, d2e_cond, d2e_then, od2e_else) = d2e0.d2exp_node
// end of [val]
//
val d3e_cond = d2exp_trup (d2e_cond)
val () = d3exp_open_and_add (d3e_cond)
//
val loc_cond = d3e_cond.d3exp_loc
val s2e_cond = d3exp_get_type (d3e_cond)
val s2f_cond = s2exp2hnf (s2e_cond)
val os2p_cond = un_s2exp_bool_index_t0ype (s2f_cond)
//
val s2e_if = s2hnf2exp (s2f_if)
//
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val loc_then = d2e_then.d2exp_loc
val ctr = c3nstroptref_make_none (loc_then)
val d3e_then = let
  val (pfpush | ()) = trans3_env_push ()
  val () = trans3_env_hypadd_propopt
    (loc_cond, $UN.castvwtp1 {s2expopt}{s2expopt_vt} (os2p_cond))
  val d3e_then = d2exp_trdn (d2e_then, s2e_if)
  val () = trans3_env_add_cnstr_ref (ctr)
  val () = trans3_env_pop_and_add_main (pfpush | loc_then)
in
  d3e_then
end // end of [val]
val () = lstaftc3nstr_update (lsaft, ctr)
//
val () = lstbefitmlst_restore_type (lsbis)
//
val d2e_else = (
  case+ od2e_else of
  | Some d2e_else => d2e_else
  | None () => let
      val loc_else = $LOC.location_rightmost (loc_then)
    in
      d2exp_empty (loc_else)
    end // end of [None]
) : d2exp // end of [val]
val loc_else = d2e_else.d2exp_loc
val ctr = c3nstroptref_make_none (loc_else)
val d3e_else = let
  val (pfpush | ()) = trans3_env_push ()
  val () = trans3_env_hypadd_propopt_neg
    (loc_cond, $UN.castvwtp1 {s2expopt}{s2expopt_vt} (os2p_cond))
  val d3e_else = d2exp_trdn (d2e_else, s2e_if)
  val () = trans3_env_add_cnstr_ref (ctr)
  val () = trans3_env_pop_and_add_main (pfpush | loc_else)
in
  d3e_else
end // end of [val]
val () = lstaftc3nstr_update (lsaft, ctr)
//
val () = option_vt_free (os2p_cond)
//
val () =
  lstaftc3nstr_process (lsaft, invres)
val () = lstaftc3nstr_finalize (lsaft)
//
val () = trans3_env_add_svarlst (invres.i2nvresstate_svs)
val () = trans3_env_hypadd_proplst (loc0, invres.i2nvresstate_gua)
//
in
  d3exp_if (loc0, s2e_if, d3e_cond, d3e_then, d3e_else)
end // end of [d2exp_trdn_ifhead]

(* ****** ****** *)

implement
d2exp_trdn_sifhead
  (d2e0, s2f_sif) = let
//
val loc0 = d2e0.d2exp_loc
val- D2Esifhead
  (invres, s2p_cond, d2e_then, d2e_else) = d2e0.d2exp_node
// end of [val]
//
val s2e_sif = s2hnf2exp (s2f_sif)
//
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val loc_then = d2e_then.d2exp_loc
val ctr = c3nstroptref_make_none (loc_then)
val d3e_then = let
  val (pfpush | ()) = trans3_env_push ()
  val () = trans3_env_hypadd_prop (loc0, s2p_cond)
  val d3e_then = d2exp_trdn (d2e_then, s2e_sif)
  val () = trans3_env_add_cnstr_ref (ctr)
  val () = trans3_env_pop_and_add_main (pfpush | loc_then)
in
  d3e_then
end // end of [val]
val () = lstaftc3nstr_update (lsaft, ctr)
//
val () = lstbefitmlst_restore_type (lsbis)
//
val loc_else = d2e_then.d2exp_loc
val ctr = c3nstroptref_make_none (loc_else)
val d3e_else = let
  val (pfpush | ()) = trans3_env_push ()
  val () = trans3_env_hypadd_prop (loc0, s2exp_bneg (s2p_cond))
  val d3e_else = d2exp_trdn (d2e_else, s2e_sif)
  val () = trans3_env_add_cnstr_ref (ctr)
  val () = trans3_env_pop_and_add_main (pfpush | loc_else)
in
  d3e_else
end // end of [val]
val () = lstaftc3nstr_update (lsaft, ctr)
//
val () =
  lstaftc3nstr_process (lsaft, invres)
val () = lstaftc3nstr_finalize (lsaft)
//
val () = trans3_env_add_svarlst (invres.i2nvresstate_svs)
val () = trans3_env_hypadd_proplst (loc0, invres.i2nvresstate_gua)
//
in
  d3exp_sif (loc0, s2e_sif, s2p_cond, d3e_then, d3e_else)
end // end of [d2exp_trdn_sifhead]

(* ****** ****** *)

implement
d2exp_trdn_letwhere
  (d2e0, s2f0, d2cs, d2e_scope) = let
  val loc0 = d2e0.d2exp_loc
  val s2e0 = s2hnf2exp (s2f0)
//
  val (pfpush_eff | ()) = the_effenv_push ()
  val (pfpush_s2cst | ()) = the_s2cstbindlst_push ()
  val (pfpush_d2var | ()) = the_d2varenv_push_let ()
//
  val d3cs = d2eclist_tr (d2cs)
  val d3e_scope = d2exp_trdn (d2e_scope, s2e0)
//
  val () = the_d2varenv_check (loc0)
//
  val () = the_effenv_pop (pfpush_eff | (*none*))
  val () = the_s2cstbindlst_pop_and_unbind (pfpush_s2cst | (*none*))
  val () = the_d2varenv_pop (pfpush_d2var | (*none*))
//
in
  d3exp_let (loc0, d3cs, d3e_scope)
end // end of [d2exp_trdn_letwhere]

(* ****** ****** *)

implement
d2exp_trdn_top
  (d2e0, s2f0) = let
  val loc0 = d2e0.d2exp_loc
  val s2e0 = s2hnf2exp (s2f0)
in
  d3exp_top (loc0, s2e0)
end // end of [d2exp_trdn_top]

implement
d2exp_trdn_seq (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val- D2Eseq (d2es) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
fun aux (
  d2e: d2exp
, d2es: d2explst
, s2e_void: s2exp
, s2e0: s2exp
) : d3explst =
  case+ d2es of
  | list_cons (d2e1, d2es1) => let
      val d3e = d2exp_trdn (d2e, s2e_void)
      val d3es = aux (d2e1, d2es1, s2e_void, s2e0)
    in
      list_cons (d3e, d3es)
    end // end of [cons]
  | list_nil () => let
      val d3e = d2exp_trdn (d2e, s2e0) in list_sing (d3e)
    end // end of [nil]
// end of [aux]
//
val s2e_void = s2exp_void_t0ype ()
//
in
//
case+ d2es of
| list_cons (d2e, d2es) => let
    var s2e_res: s2exp // uninitialized
    val d3es = aux (d2e, d2es, s2e_void, s2e0)
  in
    d3exp_seq (loc0, s2e0, d3es)
  end // end of [cons]
| list_nil () => let
    val d3e =
      d3exp_empty (loc0, s2e_void)
    // end of [val]
  in
    d3exp_trdn (d3e, s2e0)
  end // end of [list_nil]
end // end of [d2exp_trdn_seq]

(* ****** ****** *)

implement
d2exp_trdn_effmask
  (d2e0, s2f0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Eeffmask (s2fe, d2e) = d2e0.d2exp_node
  val (pfpush | ()) = the_effenv_push_effmask (s2fe)
  val s2e0 = s2hnf2exp (s2f0)
  val d3e = d2exp_trdn (d2e, s2e0)
  val () = the_effenv_pop (pfpush | (*none*))
in
  d3exp_effmask (loc0, s2fe, d3e)
end // end of [d2exp_trdn_effmask]

(* ****** ****** *)

implement
d2exp_trdn_exist
  (d2e0, s2f0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Eexist (s2a, d2e) = d2e0.d2exp_node
  val s2e0 = s2hnf2exp (s2f0)
  var s2ps: s2explst_vt
  var err: int = 0
  val s2e_ins = (
    case+ s2e0.s2exp_node of
    | S2Ewth (s2e1, wths2e2) => let
        val (s2e1, s2ps1) =
          s2exp_exi_instantiate_sexparg (s2e1, s2a, err)
        val () = s2ps := s2ps1
      in
        s2exp_wth (s2e1, wths2e2)
      end // end of [S2Ewth]
    | _ => s2e1 where {
        val (s2e1, s2ps1) =
          s2exp_exi_instantiate_sexparg (s2e0, s2a, err)
        val () = s2ps := s2ps1
      } // end of [_]
  ) : s2exp // end of [val]
  val () = trans3_env_add_proplst_vt (loc0, s2ps)
(*
  val () = if err > 0 then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": existential abstraction mismatch"
    val () = the_trans3errlst_add (T3E_d2exp_trdn_exist (d2e0, s2e0))
  } // end of [val]
*)
in
  d2exp_trdn (d2e, s2e_ins)
end // end of [d2exp_trdn_exist]

(* ****** ****** *)

implement
d2exp_trdn_trywith
  (d2e0, s2f0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Etrywith
    (r2es, d2e, c2ls) = d2e0.d2exp_node
//
  val (pfpush | ()) = the_d2varenv_push_try ()
//
  val s2e_res = s2hnf2exp (s2f0)
  val d3e = d2exp_trdn (d2e, s2e_res)
  val s2e_pat = s2exp_exception_viewtype ()
  val d3es = list_sing (d3e)
  val s2es_pat = list_sing (s2e_pat)
  val c3ls = c2laulst_trdn (
    loc0, CK_case_neg, r2es, c2ls, d3es, s2es_pat, s2e_res
  ) // end of [val]
//
  val () = the_d2varenv_pop (pfpush | (*none*))
//
in
  d3exp_trywith (loc0, d3e, c3ls)
end // end of [d2exp_trdn_trywith]

(* ****** ****** *)

(* end of [pats_trans3_dynexp_dn.dats] *)
