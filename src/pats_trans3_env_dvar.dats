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

staload ERR = "./pats_error.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<> () = prerr "pats_trans3_env_dvar"
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
overload
print with $LOC.print_location

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

implement
d2var_mutablize
  (loc0, d2v, s2e0, opt) = let
(*
val () = (
  println! (": d2var_mutablize: d2v = ", d2v)
) // end of [val]
*)
//
val s2e_elt =
  d2var_get_type_some (loc0, d2v)
//
val s2e_addr = let
  val opt = d2var_get_addr (d2v)
in
  case+ opt of
  | Some (s2e_addr) =>
      s2e_addr // HX: [d2v] is introduced by vardec
  | None () => let
      val sym = d2var_get_sym (d2v)
      val s2v_addr = s2var_make_id_srt (sym, s2rt_addr)
      val () = trans3_env_add_svar (s2v_addr) // adding svar
      val s2e_addr = s2exp_var (s2v_addr)
      val () = d2var_set_addr (d2v, Some s2e_addr)
    in
      s2e_addr
    end // end of [None]
end // end of [let] // end of [val]
//
val s2e_ptr = s2exp_ptr_addr_type (s2e_addr)
val () = d2var_set_type (d2v, Some (s2e_ptr))
val () = d2var_set_mastype (d2v, Some (s2e_ptr))
val () = d2var_set_linval (d2v, ~1(*nonlin*))
//
// HX-2012-07: this is often needed in 'unsafe' programming style
//
val () = let
  val s2p = s2exp_agtz (s2e_addr) in trans3_env_hypadd_prop (loc0, s2p)
end // end of [val]
//
val d2vw =
  d2var_ptr_viewat_make (d2v, opt) // linval is properly set
val () = d2var_set_view (d2v, Some d2vw) // [d2v] is mutable
//
val s2at0 = s2exp_at (s2e0, s2e_addr)
val () = d2var_set_mastype (d2vw, Some (s2at0))
val s2at_elt = s2exp_at (s2e_elt, s2e_addr)
val () = d2var_set_type (d2vw, Some (s2at_elt))
//
in
  d2vw
end // end of [d2var_mutablize]

implement
d2var_mutablize_none
  (loc0, d2v, s2e0) =
  d2var_mutablize (loc0, d2v, s2e0, None ())
// end of [d2var_mutablize_none]

(* ****** ****** *)

extern
fun the_d2varenv_push (): (d2varenv_push_v | void)

local

dataviewtype
ld2vsetlst = // local dynamic variables
  | LD2VSset of
      (d2varset_vt, ld2vsetlst) // local dynamic variable set
  | LD2VSlam of
      (int(*lin*), d2varlst_vt, ld2vsetlst) // marker for lambdas
  | LD2VSnil of ()
// end of [ld2vsetlst]

assume d2varenv_push_v = unit_v

val the_ld2vs =
  ref<d2varset_vt> (d2varset_vt_nil ())
// end of [val]

val the_ld2vss = ref<ld2vsetlst> (LD2VSnil ())

in // in of [local]

implement
the_d2varenv_get_top () = let
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  d2varset_vt_listize (!p)
end // end of [the_d2varenv_get_top]

implement
the_d2varenv_get_llamd2vs () = let
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
in
  case+ !pp of
  | LD2VSlam (lin, !p_d2vs, _) => let
      val d2vs = !p_d2vs; val () = !p_d2vs := list_vt_nil
    in
      fold@ (!pp); d2vs
    end // end of [LD2VSlam]
  | LD2VSset _ => (fold@ (!pp); list_vt_nil)
  | LD2VSnil _ => (fold@ (!pp); list_vt_nil)
end // end of [the_d2varenv_get_llamd2vs]

(* ****** ****** *)

implement
the_d2varenv_add_dvar
  (d2v) = let
  val (vbox pf | p) =
    ref_get_view_ptr (the_ld2vs)
  val () = !p := d2varset_vt_add (!p, d2v)
  val opt = d2var_get_view (d2v)
