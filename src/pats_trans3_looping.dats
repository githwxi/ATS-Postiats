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
// Start Time: March, 2012
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
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<> () = prerr "pats_trans3_looping"
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"
staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload
SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

fun d2var_reset_type
  (d2v: d2var): void =
  d2var_set_type (d2v, d2var_get_mastype (d2v))
// end of [d2var_reset_type]

(* ****** ****** *)

fun
lstbefitmlst_opnset_and_add
  (loc: loc_t, xs: lstbefitmlst): void = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () = d2var_opnset_and_add (loc, x.lstbefitm_var)
  in
    lstbefitmlst_opnset_and_add (loc, xs)
  end // end of [list_cons]
//
end // end of [lstbefitmlst_opnset_and_add]

(*
//
// HX-2012-11-24: is this necessary?
//
fun invarglst_opnset_and_add
  (loc: loc_t, xs: i2nvarglst): void = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () = d2var_opnset_and_add (loc, x.i2nvarg_var)
  in
    invarglst_opnset_and_add (loc, xs)
  end // end of [list_cons]
//
end // end of [invarglst_opnset_and_add]
*)

(* ****** ****** *)
//
extern
fun
d2exp_trup_loop_dryrun
(
  loc0: loc_t
, lsbis: lstbefitmlst
, test: d2exp, post: d2expopt, body: d2exp
) : lstbefitmlst // end of [d2exp_trup_loop_dryrun]
//
implement
d2exp_trup_loop_dryrun
(
  loc0, lsbis, test, post, body
) = let
//
val (pfpush | ()) = trans3_env_push ()
val (pfpush2 | ()) = the_lamlpenv_push_loop0 ()
//
val test = d2exp_trup (test)
val body = d2exp_trup (body)
//
val post = (
  case+ post of
  | Some d2e => let
      val s2f = s2exp_void_t0ype ()
      val d3e = d2exp_trdn (d2e, s2f)
    in
      Some (d3e)
    end // end of [Some]
  | None () => None ()
) : d3expopt // end of [val]
//
val () =
  the_lamlpenv_pop (pfpush2 | (*void*))
//
val s3itms = trans3_env_pop (pfpush | (*void*)) // HX: it is a dry-run
val ((*freed*)) = list_vt_free (s3itms)
//
fun
aux (
  x: lstbefitm
) : lstbefitm = let
//
val d2v = x.lstbefitm_var
//
val opt = x.lstbefitm_type
val opt2 = d2var_get_type (d2v) 
//
val () = (
//
// HX-2012-08:
// the rule is simple: each dvar is reset if its type immedidately
// after dry-run is different from the one at the start of dry-run
//
  case+ (opt, opt2) of
  | (Some (s2e),
     Some (s2e2)) => let
      val iseq = s2exp_refeq (s2e, s2e2)
    in
      if ~(iseq) then d2var_reset_type (d2v)
    end // end of [Some, Some]
  | (None (), None ()) => ()
  | (_, _) => d2var_reset_type (d2v) // HX: type-error later
) : void // end of [val]
//
val linval2 = d2var_get_linval (d2v)
//
in
  lstbefitm_make (d2v, linval2)
end // end of [aux]
//
val lsbis2 = list_map_fun (lsbis, aux)
//
in
  list_of_list_vt (lsbis2)
end // end of [d2exp_trup_loop_dryrun]
//
(* ****** ****** *)

local

fun
auxerr_none
(
  loc: loc_t, d2v: d2var, s2e: s2exp
) : void = let
//
val () =
  prerr_error3_loc (loc)
//
val () = prerr ": the dynamic variable ["
val () = prerr_d2var (d2v)
val () = prerr "] is retained with the type ["
val () = prerr_s2exp (s2e)
val () = prerr "but it should be consumed instead."
val () = prerr_newline ()
//
in
  the_trans3errlst_add (T3E_d2var_some (loc, d2v, s2e))
end // end of [auxerr_none]

fun
auxerr_some
(
  loc: loc_t, d2v: d2var, s2e0: s2exp
) : void = let
//
val () =
  prerr_error3_loc (loc)
//
val () = prerr ": the dynamic variable ["
val () = prerr_d2var (d2v)
val () = prerr "] is consumed but it should be retained with the type ["
val () = prerr_s2exp (s2e0)
val () = prerr "] instead."
val () = prerr_newline ()
//
in
  the_trans3errlst_add (T3E_d2var_some (loc, d2v, s2e0))
