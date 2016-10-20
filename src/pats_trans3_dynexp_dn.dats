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
// Start Time: November, 2011
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
implement prerr_FILENAME<> () = prerr "pats_trans3_dynexp_dn"

(* ****** ****** *)

staload LOC = "./pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_patcst2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload MAC = "./pats_dmacro2.sats"
staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

fun
d2exp_funclopt_of_d2exp
(
  d2e0: d2exp
, opt: &(fcopt_vt?) >> fcopt_vt
) : d2exp = let
in
//
case+
:(
  opt: fcopt_vt
) => d2e0.d2exp_node of
| D2Eann_funclo (d2e, fc) =>
    let val () = opt := Some_vt fc in d2e end
  // end of [D2Eann_funclo]
| _ =>
    let val () = opt := None_vt () in d2e0 end
  // end of [_]
//
end // end of [d2exp_funclopt_of_d2exp]

viewtypedef
s2effopt_vt =
Option_vt(s2eff)

fun
d2exp_s2effopt_of_d2exp
(
  d2e0: d2exp
, opt: &(s2effopt_vt?) >> s2effopt_vt
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
fun
d2exp_trdn_top(d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)

extern
fun
d2exp_trdn_tup(d2e0: d2exp, s2f0: s2hnf): d3exp
extern
fun
d2exp_trdn_rec(d2e0: d2exp, s2f0: s2hnf): d3exp
extern
fun
d2exp_trdn_seq(d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)
//
extern
fun
d2exp_trdn_raise(d2e0: d2exp, s2f0: s2hnf): d3exp
//
extern
fun
d2exp_trdn_effmask(d2e0: d2exp, s2f0: s2hnf): d3exp
//
(* ****** ****** *)

extern
fun
d2exp_trdn_exist(d2e0: d2exp, s2f0: s2hnf): d3exp

(* ****** ****** *)
//
extern
fun
d2exp_trdn_lam_dyn(d2e: d2exp, s2f0: s2hnf): d3exp
extern
fun
d2exp_trdn_lam_sta_nil(d2e: d2exp, s2f0: s2hnf): d3exp
//
(* ****** ****** *)
//
extern
fun
d2exp_trdn_delay (d2e0: d2exp, s2f0: s2hnf): d3exp
extern
fun
d2exp_trdn_ldelay (d2e0: d2exp, s2f0: s2hnf): d3exp
//
(* ****** ****** *)
//
extern
fun
d2exp_trdn_trywith (d2e0: d2exp, s2f0: s2hnf): d3exp
//
(* ****** ****** *)

implement
d2exp_trdn
  (d2e0, s2e0) = let
//
(*
val loc0 = d2e0.d2exp_loc
//
val () =
  println! ("d2exp_trdn: d2e0 = ", d2e0)
val () =
  println! ("d2exp_trdn: loc0 = ", loc0)
val () =
  println! ("d2exp_trdn: s2e0(bef) = ", s2e0)
//
*)
//
val s2f0 = s2exp2hnf(s2e0)
val s2e0 = s2hnf2exp(s2f0)
//
(*
val () =
  println! ("d2exp_trdn: s2e0(aft) = ", s2e0)
*)
//
in
//
case+
d2e0.d2exp_node
of // case+
//
| D2Etop _ =>
    d2exp_trdn_top(d2e0, s2f0)
  // end of [D2Etop]
//
| D2Elet (d2cs, d2e) =>
    d2exp_trdn_letwhere(d2e0, s2f0, d2cs, d2e)
  // end of [D2Elet]
| D2Ewhere (d2e, d2cs) =>
    d2exp_trdn_letwhere(d2e0, s2f0, d2cs, d2e)
  // end of [D2Ewhere]
//
| D2Eapplst
    (_fun, _arg) => let
    val loc0 = d2e0.d2exp_loc
(*
    val () = (
      fprintln! (stdout_ref, "d2exp_trdn: D2Eapplst: _fun = ", _fun);
      fprintln! (stdout_ref, "d2exp_trdn: D2Eapplst: _arg = ", _arg);
    ) // end of [val]
*)
  in
    case+
    _fun.d2exp_node
    of // case+
    | D2Emac d2m => let
(*
        val () =
        println!
          ("d2exp_trdn: D2Eapplst: D2Emac(bef): d2e0 = ", d2e0)
        // end of [val]
*)
        val d2e0 =
          $MAC.dmacro_eval_app_short(loc0, d2m, _arg)
        // end of [val]
(*
        val () = (
          println! ("d2exp_trdn: D2Eapplst: D2Emac(aft): loc0 = ", loc0);
          println! ("d2exp_trdn: D2Eapplst: D2Emac(aft): d2e0 = ", d2e0);
        ) (* end of [val] *)
*)
      in
        d2exp_trdn(d2e0, s2e0)
      end // end of [D2Emac]
    | _ => d2exp_trdn_rest(d2e0, s2f0)
  end // end of [D2Eapplst]
//
| D2Eifhead _ =>
    d2exp_trdn_ifhead(d2e0, s2f0)
  // end of [D2Eifhead]
| D2Esifhead _ =>
    d2exp_trdn_sifhead(d2e0, s2f0)
  // end of [D2Esifhead]
//
| D2Ecasehead _ =>
    d2exp_trdn_casehead(d2e0, s2f0)
  // end of [D2Ecasehead]
| D2Escasehead _ =>
    d2exp_trdn_scasehead(d2e0, s2f0)
  // end of [D2Escasehead]
//
| D2Esing (d2e) => d2exp_trdn(d2e, s2e0)
//
| D2Elist
    (npf, d2es) => let
    val loc0 = d2e0.d2exp_loc
    val d2e0 =
      d2exp_tup_flt(loc0, npf, d2es) in d2exp_trdn(d2e0, s2e0)
    // end of [val]
  end // end of [D2Elist]
//
| D2Etup _ => d2exp_trdn_tup (d2e0, s2f0)
| D2Erec _ => d2exp_trdn_rec (d2e0, s2f0)
| D2Eseq _ => d2exp_trdn_seq (d2e0, s2f0)
//
| D2Eraise _ => d2exp_trdn_raise (d2e0, s2f0)
//
| D2Eeffmask _ => d2exp_trdn_effmask (d2e0, s2f0)
//
| D2Eshowtype
    (d2e) => d3e where
  {
    val d3e = d2exp_trdn(d2e, s2e0)
    val ((*void*)) = fshowtype_d3exp_dn(d3e)
  } (* end of [D2Eshowtype] *)
//
| D2Eexist _ => d2exp_trdn_exist(d2e0, s2f0)
//
| D2Elam_dyn _ => d2exp_trdn_lam_dyn(d2e0, s2f0)
//
| D2Elam_sta(s2vs, _, _)
    when list_is_nil(s2vs) => d2exp_trdn_lam_sta_nil(d2e0, s2f0)
  // end of [D2Elam_sta_nil]
//
| D2Edelay _ => d2exp_trdn_delay(d2e0, s2f0)
| D2Eldelay _ => d2exp_trdn_ldelay(d2e0, s2f0)
//
| D2Etrywith _ => d2exp_trdn_trywith(d2e0, s2f0)
//
| _ (*rest-of-d2exp*) => d2exp_trdn_rest(d2e0, s2f0)
//
end // end of [d2exp_trdn]

(* ****** ****** *)

implement
d2exp_trdn_rest
  (d2e0, s2f0) = let
//
(*
val () =
println! ("d2exp_trdn_rest: d2e0 = ", d2e0)
val () =
println! ("d2exp_trdn_rest: loc0 = ", d2e0.d2exp_loc)
val () =
println! ("d2exp_trdn_rest: s2f0 = ", s2f0)
*)
//
val loc0 = d2e0.d2exp_loc
val s2e0 = s2hnf2exp(s2f0)
val d3e0 = d2exp_trup(d2e0)
//
val iswth = s2exp_is_wthtype(s2e0)
//
val s2e0 = (
//
if
iswth
then let
//
val () =
  d3exp_open_and_add(d3e0)
// end of [val]
in
  s2exp_wthtype_instantiate(loc0, s2e0)
end // end of [then]
else s2e0 // HX: not carrying a state type
//
) : s2exp // end of [val]
(*
//
val () =
println!
  ("d2exp_trdn_rest: s2e0 = ", s2e0)
//
*)
//
val () =
  if iswth then funarg_d2vfin_check(loc0)
//
in
  d3exp_trdn(d3e0, s2e0)
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
  list_of_list_vt(d3es)
end // end of [d2explst_trdn_elt]

implement
d2expopt_trdn_elt
  (od2e, s2f) = let
(*
//
val () =
println!
  ("d2expopt_trdn_elt")
//
*)
in
//
case+ od2e of
//
| None() => None()
//
| Some(d2e) =>
    Some(d2exp_trdn(d2e, s2f))
  // end of [Some]
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
(*
val () = println! ("d2exp_trdn_lam_dyn: d2e0 = ", d2e0)
val () = println! ("d2exp_trdn_lam_dyn: s2e0 = ", s2e0)
*)
//
in
//
case+ s2e0.s2exp_node of
| S2Efun (
    fc1, lin1, s2fe1, npf1, s2es_arg, s2e_res
  ) => let
    val-D2Elam_dyn
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
    var opt: fcopt_vt
    val d2e_body = d2exp_funclopt_of_d2exp (d2e_body, opt)
    val () = (
      case+ opt of
      | ~None_vt () => ()
      | ~Some_vt fc => $SOL.funclo_equal_solve_err(loc0, fc, fc1, err)
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
    val s2fe = (
      case+ opt of
      | ~Some_vt s2fe => let
          val () = $SOL.s2eff_subeq_solve_err (loc0, s2fe, s2fe1, err)
        in
          s2fe
        end // end of [Some_vt]
      | ~None_vt () => s2fe1
    ) : s2eff // end of [val]
    val () = if err != 0 then let
      val () = prerr_the_staerrlst ()
    in
      the_trans3errlst_add (T3E_d2exp_trdn_lam_dyn (d2e0, s2e0))
    end // end of [if] // end of [val]
//
    val (pfeff | ()) = the_effenv_push_lam (s2fe)
//
    val () = funarg_patck_exhaust (loc0, p2ts_arg, s2es_arg)
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
    val () = the_d2varenv_check (loc0)
    val () = if lin > 0 then the_d2varenv_check_llam (loc0)
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
//
| S2Euni
    (s2vs, s2ps, s2e) => let
    val (pfpush | ()) = trans3_env_push ()
    val () = trans3_env_add_svarlst (s2vs)
    val () = trans3_env_hypadd_proplst (loc0, s2ps)
    val d3e0 = d2exp_trdn (d2e0, s2e)
    val () = trans3_env_pop_and_add_main (pfpush | loc0)
  in
    d3exp_lam_sta (loc0, s2e0, s2vs, s2ps, d3e0)
  end // end of [S2Euni]
//
| S2Erefarg (knd, s2e) => let
    val s2f = s2exp2hnf (s2e) in d2exp_trdn_lam_dyn (d2e0, s2f)
  end // end of [s2Erefarg]
//
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
    val-D2Elam_sta
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
(*
val () = println! ("d2exp_trdn_ifhead: d2e0 = ", d2e0)
val () = println! ("d2exp_trdn_ifhead: s2f_if = ", s2f_if)
*)
val loc0 = d2e0.d2exp_loc
val-D2Eifhead
  (invres, d2e_cond, d2e_then, od2e_else) = d2e0.d2exp_node
// end of [val]
//
val s2e_bool = s2exp_bool_t0ype()
//
val d3e_cond = d2exp_trup(d2e_cond)
val () = d3exp_open_and_add(d3e_cond)
val s2e_cond = d3exp_get_type(d3e_cond)
val d3e_cond = d3exp_trdn (d3e_cond, s2e_bool)
val s2f_cond = s2exp2hnf (s2e_cond)
val os2p_cond = un_s2exp_bool_index_t0ype (s2f_cond)
//
val s2e0 = s2hnf2exp (s2f_if)
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val loc_then = d2e_then.d2exp_loc
val ctr_then = c3nstroptref_make_none(loc_then)
val d3e_then = let
  val (pfpush|()) =
    trans3_env_push((*void*))
  val () =
    trans3_env_hypadd_propopt(
      d2e_cond.d2exp_loc
    , $UN.castvwtp1{s2expopt}{s2expopt_vt}(os2p_cond)
    ) (* trans3_env_hypadd_propopt *)
  val d3e_then = d2exp_trdn(d2e_then, s2e0)
  val () = trans3_env_add_cnstr_ref (ctr_then)
  val () = trans3_env_pop_and_add_main (pfpush | loc_then)
in
  d3e_then
end // end of [val]
val ((*void*)) =
  lstaftc3nstr_update(lsaft, ctr_then)
//
val () = lstbefitmlst_restore_type(lsbis)
//
val d2e_else = (
  case+ od2e_else of
  | Some d2e_else => d2e_else
  | None ((*void*)) => let
      val loc_else =
        $LOC.location_rightmost(loc_then)
      // end of [val]
    in
      d2exp_empty(loc_else)
    end // end of [None]
) : d2exp // end of [val]
val loc_else = d2e_else.d2exp_loc
val ctr_else = c3nstroptref_make_none(loc_else)
val d3e_else = let
  val (pfpush|()) = trans3_env_push()
  val () =
    trans3_env_hypadd_propopt_neg
    (
      d2e_cond.d2exp_loc
    , $UN.castvwtp1{s2expopt}{s2expopt_vt}(os2p_cond)
    ) (* trans3_env_hypadd_propopt_neg *)
  val d3e_else = d2exp_trdn(d2e_else, s2e0)
  val () = trans3_env_add_cnstr_ref(ctr_else)
  val () = trans3_env_pop_and_add_main(pfpush | loc_else)
in
  d3e_else
end // end of [val]
val ((*void*)) =
  lstaftc3nstr_update (lsaft, ctr_else)
//
val ((*void*)) = option_vt_free (os2p_cond)
//
val ((*void*)) =
  lstaftc3nstr_process (lsaft, invres)
//
val () = lstaftc3nstr_finalize (lsaft)
val ((*void*)) = i2nvresstate_update (loc0, invres)
//
in
  d3exp_if (loc0, s2e0, d3e_cond, d3e_then, d3e_else)
end // end of [d2exp_trdn_ifhead]

(* ****** ****** *)

implement
d2exp_trdn_sifhead
  (d2e0, s2f_sif) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Esifhead
  (invres, s2p_cond, d2e_then, d2e_else) = d2e0.d2exp_node
// end of [val]
//
val s2e0 = s2hnf2exp (s2f_sif)
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val loc_then = d2e_then.d2exp_loc
val ctr_then = c3nstroptref_make_none (loc_then)
val d3e_then = let
  val (pfpush|()) = trans3_env_push()
  val () =
    trans3_env_hypadd_prop (loc0, s2p_cond)
  val d3e_then = d2exp_trdn (d2e_then, s2e0)
  val ((*void*)) =
    trans3_env_add_cnstr_ref (ctr_then)
  val ((*void*)) =
    trans3_env_pop_and_add_main (pfpush | loc_then)
in
  d3e_then
end // end of [val]
val ((*void*)) =
  lstaftc3nstr_update(lsaft, ctr_then)
//
val () = lstbefitmlst_restore_type(lsbis)
//
val loc_else = d2e_then.d2exp_loc
val ctr_else = c3nstroptref_make_none (loc_else)
val d3e_else = let
  val (pfpush|()) = trans3_env_push()
  val () =
    trans3_env_hypadd_prop
      (loc0, s2exp_bneg(s2p_cond))
    // trans3_env_hypadd_prop
  val d3e_else = d2exp_trdn(d2e_else, s2e0)
  val ((*void*)) = trans3_env_add_cnstr_ref(ctr_else)
  val ((*void*)) = trans3_env_pop_and_add_main(pfpush | loc_else)
in
  d3e_else
end // end of [val]
val ((*void*)) = lstaftc3nstr_update(lsaft, ctr_else)
//
val ((*void*)) =
  lstaftc3nstr_process (lsaft, invres)
//
val () = lstaftc3nstr_finalize (lsaft)
val ((*void*)) = i2nvresstate_update (loc0, invres)
//
in
  d3exp_sif (loc0, s2e0, s2p_cond, d3e_then, d3e_else)
end // end of [d2exp_trdn_sifhead]

(* ****** ****** *)
//
local
//
fun
f_conjtest_conj
(
  os2p_conj: s2expopt_vt
, os2p_test: s2expopt_vt
) : s2expopt_vt =
(
case+ os2p_conj of
| ~None_vt() =>
  (
    case+ os2p_test of
    | ~None_vt() => None_vt()
    | ~Some_vt(s2p_test) =>
        Some_vt(s2exp_bneg(s2p_test))
      // end of [Some_vt]
  ) (* None_vt *)
| ~Some_vt(s2p_conj) =>
  (
    case+ os2p_test of
    | ~None_vt() => Some_vt(s2p_conj)
    | ~Some_vt(s2p_test) =>
        Some_vt(s2exp_bmul(s2p_conj, s2exp_bneg(s2p_test)))
      // end of [Some_vt]
  ) (* Some_vt *)
) (* end of [f_conjtest_conj] *)
//
fun
f_conjtest_test
(
  os2p_conj: !s2expopt_vt
, os2p_test: !s2expopt_vt
) : s2expopt_vt =
(
//
case+ os2p_conj of
| None_vt((*void*)) => let
    prval () = fold@(os2p_conj)
  in
    case+ os2p_test of
    | None_vt() => (fold@(os2p_test); None_vt())
    | Some_vt(s2p_test) => (fold@(os2p_test); Some_vt(s2p_test))
  end // end of [None_vt]
| Some_vt(s2p_conj) => opt where
  {
    val opt = (
      case+ os2p_test of
      | None_vt() => (fold@(os2p_test); Some_vt(s2p_conj))
      | Some_vt(s2p_test) => (fold@(os2p_test); Some_vt(s2exp_bmul(s2p_conj, s2p_test)))
    ) : s2expopt_vt
    prval () = fold@(os2p_conj)
  } (* end of [Some_vt] *)
) (* end of [f_conjtest_test] *)
//
fun
auxlst1_check
(
  x0: i2fcl
, xs: i2fclist
, s2e_if: s2exp
, os2p_conj: s2expopt_vt
, lsbis: lstbefitmlst, lsaft: !lstaftc3nstr
) : i3fclist = let
//
val loc = x0.i2fcl_loc
val ctr = c3nstroptref_make_none(loc)
val d2e_test = x0.i2fcl_test
val d2e_body = x0.i2fcl_body
//
val s2e_bool = s2exp_bool_t0ype()
//
val d3e_test =
(
//
case+
d2e_test.d2exp_node
of (* case+ *)
| D2Etop() => let
    val loc = d2e_test.d2exp_loc
  in
    d3exp_bool(loc, s2e_bool, true)
  end // end of [D2Etop]
| _(*non-D2Etop*) => d2exp_trup(d2e_test)
//
) : d3exp // end of [val]
//
val () = d3exp_open_and_add(d3e_test)
val s2e_test = d3exp_get_type(d3e_test)
val d3e_test = d3exp_trdn(d3e_test, s2e_bool)
//
val s2f_test = s2exp2hnf(s2e_test)
val os2p_test = un_s2exp_bool_index_t0ype(s2f_test)
val os2p_test2 = f_conjtest_test(os2p_conj, os2p_test)
//
val (pfpush|()) =
  trans3_env_push((*void*))
val () =
  trans3_env_hypadd_propopt(
    d2e_test.d2exp_loc
  , $UN.castvwtp1{s2expopt}{s2expopt_vt}(os2p_test2)
  ) (* trans3_env_hypadd_propopt *)
val d3e_body = d2exp_trdn(d2e_body, s2e_if)
//
val ((*void*)) = trans3_env_add_cnstr_ref(ctr)
val ((*void*)) = trans3_env_pop_and_add_main(pfpush | loc)
//
val ifcl = i3fcl_make(loc, d3e_test, d3e_body)
//
val ((*void*)) = option_vt_free(os2p_test2)
val ((*void*)) = lstaftc3nstr_update (lsaft, ctr)
//
in
//
case+ xs of
| list_nil() => let
    val () =
      option_vt_free(os2p_conj)
    val () =
      option_vt_free(os2p_test)
  in
    list_cons(ifcl, list_nil((*void*)))
  end // end of [list_nil]
| list_cons(x, xs) =>
  list_cons(ifcl, ifcls_rest) where
  {
    val os2p_conj2 =
      f_conjtest_conj(os2p_conj, os2p_test)
    // end of [val]
    val () = lstbefitmlst_restore_type(lsbis)
    val ifcls_rest =
      auxlst1_check
        (x, xs, s2e_if, os2p_conj2, lsbis, lsaft)
      // auxlst1_check
  } (* end of [list_cons] *)
//
end // end of [auxlst1_check]
//
in (* in-of-local *)

implement
d2exp_trdn_ifcasehd
  (d2e0, s2f_if) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Eifcasehd
  (knd, invres, ifcls) = d2e0.d2exp_node
//
val s2e0 = s2hnf2exp(s2f_if)
//
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val ifcls =
(
//
case+
: (
  lsaft: lstaftc3nstr
) =>
ifcls of
| list_nil() =>
    list_nil((*void*))
  // end of [list_nil]
| list_cons(x0, xs) =>
  (
    auxlst1_check
      (x0, xs, s2e0, None_vt(*conj*), lsbis, lsaft)
    // auxlst1_check
  ) (* end of [list_cons] *)
//
) : i3fclist // end of [val]
//
val ((*void*)) =
  lstaftc3nstr_process (lsaft, invres)
//
val () = lstaftc3nstr_finalize (lsaft)
val ((*void*)) = i2nvresstate_update (loc0, invres)
//
in
  d3exp_ifcase(loc0, s2e0, knd, ifcls)
end // end of [d2exp_trdn_ifcasehd]
//
end // end of [local]
//
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

(* ****** ****** *)

local

fun auxerrlen
(
  loc0: loc_t, serr: int
) : void = () where {
//
val () =
  prerr_error3_loc (loc0)
val () = if serr < 0 then prerr ": more record field expected."
val () = if serr > 0 then prerr ": fewer record field expected."
val () = prerr_newline ()
//
} // end if [auxerrlen]

(* ****** ****** *)

fun auxtup (
  d2es: d2explst, ls2es: labs2explst, serr: &int
) : d3explst = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
  in
    case+ ls2es of
    | list_cons
        (ls2e, ls2es) => let
        val+SLABELED (l, name, s2e) = ls2e
        val d3e = d2exp_trdn (d2e, s2e)
        val d3es = auxtup (d2es, ls2es, serr)
      in
        list_cons (d3e, d3es)
      end // end of [list_cons]
    | list_nil () => let
        val () = serr := serr+1 in list_nil ()
      end // end of [list_nil]
  end // end of [list_cons]
| list_nil () => let
  in
    case+ ls2es of
    | list_cons _ => let
        val () = serr := serr-1 in list_nil ()
      end // end of [list_cons]
    | list_nil () => list_nil ()
  end // end of [list_nil]
//
end // end of [auxtup]

fun auxrec (
  ld2es: labd2explst, ls2es: labs2explst, serr: &int
) : labd3explst = let
in
//
case+ ld2es of
| list_cons
    (ld2e, ld2es) => let
    val $SYN.DL0ABELED (l0, d2e) = ld2e
  in
    case+ ls2es of
    | list_cons
        (ls2e, ls2es) => let
        val+SLABELED (_, name, s2e) = ls2e
        val d3e = d2exp_trdn (d2e, s2e)
        val ld3e = $SYN.DL0ABELED (l0, d3e)
        val ld3es = auxrec (ld2es, ls2es, serr)
      in
        list_cons (ld3e, ld3es)
      end // end of [list_cons]
    | list_nil () => let
        val () = serr := serr+1 in list_nil ()
      end // end of [list_nil]
  end // end of [list_cons]
| list_nil () => let
  in
    case+ ls2es of
    | list_cons _ => let
        val () = serr := serr-1 in list_nil ()
      end // end of [list_cons]
    | list_nil () => list_nil ()
  end // end of [list_nil]
//
end // end of [auxrec]

in (* in-of-local *)

implement
d2exp_trdn_tup
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Etup (knd, npf, d2es) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
in
//
case+
  s2e0.s2exp_node of
//
| S2Etyrec (
    knd1, npf1, ls2es
  ) => let
//
    var err: int = 0
    val () = $SOL.boxity_equal_solve_err (loc0, knd, knd1, err)
    val () = $SOL.pfarity_equal_solve_err (loc0, npf, npf1, err)
    val () =
    if err != 0 then {
      val () =
        prerr_the_staerrlst ()
      val () =
        the_trans3errlst_add(T3E_d2exp_trdn_tup(d2e0, s2e0))
    } (* end of [if] *) // end of [val]
//
    var serr: int = 0
    val d3es = auxtup (d2es, ls2es, serr)
    val () =
    if (serr != 0) then {
      val () =
        auxerrlen (loc0, serr)
      val () =
        the_trans3errlst_add(T3E_d2exp_trdn_tup(d2e0, s2e0))
    } (* end of [if] *) // end of [val]
//
  in
    d3exp_tup(loc0, s2e0, knd, npf, d3es)
  end // end of [S2Etyrec]
| _ (*non-S2Etyrec*) => d2exp_trdn_rest(d2e0, s2f0)
//
end // end of [d2exp_trdn_tup]

implement
d2exp_trdn_rec
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Erec (knd, npf, ld2es) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
in
//
case+
s2e0.s2exp_node
of // case+
//
| S2Etyrec (
    knd1, npf1, ls2es
  ) => let
    var err: int = 0
    val () =
      $SOL.boxity_equal_solve_err(loc0, knd, knd1, err)
    val () =
      $SOL.pfarity_equal_solve_err(loc0, npf, npf1, err)
    val () =
    if err != 0 then {
      val () =
        prerr_the_staerrlst ()
      val () =
        the_trans3errlst_add(T3E_d2exp_trdn_rec(d2e0, s2e0))
    } // end of [if] // end of [val]
    var serr: int = 0
    val ld3es = auxrec (ld2es, ls2es, serr)
    val () =
    if (serr != 0) then {
      val () =
        auxerrlen (loc0, serr)
      val () =
        the_trans3errlst_add(T3E_d2exp_trdn_rec(d2e0, s2e0))
    } // end of [if] // end of [val]
//
  in
    d3exp_rec(loc0, s2e0, knd, npf, ld3es)
  end // end of [S2Etyrec]
| _ (* non-S2Etyrec *) => d2exp_trdn_rest(d2e0, s2f0)
//
end // end of [d2exp_trdn_rec]

end // end of [local]

(* ****** ****** *)

implement
d2exp_trdn_seq
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Eseq (d2es) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
fun aux (
  d2e: d2exp
, d2es: d2explst
, s2e_void: s2exp
, s2e0: s2exp
) : d3explst =
(
  case+ d2es of
  | list_cons
      (d2e1, d2es1) => let
      val d3e = d2exp_trdn (d2e, s2e_void)
      val d3es = aux (d2e1, d2es1, s2e_void, s2e0)
    in
      list_cons (d3e, d3es)
    end // end of [list_cons]
  | list_nil () => let
      val d3e = d2exp_trdn (d2e, s2e0) in list_sing (d3e)
    end // end of [list_nil]
) (* end of [aux] *)
//
val s2e_void = s2exp_void_t0ype ()
//
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    var
    s2e_res: s2exp // uninitized
    val d3es = aux (d2e, d2es, s2e_void, s2e0)
  in
    d3exp_seq (loc0, s2e0, d3es)
  end // end of [list_cons]
| list_nil ((*void*)) => let
    val d3e =
      d3exp_empty (loc0, s2e_void)
    // end of [val]
  in
    d3exp_trdn (d3e, s2e0)
  end // end of [list_nil]
end // end of [d2exp_trdn_seq]

(* ****** ****** *)

implement
d2exp_trdn_raise
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
//
val-
D2Eraise
  (d2e_exn) = d2e0.d2exp_node
//
val err =
  the_effenv_check_exn (loc0)
// end of [val]
val () =
if (err > 0) then
  the_trans3errlst_add(T3E_d2exp_trup_exn(loc0))
// end of [if] // end of [val]
//
val s2e0 = s2hnf2exp (s2f0)
//
val s2e_exn = s2exp_exception_vtype ()
val d3e_exn = d2exp_trdn (d2e_exn, s2e_exn)
//
in
  d3exp_raise (loc0, s2e0, d3e_exn)
end // end of [d2exp_trdn_raise]

(* ****** ****** *)

implement
d2exp_trdn_effmask
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
//
val-
D2Eeffmask
  (s2fe, d2e1) = d2e0.d2exp_node
//
val
(pfpush|()) =
the_effenv_push_effmask (s2fe)
//
val s2e0 = s2hnf2exp (s2f0)
val d3e1 = d2exp_trdn (d2e1, s2e0)
//
val ((*void*)) =
the_effenv_pop (pfpush | (*none*))
//
in
  d3exp_effmask (loc0, s2fe, d3e1)
end // end of [d2exp_trdn_effmask]

(* ****** ****** *)

implement
d2exp_trdn_exist
  (d2e0, s2f0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Eexist
    (s2a, d2e1) = d2e0.d2exp_node
  val s2e0 = s2hnf2exp (s2f0)
  var err: int = 0; var s2ps0: s2explst_vt
  val s2e_ins = (
    case+ s2e0.s2exp_node of
    | S2Ewthtype
        (s2e1, wths2e2) => let
        val (s2e1, s2ps1) =
          s2exp_exi_instantiate_sexparg (s2e1, s2a, err)
        val () = s2ps0 := s2ps1
      in
        s2exp_wthtype (s2e1, wths2e2)
      end // end of [S2Ewthtype]
    | _ => s2e1 where {
        val (s2e1, s2ps1) =
          s2exp_exi_instantiate_sexparg (s2e0, s2a, err)
        val () = s2ps0 := s2ps1
      } // end of [_]
  ) : s2exp // end of [val]
  val () = trans3_env_add_proplst_vt (loc0, s2ps0)
(*
  val () =
  if err > 0 then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": existential abstraction mismatch"
    val () = the_trans3errlst_add (T3E_d2exp_trdn_exist (d2e0, s2e0))
  } (* end of [if] *) // end of [val]
*)
in
  d2exp_trdn (d2e1, s2e_ins)
end // end of [d2exp_trdn_exist]

(* ****** ****** *)

implement
d2exp_trdn_delay
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
//
val-D2Edelay(d2e) = d2e0.d2exp_node
//
val s2e0 = s2hnf2exp (s2f0)
val s2eopt = un_s2exp_lazy_t0ype_type(s2f0)
//
in
//
case+
s2eopt
of (* case+ *)
//
| ~None_vt((*void*)) =>
    d2exp_trdn_rest(d2e0, s2f0)
  // end of [None_vt]
| ~Some_vt(s2e) =>
    d2exp_trup(d2e0) where
  {
    val loc =
      d2e.d2exp_loc
    val d2e =
      d2exp_ann_type(loc, d2e, s2e)
    val d2e0 = d2exp_delay(loc0, d2e)
  } (* end of [Some_vt] *)
//
end // end of [d2exp_trdn_delay]

(* ****** ****** *)

implement
d2exp_trdn_ldelay
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
//
val-D2Eldelay(d2e, d2eopt) = d2e0.d2exp_node
//
val s2e0 = s2hnf2exp (s2f0)
val s2eopt = un_s2exp_lazy_vt0ype_vtype(s2f0)
//
in
//
case+
s2eopt
of (* case+ *)
//
| ~None_vt((*void*)) =>
    d2exp_trdn_rest(d2e0, s2f0)
  // end of [None_vt]
| ~Some_vt(s2e) =>
    d2exp_trup(d2e0) where
  {
    val d2e =
      d2exp_ann_type(d2e.d2exp_loc, d2e, s2e)
    // end of [val]
    val d2e0 = d2exp_ldelay(loc0, d2e, d2eopt)
  } (* end of [Some_vt] *)
//
end // end of [d2exp_trdn_ldelay]

(* ****** ****** *)

implement
d2exp_trdn_trywith
  (d2e0, s2f0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Etrywith
  (r2es, d2e, c2ls) = d2e0.d2exp_node
//
val (pfd2v | ()) = the_d2varenv_push_try ()
val (pfman | ()) = the_pfmanenv_push_try ()
//
val s2e_res = s2hnf2exp (s2f0)
val d3e = d2exp_trdn (d2e, s2e_res)
val s2e_pat = s2exp_exception_vtype ()
val d3es = list_sing (d3e)
val s2es_pat = list_sing (s2e_pat)
val c3ls =
  c2laulst_trdn (
    loc0, CK_case_neg, r2es, c2ls, d3es, s2es_pat, s2e_res
  ) (* end of [val] *)
//
val ((*void*)) = the_d2varenv_pop (pfd2v | (*none*))
val ((*void*)) = the_pfmanenv_pop (pfman | (*none*))
//
in
  d3exp_trywith (loc0, d3e, c3ls)
end // end of [d2exp_trdn_trywith]

(* ****** ****** *)

(* end of [pats_trans3_dynexp_dn.dats] *)