in
//
case+ opt of
| Some (d2vw) => !p := d2varset_vt_add (!p, d2vw)
| None () => ()
//
end // end of [the_d2varenv_add]

implement
the_d2varenv_add_dvarlst
  (d2vs) = let
  fun loop {n:nat} .<n>. (
    set: d2varset_vt, d2vs: list (d2var, n)
  ) :<> d2varset_vt =
    case+ d2vs of
    | list_cons (d2v, d2vs) => let
        val set = d2varset_vt_add (set, d2v) in loop (set, d2vs)
      end // end of [list_cons]
    | list_nil () => set
  // end of [loop]
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  !p := loop (!p, d2vs)
end // end of [the_d2varenv_addlst]

implement
the_d2varenv_add_dvaropt
  (opt) = (
  case+ opt of
  | Some (d2v) => the_d2varenv_add_dvar (d2v)
  | None () => ()
) // end of [the_d2varenv_add_dvaropt]

(* ****** ****** *)

implement
the_d2varenv_pop
   (pfpush | (*none*)) = let
   viewtypedef lset = d2varset_vt
   fun loop (
     ld2vss: ld2vsetlst, res: &lset? >> lset
   ) : ld2vsetlst =
     case+ ld2vss of
     | ~LD2VSset
         (d2vs, ld2vss) => let
         val () = res := d2vs in ld2vss
       end // end of [LD2VSset]
     | ~LD2VSlam (lin, d2vs, ld2vss) => let
         val () = list_vt_free (d2vs) in loop (ld2vss, res)
       end // end of [LD2VSlam]
     | ~LD2VSnil () => let
         val () = res := d2varset_vt_nil () in LD2VSnil ()
       end // end of [LD2VSnil]
   // end of [loop]
   prval unit_v () = pfpush
   val (vbox pf1 | p) =
     ref_get_view_ptr (the_ld2vs)
   val () = d2varset_vt_free (!p)
   val () = $effmask_ref let
     val (vbox pf2 | pp) = ref_get_view_ptr (the_ld2vss)
   in
     !pp := $effmask_ref (loop (!pp, !p))
   end // end of [val]
in
  // nothing
end // end of [the_d2varenv_pop]

(* ****** ****** *)

implement
the_d2varenv_push () = let
  val d2vs = d2vs where {
    val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
    val d2vs = !p
    val () = !p := d2varset_vt_nil ()
  } // end of [val]
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
  val () = !pp := LD2VSset (d2vs, !pp)
in
  (unit_v () | ())
end // end of [the_d2varenv_push]

implement
the_d2varenv_push_lam (lin) = let
  val (pfpush | ()) = the_d2varenv_push ()
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
  val () = !pp := LD2VSlam (lin, list_vt_nil, !pp)
in
  (pfpush | ())
end // end of [the_d2varenv_push_lam]

implement
the_d2varenv_push_let () = the_d2varenv_push ()

// HX: preventing
implement // linear resources from being accessed
the_d2varenv_push_try () = the_d2varenv_push_lam (0)

(* ****** ****** *)

implement
the_d2varenv_d2var_is_llamlocal
  (d2v0) = let // [d2v0] is linear
//
fun loop (
  ld2vss: !ld2vsetlst, d2v0: d2var
) : bool = (
  case+ ld2vss of
  | LD2VSlam (
      lin, !p_d2vs, !p_ld2vss
    ) => (
    case+ 0 of
    | _ when lin > 0 => let
        val () = !p_d2vs :=
          list_vt_cons (d2v0, !p_d2vs)
        // end of [val]
        val ans = loop (!p_ld2vss, d2v0)
      in
        fold@ (ld2vss); ans
      end // end of [llam]
    | _ => (fold@ (ld2vss); false)
    ) // end of [LD2VSlam]
  | LD2VSset (!p_d2vs, !p_ld2vss) => let
      val ans = d2varset_vt_ismem (!p_d2vs, d2v0)
      val ans = (
        if ans then true else loop (!p_ld2vss, d2v0)
      ) // end of [val]
    in
      fold@ (ld2vss); ans
    end // end of [LD2VSset]
  | LD2VSnil () => (fold@ (ld2vss); false)
) (* end of [loop] *)
//
val ans = let
//
val
(
  vbox pf | p
) = ref_get_view_ptr (the_ld2vs)
//
in
  d2varset_vt_ismem (!p, d2v0)