end // end of [auxerr_some]

fun
auxerr_some2
(
  loc: loc_t, d2v: d2var, s2e0: s2exp, s2e: s2exp
) : void = let
//
val () =
  prerr_error3_loc (loc)
//
val () = prerr ": the dynamic variable ["
val () = prerr_d2var (d2v)
val () = prerr "] is retained but with a type that fails to merge."
val () = prerr_newline ()
val () = prerr_the_staerrlst ()
//
in
  the_trans3errlst_add (T3E_d2var_some2 (loc, d2v, s2e0, s2e))
end // end of [auxerr_some2]

(* ****** ****** *)

fun
auxVarCK
(
  loc: loc_t
, d2v: d2var
, opt: s2expopt, opt2: s2expopt
) : void = let
//
(*
val () = println! ("auxVarCK: d2v = ", d2v)
*)
//
in
//
case+ opt of
| Some (s2e) => (
  case+ opt2 of
  | Some (s2e2) => let
      var err0: int = 0
//
(*
      val () = println! ("auxVarCK: s2e = ", s2e)
      val () = println! ("auxVarCK: s2e2 = ", s2e2)
*)
//
      val iseq = s2exp_refeq (s2e, s2e2)
      val () =
        if ~(iseq) then let
//
        val
        (pfpush|()) = trans3_env_push()
        val err = $SOL.s2exp_tyleq_solve (loc, s2e, s2e2)
        val ctrknd = C3TKlstate_var (d2v)
        val () = trans3_env_pop_and_add (pfpush | loc, ctrknd)
//
      in
        err0 := err
      end // end of [if] // end of [val]
      val () =
        if (err0 > 0) then {
        val () = prerr_the_staerrlst ()
        val () = auxerr_some2 (loc, d2v, s2e, s2e2)
      } // end of [if] // end of [val]
    in
      // nothing
    end // end of [Some]
  | None () => auxerr_none (loc, d2v, s2e)
  ) // end of [Some]
| None () => (
  case+ opt2 of
  | Some (s2e2) => auxerr_some (loc, d2v, s2e2) | None () => ()
  ) // end of [None]
//
end // end of [auxVarCK]

(* ****** ****** *)

fun
auxMetCK
(
  loc: loc_t
, sub: !stasub, opt: s2explstopt
) : void = let
in
  case+ opt of
  | Some (met0) => let
      val met = s2explst_subst (sub, met0)
      val c3t = c3nstr_termet_isdec (loc, met, met0)
    in
      trans3_env_add_cnstr (c3t)
    end // end of [Some]
  | None () => ((*void*))
end // end of [auxMetCK]

(* ****** ****** *)

fun
auxEnter
(
  loc: loc_t
, i2nv: loopi2nv, lsbis: lstbefitmlst
) : void = let
//
(*
val () = println! ("auxEnter: enter")
*)
//
fun
auxitm
(
  loc: loc_t
, sub: !stasub, args: i2nvarglst, x: lstbefitm
) : void = let
  val d2v = x.lstbefitm_var
in
//
case+ args of
| list_nil
    ((*void*)) => let
    val opt = x.lstbefitm_type
    val opt2 = d2var_get_type (d2v)
  in
    auxVarCK (loc, d2v, opt, opt2)
  end // end of [list_nil]
| list_cons
    (arg, args) => let
    val d2v2 = i2nvarg_get_var (arg)
    val iseq = eq_d2var_d2var (d2v, d2v2)
  in
    if iseq
      then let
        val opt = x.lstbefitm_type
        val opt2 = i2nvarg_get_type (arg)
        val opt2 = s2expopt_subst (sub, opt2)
      in
        auxVarCK (loc, d2v, opt, opt2)
      end // end of [then]
      else auxitm (loc, sub, args, x) // else
    // end of [if]
  end // end of [list_cons]
//
end (* end of [auxitm] *)
//
fun
auxitmlst
(
  loc: loc_t
, sub: !stasub, args: i2nvarglst, xs: lstbefitmlst
) : void = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () =
      auxitm (loc, sub, args, x)
    // end of [val]
  in
    auxitmlst (loc, sub, args, xs)
  end // end of [list_cons]
//
end (* end of [auxitmlst] *)
//
val sub =
  stasub_make_svarlst (loc, i2nv.loopi2nv_svs)