end // end of [val]
//
in
//
if ans then true else let
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
in
  $effmask_ref (loop (!pp, d2v0))
end // end of [if]
//
end // end of [the_d2varenv_d2var_is_llamlocal]

(* ****** ****** *)

implement
the_d2varenv_save_lstbefitmlst
  () = let
//
fun aux (
  d2v: d2var
, res: &lstbefitmlst >> lstbefitmlst
) : void = let
  val linval = d2var_get_linval (d2v)
(*
  val () = begin
    println! ("the_d2varenv_save_lstbefitmlst: aux: d2v = ", d2v);
    println! ("the_d2varenv_save_lstbefitmlst: aux: linval = ", linval);
  end // end of [val]
*)
in
  if linval >= 0 then let
    val x = lstbefitm_make (d2v, linval) in res := list_cons (x, res)
  end else () // end of [if]
end // end of [aux]
//
fun auxlst (
  d2vs: d2varlst_vt
, res: &lstbefitmlst >> lstbefitmlst
) : void = (
  case+ d2vs of
  | ~list_vt_cons (d2v, d2vs) => let
      val () = aux (d2v, res) in auxlst (d2vs, res)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
) (* end of [auxlst] *)
//
fun auxset (
  d2vs: !d2varset_vt
, res: &lstbefitmlst >> lstbefitmlst
) : void = let
  val d2vs = d2varset_vt_listize (d2vs) in auxlst (d2vs, res)
end // end of [auxset]
//
fun auxsetlst (
  xs: !ld2vsetlst, res: &lstbefitmlst >> lstbefitmlst
) : void = let
in
//
case+ xs of
| LD2VSset
    (!p_d2vs, !p_xs) => {
    val () = auxset (!p_d2vs, res)
    val () = auxsetlst (!p_xs, res)
    prval () = fold@ (xs)
  } // end of [LD2VSset]
| LD2VSlam (
    lin, _(*d2vs*), !p_xs
  ) when lin > 0 => {
    val () = auxsetlst (!p_xs, res)
    prval () = fold@ (xs)
  } // end of [LD2VSlam(1)]
| _ => ()
//
end // end of [auxsetlst]
//
var res: lstbefitmlst = list_nil
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  $effmask_ref (auxset (!p, res))
end // end of [val]
val () = let
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
in
  $effmask_ref (auxsetlst (!pp, res))
end // end of [val]
(*
val () = (
  print "the_d2varset_save_lstbefitmlst: res = ";
  fprint_lstbefitmlst (stdout_ref, res); print_newline ()
) (* end of [val] *)
*)
in
  res
end // end of [the_d2varset_save_lstbefitmlst]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

extern
fun the_d2varenv_add_labp3atlst (xs: labp3atlst): void

implement
the_d2varenv_add_p3at
  (p3t) = let
//
val opt = p3at_get_dvaropt (p3t)
val () = the_d2varenv_add_dvaropt (opt)
//
in
//
case+ p3t.p3at_node of
//
| P3Tany (d2v) => the_d2varenv_add_dvar (d2v)
| P3Tvar (d2v) => the_d2varenv_add_dvar (d2v)
//
| P3Tcon (
    _(*pck*), d2c, npf, p3ts
  ) => the_d2varenv_add_p3atlst (p3ts)
//
| P3Tann (p3t, s2e) => the_d2varenv_add_p3at (p3t)
//
| P3Tint _ => ()
| P3Tintrep _ => ()
//
| P3Tbool _ => ()
| P3Tchar _ => ()
| P3Tfloat _ => ()
| P3Tstring _ => ()
//
| P3Ti0nt _ => ()
| P3Tf0loat _ => ()
//
| P3Tempty _ => ()
//
| P3Trec (
    knd, npf, lp3ts
  ) =>
    the_d2varenv_add_labp3atlst (lp3ts)
  // end of [P3Trec]
| P3Tlst (
    lin, _elt, p3ts
  ) => the_d2varenv_add_p3atlst (p3ts)
//
| P3Trefas (d2v, p3t) => {
    val () = the_d2varenv_add_dvar (d2v)
    val () = the_d2varenv_add_p3at (p3t)
  } // end of [P3Trefas]
//
| P3Texist (s2vs, p3t) => the_d2varenv_add_p3at (p3t)
//
| P3Tvbox (d2v) => the_d2varenv_add_dvar (d2v)
//
| P3Terrpat ((*void*)) => ()
//
end // end of [the_d2varenv_add_p3at]

implement
the_d2varenv_add_p3atlst
  (p3ts) = list_app_fun<p3at> (p3ts, the_d2varenv_add_p3at)
// end of [the_d2varenv_add_p3atlst]

implement
the_d2varenv_add_labp3atlst
  (xs) = loop (xs) where {
  fun loop (
    xs: labp3atlst
  ) : void =
    case+ xs of
    | list_cons (x, xs) => let
        val LABP3AT (l, p3t) = x
        val () = the_d2varenv_add_p3at (p3t)
      in
        loop (xs)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [loop]
} // end of [the_d2varenv_add_labp3atlst]

(* ****** ****** *)
//
extern
fun d2vfin_check
  (loc0: loc_t, d2v: d2var): void
//
(* ****** ****** *)

local

fun
d2vfin_check_some
(
  loc0: loc_t, d2v: d2var, s2e: s2exp
) : void = let
//
fun auxerr1
(
  loc0: loc_t
, d2v: d2var, s2e1: s2exp, s2e2: s2exp
) : void = {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is preserved but with an incompatible type."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val () =  the_trans3errlst_add (T3E_d2var_fin_some_some (loc0, d2v))
} (* end of [auxerr1] *)
fun auxerr2
(
  loc0: loc_t, d2v: d2var, s2e: s2exp
) : void = {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] needs to be consumed but it is preserved with the type ["
  val () = prerr_s2exp (s2e)
  val () = prerr "] instead."
  val () = prerr_newline ()
  val () = the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
} (* end of [auxerr2] *)
//
val d2vfin = d2var_get_finknd (d2v)
(*
val () = (
  print "d2vfin_check_some: d2v = "; print_d2var(d2v); print_newline();
  print "d2vfin_check_some: d2vfin = "; print_d2vfin(d2vfin); print_newline();
) (* end of [val] *)
*)
in
//
case+ d2vfin of
//
| D2VFINnone() => let
    val islin = s2exp_is_lin2 (s2e)
    val () = if islin then auxerr2 (loc0, d2v, s2e)
    val linval = d2var_get_linval (d2v)
  in
    if linval >= 0 then d2var_set_type(d2v, None ())
  end // end of [D2VFINnone]
//
| D2VFINsome
    (s2e_fin) => let
    val
    (pfpush | ()) = trans3_env_push()
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e, s2e_fin)
    val () = if err > 0 then auxerr1 (loc0, d2v, s2e, s2e_fin)
    val knd = C3TKsome_fin (d2v, s2e_fin, s2e)
    val ((*void*)) = trans3_env_pop_and_add (pfpush | loc0, knd)
  in
    d2var_set_type (d2v, Some s2e_fin)
  end // end of [D2VFINsome]
//
| D2VFINsome_lvar
    (s2e_fin) => let
//
    val
    (pfpush | ()) = trans3_env_push()
//
    val s2e = (
      case+
      s2e.s2exp_node
      of // case+
      | S2Eat(s2at, s2l) =>
        let
          val isnonlin = s2exp_is_nonlin(s2at)
        in
          if isnonlin then s2exp_at(s2exp_topize_0(s2at), s2l) else s2e
        end // end of [S2Eat]
      | _ (* non-S2Eat *) => let
          val () = assertloc (false) in s2e // HX: this should be deadcode!
        end // end of [_]
    ) : s2exp // end of [val]