//
val
(pfpush | ()) = trans3_env_push ()
//
local
val
s2ps =
s2explst_subst_vt(sub, i2nv.loopi2nv_gua)
in
val () = trans3_env_add_proplst_vt (loc, s2ps)
end // end of [local]
//
val () = auxitmlst(loc, sub, i2nv.loopi2nv_arg, lsbis)
//
val ctrknd = C3TKloop(~1(*entering*))
//
val ((*void*)) = trans3_env_pop_and_add (pfpush | loc, ctrknd)
//
val ((*freed*)) = stasub_free (sub)
//
in
  // nothing
end // end of [auxEnter]

(* ****** ****** *)

fun
auxBreak
(
  loc: loc_t
, i2nv: loopi2nv, lsbis: lstbefitmlst
) : void = let
//
(*
val () = println! ("auxBreak: enter")
*)
//
fun
auxitm1
(
  loc: loc_t
, i2nv: loopi2nv
, lsbis: lstbefitmlst
, sub: !stasub, args: i2nvarglst, x0: lstbefitm
) : void = let
  val d2v = x0.lstbefitm_var
in
//
case+ args of
| list_nil () =>
  auxitm2
    (loc, lsbis, i2nv.loopi2nv_arg, x0)
  // end of [list_nil]
| list_cons
    (arg, args) => let
    val d2v2 = i2nvarg_get_var (arg)
    val iseq = eq_d2var_d2var (d2v, d2v2)
  in
    if iseq
      then let
        val opt = x0.lstbefitm_type
        val opt2 = i2nvarg_get_type (arg)
        val opt2 = s2expopt_subst (sub, opt2)
      in
        auxVarCK (loc, d2v, opt, opt2)
      end // end of [then]
      else (
        auxitm1 (loc, i2nv, lsbis, sub, args, x0)
      ) (* end of [else] *)
    // end of [if]
  end // end of [list_cons]
//
end // end of [auxitm1]
//
and
auxitm2
(
  loc: loc_t
, lsbis: lstbefitmlst, args: i2nvarglst, x0: lstbefitm
) : void = let
  val d2v = x0.lstbefitm_var
in
//
case+ args of
| list_nil
    ((*void*)) =>
    auxitm3 (loc, lsbis, x0)
  // end of [list_nil]
| list_cons
    (arg, args) => let
    val d2v2 = i2nvarg_get_var (arg)
    val iseq = eq_d2var_d2var (d2v, d2v2)
  in
    if iseq
      then let
        val opt = x0.lstbefitm_type
        val opt2 = i2nvarg_get_type (arg)
      in
        auxVarCK (loc, d2v, opt, opt2)
      end // end of [then]
      else (
        auxitm2 (loc, lsbis, args, x0)
      ) (* end of [else] *)
    // end of [if]
  end // end of [list_cons]
//
end // end of [auxitm2]
//
and
auxitm3
(
  loc: loc_t
, lsbis: lstbefitmlst, x0: lstbefitm
) : void = let
  val d2v = x0.lstbefitm_var
in
//
case+ lsbis of
| list_nil
    ((*void*)) => ()
| list_cons
    (lsbi, lsbis) => let
    val d2v2 = lsbi.lstbefitm_var
    val iseq = eq_d2var_d2var (d2v, d2v2)
  in
    if iseq
      then let
        val opt = x0.lstbefitm_type
        val opt2 = lsbi.lstbefitm_type
      in
        auxVarCK (loc, d2v, opt, opt2)
      end // end of [then]
      else auxitm3 (loc, lsbis, x0) // else
    // end of [if]
  end // end of [list_cons]
//
end // end of [auxitm3]
//
fun
auxitmlst
(
  loc: loc_t
, i2nv: loopi2nv
, lsbis: lstbefitmlst
, sub: !stasub, args: i2nvarglst, xs: lstbefitmlst
) : void = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () =
      auxitm1 (loc, i2nv, lsbis, sub, args, x)
    // end of [val]
  in
    auxitmlst (loc, i2nv, lsbis, sub, args, xs)
  end // end of [list_cons]
//
end (* end of [auxitmlst] *)
//
val r2es = i2nv.loopi2nv_res
val s2vs = r2es.i2nvresstate_svs
//
val sub = stasub_make_svarlst(loc, s2vs)
//
val lsbis2 = the_d2varenv_save_lstbefitmlst ()
//
val
(pfpush | ()) = trans3_env_push ()
//
val () =
auxitmlst
  (loc, i2nv, lsbis, sub, r2es.i2nvresstate_arg, lsbis2)