//
(*
    val () = println! ("d2vfin_check_some: D2VFINsome_lvar: s2e = ", s2e)
*)
//
    val err =
    $SOL.s2exp_tyleq_solve(loc0, s2e, s2e_fin)
    val () =
    if err > 0 then auxerr1(loc0, d2v, s2e, s2e_fin)
//
    val knd = C3TKsome_lvar(d2v, s2e_fin, s2e)
    val ((*void*)) = trans3_env_pop_and_add(pfpush | loc0, knd)
//
  in
    d2var_set_type (d2v, Some (s2e_fin))
  end // end of [D2VFINsome_lvar]
//
| D2VFINsome_vbox
    (s2e_box) => let
    val
    (pfpush | ()) = trans3_env_push ()
    val err =
    $SOL.s2exp_tyleq_solve (loc0, s2e, s2e_box)
    val () = if err > 0 then auxerr1 (loc0, d2v, s2e, s2e_box)
    val knd = C3TKsome_vbox (d2v, s2e_box, s2e)
    val ((*void*)) = trans3_env_pop_and_add (pfpush | loc0, knd)
  in
    d2var_set_type (d2v, Some (s2e_box))
  end // end of [D2VFINsome_vbox]
//
| D2VFINdone _ => () // HX: handled by [funarg_d2vfin_check]
// end of [case]
//
end // end of [d2vfin_check_some]

fun
d2vfin_check_none
(
  loc0: loc_t, d2v: d2var
) : void = let
//
fun auxerr
(
  loc0: loc_t, d2v: d2var
) : void = {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] needs to be preserved but it is consumed instead."
  val () = prerr_newline ()
} (* end of [auxerr] *)
//
val d2vfin = d2var_get_finknd (d2v)
(*
val () = (
  print "d2vfin_check_none: d2v = "; print_d2var (d2v); print_newline ();
  print "d2vfin_check_none: d2vfin = "; print_d2vfin (d2vfin); print_newline ();
) (* end of [val] *)
*)
in
//
case+ d2vfin of
| D2VFINnone () => ()
| D2VFINsome _ => let
    val () = auxerr (loc0, d2v)
  in
    the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
  end // end of [D2VFINsome]
| D2VFINsome_lvar _ => let
    val () = auxerr (loc0, d2v)
  in
    the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
  end // end of [D2VFINsome_lvar]
| D2VFINsome_vbox _ => let
    val () = auxerr (loc0, d2v)
  in
    the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
  end // end of [D2VFINsome_vbox]
| D2VFINdone _ => () // HX: handled by [funarg_d2vfin_check]
//
end // end of [d2vfin_check_none]

in // in of [local]

implement
d2vfin_check (loc0, d2v) = let
//
(*
val () = (
  println! ("d2vfin_check: d2v = ", d2v)
) // end of [val]
*)
//
val opt = d2var_get_type (d2v)
//
in
//
case+ opt of
| Some (s2e) => let
(*
    val () = (
      println! ("d2vfin_check: s2e = ", s2e)
    ) // end of [val]
*)
  in
    d2vfin_check_some (loc0, d2v, s2e)
  end // end of [Some]
| None () => d2vfin_check_none (loc0, d2v)
//
end // end of [d2vfin_check]