//
val ctrknd = C3TKloop(0(*breaking*))
//
val ((*void*)) = trans3_env_pop_and_add (pfpush | loc, ctrknd)
//
val ((*freed*)) = stasub_free (sub)
//
in
  // nothing
end // end of [auxBreak]

(* ****** ****** *)

fun
auxContinue
(
  loc: loc_t
, i2nv: loopi2nv, lsbis: lstbefitmlst
, post: d2expopt
) : d3expopt = let
//
(*
val () = println! ("auxContinue: enter")
*)
//
fun
auxitm1
(
  loc: loc_t
, lsbis: lstbefitmlst
, sub: !stasub, args: i2nvarglst, x0: lstbefitm
) : void = let
  val d2v = x0.lstbefitm_var
in
//
case+ args of
| list_nil() =>
    auxitm2 (loc, lsbis, x0)
  // end of [list_nil]
| list_cons(arg, args) => let
    val d2v2 = i2nvarg_get_var (arg)
    val iseq = eq_d2var_d2var (d2v, d2v2)
  in
    if iseq
      then let
        val opt = x0.lstbefitm_type
        val opt2 = i2nvarg_get_type (arg)
        val opt2 = s2expopt_subst (sub, opt2)
      in
        auxVarCK (loc, d2v, opt, opt2)
      end // end of [then]
      else (
        auxitm1 (loc, lsbis, sub, args, x0)
      ) (* end of [then] *)
    // end of [if]
  end // end of [list_cons]
//
end // end of [auxitm1]
//
and
auxitm2
(
  loc: loc_t
, lsbis: lstbefitmlst, x0: lstbefitm
) : void = let
  val d2v = x0.lstbefitm_var
in
//
case+ lsbis of
| list_nil
    ((*void*)) => ()
| list_cons
    (lsbi, lsbis) => let
    val d2v2 = lsbi.lstbefitm_var
    val iseq = eq_d2var_d2var (d2v, d2v2)
  in
    if iseq
      then let
        val opt = x0.lstbefitm_type
        val opt2 = lsbi.lstbefitm_type
      in
        auxVarCK (loc, d2v, opt, opt2)
      end // end of [then]
      else auxitm2 (loc, lsbis, x0) // else
    // end of [if]
  end // end of [list_cons]
//
end // end of [auxitm2]
//
fun
auxitmlst
(
  loc: loc_t
, lsbis: lstbefitmlst
, sub: !stasub, args: i2nvarglst, xs: lstbefitmlst
) : void = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () =
      auxitm1 (loc, lsbis, sub, args, x)
    // end of [val]
  in
    auxitmlst (loc, lsbis, sub, args, xs)
  end // end of [list_cons]
//
end (* end of [auxitmlst] *)
//
val
s2f_void = s2exp_void_t0ype ()
//
val post = (
  case+ post of
  | Some (d2e) => Some (d2exp_trdn (d2e, s2f_void))
  | None () => None ()
) : d3expopt // end of [val]
//
val sub =
  stasub_make_svarlst(loc, i2nv.loopi2nv_svs)
//
val lsbis2 = the_d2varenv_save_lstbefitmlst ()
//
val
(pfpush | ()) = trans3_env_push ()
//
local
val
s2ps =
s2explst_subst_vt(sub, i2nv.loopi2nv_gua)
in
val () = trans3_env_add_proplst_vt (loc, s2ps)
end // end of [local]
//
val () =
auxMetCK (loc, sub, i2nv.loopi2nv_met)
val () =
auxitmlst
  (loc, lsbis, sub, i2nv.loopi2nv_arg, lsbis2)
//
val ctrknd = C3TKloop(1(*continue*))
//
val ((*void*)) =
  trans3_env_pop_and_add (pfpush | loc, ctrknd)
//
val ((*freed*)) = stasub_free (sub)
//
in
  post(*d3expopt*)
end // end of [auxContinue]

in (* in of [local] *)

implement
d2exp_trup_loop
(
  loc0, i2nv, init, test, post, body
) = let
//
val s2f_void = s2exp_void_t0ype ()
//
val init = (
  case+ init of
  | Some d2e => let
      val d3e =
        d2exp_trdn (d2e, s2f_void) in Some (d3e)
      // end of [val]
    end // end of [Some]
  | None () => None ()
) : d3expopt // end of [val]
//
val lsbis0 = the_d2varenv_save_lstbefitmlst ()
val lsbis1 =
  d2exp_trup_loop_dryrun (loc0, lsbis0, test, post, body)