implement
the_d2varenv_check (loc0) = let
(*
val () = (
  print "the_d2varenv_check"; print_newline ()
) // end of [val]
*)
fun loop
(
  loc0: loc_t, d2vs: d2varlst_vt
) : void =
  case+ d2vs of
  | ~list_vt_cons (d2v, d2vs) => let
      val () = d2vfin_check (loc0, d2v) in loop (loc0, d2vs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
(* end of [loop] *)
//
in
  loop (loc0, the_d2varenv_get_top ())
end // end of [the_d2varenv_check]

implement
the_d2varenv_check_llam
  (loc0) = let
//
fun aux
(
  loc0: loc_t, d2v: d2var
) : void = let
  val opt = d2var_get_type (d2v)
in
  case+ opt of
  | Some (s2e) => let
      val islin = s2exp_is_lin (s2e)
    in
      if islin then let
        val () = prerr_error3_loc (loc0)
        val () = prerr ": the linear dynamic variable ["
        val () = prerr_d2var (d2v)
        val () = prerr "] needs to be consumed but it is preserved with the type ["
        val () = prerr_s2exp (s2e)
        val () = prerr "] instead."
        val () = prerr_newline ()
        val () = assertloc (false)
      in
        exit (1)
      end else
        d2var_set_type (d2v, None ())
      // end of [if]
    end // end of [Some]
  | None () => ()
end // end of [aux]
//
fun auxlst
(
  loc0: loc_t, d2vs: d2varlst_vt
) : void =
(
  case+ d2vs of
  | ~list_vt_cons
      (d2v, d2vs) => let
      val () = aux (loc0, d2v)
      val () = auxlst (loc0, d2vs)
    in
      // nothing
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
) (* end of [auxlst] *)
//
in
  auxlst (loc0, the_d2varenv_get_llamd2vs ())
end // end of [the_d2varenv_check_llam]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

fun d2vfin_checked
  (d2v: d2var): void = let
  val d2vfin = d2var_get_finknd (d2v)
in
//
case+ d2vfin of
| D2VFINdone _ => ()
| _ => d2var_set_finknd (d2v, D2VFINdone (d2vfin))
//
end // end of [d2vfin_checked]

in // in of [local]

implement
funarg_d2vfin_check (loc0) = let
(*
val () = (
  println! ("funarg_d2vfin_check: enter")
) (* end of [val] *)
*)
fun auxvar
(
  loc0: loc_t, d2v: d2var
) : void = let
(*
val () = begin
  println! ("funarg_d2vfin_check: auxvar: d2v (bef) = ", d2v)
end // end of [val]
*)
val d2v = let
  val opt = d2var_get_view (d2v) in
  case+ opt of Some (d2v) => d2v | None () => d2v
end : d2var // end of [val]
(*
val () = begin
  println! ("funarg_d2vfin_check: auxvar: d2v (aft) = ", d2v)
end // end of [val]
*)
//
val () = d2vfin_check (loc0, d2v)
//
in
  d2vfin_checked (d2v) // HX: indicating that [d2vfin_check] should skip it
end // end of [auxvar]
//
fun
auxpatlst
(
  loc0: loc_t, p3ts: p3atlst
) : void = let
in
//
case+ p3ts of
| list_cons
    (p3t, p3ts) => let
    val () = (
      case+ p3t.p3at_node of
      | P3Tvar (d2v) => auxvar (loc0, d2v)
      | P3Trefas (d2v, _) => auxvar (loc0, d2v)
      | _ => ()
    ) : void // end of [val]
  in
    auxpatlst (loc0, p3ts)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxpatlst]
//
val opt = the_lamlpenv_get_funarg ()
//
in
//
case+ opt of
| ~Some_vt p3ts => let
    val () = auxpatlst (loc0, p3ts)
  in
    // nothing
  end // end of [Some_vt]
//
| ~None_vt () => let
    val () = prerr_interror_loc (loc0)
    val () = prerr ": funarg_d2vfin_check: there is no funarg."
    val () = prerr_newline ()
  in
    assertloc (false)
  end // end of [None_vt]
end (* end of [funarg_d2vfin_check] *)

end // end of [local]

(* ****** ****** *)

implement
s2exp_wthtype_instantiate (loc0, s2e0) = let
//
(*
val () = begin
  println! ("s2exp_wthtype_instantiate: s2e0 = ", s2e0)
end // end of [val]
*)
//
fun p3at_get_var
  (p3t: p3at): d2var = let