(*
val () = fprintln! (stdout_ref, "lsbis0 = ", lsbis0)
val () = fprintln! (stdout_ref, "lsbis1 = ", lsbis1)
*)
//
val () = auxEnter (loc0, i2nv, lsbis0)
//
val locinv = i2nv.loopi2nv_loc
val () =
  trans3_env_add_svarlst (i2nv.loopi2nv_svs)
val () =
  trans3_env_hypadd_proplst (locinv, i2nv.loopi2nv_gua)
//
val _(*err*) = let
  val opt = i2nv.loopi2nv_met
in
  case+ opt of
  | Some (met) => let
      val () = s2explst_check_termet (loc0, met) in (0)
    end // end of [Some]
  | None () =>
      the_effenv_check_ntm (loc0) // HX: raising ntm-effect
    // end of [None]
end : int // end of [val]
//
val invargs = i2nv.loopi2nv_arg
val () = i2nvarglst_update (locinv, invargs)
val () = lstbefitmlst_opnset_and_add (locinv, lsbis1)
//
val test = d2exp_trup (test)
val loc_test = test.d3exp_loc
val () = d3exp_open_and_add (test)
val s2e_test = d3exp_get_type (test)
val s2e_bool = s2exp_bool_t0ype ()
val test = d3exp_trdn (test, s2e_bool)
val s2f_test = s2exp2hnf (s2e_test)
//
val os2p_test = un_s2exp_bool_index_t0ype (s2f_test)
//
val (pfpush | ()) = trans3_env_push ()
val () = trans3_env_hypadd_propopt_neg
  (loc_test, $UN.castvwtp1 {s2expopt}{s2expopt_vt} (os2p_test))
val () = auxBreak (loc0, i2nv, lsbis1)
val () = trans3_env_pop_and_add_main (pfpush | loc0)
//
val (pfpush | ()) = trans3_env_push ()
val () = trans3_env_hypadd_propopt(*true*)
  (loc_test, $UN.castvwtp1 {s2expopt}{s2expopt_vt} (os2p_test))
//
val (pfpush2 | ()) =
  the_lamlpenv_push_loop1 (i2nv, lsbis1, post)
val body = d2exp_trdn (body, s2f_void)
val () = the_lamlpenv_pop (pfpush2 | (*void*))
//
val post = auxContinue (loc0, i2nv, lsbis1, post)
//
val () = trans3_env_pop_and_add_main (pfpush | loc0)
//
val () = option_vt_free (os2p_test)
//
val () = lstbefitmlst_restore_type (lsbis1)
val () = i2nvarglst_update (locinv, i2nv.loopi2nv_arg)
val () = i2nvresstate_update (locinv, i2nv.loopi2nv_res)
//
in
  d3exp_loop (loc0, init, test, post, body)
end // end of [d2exp_trup_loop]

(* ****** ****** *)

implement
d2exp_trup_loopexn
  (loc0, knd) = let
//
fun
auxerr
(
  loc: loc_t, knd: int
) : void = let
  val () = prerr_error3_loc (loc)
  val () = if knd = 0 then
    prerr ": [break] is only allowed inside a for/while-loop"
  val () = if knd > 0 then
    prerr ": [continue] is only allowed inside a for/while-loop"
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_loopexn (loc, knd))
end // end of [auxerr]
//
val opt = the_lamlpenv_top ()
val () = (
  case+ opt of
  | ~Some_vt (lamlp) => (
    case+ lamlp of
    | LAMLPlam _ => auxerr (loc0, knd)
    | LAMLPloop0 _ => () // HX: skip during dryrun
    | LAMLPloop1 (
        i2nv, lsbis, post
      ) =>
        if knd = 0 then
          auxBreak (loc0, i2nv, lsbis)
        else let
          val _(*post*) = auxContinue (loc0, i2nv, lsbis, post)
        in
          // nothing
        end // end of [if]
    ) // end of [Some_vt]
  | ~None_vt () => auxerr (loc0, knd)
) : void // end of [val]
//
in
  d3exp_loopexn (loc0, knd)
end // end of [d2exp_trup_loopexn]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_looping.dats] *)