in
//
case+ p3t.p3at_node of
| P3Tvar (d2v) => d2v
| P3Trefas (d2v, _) => d2v
| _ => let
    val () =
      prerr_interror_loc (p3t.p3at_loc)
    // end of [val]
    val () = prerr ": s2exp_wthtype_instantiate"
    val () = prerrln! ": p2at_get_var: the pattern is expected to be a variable."
    val ((*exit*)) = assertloc (false)
  in
    $ERR.abort_interr{d2var}((*deadcode*))
  end // end of [_]
//
end // end of [p3at_get_var]
//
fun d2vfin_unchecked
  (d2v: d2var): void = let
  val d2vfin = d2var_get_finknd (d2v)
in
//
case+ d2vfin of
| D2VFINdone(d2vfin) => d2var_set_finknd(d2v, d2vfin)
| _ (*non-D2VFINdone*) => () // HX: is this deadcode?
//
end // end of [d2vfin_unchecked]
//
fun aux_invar .<>.
(
  refknd: int, p3t: p3at, s2e: s2exp
) : void = let
//
val d2v = p3at_get_var (p3t)
//
in
//
case+ 0 of
| _ when
    refknd = 0 => d2vfin_unchecked (d2v)
| _ (* refknd = 1 *) => let
    val-Some
    (
      d2v_view
    ) = d2var_get_view (d2v) in d2vfin_unchecked (d2v_view)
  end // end of [_]
//
end // end of [aux_invar]
//
fun aux_trans .<>.
(
  refknd: int, p3t: p3at, s2e: s2exp
) : void = let
//
val d2v = p3at_get_var (p3t)
//
(*
val () = println! ("aux_trans: d2v = ", d2v)
val () = println! ("aux_trans: s2e = ", s2e)
*)
//
in
//
case+ 0 of
| _ when refknd = 0 =>
    d2var_set_finknd (d2v, D2VFINsome s2e)
| _ (* refknd = 1 *) => let
    val-Some (d2v_view) = d2var_get_view (d2v)
    val-Some (s2e_addr) = d2var_get_addr (d2v)
    val s2e_at = s2exp_at (s2e, s2e_addr)
  in
    d2var_set_finknd (d2v_view, D2VFINsome (s2e_at))
  end // end of [_]
//
end // end of [aux_trans]
//
fun auxlst
(
  loc0: loc_t
, p3ts: p3atlst, wths2es: wths2explst
) : void = let
in
//
case+ wths2es of
| WTHS2EXPLSTcons_invar
    (refknd, s2e, wths2es) => let
    val-list_cons (p3t, p3ts) = p3ts
    val () = aux_invar (refknd, p3t, s2e)
  in
    auxlst (loc0, p3ts, wths2es)
  end // end of [WTHS2EXPLSTcons_invar]
| WTHS2EXPLSTcons_trans
    (refknd, s2e, wths2es) => let
    val-list_cons (p3t, p3ts) = p3ts
    val () = aux_trans (refknd, p3t, s2e)
  in
    auxlst (loc0, p3ts, wths2es)     
  end // end of [WTHS2EXPLSTcons_trans]
| WTHS2EXPLSTcons_none
    (wths2es) => let
    val-list_cons (p3t, p3ts) = p3ts
  in
    auxlst (loc0, p3ts, wths2es)
  end // end of [WTHS2EXPLSTcons_none]
| WTHS2EXPLSTnil () => ()
//
end // end of [auxlst]
//
var err: int = 0
val (s2e, s2ps) =
  s2exp_exi_instantiate_all (s2e0, loc0, err)
val () = trans3_env_add_proplst_vt (loc0, s2ps)
//
in
//
case+ s2e.s2exp_node of
//
| S2Ewthtype
    (s2e, wths2es) => let
    val-~Some_vt (p3ts) = opt where {
      val opt = the_lamlpenv_get_funarg ()
    } // end of [val]
    val () = auxlst (loc0, p3ts, wths2es)
  in
    s2e
  end // end of [S2Ewthtype]
//
| _ (*non-withtype*) => (s2e)
//
end // end of [s2exp_wthtype_instantiate]

(* ****** ****** *)

(* end of [pats_trans3_env_dvar.dats] *)
